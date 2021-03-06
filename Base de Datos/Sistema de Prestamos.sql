USE [master]
GO
/****** Object:  Database [Sistema de Prestamos]    Script Date: 14/4/2020 4:35:14 p. m. ******/
CREATE DATABASE [Sistema de Prestamos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sistema de Prestamos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Sistema de Prestamos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sistema de Prestamos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Sistema de Prestamos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Sistema de Prestamos] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sistema de Prestamos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sistema de Prestamos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sistema de Prestamos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sistema de Prestamos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sistema de Prestamos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sistema de Prestamos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sistema de Prestamos] SET  MULTI_USER 
GO
ALTER DATABASE [Sistema de Prestamos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sistema de Prestamos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sistema de Prestamos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sistema de Prestamos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Sistema de Prestamos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Sistema de Prestamos] SET QUERY_STORE = OFF
GO
USE [Sistema de Prestamos]
GO
/****** Object:  Table [dbo].[Amortizacion]    Script Date: 14/4/2020 4:35:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Amortizacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NoCuota] [int] NOT NULL,
	[InteresCuota] [money] NOT NULL,
	[Capital] [money] NOT NULL,
	[Pago] [money] NOT NULL,
	[IdPrestamo] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
 CONSTRAINT [PK_Amortizacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nchar](100) NOT NULL,
	[DIreccion] [nchar](100) NOT NULL,
	[Telefono] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamo]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Monto] [nchar](10) NOT NULL,
	[Interes] [money] NOT NULL,
	[TasaDeInteres] [int] NOT NULL,
	[Cuotas] [int] NOT NULL,
	[idCliente] [int] NOT NULL,
 CONSTRAINT [PK_Prestamo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Amortizacion]  WITH CHECK ADD  CONSTRAINT [FK_Amortizacion_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[Amortizacion] CHECK CONSTRAINT [FK_Amortizacion_Cliente]
GO
ALTER TABLE [dbo].[Amortizacion]  WITH CHECK ADD  CONSTRAINT [FK_Amortizacion_Prestamo] FOREIGN KEY([IdPrestamo])
REFERENCES [dbo].[Prestamo] ([id])
GO
ALTER TABLE [dbo].[Amortizacion] CHECK CONSTRAINT [FK_Amortizacion_Prestamo]
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD  CONSTRAINT [FK_Prestamo_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[Prestamo] CHECK CONSTRAINT [FK_Prestamo_Cliente]
GO
/****** Object:  StoredProcedure [dbo].[addClients]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addClients] @Nombre nvarchar(100), @Direccion nvarchar(100), @Telefono nvarchar(100)
AS
BEGIN
	INSERT INTO Cliente(Nombre,DIreccion,Telefono)
	VALUES(@Nombre,@Direccion,@Telefono)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteClients]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteClients] @Nombre nvarchar(50)
AS
BEGIN
	Delete from Cliente
	WHERE Nombre = @Nombre
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteLoans]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteLoans] @idLoans int
AS
BEGIN
	DELETE FROM [Sistema de Prestamos].dbo.Amortizacion
	WHERE IdPrestamo = @idLoans
	
	DELETE FROM [Sistema de Prestamos].dbo.Prestamo
	WHERE Prestamo.id = @idLoans
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateLoans]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateLoans] @Clientid int, @Amount money, @InterestRate int,@feesamount int
AS 
BEGIN
	SET NOCOUNT ON;
	-- Declaring Variables
	DECLARE @count INT
	DECLARE @interest money
	
	
	-- Instert in Prestamo Table
	SET @interest = ((@InterestRate*@Amount)/100)
	INSERT INTO dbo.Prestamo
	VALUES(@Amount,@interest,@InterestRate,@feesamount,@Clientid)

	--Searching @idPrestamo
	DECLARE @IdPrestamo int
	SET @IdPrestamo = (SELECT id FROM Prestamo P WHERE idCliente = @Clientid)
	
	
	-- Setting Amortization Table
	SET @count = 1
	WHILE @count <= @feesamount
	BEGIN
		INSERT INTO dbo.Amortizacion(NoCuota, InteresCuota, Capital,Pago,IdPrestamo,IdCliente)
		VALUES(@count, (@interest/@feesamount), (@Amount/@feesamount),0,@IdPrestamo,@IdPrestamo)
	SET @count = @count + 1
	END

END
GO
/****** Object:  StoredProcedure [dbo].[generatePaidments]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[generatePaidments] @idprestamo int, @Paidment money
AS
BEGIN
	DECLARE @NoCuota INT
	SET @NoCuota = 1
	DECLARE @id INT
	SELECT @id = IdPrestamo FROM Amortizacion

	WHILE (@id = @idprestamo AND @Paidment > 0)
	BEGIN
		
		-- Tomando el interes de la tabla
		DECLARE @Interes MONEY
		SELECT @Interes = InteresCuota FROM Amortizacion WHERE NoCuota = @NoCuota

		-- Tomando Capital de la tabla
		DECLARE @Capital MONEY
		SELECT @Capital = Capital FROM Amortizacion WHERE NoCuota = @NoCuota

		-- Buscando totales de interes y prestamo
		DECLARE @TotalCapital MONEY
		DECLARE @TotalInteres MONEY
		SELECT @TotalCapital = SUM(Capital) FROM Amortizacion WHERE IdPrestamo = @idprestamo
		SELECT @TotalInteres = SUM(InteresCuota) FROM Amortizacion WHERE IdPrestamo = @idprestamo
		
		-- Cobrando Interes
		IF (@Paidment > @Interes AND @Paidment < (@TotalCapital + @TotalInteres)) -- Si el pago es mayor al interes pero no da para pagar el prestamo
		BEGIN
			UPDATE Amortizacion
			SET InteresCuota = 0,
			Pago = @Paidment,
			Capital = CASE WHEN (@Paidment > @Capital) THEN (0) ELSE (@Capital - (@Paidment - @Interes)) END
			WHERE NoCuota = @NoCuota AND IdPrestamo = @idprestamo
			SET @Paidment = (@Paidment - @Interes - @Capital)
		END

		ELSE IF (@Paidment >= (@TotalCapital + @TotalInteres)) -- Si el pago da para saldar todo el prestamo
		BEGIN
			DECLARE @Sobrante MONEY
			SET @Sobrante = (@Paidment - (@TotalCapital + @TotalInteres))
			UPDATE Amortizacion
			SET InteresCuota = 0,
			Capital = 0,
			Pago = @Paidment
			WHERE IdPrestamo = @idprestamo

			PRINT 'Prestamo Saldo, le sobran ' + CAST(@Sobrante AS VARCHAR)
			BREAK

		END

		ELSE --si el pago es menor o igual al interes
		BEGIN
			UPDATE Amortizacion
			SET Pago = @Paidment,
			InteresCuota = (InteresCuota - @Paidment)
			WHERE NoCuota = @NoCuota AND IdPrestamo = @idprestamo
			SET @Paidment = (@Paidment - @Interes - @Capital)
		END
		
			SET @NoCuota = @NoCuota + 1
	
	END

	-- Este Stored Procedure es mi orgullo

END
GO
/****** Object:  StoredProcedure [dbo].[ModifyClients]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModifyClients] @clientid int,@Nombre nvarchar(50), @Direccion nvarchar(100), @Telefono nvarchar(20)
AS
BEGIN
	UPDATE [Sistema de Prestamos].dbo.Cliente
	SET Nombre = @Nombre,
	Direccion = @Direccion,
	Telefono = @Telefono
	WHERE Id = @clientid
END
GO
/****** Object:  StoredProcedure [dbo].[SearchClients]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchClients] @Nombre nvarchar(50)
AS
BEGIN
	SELECT * FROM Cliente
	WHERE Nombre = @Nombre
END
GO
/****** Object:  StoredProcedure [dbo].[SearchLoans]    Script Date: 14/4/2020 4:35:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchLoans] @CLientName nvarchar(50)
AS
BEGIN
	SELECT C.Nombre, P.id, P.Monto, p.Cuotas, P.TasaDeInteres
	FROM [Sistema de Prestamos].dbo.Prestamo P, [Sistema de Prestamos].dbo.Cliente C
	WHERE C.Id = P.idCliente AND C.Nombre = @CLientName
END
GO
USE [master]
GO
ALTER DATABASE [Sistema de Prestamos] SET  READ_WRITE 
GO
