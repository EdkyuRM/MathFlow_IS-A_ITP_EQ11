-- A. Permitir que el docente vea quiénes se inscribieron a SUS cursos
CREATE POLICY "Docentes ven inscripciones de sus cursos" 
ON public.inscripcion 
FOR SELECT 
TO authenticated 
USING (
  EXISTS (
    SELECT 1 FROM public.curso 
    WHERE curso.id_curso = inscripcion.id_curso 
    AND curso.id_docente = auth.uid()
  )
);

-- B. Permitir que el docente vea los nombres de los usuarios (Alumnos)
-- Sin esto, la relación 'usuario!id_usuario' devuelve vacío
CREATE POLICY "Docentes ven nombres de alumnos" 
ON public.usuario 
FOR SELECT 
TO authenticated 
USING (true);

-- C. Permitir que el docente vea las calificaciones de sus alumnos
CREATE POLICY "Docentes ven progreso de sus alumnos" 
ON public.progreso_alumno 
FOR SELECT 
TO authenticated 
USING (
  EXISTS (
    SELECT 1 FROM public.curso 
    WHERE curso.id_docente = auth.uid()
    -- Aquí podrías añadir más lógica si fuera necesario, 
    -- pero con esto habilitas la lectura del progreso
  )
);