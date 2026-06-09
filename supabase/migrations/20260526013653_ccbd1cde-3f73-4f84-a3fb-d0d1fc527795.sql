
-- Status enum for access requests
DO $$ BEGIN
  CREATE TYPE public.request_status AS ENUM ('pending','approved','rejected');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Access requests from prospective students
CREATE TABLE IF NOT EXISTS public.access_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  whatsapp text NOT NULL,
  email text,
  notes text,
  status public.request_status NOT NULL DEFAULT 'pending',
  generated_code text,
  synthetic_email text,
  auto_password text,
  user_id uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  approved_at timestamptz
);

ALTER TABLE public.access_requests ENABLE ROW LEVEL SECURITY;

-- Anyone (including anon) can submit a request
DROP POLICY IF EXISTS "Anyone can submit a request" ON public.access_requests;
CREATE POLICY "Anyone can submit a request"
ON public.access_requests
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- Only admins can read/update/delete requests
DROP POLICY IF EXISTS "Admins manage requests" ON public.access_requests;
CREATE POLICY "Admins manage requests"
ON public.access_requests
FOR ALL
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Support ticket reply + admin manage already covered by existing policy; add columns
ALTER TABLE public.support_tickets
  ADD COLUMN IF NOT EXISTS admin_reply text,
  ADD COLUMN IF NOT EXISTS replied_at timestamptz;

-- Allow admins to delete (already covered by ALL policy "Admins manage tickets"), no change needed.

-- Bind a code to a specific provisioned user (optional)
ALTER TABLE public.access_codes
  ADD COLUMN IF NOT EXISTS bound_user_id uuid;
