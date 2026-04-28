-- Vaciar las tablas transaccionales y reiniciar sus IDs a 1
TRUNCATE TABLE 
  public.progreso_alumno,
  public.evaluacion,
  public.recurso_refuerzo,
  public.leccion,
  public.inscripcion,
  public.curso
RESTART IDENTITY CASCADE;