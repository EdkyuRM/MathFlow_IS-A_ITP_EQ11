-- Habilitar RLS en la tabla curso
ALTER TABLE public.curso ENABLE ROW LEVEL SECURITY;

-- Política: Un docente solo puede ver los cursos que él mismo creó
CREATE POLICY "Docentes ven sus propios cursos" 
ON public.curso 
FOR SELECT 
TO authenticated 
USING (id_docente = auth.uid());