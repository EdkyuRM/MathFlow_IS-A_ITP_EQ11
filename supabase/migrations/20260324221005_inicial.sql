CREATE TYPE tipo_usuario_enum AS ENUM ('Estudiante', 'Docente', 'Administrador');

CREATE TABLE Usuario (
    ID_Usuario BIGSERIAL PRIMARY KEY, 
    Nombre VARCHAR(255) NOT NULL, 
    Correo VARCHAR(255) UNIQUE NOT NULL, 
    Contraseña VARCHAR(255) NOT NULL, 
    Tipo_Usuario tipo_usuario_enum NOT NULL
);

CREATE TABLE Curso (
    ID_Curso BIGSERIAL PRIMARY KEY, 
    Nombre_Curso VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL, 
    Nivel VARCHAR(100) NOT NULL, 
    ID_Docente INT NOT NULL REFERENCES Usuario(ID_Usuario) 
);

CREATE TABLE Leccion (
    ID_Leccion BIGSERIAL PRIMARY KEY, 
    ID_Curso INT NOT NULL REFERENCES Curso(ID_Curso),
    Tema VARCHAR(255) NOT NULL,
    Contenido TEXT NOT NULL, 
    Recursos_Didacticos TEXT 
);

CREATE TABLE Evaluacion (
    ID_Evaluacion BIGSERIAL PRIMARY KEY, 
    ID_Curso INT NOT NULL REFERENCES Curso(ID_Curso), 
    Tipo_Pregunta VARCHAR(100) NOT NULL,
    Pregunta TEXT NOT NULL, 
    Respuesta_Correcta TEXT NOT NULL,
    Puntaje INT NOT NULL 
);

CREATE TABLE Resultado_Academico (
    ID_Resultado BIGSERIAL PRIMARY KEY, 
    ID_Usuario INT NOT NULL REFERENCES Usuario(ID_Usuario), 
    ID_Evaluacion INT NOT NULL REFERENCES Evaluacion(ID_Evaluacion),
    Calificacion DECIMAL(4,2) NOT NULL, 
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Recomendacion_IA (
    ID_Recomendacion BIGSERIAL PRIMARY KEY, 
    ID_Usuario INT NOT NULL REFERENCES Usuario(ID_Usuario),
    Contenido_Sugerido TEXT NOT NULL, 
    Motivo_Recomendacion TEXT NOT NULL, 
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Historial_Aprendizaje (
    ID_Historial BIGSERIAL PRIMARY KEY, 
    ID_Usuario INT NOT NULL REFERENCES Usuario(ID_Usuario),
    Actividad TEXT NOT NULL, 
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Notificacion (
    ID_Notificacion BIGSERIAL PRIMARY KEY, 
    ID_Usuario INT NOT NULL REFERENCES Usuario(ID_Usuario), 
    Mensaje TEXT NOT NULL, 
    Fecha_Envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL 
);