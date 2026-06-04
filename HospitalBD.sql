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