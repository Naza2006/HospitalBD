USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'EmpresaSQL')
BEGIN
	ALTER DATABASE EmpresaSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE EmpresaSQL
END
GO

CREATE DATABASE EmpresaSQL
GO

USE EmpresaSQL
GO

CREATE SCHEMA Empresa
GO

CREATE SCHEMA Personal
GO

CREATE SCHEMA Ventas
GO

CREATE TABLE Empresa.TDepartamento (
	nDepartamentoID INT IDENTITY(1,1) CONSTRAINT PK_TDepartamento PRIMARY KEY,
	cNombreDepartamento NVARCHAR(60) NOT NULL CONSTRAINT UQ_TDepartamento_Nombre UNIQUE
)
GO

CREATE TABLE Personal.TCargo (
	nCargoID INT IDENTITY(1,1) CONSTRAINT PK_TCargo PRIMARY KEY,
	cNombreCargo NVARCHAR(60) NOT NULL CONSTRAINT UQ_TCargo_Nombre UNIQUE
)
GO

CREATE TABLE Personal.TEmpleado (
	nEmpleadoID INT IDENTITY(1,1) CONSTRAINT PK_TEmpleado PRIMARY KEY,
	cNIF NVARCHAR(30) CONSTRAINT UQ_TEmpleado_NIF UNIQUE,
	cNombre NVARCHAR(60) NOT NULL,
	cApellido NVARCHAR(60) NOT NULL,
	nDepartamentoID INT NOT NULL,
	nCargoID INT NOT NULL,
	dFechaContratacion DATE NOT NULL CONSTRAINT DF_TEmpleado_FechaContratacion DEFAULT GETDATE(),
	nSalario DECIMAL(10,2) NOT NULL CONSTRAINT CK_TEmpleado_Salario CHECK(nSalario > 300),
	CONSTRAINT FK_TEmpleado_TDepartamento FOREIGN KEY(nDepartamentoID) REFERENCES Empresa.TDepartamento(nDepartamentoID),
	CONSTRAINT FK_TEmpleado_TCargo FOREIGN KEY(nCargoID) REFERENCES Personal.TCargo(nCargoID)
)
GO

CREATE TABLE Empresa.TProyecto (
	nProyectoID INT IDENTITY(1,1) CONSTRAINT PK_TProyecto PRIMARY KEY,
	cNombreProyecto NVARCHAR(100) NOT NULL,
	dFechaInicio DATE NOT NULL,
	dFechaFinalizacion DATE NULL
)
GO

CREATE TABLE Empresa.TEmpleadoProyecto (
	nEmpleadoProyectoID INT IDENTITY(1,1) CONSTRAINT PK_TEmpleadoProyecto PRIMARY KEY,
	nEmpleadoID INT NOT NULL,
	nProyectoID INT NOT NULL,
	dFechaAsignacion DATE NOT NULL CONSTRAINT DF_TEmpleadoProyecto_FechaAsignacion DEFAULT GETDATE(),
	CONSTRAINT FK_TEmpleadoProyecto_TEmpleado FOREIGN KEY(nEmpleadoID) REFERENCES Personal.TEmpleado(nEmpleadoID),
	CONSTRAINT FK_TEmpleadoProyecto_TProyecto FOREIGN KEY(nProyectoID) REFERENCES Empresa.TProyecto(nProyectoID),
	CONSTRAINT UQ_TEmpleadoProyecto UNIQUE(nEmpleadoID, nProyectoID)
)
GO