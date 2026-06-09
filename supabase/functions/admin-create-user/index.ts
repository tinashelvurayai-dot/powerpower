// Admin-only: create a new user account with full access.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: cors });
  try {
    const supa = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    // Verify caller is admin
    const auth = req.headers.get("Authorization") || "";
    const token = auth.startsWith("Bearer ") ? auth.slice(7) : "";
    if (!token) throw new Error("Unauthorized");
    const { data: userRes, error: uErr } = await supa.auth.getUser(token);
    if (uErr || !userRes?.user) throw new Error("Unauthorized");
    const { data: roles } = await supa.from("user_roles").select("role").eq("user_id", userRes.user.id);
    if (!roles?.some((r: { role: string }) => r.role === "admin")) throw new Error("Forbidden");

    const { email, password, full_name, access_level } = await req.json();
    if (!email || !password) throw new Error("email and password are required");
    if (String(password).length < 6) throw new Error("password must be at least 6 characters");

    const { data: created, error: cErr } = await supa.auth.admin.createUser({
      email: String(email).trim(),
      password: String(password),
      email_confirm: true,
      user_metadata: { full_name: full_name || email },
    });
    if (cErr) throw new Error(cErr.message);

    const uid = created.user!.id;
    // Ensure profile + access level
    await supa.from("profiles").upsert({
      id: uid,
      email: String(email).trim(),
      full_name: full_name || email,
      access_level: access_level === "free" ? "free" : "full",
    });

    return new Response(JSON.stringify({ ok: true, user_id: uid }), {
      headers: { ...cors, "content-type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: (e as Error).message }), {
      status: 400,
      headers: { ...cors, "content-type": "application/json" },
    });
  }
});
