import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function escapeHtml(s: string) {
  return s.replace(/[&<>"']/g, (c) =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" } as Record<string, string>)[c]!,
  );
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: cors });

  try {
    const { to, fullName, code } = await req.json();
    if (!to || !fullName || !code) {
      throw new Error("Missing required fields: to, fullName, code");
    }

    const supa = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    const html = `
    <div style="font-family:system-ui,-apple-system,sans-serif;max-width:560px;margin:0 auto;padding:24px;background:#0f172a;color:#fff;border-radius:12px;border:1px solid #1e293b">
      <div style="text-align:center;margin-bottom:24px">
        <h1 style="margin:0;font-size:28px;font-weight:700;color:#fff">Welcome, ${escapeHtml(fullName)}!</h1>
      </div>
      
      <p style="color:#cbd5e1;line-height:1.6;margin:0 0 16px 0;font-size:14px">Your payment has been approved by the admin. Your access code is ready:</p>
      
      <div style="background:#1e293b;border:2px solid #6366f1;border-radius:10px;padding:24px;margin:24px 0;text-align:center">
        <p style="margin:0 0 8px 0;color:#94a3b8;font-size:12px;text-transform:uppercase;letter-spacing:1px">Your Access Code</p>
        <p style="margin:0;font-family:'Courier New',monospace;font-size:32px;font-weight:700;color:#6366f1;letter-spacing:4px">${escapeHtml(code)}</p>
      </div>
      
      <div style="background:#1e293b;border:1px solid #334155;border-radius:8px;padding:16px;margin:16px 0">
        <p style="margin:0 0 12px 0;color:#cbd5e1;font-size:14px;font-weight:600">How to sign in:</p>
        <ol style="margin:0;padding-left:20px;color:#cbd5e1;font-size:14px">
          <li style="margin-bottom:8px">Open the Power Electronics 1 app</li>
          <li style="margin-bottom:8px">Click <strong>"I have a code"</strong> button</li>
          <li style="margin-bottom:8px">Enter your full name: <strong>${escapeHtml(fullName)}</strong></li>
          <li>Enter the access code above</li>
        </ol>
      </div>
      
      <p style="color:#94a3b8;line-height:1.6;margin:24px 0 0 0;font-size:13px">
        Questions or issues? Contact us at <strong>powerelectronics1@gmail.com</strong>
      </p>
      
      <div style="margin-top:24px;padding-top:16px;border-top:1px solid #334155;text-align:center">
        <p style="margin:0;color:#64748b;font-size:12px">
          © Power Electronics 1. All rights reserved.
        </p>
      </div>
    </div>`;

    // Send email via Supabase Auth email provider
    const { error } = await supa.auth.admin.sendRawEmail({
      email: to,
      html,
      subject: "Your Power Electronics 1 Access Code",
    });

    if (error) {
      console.error("Email send error:", error);
      throw error;
    }

    return new Response(
      JSON.stringify({ success: true, message: "Email sent successfully" }),
      { status: 200, headers: { ...cors, "content-type": "application/json" } }
    );
  } catch (e) {
    console.error("Error:", e);
    return new Response(
      JSON.stringify({ error: (e as Error).message }),
      { status: 400, headers: { ...cors, "content-type": "application/json" } }
    );
  }
});
