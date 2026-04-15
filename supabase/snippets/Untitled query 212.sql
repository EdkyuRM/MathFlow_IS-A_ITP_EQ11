ALTER TABLE public.recurso_refuerzo ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lectura pública de recursos" ON public.recurso_refuerzo FOR SELECT TO authenticated USING (true);