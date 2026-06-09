--1.Crear base de datos
CREATE DATABASE HospitalDB;
GO

--2.Mostrar bases de datos existentes
SELECT name
FROM sys.databases;
GO

--3.Seleccionar HospitalDB
USE HospitalDB;
GO

--4.Crear tabla Pacientes
CREATE TABLE Pacientes
(
    IdPaciente INT IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100),
    Edad INT,
    Correo VARCHAR(100),
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

--5.Crear tabla Medicos
CREATE TABLE Medicos
(
    IdMedico INT IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100),
    Correo VARCHAR(100),
    Salario DECIMAL(10,2),
    IdEspecialidad INT
);
GO

--6.Crear tabla Especialidades
CREATE TABLE Especialidades
(
    IdEspecialidad INT IDENTITY(1,1),
    NombreEspecialidad VARCHAR(100),
    Descripcion VARCHAR(200)
);
GO

--7.Crear tabla Citas
CREATE TABLE Citas
(
    IdCita INT IDENTITY(1,1),
    FechaCita DATETIME,
    Motivo VARCHAR(200),
    IdPaciente INT,
    IdMedico INT
);
GO

--8.Crear tabla Habitaciones
CREATE TABLE Habitaciones
(
    IdHabitacion INT IDENTITY(1,1),
    NumeroHabitacion INT,
    TipoHabitacion VARCHAR(50),
    Estado VARCHAR(50),
    IdPaciente INT
);
GO

--9.Crear tabla Tratamientos
CREATE TABLE Tratamientos
(
    IdTratamiento INT IDENTITY(1,1),
    NombreTratamiento VARCHAR(100),
    Descripcion VARCHAR(200),
    IdPaciente INT
);
GO

--10.Crear tabla Medicamentos
CREATE TABLE Medicamentos
(
    IdMedicamento INT IDENTITY(1,1),
    NombreMedicamento VARCHAR(100),
    Descripcion VARCHAR(200),
    Stock INT,
    IdTratamiento INT
);
GO

--11.PRIMARY KEY Pacientes
ALTER TABLE Pacientes
ADD CONSTRAINT PK_Pacientes
PRIMARY KEY (IdPaciente);
GO

--12.PRIMARY KEY Medicos
ALTER TABLE Medicos
ADD CONSTRAINT PK_Medicos
PRIMARY KEY (IdMedico);
GO

--PK necesarias para referencias
ALTER TABLE Especialidades
ADD CONSTRAINT PK_Especialidades
PRIMARY KEY (IdEspecialidad);
GO

ALTER TABLE Citas
ADD CONSTRAINT PK_Citas
PRIMARY KEY (IdCita);
GO

ALTER TABLE Habitaciones
ADD CONSTRAINT PK_Habitaciones
PRIMARY KEY (IdHabitacion);
GO

ALTER TABLE Tratamientos
ADD CONSTRAINT PK_Tratamientos
PRIMARY KEY (IdTratamiento);
GO

ALTER TABLE Medicamentos
ADD CONSTRAINT PK_Medicamentos
PRIMARY KEY (IdMedicamento);
GO

--13.NOT NULL nombre paciente ya aplicado en CREATE TABLE

--14.NOT NULL nombre médico ya aplicado en CREATE TABLE

--15.UNIQUE correo paciente
ALTER TABLE Pacientes
ADD CONSTRAINT UQ_Pacientes_Correo
UNIQUE (Correo);
GO

--16.UNIQUE correo médico
ALTER TABLE Medicos
ADD CONSTRAINT UQ_Medicos_Correo
UNIQUE (Correo);
GO

--17.CHECK edad >= 0
ALTER TABLE Pacientes
ADD CONSTRAINT CHK_Pacientes_Edad
CHECK (Edad >= 0);
GO

--18.CHECK salario > 0
ALTER TABLE Medicos
ADD CONSTRAINT CHK_Medicos_Salario
CHECK (Salario > 0);
GO

--19.DEFAULT fecha registro ya aplicado en CREATE TABLE

--20.FK Médicos a Especialidades
ALTER TABLE Medicos
ADD CONSTRAINT FK_Medicos_Especialidades
FOREIGN KEY (IdEspecialidad)
REFERENCES Especialidades(IdEspecialidad);
GO

--21.FK Citas a Pacientes
ALTER TABLE Citas
ADD CONSTRAINT FK_Citas_Pacientes
FOREIGN KEY (IdPaciente)
REFERENCES Pacientes(IdPaciente);
GO

--22.FK Citas a Médicos
ALTER TABLE Citas
ADD CONSTRAINT FK_Citas_Medicos
FOREIGN KEY (IdMedico)
REFERENCES Medicos(IdMedico);
GO

--23.FK Tratamientos a Pacientes
ALTER TABLE Tratamientos
ADD CONSTRAINT FK_Tratamientos_Pacientes
FOREIGN KEY (IdPaciente)
REFERENCES Pacientes(IdPaciente);
GO

--24.FK Medicamentos a Tratamientos
ALTER TABLE Medicamentos
ADD CONSTRAINT FK_Medicamentos_Tratamientos
FOREIGN KEY (IdTratamiento)
REFERENCES Tratamientos(IdTratamiento);
GO

--25.FK Habitaciones a Pacientes
ALTER TABLE Habitaciones
ADD CONSTRAINT FK_Habitaciones_Pacientes
FOREIGN KEY (IdPaciente)
REFERENCES Pacientes(IdPaciente);
GO

USE HospitalDB;
GO

/*=================================================
  MODULO III (26 - 40)
=================================================*/

--26.Agregar columna teléfono a Pacientes
ALTER TABLE Pacientes
ADD Telefono VARCHAR(20);
GO

--27.Agregar columna dirección a Pacientes
ALTER TABLE Pacientes
ADD Direccion VARCHAR(200);
GO

--28.Agregar columna género
ALTER TABLE Pacientes
ADD Genero VARCHAR(20);
GO

--29.Agregar columna tipo_sangre
ALTER TABLE Pacientes
ADD TipoSangre VARCHAR(5);
GO

--30.Agregar columna fecha_nacimiento
ALTER TABLE Pacientes
ADD FechaNacimiento DATE;
GO

--31.Modificar tamaño del campo nombre
ALTER TABLE Pacientes
ALTER COLUMN Nombre VARCHAR(150) NOT NULL;
GO

--32.Modificar tamaño del campo dirección
ALTER TABLE Pacientes
ALTER COLUMN Direccion VARCHAR(300);
GO

--33.Agregar columna experiencia a Médicos
ALTER TABLE Medicos
ADD Experiencia INT;
GO

--34.Agregar columna turno
ALTER TABLE Medicos
ADD Turno VARCHAR(30);
GO

--35.Agregar columna observaciones
ALTER TABLE Medicos
ADD Observaciones VARCHAR(500);
GO

--36.Eliminar columna observaciones
ALTER TABLE Medicos
DROP COLUMN Observaciones;
GO

--37.Agregar columna estado a Citas
ALTER TABLE Citas
ADD Estado VARCHAR(30);
GO

--38.Agregar columna costo_consulta
ALTER TABLE Citas
ADD CostoConsulta DECIMAL(10,2);
GO

--39.Modificar tipo de dato del costo
ALTER TABLE Citas
ALTER COLUMN CostoConsulta DECIMAL(12,2);
GO

--40.Agregar columna disponibilidad a Habitaciones
ALTER TABLE Habitaciones
ADD Disponibilidad VARCHAR(30);
GO

USE HospitalDB;
GO

/*=================================================
  MODULO IV - ELIMINACION DE OBJETOS (DROP)
=================================================*/

--41.Eliminar una tabla temporal
CREATE TABLE TablaTemporal
(
    Id INT PRIMARY KEY,
    Descripcion VARCHAR(100)
);
GO

DROP TABLE TablaTemporal;
GO

--42.Eliminar una restricción CHECK
ALTER TABLE Pacientes
DROP CONSTRAINT CHK_Pacientes_Edad;
GO

--43.Eliminar una restricción UNIQUE
ALTER TABLE Pacientes
DROP CONSTRAINT UQ_Pacientes_Correo;
GO

--44.Eliminar una columna
ALTER TABLE Habitaciones
DROP COLUMN Disponibilidad;
GO

--45.Eliminar una tabla de pruebas
CREATE TABLE TablaPruebas
(
    Id INT PRIMARY KEY,
    Nombre VARCHAR(50)
);
GO

DROP TABLE TablaPruebas;
GO

/* 46. Crear y eliminar una tabla Auditoria */
CREATE TABLE Auditoria
(
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE(),
    Descripcion VARCHAR(200)
);
GO

DROP TABLE Auditoria;
GO

/* 47. Crear y eliminar una tabla Logs */
CREATE TABLE Logs
(
    IdLog INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE(),
    Mensaje VARCHAR(200)
);
GO

DROP TABLE Logs;
GO

/* 48. Eliminar una FOREIGN KEY */
ALTER TABLE Habitaciones
DROP CONSTRAINT FK_Habitaciones_Pacientes;
GO

/* 49. Eliminar una tabla MedicamentosPrueba */
CREATE TABLE MedicamentosPrueba
(
    IdMedicamento INT PRIMARY KEY,
    Nombre VARCHAR(100)
);
GO

DROP TABLE MedicamentosPrueba;
GO

/* 50. Eliminar una base de datos de pruebas */
IF DB_ID('HospitalDB_Pruebas') IS NULL
BEGIN
    CREATE DATABASE HospitalDB_Pruebas;
END
GO

DROP DATABASE HospitalDB_Pruebas;
GO