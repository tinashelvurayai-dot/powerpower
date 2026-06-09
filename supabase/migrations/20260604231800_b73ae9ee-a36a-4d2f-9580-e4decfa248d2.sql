
DROP POLICY "anyone can submit request" ON public.access_requests;
CREATE POLICY "anyone can submit valid request" ON public.access_requests
  FOR INSERT TO anon, authenticated
  WITH CHECK (
    char_length(trim(full_name)) BETWEEN 2 AND 100
    AND char_length(trim(whatsapp)) BETWEEN 6 AND 30
    AND status = 'pending'
    AND access_code IS NULL
    AND approved_at IS NULL
  );
