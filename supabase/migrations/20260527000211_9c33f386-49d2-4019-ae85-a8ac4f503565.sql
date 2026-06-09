
-- 1) Enforce email NOT NULL on access_requests (fill any nulls first)
UPDATE public.access_requests SET email = 'unknown@example.com' WHERE email IS NULL;
ALTER TABLE public.access_requests ALTER COLUMN email SET NOT NULL;

-- 2) App settings singleton
CREATE TABLE public.app_settings (
  id BOOLEAN PRIMARY KEY DEFAULT true CHECK (id = true),
  primary_agent_name TEXT NOT NULL DEFAULT 'Contact admin for agent details',
  solo_amount NUMERIC NOT NULL DEFAULT 5,
  pair_amount NUMERIC NOT NULL DEFAULT 8,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

GRANT SELECT ON public.app_settings TO anon;
GRANT SELECT, INSERT, UPDATE ON public.app_settings TO authenticated;
GRANT ALL ON public.app_settings TO service_role;

ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read settings" ON public.app_settings FOR SELECT USING (true);
CREATE POLICY "Admins update settings" ON public.app_settings FOR UPDATE TO authenticated USING (has_role(auth.uid(), 'admin'::app_role)) WITH CHECK (has_role(auth.uid(), 'admin'::app_role));
CREATE POLICY "Admins insert settings" ON public.app_settings FOR INSERT TO authenticated WITH CHECK (has_role(auth.uid(), 'admin'::app_role));

INSERT INTO public.app_settings (id) VALUES (true) ON CONFLICT DO NOTHING;
