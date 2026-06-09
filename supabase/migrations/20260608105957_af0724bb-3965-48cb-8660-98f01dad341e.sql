DELETE FROM public.user_roles WHERE role = 'admin';

CREATE OR REPLACE FUNCTION public.claim_admin()
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $function$
DECLARE
  uid uuid := auth.uid();
BEGIN
  IF uid IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'Not authenticated');
  END IF;
  -- Reset: remove any existing admins, then make the current user the sole admin.
  DELETE FROM public.user_roles WHERE role = 'admin' AND user_id <> uid;
  INSERT INTO public.user_roles (user_id, role) VALUES (uid, 'admin')
    ON CONFLICT (user_id, role) DO NOTHING;
  RETURN jsonb_build_object('success', true);
END;
$function$;