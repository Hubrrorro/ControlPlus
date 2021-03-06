USE [master]
GO
/****** Object:  Database [ControlProKSDP]    Script Date: 12/01/2017 09:09:28 a. m. ******/
CREATE DATABASE [ControlProKSDP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ControlProKSDP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ControlProKSDP.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ControlProKSDP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ControlProKSDP_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ControlProKSDP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ControlProKSDP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ControlProKSDP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ControlProKSDP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ControlProKSDP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ControlProKSDP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ControlProKSDP] SET ARITHABORT OFF 
GO
ALTER DATABASE [ControlProKSDP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ControlProKSDP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ControlProKSDP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ControlProKSDP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ControlProKSDP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ControlProKSDP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ControlProKSDP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ControlProKSDP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ControlProKSDP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ControlProKSDP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ControlProKSDP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ControlProKSDP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ControlProKSDP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ControlProKSDP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ControlProKSDP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ControlProKSDP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ControlProKSDP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ControlProKSDP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ControlProKSDP] SET  MULTI_USER 
GO
ALTER DATABASE [ControlProKSDP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ControlProKSDP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ControlProKSDP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ControlProKSDP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ControlProKSDP] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ControlProKSDP]
GO
/****** Object:  User [KSDPUser]    Script Date: 12/01/2017 09:09:28 a. m. ******/
CREATE USER [KSDPUser] FOR LOGIN [KSDPUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [KSDPUser]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCustomPass]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnCustomPass] 
(    
    @size AS INT --Tamaño de la cadena aleatoria
    --@op AS VARCHAR(2) --Opción para letras(ABC..), numeros(123...) o ambos.
)
RETURNS VARCHAR(62)
AS
BEGIN    

    DECLARE @chars AS VARCHAR(52),
            @numbers AS VARCHAR(10),
            @strChars AS VARCHAR(62),        
            @strPass AS VARCHAR(62),
            @index AS INT,
            @cont AS INT

    SET @strPass = ''
    SET @strChars = ''    
    SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    SET @numbers = '0123456789'

    SET @strChars =  @chars + @numbers; --Ambos (Letras y Números)
                        

    SET @cont = 0
    WHILE @cont < @size
    BEGIN
        SET @index = ceiling( ( SELECT rnd FROM VRandom ) * (len(@strChars)))--Uso de la vista para el Rand() y no generar error.
        SET @strPass = @strPass + substring(@strChars, @index, 1)
        SET @cont = @cont + 1
    END    
        
    RETURN @strPass

END



GO
/****** Object:  Table [dbo].[Cat_Cliente]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cat_Cliente](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cat_Documentos]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_Documentos](
	[id_Documento] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[Activo] [bit] NULL,
	[Codigo] [nvarchar](60) NULL,
	[EXTENSION] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_Estatus]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cat_Estatus](
	[id_Estatus] [int] IDENTITY(1,1) NOT NULL,
	[Estatus] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cat_Etapa]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cat_Etapa](
	[id_Etapa] [int] IDENTITY(1,1) NOT NULL,
	[Etapa] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cat_HistEtapa]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_HistEtapa](
	[IDTicket] [int] NOT NULL,
	[id_Etapa] [int] NOT NULL,
	[Fecha] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_Menu]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_Menu](
	[idMenu] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](50) NULL,
	[Ruta] [nvarchar](150) NULL,
	[idPadre] [int] NULL,
	[idWebAPP] [int] NULL,
	[Ordenar] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_menupuesto]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_menupuesto](
	[idMenu] [int] NULL,
	[idPuesto] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_Puesto]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cat_Puesto](
	[idPuesto] [int] IDENTITY(1,1) NOT NULL,
	[Puesto] [varchar](100) NULL,
	[funciones] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[idPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cat_SVN]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_SVN](
	[idSVN] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[Ruta] [nvarchar](200) NULL,
	[Usuario] [nvarchar](50) NULL,
	[Pass] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_SVN] PRIMARY KEY CLUSTERED 
(
	[idSVN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_SVNLocal]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_SVNLocal](
	[idUsuario] [int] NULL,
	[idSVN] [int] NULL,
	[RutaSVN] [nvarchar](400) NULL,
	[RutaLocal] [nvarchar](400) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_TicketDocumentos]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cat_TicketDocumentos](
	[idTicket] [int] NULL,
	[Ruta] [nvarchar](150) NULL,
	[Version] [int] NULL,
	[idDocumento] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cat_Tipo]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cat_Tipo](
	[id_Tipo] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatSistema]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatSistema](
	[idSistema] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[Sistema] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idSistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CatSubEtapa]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatSubEtapa](
	[idCatSubEtapa] [int] IDENTITY(1,1) NOT NULL,
	[SubEtapa] [nvarchar](50) NULL,
 CONSTRAINT [PK_CatSubEtapa] PRIMARY KEY CLUSTERED 
(
	[idCatSubEtapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CatTicketEmpleado]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatTicketEmpleado](
	[idEmpleado] [int] NOT NULL,
	[IDTicket] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblActividades]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblActividades](
	[idActividades] [int] IDENTITY(1,1) NOT NULL,
	[idTblProyect] [int] NOT NULL,
	[Responsable] [int] NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
	[Horas] [decimal](18, 0) NULL,
	[HorasReales] [decimal](18, 0) NULL,
	[EDT] [varchar](20) NULL,
	[Porcentaje] [int] NULL,
	[Padre] [int] NULL,
	[Descripcion] [varchar](200) NULL,
	[Cobrada] [bit] NULL,
	[MesFacturacion] [int] NULL,
	[AñoFacturacion] [int] NULL,
	[Documento] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idActividades] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TblAsuntos]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAsuntos](
	[idAsunto] [int] NOT NULL,
	[Fecha] [date] NULL,
	[Identificado] [nvarchar](20) NULL,
	[Descripcion] [nvarchar](150) NULL,
	[TipoAsunto] [nvarchar](20) NULL,
	[FechaPlaneada] [date] NULL,
	[Responsable] [nvarchar](20) NULL,
	[Estatus] [nvarchar](10) NULL,
	[FchSeguimiento] [date] NULL,
	[AccionesSol] [nvarchar](50) NULL,
	[Efectividad] [nvarchar](50) NULL,
	[Comentarios] [nvarchar](200) NULL,
	[IDTticket] [int] NOT NULL,
 CONSTRAINT [PK_TblAsuntos] PRIMARY KEY CLUSTERED 
(
	[idAsunto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblBitacora]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblBitacora](
	[idBitacora] [int] IDENTITY(1,1) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[IDTicket] [int] NOT NULL,
	[Comentario] [varchar](500) NULL,
	[FchComentario] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idBitacora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TblCC]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblCC](
	[idCC] [int] IDENTITY(1,1) NOT NULL,
	[IDTicket] [int] NOT NULL,
	[FchEntrega] [date] NULL,
	[FchRecep] [date] NULL,
	[Horas] [decimal](18, 0) NULL,
	[UsuSol] [varchar](150) NULL,
	[Identificador] [varchar](20) NULL,
	[FchUp] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TblComentarioReunion]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblComentarioReunion](
	[idCometarioReunion] [int] IDENTITY(1,1) NOT NULL,
	[Comentario] [nvarchar](300) NOT NULL,
	[idReunion] [int] NOT NULL,
 CONSTRAINT [PK_TblComentarioReunion] PRIMARY KEY CLUSTERED 
(
	[idCometarioReunion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblCompromiso]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCompromiso](
	[FechIdent] [date] NOT NULL,
	[DondeIdent] [nvarchar](50) NOT NULL,
	[DescCompromiso] [nvarchar](150) NOT NULL,
	[FechaPlaneada] [date] NOT NULL,
	[Responsable] [nvarchar](50) NOT NULL,
	[Prioridad] [nvarchar](10) NOT NULL,
	[Estatus] [nvarchar](20) NOT NULL,
	[FechaAtendido] [date] NULL,
	[idCompromiso] [int] IDENTITY(1,1) NOT NULL,
	[Comentarios] [nvarchar](300) NULL,
	[IDTicket] [int] NULL,
 CONSTRAINT [PK_TblCompromiso] PRIMARY KEY CLUSTERED 
(
	[idCompromiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblEmpleado]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblEmpleado](
	[idEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[idPuesto] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[ApellidoPat] [varchar](50) NULL,
	[ApellidoMat] [varchar](50) NULL,
	[Usuario] [varchar](20) NOT NULL,
	[FchIngreso] [date] NULL,
	[FchBaja] [date] NULL,
	[FchNac] [date] NULL,
	[Pass] [varchar](256) NULL,
	[Activo] [bit] NULL,
	[Correo] [varchar](150) NULL,
	[idEmpresa] [int] NULL,
	[Iniciales] [varchar](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TblGuiaAjusteConfiguration]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblGuiaAjusteConfiguration](
	[idGuia] [int] IDENTITY(1,1) NOT NULL,
	[Proceso] [nvarchar](50) NOT NULL,
	[Actividad] [nvarchar](150) NOT NULL,
	[Producto] [nvarchar](200) NOT NULL,
	[Documento] [nvarchar](300) NULL,
	[Carpeta] [nvarchar](20) NOT NULL,
	[ArchivoKSDP] [nvarchar](100) NULL,
 CONSTRAINT [PK_TblGuiaAjusteConfiguration] PRIMARY KEY CLUSTERED 
(
	[idGuia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblGuiaAjusteDocumento]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblGuiaAjusteDocumento](
	[idTicket] [int] NOT NULL,
	[idDocumento] [int] NOT NULL,
	[idGuia] [int] NOT NULL,
 CONSTRAINT [PK_TblGuiaAjusteDocumento] PRIMARY KEY CLUSTERED 
(
	[idTicket] ASC,
	[idDocumento] ASC,
	[idGuia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblParticipante]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblParticipante](
	[idParticipante] [int] IDENTITY(1,1) NOT NULL,
	[Participante] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](100) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblProyect]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProyect](
	[idTblProyect] [int] IDENTITY(1,1) NOT NULL,
	[TblTicket_IDTicket] [int] NOT NULL,
	[FchAlta] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTblProyect] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblReunion]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblReunion](
	[idReunion] [int] IDENTITY(1,1) NOT NULL,
	[Objetivo] [nvarchar](50) NOT NULL,
	[idTicket] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_TblReunion] PRIMARY KEY CLUSTERED 
(
	[idReunion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblReunionPart]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblReunionPart](
	[IdParticipante] [int] NOT NULL,
	[idReunion] [int] NOT NULL,
	[Anexo] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblRiesgo]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRiesgo](
	[idRiesgo] [int] IDENTITY(1,1) NOT NULL,
	[idTicket] [int] NULL,
	[Fecha] [date] NULL,
	[Categoria] [nvarchar](20) NULL,
	[Interno] [bit] NULL,
	[Descripcion] [nvarchar](300) NULL,
	[Probabilidad] [int] NULL,
	[Impacto] [int] NULL,
	[Semaforo] [nchar](10) NULL,
	[Estategia] [nchar](10) NULL,
	[Estatus] [nchar](10) NULL,
 CONSTRAINT [PK_TblRiesgo] PRIMARY KEY CLUSTERED 
(
	[idRiesgo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblRiesgoComentario]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRiesgoComentario](
	[idComentario] [int] IDENTITY(1,1) NOT NULL,
	[idRiesgo] [int] NOT NULL,
	[Comentario] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_TblRiesgoComentario] PRIMARY KEY CLUSTERED 
(
	[idComentario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblRiesgoContingencia]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRiesgoContingencia](
	[idContingencia] [int] IDENTITY(1,1) NOT NULL,
	[idRiesgo] [int] NULL,
	[Contingencia] [nvarchar](300) NULL,
 CONSTRAINT [PK_TblRiesgoContingencia] PRIMARY KEY CLUSTERED 
(
	[idContingencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblRiesgoMitigacion]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRiesgoMitigacion](
	[idMitigacion] [int] IDENTITY(1,1) NOT NULL,
	[idRiesgo] [int] NULL,
	[Mitigacion] [nvarchar](300) NULL,
 CONSTRAINT [PK_TblRiesgoMitigacion] PRIMARY KEY CLUSTERED 
(
	[idMitigacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblTicket]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblTicket](
	[IDTicket] [int] IDENTITY(1,1) NOT NULL,
	[idSistema] [int] NOT NULL,
	[id_Tipo] [int] NOT NULL,
	[id_Etapa] [int] NOT NULL,
	[id_Estatus] [int] NOT NULL,
	[Ticket] [nvarchar](20) NULL,
	[FechaAlta] [date] NULL,
	[Identificador] [varchar](15) NULL,
	[Nombre] [varchar](100) NULL,
	[Descripcion] [varchar](500) NULL,
	[idSubEtapa] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TblTicketActvidadesDocs]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TblTicketActvidadesDocs](
	[id_Documento] [int] NOT NULL,
	[idActividades] [int] NOT NULL,
	[FchUpload] [date] NULL,
	[FchMod] [date] NULL,
	[UsuUp] [int] NULL,
	[UsuMod] [int] NULL,
	[Ruta] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[VRandom]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VRandom]
AS
SELECT RAND() as Rnd



GO
SET IDENTITY_INSERT [dbo].[Cat_Cliente] ON 

INSERT [dbo].[Cat_Cliente] ([idCliente], [Cliente]) VALUES (0, N'KRIOSOFT')
INSERT [dbo].[Cat_Cliente] ([idCliente], [Cliente]) VALUES (1, N'FOVISSSTE')
INSERT [dbo].[Cat_Cliente] ([idCliente], [Cliente]) VALUES (2, N'ISSSTE')
INSERT [dbo].[Cat_Cliente] ([idCliente], [Cliente]) VALUES (3, N'ALTAVISTA')
INSERT [dbo].[Cat_Cliente] ([idCliente], [Cliente]) VALUES (4, N'')
SET IDENTITY_INSERT [dbo].[Cat_Cliente] OFF
SET IDENTITY_INSERT [dbo].[Cat_Documentos] ON 

INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (27, 1, N'Orden de Trabajo - ODT', 1, N'PE-CAT-AOP-76-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (28, 1, N'Matriz de casos de pruebas', 1, N'PE-CAT-AOP-58-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (29, 1, N'Documento de Caso de Uso', 1, N'PE-CAT-AOP-50-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (30, 1, N' Minuta de Trabajo (Se requiere este documento completo)', 1, N'IBDS-CSI-ASI-15-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (31, 1, N'Matriz de Pruebas', 1, N' PE-CAT-AOP-77-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (32, 1, N'Entrega de plan de trabajo ', 1, N'Entrega de plan de trabajo ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (33, 1, N'Doc. de Descrip. de Roles y Respon. de los Grup. de Trab.', 1, N'PE-CAT-AOP-36-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (34, 1, N'Análisis y Diseño de Requerimiento', 1, N'PE-CAT-AOP-49-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (35, 1, N' Revisión de calidad de base de datos', 1, N'PE-CAT-AOP-82-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (36, 1, N' Documento de diseño', 1, N'PE-CAT-AOP-19-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (37, 1, N'Documento de registro de pruebas unitarias(Bitacora Pruebas Firmado por el Enlace)', 1, N'PE-CAT-AOP-21-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (38, 1, N'Pase de Aplicaciones al Ambiente de Calidad', 1, N'IBDS-AAP-AOP-57-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (39, 1, N' Pase al ambiente de QA de base de datos', 1, N' PE-CAT-AOP-53-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (40, 1, N'Manual Técnico de la solución tecnológica', 1, N'PE-CAT-AOP-23-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (41, 1, N'Manual de usuario de la solución TIC', 1, N'PE-CAT-AOP-54-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (42, 1, N'Carta de aceptación de usuario QA', 1, N'PE-CAT-AOP-55-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (43, 1, N'Carta de Aceptación - Implementación', 1, N'PE-CAT-AOP-79-000  ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (44, 1, N' Carta suspensión del requerimiento', 1, N'PE-CAT-AOP-80-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (45, 1, N'Carta de cancelación del requerimiento', 1, N'PE-CAT-AOP-81-000  ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (46, 1, N'Liberaciones derivadas de la operación al ambiente de producción (Base de Datos)-SC', 1, N'IBDS-ABD-AOP-2-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (47, 1, N'Pase de base de datos al ambiente de producción', 1, N'IBDS-CBD-AOP-4-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (48, 1, N'Pase de Aplicaciones al Ambiente de Produccion', 1, N'IBDS-AAP-AOP-3-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (49, 1, N'Solicitud de servicio', 1, N'JSTI-PE-AOP-90-000', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (50, 1, N'Presupuesto', 1, N'Presupuesto', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (51, 1, N'ANEXO TÉCNICO ', 1, N'ANEXO TÉCNICO ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (52, 1, N'Guía de Adaptación del Proyecto', 1, N'JSTI-PE-AOP-89-000 ', NULL)
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (206, 0, N'PLAN DE PROCESO', 1, N'KSDP_OPD_F01_PLANPROCESO', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (207, 0, N'GUIA DE AJUSTE ', 1, N'KSDP_OPD_F02_GUIAAJUSTE', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (208, 0, N'REPORTE DE CUMPLIMIENTO', 1, N'KSDP_OT_F05_REPORTECUMPLIMIENTO', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (209, 0, N'EVALUACION DE EFECTIVIDAD', 1, N'KSDP_OT_F06_EVALUACIONEFECTIVIDAD', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (210, 0, N'EVALUACION DEL CURSO', 1, N'KSDP_OT_F07_EVALUACIONCURSO', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (211, 0, N'RETROALIMENTACION DE LA CAPACITACION', 1, N'KSDP_OT_F08_RETROALIMENTACIONCAPACITACION', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (212, 0, N'REGISTRO ASISTENCIA', 1, N'KSDP_OT_F09_REGISTROASISTENCIA', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (213, 0, N'CARTA DESCRIPTIVA ', 1, N'KSDP_OT_F10_CARTADESCRIPTIVA', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (214, 0, N'DECLINA CAPACITACION', 1, N'KSDP_OT_F11_DECLINACAPACITACION', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (215, 0, N'CONTANCIA', 1, N'KSDP_OT_F12_CONSTANCIA', N'.PPT')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (216, 0, N'SOLICITUD DE CAPACITACION', 1, N'KSDP_OT_F03_SOLICITUDCAPACITACION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (217, 0, N'DETECCION DE NECESIDADES DE CAPACITACION', 1, N'KSDP_OT_F02_DETECCIONNECESIDADESCAPACITACION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (218, 0, N'ESTRATEGIA DE CAPACITACION', 1, N'KSDP_OT_F01_ESTRATEGIACAPACITACION', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (219, 0, N'PLAN DE CAPACITACION', 1, N'KSDP_OT_F04_PLANCAPACITACION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (220, 0, N'BITACORA DE SEGUIMIENTO', 1, N'KSDP_PMC_F01_BITACORASEGUIMIENTO', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (221, 0, N'AVANCE DEL PROYECTO', 1, N'KSDP_PMC_F02_AVANCEPROYECTO', N'.PPT')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (222, 0, N'HITO DEL PROYECTO', 1, N'KSDP_PMC_F03_HITOPROYECTO', N'.PPT')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (223, 0, N'CARTA DE CIERRE', 1, N'KSDP_PMC_F04_CARTACIERRE', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (224, 0, N'ESTIMACION DE ATRIBUTOS', 1, N'KSDP_PP_F01_ESTIMACIONATRIBUTOS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (225, 0, N'ESTIMACION DE ESFUERZO DELPHI', 1, N'KSDP_PP_F02_ESTIMACIONESFUERZO_DELPHI', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (226, 0, N'PLAN DE PROVICIONES', 1, N'KSDP_PP_F03_PLANPROVISIONES', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (227, 0, N'PLAN DE PROYECTO', 1, N'KSDP_PP_F04_PLANPROYECTO', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (228, 0, N'SOLICITUD DE AUDITOR ASEGURAMIENTO', 1, N'KSDP_PP_F05_SOLICITUDAUDITORASEGURAMIENTO', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (229, 0, N'WBS', 1, N'KSDP_PP_F06_WBS', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (230, 0, N'KICK OFF', 1, N'KSDP_PP_F07_KICKOFF', N'.PPT')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (231, 0, N'ESTIMADOR KRIOSOFT', 1, N'KSDP_PP_F08_ESTIMADORKRIOSOFT', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (232, 0, N'MINUTA', 1, N'KSDP_PP_F09_000_FORMATOMINUTA', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (233, 0, N'RASTREABILIDAD', 1, N'KSDP_REQM_F01_RASTREABILIDAD', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (234, 0, N'SOLICITUD DE CAMBIO', 1, N'KSDP_REQM_F02_SOLICITUDCAMBIO', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (235, 0, N'CONCENTRADO DE SOLICITUD DE CAMBIOS', 1, N'KSDP_REQM_F03_CONCENTRADOSOLICITUDCAMBIOS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (236, 0, N'MATRIZ DE RIESGOS', 1, N'KSDP_RSKM_F01_MATRIZRIESGOS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (237, 0, N'PLAN DE INTEGRACION', 1, N'KSDP_PI_F01_PLANINTEGRACION', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (238, 0, N'PLAN DE IMPLEMENTACION', 1, N'KSDP_PI_F02_PLANIMPLEMENTACION', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (239, 0, N'REQUERIMIENTOS', 1, N'KSDP_RD_F01_REQUERIMIENTOS', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (240, 0, N'DISEÑO ALTO NIVEL', 1, N'KSDP_TS_F01_DISEÑOALTONIVEL', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (241, 0, N'DISEÑO BAJO NIVEL', 1, N'KSDP_TS_F02_DISEÑOBAJONIVEL', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (242, 0, N'ESTRATEGIA DE PRUEBAS', 1, N'KSDP_VAL_F01_ESTRATEGIAPRUEBAS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (243, 0, N'MATRIZ DE CASOS DE PRUEBA', 1, N'KSDP_VAL_F02_MATRIZCASOSPRUEBA', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (244, 0, N'MATRIZ DE PRODUCTOS A VERIFICAR', 1, N'KSDP_VER_F01_MATRIZPRODUCTOSVERIFICAR', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (245, 0, N'REPORTE DE REVISIONES', 1, N'KSDP_VER_F02_REPORTEREVISIONES', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (246, 0, N'PLAN ADMINISTRACION DE CONFIGURACION', 1, N'KSDP_CM_F01_PLANADMINISTRACIONCONFIGURACION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (247, 0, N'REPORTE DE REVISIONES DE CONFIGURACION', 1, N'KSDP_CM_F02_REPORTEREVISIONESCONFIGURACION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (248, 0, N'SEGUIMIENTO DE LINEA BASE ', 1, N'KSDP_CM_F03_SEGUIMIENTOLINEABASE', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (249, 0, N'TOMA DE DECISION', 1, N'KSDP_DAR_F01_TOMADECISION', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (250, 0, N'PLAN DE METRICAS', 1, N'KSDP_MA_F01_PLANMETICAS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (251, 0, N'MATRIZ DE METRICAS', 1, N'KSDP_MA_F02_MATRIZMETRICAS', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (252, 0, N'PLAN DE ASEGURAMIENTO DE CALIDAD', 1, N'KSDP_PPQA_F01_PLANASEGURAMIENTOCALIDAD', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (253, 0, N'HALLAZGOS DE AUDITORIA', 1, N'KSDP_PPQA_F02_HALLAZGOSAUDITORIA', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (254, 0, N'REPORTE DE AVANCE', 1, N'KSDP_PPQA_F03_REPORTEAVANCE', N'.XLSX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (255, 0, N'ASIGNACION DE RECURSOS ', 1, N'KSDP_PPQA_F04_ASIGNACIONRECURSOS', N'.DOCX')
INSERT [dbo].[Cat_Documentos] ([id_Documento], [idCliente], [Nombre], [Activo], [Codigo], [EXTENSION]) VALUES (256, 0, N'LISTA DE VERIFICACION GESTION PROCESO(COMPLETA)', 1, N'KSDP_PPQA_F05_LISTAVERIFICACION_GESTION_PROCESO_COMPLETA', N'.XLSX')
SET IDENTITY_INSERT [dbo].[Cat_Documentos] OFF
SET IDENTITY_INSERT [dbo].[Cat_Estatus] ON 

INSERT [dbo].[Cat_Estatus] ([id_Estatus], [Estatus]) VALUES (1, N'ACTIVO')
SET IDENTITY_INSERT [dbo].[Cat_Estatus] OFF
SET IDENTITY_INSERT [dbo].[Cat_Etapa] ON 

INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (1, N'PREANALISIS')
INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (2, N'ANALISIS')
INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (3, N'DISEÑO')
INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (4, N'CONTRUCCION')
INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (5, N'PRUEBAS')
INSERT [dbo].[Cat_Etapa] ([id_Etapa], [Etapa]) VALUES (6, N'LIBERACION')
SET IDENTITY_INSERT [dbo].[Cat_Etapa] OFF
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (2, 1, CAST(N'2017-01-05' AS Date))
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (6, 1, CAST(N'2017-01-08' AS Date))
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (7, 1, CAST(N'2017-01-08' AS Date))
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (8, 1, CAST(N'2017-01-08' AS Date))
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (9, 1, CAST(N'2017-01-08' AS Date))
INSERT [dbo].[Cat_HistEtapa] ([IDTicket], [id_Etapa], [Fecha]) VALUES (10, 1, CAST(N'2017-01-08' AS Date))
SET IDENTITY_INSERT [dbo].[Cat_Menu] ON 

INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (1, N'SVN', NULL, 7, 0, 0)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (2, N'Configura SVN', NULL, 1, 0, 0)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (3, N'Inicio', NULL, 0, 0, 1)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (4, N'Ticket', NULL, 3, 0, 0)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (5, N'Agregar', NULL, 4, 0, 0)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (6, N'Modificar', NULL, 4, 0, 1)
INSERT [dbo].[Cat_Menu] ([idMenu], [Titulo], [Ruta], [idPadre], [idWebAPP], [Ordenar]) VALUES (7, N'Configuracion', NULL, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Cat_Menu] OFF
SET IDENTITY_INSERT [dbo].[Cat_Puesto] ON 

INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (1, N'ADMINISTRADOR', NULL)
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (2, N'Lider de Proyecto', NULL)
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (3, N'PMO', NULL)
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (4, N'Enlace', NULL)
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (5, N'Desarrollador de software', N'Revisar el requerimiento y generar un producto final de acuerdo a las necesidades identificadas en el requerimiento Atributos de la vivienda accesible')
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (6, N'PPQA', N'Revisar  y asegurar el control de la calidad en cuanto a proceso y entregables del proyecto de Atributos de la vivienda accesible')
INSERT [dbo].[Cat_Puesto] ([idPuesto], [Puesto], [funciones]) VALUES (7, N'Administrador de configuración', N'Revisar, asegurar , auditar los repositorios de documentación y código del aplicativo Atributos de la vivienda accesible')
SET IDENTITY_INSERT [dbo].[Cat_Puesto] OFF
SET IDENTITY_INSERT [dbo].[Cat_SVN] ON 

INSERT [dbo].[Cat_SVN] ([idSVN], [idUsuario], [Ruta], [Usuario], [Pass]) VALUES (1, 1, N'https://45.35.48.168/svn/FOVISSSTE/SIO/2016/9. SEPTIEMBRE/WO67684/', N'eduardo.jimenez', N'P4ssw0rd210')
INSERT [dbo].[Cat_SVN] ([idSVN], [idUsuario], [Ruta], [Usuario], [Pass]) VALUES (2, 2, N'https://45.35.48.168/svn/FOVISSSTE/SIO/2016/9. SEPTIEMBRE/WO67684/', N'eduardo.jimenez', N'P4ssw0rd210')
SET IDENTITY_INSERT [dbo].[Cat_SVN] OFF
SET IDENTITY_INSERT [dbo].[Cat_Tipo] ON 

INSERT [dbo].[Cat_Tipo] ([id_Tipo], [Tipo]) VALUES (1, N'MANTENIMIENTO')
INSERT [dbo].[Cat_Tipo] ([id_Tipo], [Tipo]) VALUES (2, N'NUEVO DESARROLLO')
INSERT [dbo].[Cat_Tipo] ([id_Tipo], [Tipo]) VALUES (3, N'OPERACION')
INSERT [dbo].[Cat_Tipo] ([id_Tipo], [Tipo]) VALUES (4, N'INCIDENCIA')
SET IDENTITY_INSERT [dbo].[Cat_Tipo] OFF
SET IDENTITY_INSERT [dbo].[CatSistema] ON 

INSERT [dbo].[CatSistema] ([idSistema], [idCliente], [Sistema]) VALUES (2, 1, N'SIO')
INSERT [dbo].[CatSistema] ([idSistema], [idCliente], [Sistema]) VALUES (3, 1, N'SIBADAC')
INSERT [dbo].[CatSistema] ([idSistema], [idCliente], [Sistema]) VALUES (4, 1, N'SIOV')
INSERT [dbo].[CatSistema] ([idSistema], [idCliente], [Sistema]) VALUES (5, 1, N'SIREB')
INSERT [dbo].[CatSistema] ([idSistema], [idCliente], [Sistema]) VALUES (6, 3, N'SED')
SET IDENTITY_INSERT [dbo].[CatSistema] OFF
SET IDENTITY_INSERT [dbo].[CatSubEtapa] ON 

INSERT [dbo].[CatSubEtapa] ([idCatSubEtapa], [SubEtapa]) VALUES (1, N'Asignado Lider')
INSERT [dbo].[CatSubEtapa] ([idCatSubEtapa], [SubEtapa]) VALUES (2, N'Personal Asignado')
SET IDENTITY_INSERT [dbo].[CatSubEtapa] OFF
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (3, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (7, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (13, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (11, 1)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (3, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (7, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (13, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (12, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 2)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 6)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 6)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 6)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 7)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 7)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 7)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 8)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 8)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 8)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 9)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 9)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 9)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 10)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (4, 10)
INSERT [dbo].[CatTicketEmpleado] ([idEmpleado], [IDTicket]) VALUES (2, 10)
SET IDENTITY_INSERT [dbo].[TblComentarioReunion] ON 

INSERT [dbo].[TblComentarioReunion] ([idCometarioReunion], [Comentario], [idReunion]) VALUES (1, N'sadsasdasdasadsadsadasddsasds
sasdasadasdsa
asdasd
a
saasddassd
asdasdasd', 8)
INSERT [dbo].[TblComentarioReunion] ([idCometarioReunion], [Comentario], [idReunion]) VALUES (2, N'sadsasdasdasadsadsadasddsasds
sasdasadasdsa
asdasd
a
saasddassd
asdasdasd', 9)
INSERT [dbo].[TblComentarioReunion] ([idCometarioReunion], [Comentario], [idReunion]) VALUES (3, N'sadsasdasdasadsadsadasddsasds
sasdasadasdsa
asdasd
a
saasddassd
asdasdasd', 9)
SET IDENTITY_INSERT [dbo].[TblComentarioReunion] OFF
SET IDENTITY_INSERT [dbo].[TblCompromiso] ON 

INSERT [dbo].[TblCompromiso] ([FechIdent], [DondeIdent], [DescCompromiso], [FechaPlaneada], [Responsable], [Prioridad], [Estatus], [FechaAtendido], [idCompromiso], [Comentarios], [IDTicket]) VALUES (CAST(N'2016-12-04' AS Date), N'reee', N'', CAST(N'2016-12-04' AS Date), N'fwffwe', N'', N'', NULL, 2, N'effeefef', 0)
INSERT [dbo].[TblCompromiso] ([FechIdent], [DondeIdent], [DescCompromiso], [FechaPlaneada], [Responsable], [Prioridad], [Estatus], [FechaAtendido], [idCompromiso], [Comentarios], [IDTicket]) VALUES (CAST(N'2016-12-04' AS Date), N'reee', N'', CAST(N'2016-12-04' AS Date), N'fwffwe', N'', N'', NULL, 3, N'effeefef', 0)
INSERT [dbo].[TblCompromiso] ([FechIdent], [DondeIdent], [DescCompromiso], [FechaPlaneada], [Responsable], [Prioridad], [Estatus], [FechaAtendido], [idCompromiso], [Comentarios], [IDTicket]) VALUES (CAST(N'2016-12-04' AS Date), N'effwefwefe', N'', CAST(N'2016-12-04' AS Date), N'wfefefefefwe', N'', N'', NULL, 4, N'weffefefe', 0)
INSERT [dbo].[TblCompromiso] ([FechIdent], [DondeIdent], [DescCompromiso], [FechaPlaneada], [Responsable], [Prioridad], [Estatus], [FechaAtendido], [idCompromiso], [Comentarios], [IDTicket]) VALUES (CAST(N'2016-12-04' AS Date), N'vvvsvsdvvsd', N'sdfsdfsd', CAST(N'2016-12-04' AS Date), N'ddfdfdsf', N'Alto', N'Identificado', CAST(N'2016-12-05' AS Date), 5, N'fefeefef
sajaajlañkajñl', 1)
INSERT [dbo].[TblCompromiso] ([FechIdent], [DondeIdent], [DescCompromiso], [FechaPlaneada], [Responsable], [Prioridad], [Estatus], [FechaAtendido], [idCompromiso], [Comentarios], [IDTicket]) VALUES (CAST(N'2016-12-04' AS Date), N'vvvsvsdvvsd', N'asasassaas', CAST(N'2016-12-04' AS Date), N'ddfdfdsf', N'Alto', N'Identificado', NULL, 6, N'fefeefef', 1)
SET IDENTITY_INSERT [dbo].[TblCompromiso] OFF
SET IDENTITY_INSERT [dbo].[TblEmpleado] ON 

INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (1, 1, N'EDUARDO', N'JIMENEZ', N'GARCIA', N'ADMIN', CAST(N'2016-01-04' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'J3ZL9TNY', 1, N'ejjimenezgarcia@gmail.com', 0, N'EJJG')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (2, 2, N'EDUARDO', N'JIMÉNEZ', N'GARCÍA', N'EJIMENEZ', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'EJJG')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (3, 3, N'SAHARAIN', N'SANTIAGO', N'GUERRERO', N'SGUERRERO', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'SSG')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (4, 4, N'YOSANY OLIVIER', N'MORENO', N'LOPEZ', N'YOLIVIER', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 1, N'YOML')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (7, 5, N'JUAN', N'LOPEZ', N' ', N'JLOPEZ', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'JL')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (9, 5, N'OSCAR', N'LEDESMA', N' ', N'OLEDESMA', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia', 0, N'OL')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (10, 5, N'ALBERTO', N'MARTINEZ', N' ', N'AMARTINEZ', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'AMM')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (11, 6, N'NIDIA', N'TORRES', N'BARROSO', N'NTORRES', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'NTB')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (12, 6, N'JAQUELINE', N'VAZQUEZ', N'MENDEZ', N'JVAZQUEZ', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'JVM')
INSERT [dbo].[TblEmpleado] ([idEmpleado], [idPuesto], [Nombre], [ApellidoPat], [ApellidoMat], [Usuario], [FchIngreso], [FchBaja], [FchNac], [Pass], [Activo], [Correo], [idEmpresa], [Iniciales]) VALUES (13, 7, N'MANUEL ALEJANDRO', N'BRAVO', N'JIMÉNEZ', N'MBRAVO', CAST(N'2016-12-01' AS Date), NULL, CAST(N'1981-08-05' AS Date), N'Lalo1981', 1, N'ejjimenezgarcia@gmail.com', 0, N'MABJ')
SET IDENTITY_INSERT [dbo].[TblEmpleado] OFF
SET IDENTITY_INSERT [dbo].[TblGuiaAjusteConfiguration] ON 

INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (322, N'Planear Proyecto', N'Comprender el alcance del proyecto', N'Evidencia de comprensión  del alcance', N'IBDS-CSI-ASI-15-000 Minuta de Trabajo (Se requiere este documento completo)', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (323, N'Planear Proyecto', N'Comprender el alcance del proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (324, N'Planear Proyecto', N'Conformar equipo de trabajo', N'Solicitud al Responsable de Procesos/ Calidad', N'74.-KSDP_PP_F05_SolicitudAuditorAseguramientoCalidad', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (325, N'Planear Proyecto', N'Conformar equipo de trabajo', N'Asignación al Proyecto', N'Evidencia por correo', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (326, N'Planear Proyecto', N'Conformar equipo de trabajo', N'Solicitud de Capacitación', N'"5.- KSDP_OT_F03_SolicitudCapacitacion
6.-KSDP_OT_F02_DeteccionNecesidadesCapacitación"', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (327, N'Planear Proyecto', N'Estimar esfuerzo del proyecto', N'WBS', N'75.-KSDP_PP_F06_WBS', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (328, N'Planear Proyecto', N'Estimar esfuerzo del proyecto', N'Estimación del Proyecto', N'"Métodologia : KSDP :  KSDP_PP_F02_EstimacionEsfuerzo_DELPHI.xls Métodologia : CLIENTE FOVISSSTE :   Documento de presupuesto"', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (329, N'Planear Proyecto', N'Estimar esfuerzo del proyecto', N'Aprobación de la Estimación', N'Evidencia por correo', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (330, N'Planear Proyecto', N'Ajustar KSDP al Proyecto', N'Plan de Procesos', N'1.-KSDP_OPD_F01_PlanProceso.xlsx', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (331, N'Planear Proyecto', N'Ajustar KSDP al Proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (332, N'Planear Proyecto', N'Elaborar el Calendario del Proyecto', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (333, N'Planear Proyecto', N'Elaborar el Calendario del Proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (334, N'Planear Proyecto', N'Elaborar Plan del Proyecto', N'Plan del Proyecto', N'28.- Metodologia : KSDP_PP_F04_PlanProyecto', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (335, N'Planear Proyecto', N'Elaborar Plan del Proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (336, N'Planear Proyecto', N'Realizar la presentación de arranque', N'Presentación KickOff', N'73.-KSDP_FOR_KICK OFF', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (337, N'Planear Proyecto', N'Realizar la presentación de arranque', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (338, N'Admnistrar Proyecto', N'Ejecutar actividades del proyecto', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (339, N'Admnistrar Proyecto', N'Ejecutar actividades del proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (340, N'Admnistrar Proyecto', N'Informar avance del proyecto', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (341, N'Admnistrar Proyecto', N'Informar avance del proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (342, N'Admnistrar Proyecto', N'Informar avance del proyecto', N'Reporte de Avance', N'20.-KSDP_PMC_F02_AvanceProyecto', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (343, N'Admnistrar Proyecto', N'Revisar hitos o milestones del proyecto', N'Reporte de Hito/Milestone', N'21.-KSDP_PMC_F03_HitoProyecto', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (344, N'Admnistrar Proyecto', N'Obtener Lecciones Aprendidas', N'Reporte de Lecciones Aprendidas', N'21.-KSDP_PMC_F03_HitoProyecto', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (345, N'Admnistrar Proyecto', N'Terminar Proyecto', N'Carta de Aceptación de Cierre', N'PE-CAT-AOP-55-000 Carta de aceptación de usuario QA', N'6. LIBERACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (346, N'Admnistrar Proyecto', N'Terminar Proyecto', N'Liberación de Recursos', N'Evidencia por correo', N'6. LIBERACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (347, N'Administrar Requerimientos', N'Comprender los requerimientos del proyecto', N'Bitácora de Seguimiento del Proyecto', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (348, N'Administrar Requerimientos', N'Comprender los requerimientos del proyecto', N'Matriz de Rastreabilidad', N'31.-KSDP_REQM_F01_Rastreabilidad', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (349, N'Administrar Requerimientos', N'Controlar cambios a los requerimientos', N'Solicitud de Cambio', N'PE-CAT-AOP-76-000 Orden de Trabajo - ODT', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (350, N'Administrar Requerimientos', N'Controlar cambios a los requerimientos', N'Concentrado de Solicitudes de Cambio', N'33.-KSDP_REQM_F03_ConcentradoSolicitudCambios', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (351, N'Administrar Requerimientos', N'Mantener rastreabilidad bidireccional de los requerimientos', N'Matriz de Rastreabilidad', N'31.-KSDP_REQM_F01_Rastreabilidad', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (352, N'Administrar Requerimientos', N'Identificar inconsistencias en los requerimientos', N'Bitácora de Seguimiento del Proyecto', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (353, N'Manejo de Riesgos', N'Establecer estrategia de riesgos', N'Matriz de Riesgos', N'36.-KSDP_RSKM_F01_MatrizRiesgos', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (354, N'Manejo de Riesgos', N'Identificar y evaluar los riesgos', N'Matriz de Riesgos', N'36.-KSDP_RSKM_F01_MatrizRiesgos', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (355, N'Manejo de Riesgos', N'Establecer planes de mitigación y contingencia', N'Matriz de Riesgos', N'36.-KSDP_RSKM_F01_MatrizRiesgos', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (356, N'Manejo de Riesgos', N'Seguimiento a  planes de mitigación y contingencia ', N'Matriz de Riesgos', N'36.-KSDP_RSKM_F01_MatrizRiesgos', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (357, N'Manejo de Riesgos', N'0', N'Bitácora de Seguimiento del Proyecto', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (358, N'Desarrollo de Requerimientos', N'Documentar Requerimientos del Proyecto', N'Documento de Requerimientos', N'PE-CAT-AOP-76-000 Orden de Trabajo - ODT', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (359, N'Desarrollo de Requerimientos', N'Documentar Requerimientos del Proyecto', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (360, N'Desarrollo de Requerimientos', N'Analizar los Requerimientos del Proyecto', N'Documento de Requerimientos', N'PE-CAT-AOP-76-000 Orden de Trabajo - ODT', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (361, N'Desarrollo de Requerimientos', N'Analizar los Requerimientos del Proyecto', N'Matriz de Rastreabilidad', N'31.-KSDP_REQM_F01_Rastreabilidad', N'N/A', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (362, N'Desarrollo de Requerimientos', N'Validar los requerimientos', N'Documento de Requerimientos', N'PE-CAT-AOP-76-000 Orden de Trabajo - ODT', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (363, N'Desarrollo de Requerimientos', N'Validar los requerimientos', N'Matriz de Rastreabilidad', N'31.-KSDP_REQM_F01_Rastreabilidad', N'N/A', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (364, N'Desarrollo de Requerimientos', N'Validar los requerimientos', N'Matriz de Riesgos', N'36.-KSDP_RSKM_F01_MatrizRiesgos', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (365, N'Desarrollo de Requerimientos', N'Validar los requerimientos', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (366, N'Desarrollo de Requerimientos', N'Validar los requerimientos', N'Evidencia de Aprobación', N' No se realiza requerimiento ', N'N/A', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (367, N'Diseñar y Construir Solución', N'Identificar y seleccionar alternativas de solución', N'Análisis de Alternativas', N'PE-CAT-AOP-19-000 Documento de diseño', N'3. DISEÑO', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (368, N'Diseñar y Construir Solución', N'Validar alternativas de solución', N'Diseño de Alto Nivel', N'PE-CAT-AOP-19-000 Documento de diseño', N'0', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (369, N'Diseñar y Construir Solución', N'Desarrollar diseños', N'Diseño de Bajo Nivel', N'PE-CAT-AOP-19-000 Documento de diseño', N'0', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (370, N'Diseñar y Construir Solución', N'Desarrollar la Solución', N'Análisis de Componentes', N'PE-CAT-AOP-49-000 Análisis y Diseño de Requerimiento', N'3. DISEÑO', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (371, N'Diseñar y Construir Solución', N'Desarrollar la Solución', N'Solución', N'Revisión de repositorio con estructura y documentación completa de acuerdo a la metódologia ', N'4. CONTRUCCION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (372, N'Diseñar y Construir Solución', N'Elaborar documentación de soporte', N'Documentación de Soporte', N'"PE-CAT-AOP-23-000 Manual Técnico de la solución tecnológica
PE-CAT-AOP-54-000 Manual de usuario de la solución TIC"', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (373, N'Integrar la Solución', N'Planear integración', N'Plan de integración', N'"1) IBDS-AAP-AOP-57-000 Pase de Aplicaciones al Ambiente de Calidad
2) PE-CAT-AOP-53-000 Pase al ambiente de QA de base de datos
"', N'4. CONTRUCCION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (374, N'Integrar la Solución', N'Planear integración', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (375, N'Integrar la Solución', N'Establecer el ambiente de integración', N'Ambiente requerido', N'PE-CAT-AOP-23-000 Manual Técnico de la solución tecnológica', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (376, N'Integrar la Solución', N'Establecer el ambiente de integración', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (377, N'Integrar la Solución', N'Revisar y administrar interfaces', N'Interfaces', N'"PE-CAT-AOP-21-000 Documento de registro de pruebas unitarias(Bitacora Pruebas Firmado por el Enlace) 
Incluir documentación de equipo de testing (reporte de pruebas)"', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (378, N'Integrar la Solución', N'Integrar el producto', N'Producto Integrado', N'"1) IBDS-AAP-AOP-57-000 Pase de Aplicaciones al Ambiente de Calidad
2) PE-CAT-AOP-53-000 Pase al ambiente de QA de base de datos
"', N'4. CONTRUCCION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (379, N'Integrar la Solución', N'Evaluar los componentes de producto', N'Pruebas de Integración', N'PE-CAT-AOP-21-000 Documento de registro de pruebas unitarias(Bitacora Pruebas Firmado por el Enlace)', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (380, N'Integrar la Solución', N'Empaquetar y entregar al Cliente', N'Plan de implementación', N'"3) IBDS-ABD-AOP-2-000 Liberaciones derivadas de la operación al ambiente de producción (Base de Datos)-SC
4) IBDS-AAP-AOP-3-000 Pase de Aplicaciones al Ambiente de Produccion
5) IBDS-CBD-AOP-4-000 Pase de base de datos al ambiente de producción"', N'6. LIBERACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (381, N'Integrar la Solución', N'Empaquetar y entregar al Cliente', N'Empaquetado de la Solución o Producto', N'3) IBDS-ABD-AOP-2-000 Liberaciones derivadas de la operación al ambiente de producción (Base de Datos)-SC 4) IBDS-AAP-AOP-3-000 Pase de Aplicaciones al Ambiente de Produccion 5) IBDS-CBD-AOP-4-000 Pase de base de datos al ambiente de producción', N'0', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (382, N'Verificar el Producto', N'Identificar productos a verificar', N'Productos a Verificar', N'50.-KSDP_VER_F01_MatrizProductosVerificar', N'4. CONTRUCCION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (383, N'Verificar el Producto', N'Definir métodos de  verificación', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (384, N'Verificar el Producto', N'Establecer y mantener el ambiente de verificación', N'Ambiente requerido', N'PE-CAT-AOP-23-000 Manual Técnico de la solución tecnológica', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (385, N'Verificar el Producto', N'0', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (386, N'Verificar el Producto', N'Ejecutar verificación', N'Resultados de la Verificación', N'PENDIENTE DE GENERAR DOCUMENTO ', N'N/A', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (387, N'Verificar el Producto', N'Comunicar el resultado de la verificación', N'Resultados de la Verificación', N'PENDIENTE DE GENERAR DOCUMENTO ', N'N/A', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (388, N'Verificar el Producto', N'0', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (389, N'Validar el Producto', N'Definir estrategia de pruebas', N'Estrategia de Pruebas', N'46.- KSDP_VAL_F01_EstrategiaPruebas', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (390, N'Validar el Producto', N'0', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (391, N'Validar el Producto', N'Definir criterios y casos de pruebas', N'Casos de Prueba', N'"PE-CAT-AOP-58-000 Matriz de casos de pruebas
"', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (392, N'Validar el Producto', N'0', N'Matriz de Casos de Prueba', N' PE-CAT-AOP-77-000 Matriz de Pruebas', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (393, N'Validar el Producto', N'Establecer y mantener ambiente de prueba', N'Ambiente requerido', N'PE-CAT-AOP-23-000 Manual Técnico de la solución tecnológica', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (394, N'Validar el Producto', N'0', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (395, N'Validar el Producto', N'Ejecutar la prueba', N'Resultados de las pruebas', N'"PE-CAT-AOP-21-000 Documento de registro de pruebas unitarias(Bitacora Pruebas Firmado por el Enlace) 
Incluir documentación de equipo de testing (reporte de pruebas)"', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (396, N'Validar el Producto', N'Analizar el resultado de la prueba', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (397, N'Validar el Producto', N'0', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'2. ANALISIS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (398, N'Validar el Producto', N'0', N'Matriz de Rastreabilidad', N'31.-KSDP_REQM_F01_Rastreabilidad', N'5. PRUEBAS', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (399, N'Aseguramiento de Calidad/Procesos', N'Desarrollar el Plan de Aseguramiento de Calidad', N'Asignación de PPQA', N'69.-KSDP_PPQA_F04_AsignaciónRecursos', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (400, N'Aseguramiento de Calidad/Procesos', N'Desarrollar el Plan de Aseguramiento de Calidad', N'Plan de Aseguramiento de Calidad / Procesos', N'66.-KSDP_PPQA_F01_PlanAseguramientoCalidad', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (401, N'Aseguramiento de Calidad/Procesos', N'Desarrollar el Plan de Aseguramiento de Calidad', N'Cronograma de PPQA', N'1.- Plantilla de calendario de trabajo v1', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (402, N'Aseguramiento de Calidad/Procesos', N'Brindar Asesorías', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (403, N'Aseguramiento de Calidad/Procesos', N'Realizar las Auditorías', N'Listas de Verificación', N'72.-KSDP_PPQA_F05_ListaVeficacion_Gestión de Proceso_completa', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (404, N'Aseguramiento de Calidad/Procesos', N'Realizar las Auditorías', N'Reporte de Hallazgos', N'67.- KSDP_PPQA_F02_HallazgosAuditoria', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (405, N'Aseguramiento de Calidad/Procesos', N'Realizar las Auditorías', N'Cronograma de PPQA', N'1.- Plantilla de calendario de trabajo v1', N'1. PLANEACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (406, N'Aseguramiento de Calidad/Procesos', N'Realizar las Auditorías', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'0', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (407, N'Aseguramiento de Calidad/Procesos', N'Dar Seguimiento a Hallazgos', N'Reporte de Hallazgos', N'67.- KSDP_PPQA_F02_HallazgosAuditoria', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (408, N'Aseguramiento de Calidad/Procesos', N'Dar Seguimiento a Hallazgos', N'Escalamiento de Atención de Hallazgos', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (409, N'Aseguramiento de Calidad/Procesos', N'Dar Seguimiento a Hallazgos', N'Cierre de Auditoría', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (410, N'Aseguramiento de Calidad/Procesos', N'Reportar Avances', N'Reporte de Avance de Aseguramiento de la Calidad', N'68.-KSDP_PPQA_F03_ReporteAvance', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (411, N'Administración de la Configuración', N'Realizar Plan de Configuración', N'Plan de Administración de Configuración', N'55.- KSDP_CM_F01_PlanAdministracionConfiguracion', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (412, N'Administración de la Configuración', N'Realizar Plan de Configuración', N'Plan de Proyecto', N'28.- Metodologia : KSDP_PP_F04_PlanProyecto', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (413, N'Administración de la Configuración', N'Realizar Plan de Configuración', N'Calendario del Proyecto', N'1.- Plantilla de calendario de trabajo v1', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (414, N'Administración de la Configuración', N'Realizar Plan de Configuración', N'Repositorio del Proyecto', N'Revisión de repositorio con estructura y documentación completa de acuerdo a la metódologia ', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (415, N'Administración de la Configuración', N'Realizar Plan de Configuración', N'Correos de Notificación', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (416, N'Administración de la Configuración', N'Verificar el uso del Repositorio', N'Reporte de Revisión a Configuración', N'56.-KSDP_CM_F02_ReporteRevisionesConfiguracion', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (417, N'Administración de la Configuración', N'Generar y Auditar Líneas Base', N'Líneas Base', N'57.-KSDP_CM_F03_SeguimientoLineaBase', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (418, N'Administración de la Configuración', N'Generar y Auditar Líneas Base', N'Seguimiento a lineas base', N'57.-KSDP_CM_F03_SeguimientoLineaBase', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (419, N'Administración de la Configuración', N'Generar y Auditar Líneas Base', N'Correos de notificación de Auditorias', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (420, N'Administración de la Configuración', N'Informar Actividades de Configuración', N'Reporte de Actividades de Configuración', N'56.-KSDP_CM_F02_ReporteRevisionesConfiguracion', N'7. ADMINISTRACION', NULL)
GO
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (421, N'Toma de Decisiones Formales', N'Identificar la necesidad de una Decisión Formal', N'Análisis de Decisiones', N'59.-KSDP_DAR_F01_TomaDecision', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (422, N'Toma de Decisiones Formales', N'Identificar la necesidad de una Decisión Formal', N'Convocatoria', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (423, N'Toma de Decisiones Formales', N'Identificar alternativas de solución', N'Análisis de Decisiones', N'59.-KSDP_DAR_F01_TomaDecision', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (424, N'Toma de Decisiones Formales', N'Evaluar alternativas de solución', N'Análisis de Decisiones', N'59.-KSDP_DAR_F01_TomaDecision', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (425, N'Toma de Decisiones Formales', N'Seleccionar la solución', N'Análisis de Decisiones', N'59.-KSDP_DAR_F01_TomaDecision', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (426, N'Toma de Decisiones Formales', N'Seleccionar la solución', N'Comunicar resultado de la decisión', N'Evidencia por correo', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (427, N'Toma de Decisiones Formales', N'Seleccionar la solución', N'Bitácora de Seguimiento', N'19.- KSDP_PMC_F01_BitacoraSeguimiento', N'7. ADMINISTRACION', NULL)
INSERT [dbo].[TblGuiaAjusteConfiguration] ([idGuia], [Proceso], [Actividad], [Producto], [Documento], [Carpeta], [ArchivoKSDP]) VALUES (428, N'Toma de Decisiones Formales', N'Actualizar Guía de Aplicación', N'Sugerencia de Mejora', N'Evidencia por correo:  Indicando la sugerencia de mejora de formatos', N'7. ADMINISTRACION', NULL)
SET IDENTITY_INSERT [dbo].[TblGuiaAjusteConfiguration] OFF
INSERT [dbo].[TblGuiaAjusteDocumento] ([idTicket], [idDocumento], [idGuia]) VALUES (1, 32, 322)
INSERT [dbo].[TblGuiaAjusteDocumento] ([idTicket], [idDocumento], [idGuia]) VALUES (1, 36, 323)
INSERT [dbo].[TblGuiaAjusteDocumento] ([idTicket], [idDocumento], [idGuia]) VALUES (1, 36, 324)
SET IDENTITY_INSERT [dbo].[TblParticipante] ON 

INSERT [dbo].[TblParticipante] ([idParticipante], [Participante], [Email]) VALUES (1, N'sdfsd', N'sdfsdfs')
INSERT [dbo].[TblParticipante] ([idParticipante], [Participante], [Email]) VALUES (2, N'Laura Sanchez', N'lsanche@llsl.com')
SET IDENTITY_INSERT [dbo].[TblParticipante] OFF
SET IDENTITY_INSERT [dbo].[TblReunion] ON 

INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (1, N'esta prueba', 0, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (2, N'efewweewfwe', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (3, N'efewweewfwe', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (4, N'ddssdsdsdfsddfds', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (5, N'saasaas', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (6, N'saasaas', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (7, N'sdssdfdfssdf', 1, CAST(N'2016-12-05' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (8, N'sdssadsadsdasda', 1, CAST(N'2016-12-06' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (9, N'sdssadsadsdasda', 1, CAST(N'2016-12-06' AS Date))
INSERT [dbo].[TblReunion] ([idReunion], [Objetivo], [idTicket], [Fecha]) VALUES (10, N'sdssadsadsdasda', 1, CAST(N'2016-12-06' AS Date))
SET IDENTITY_INSERT [dbo].[TblReunion] OFF
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 4, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 5, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 6, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 7, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (1, 7, 0)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 8, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 8, 0)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 9, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 9, 0)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 9, 1)
INSERT [dbo].[TblReunionPart] ([IdParticipante], [idReunion], [Anexo]) VALUES (2, 9, 0)
SET IDENTITY_INSERT [dbo].[TblRiesgo] ON 

INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (1, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'sdfdsddssddsdsfaa', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (2, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'werewewewewrewr', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (3, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (4, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (5, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (6, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
INSERT [dbo].[TblRiesgo] ([idRiesgo], [idTicket], [Fecha], [Categoria], [Interno], [Descripcion], [Probabilidad], [Impacto], [Semaforo], [Estategia], [Estatus]) VALUES (7, 1, CAST(N'2016-12-19' AS Date), N'Negocio', 1, N'', 1, 1, N'          ', N'Aceptar   ', N'Abierto   ')
SET IDENTITY_INSERT [dbo].[TblRiesgo] OFF
SET IDENTITY_INSERT [dbo].[TblRiesgoComentario] ON 

INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (1, 1, N'nnnnnnnnnnnnnnn')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (2, 2, N'vvv')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (3, 3, N'vvv')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (4, 4, N'vvv')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (5, 5, N'jj')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (6, 6, N'kk')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (7, 7, N'qq')
INSERT [dbo].[TblRiesgoComentario] ([idComentario], [idRiesgo], [Comentario]) VALUES (8, 7, N'aa')
SET IDENTITY_INSERT [dbo].[TblRiesgoComentario] OFF
SET IDENTITY_INSERT [dbo].[TblRiesgoContingencia] ON 

INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (1, 1, N'bbbbbbbbbbbbbbbbbbbbb')
INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (2, 2, N'vvvv')
INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (3, 3, N'vvvv')
INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (4, 4, N'vvvv')
INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (5, 7, N'ee')
INSERT [dbo].[TblRiesgoContingencia] ([idContingencia], [idRiesgo], [Contingencia]) VALUES (6, 7, N'dd')
SET IDENTITY_INSERT [dbo].[TblRiesgoContingencia] OFF
SET IDENTITY_INSERT [dbo].[TblRiesgoMitigacion] ON 

INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (1, 1, N'ffffffffffffffffffffff')
INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (2, 2, N'vvvvv')
INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (3, 3, N'vvvvv')
INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (4, 4, N'vvvvv')
INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (5, 7, N'kk')
INSERT [dbo].[TblRiesgoMitigacion] ([idMitigacion], [idRiesgo], [Mitigacion]) VALUES (6, 7, N'mm')
SET IDENTITY_INSERT [dbo].[TblRiesgoMitigacion] OFF
SET IDENTITY_INSERT [dbo].[TblTicket] ON 

INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (1, 2, 1, 1, 1, N'KSDP201600001', CAST(N'2016-12-01' AS Date), N'fdsdfsdfs', N'sddsfdfs', N'dfdfdfsds', 2)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (2, 3, 1, 1, 1, N'KSDP201700001', CAST(N'2017-01-05' AS Date), N'r01', N'raul', N'afdsdsafadsfdsafdfsafsda', 2)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (6, 3, 1, 1, 1, N'KSDP201700002', CAST(N'2017-01-08' AS Date), N'TextBox2', N'TextBox1', N'TextBox3', 1)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (7, 3, 1, 1, 1, N'KSDP201700003', CAST(N'2017-01-08' AS Date), N'TextBox3', N'TextBox2', N'TextBox3', 1)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (8, 3, 1, 1, 1, N'KSDP201700004', CAST(N'2017-01-08' AS Date), N'TextBox4', N'TextBox3', N'TextBox3', 1)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (9, 3, 1, 1, 1, N'KSDP201700005', CAST(N'2017-01-08' AS Date), N'TextBox6', N'TextBox5', N'TextBox', 1)
INSERT [dbo].[TblTicket] ([IDTicket], [idSistema], [id_Tipo], [id_Etapa], [id_Estatus], [Ticket], [FechaAlta], [Identificador], [Nombre], [Descripcion], [idSubEtapa]) VALUES (10, 3, 1, 1, 1, N'KSDP201700006', CAST(N'2017-01-08' AS Date), N'TextBox8', N'TextBox7', N'TextBox', 1)
SET IDENTITY_INSERT [dbo].[TblTicket] OFF
/****** Object:  Index [Cat_Documentos_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [Cat_Documentos_FKIndex1] ON [dbo].[Cat_Documentos]
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_13]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_13] ON [dbo].[Cat_Documentos]
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Cat_HistEtapa_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [Cat_HistEtapa_FKIndex1] ON [dbo].[Cat_HistEtapa]
(
	[id_Etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Cat_HistEtapa_FKIndex2]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [Cat_HistEtapa_FKIndex2] ON [dbo].[Cat_HistEtapa]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_07]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_07] ON [dbo].[Cat_HistEtapa]
(
	[id_Etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_08]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_08] ON [dbo].[Cat_HistEtapa]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CatSistema_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [CatSistema_FKIndex1] ON [dbo].[CatSistema]
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_16]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_16] ON [dbo].[CatSistema]
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CatTicketEmpleado_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [CatTicketEmpleado_FKIndex1] ON [dbo].[CatTicketEmpleado]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CatTicketEmpleado_FKIndex2]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [CatTicketEmpleado_FKIndex2] ON [dbo].[CatTicketEmpleado]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_05]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_05] ON [dbo].[CatTicketEmpleado]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_06]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_06] ON [dbo].[CatTicketEmpleado]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_17]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_17] ON [dbo].[TblActividades]
(
	[idTblProyect] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblActividades_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblActividades_FKIndex1] ON [dbo].[TblActividades]
(
	[idTblProyect] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_11]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_11] ON [dbo].[TblBitacora]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_12]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_12] ON [dbo].[TblBitacora]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblBitacora_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblBitacora_FKIndex1] ON [dbo].[TblBitacora]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblBitacora_FKIndex2]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblBitacora_FKIndex2] ON [dbo].[TblBitacora]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_21]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_21] ON [dbo].[TblCC]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblCC_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblCC_FKIndex1] ON [dbo].[TblCC]
(
	[IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_04]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_04] ON [dbo].[TblEmpleado]
(
	[idPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblEmpleado_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblEmpleado_FKIndex1] ON [dbo].[TblEmpleado]
(
	[idPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_10]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_10] ON [dbo].[TblProyect]
(
	[TblTicket_IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblProyect_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblProyect_FKIndex1] ON [dbo].[TblProyect]
(
	[TblTicket_IDTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_01]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_01] ON [dbo].[TblTicket]
(
	[id_Estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_02]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_02] ON [dbo].[TblTicket]
(
	[id_Etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_09]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_09] ON [dbo].[TblTicket]
(
	[id_Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_17]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_17] ON [dbo].[TblTicket]
(
	[idSistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicket_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicket_FKIndex1] ON [dbo].[TblTicket]
(
	[id_Estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicket_FKIndex2]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicket_FKIndex2] ON [dbo].[TblTicket]
(
	[id_Etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicket_FKIndex4]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicket_FKIndex4] ON [dbo].[TblTicket]
(
	[id_Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicket_FKIndex5]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicket_FKIndex5] ON [dbo].[TblTicket]
(
	[idSistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_18]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_18] ON [dbo].[TblTicketActvidadesDocs]
(
	[idActividades] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IFK_Rel_20]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [IFK_Rel_20] ON [dbo].[TblTicketActvidadesDocs]
(
	[id_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicketActvidadesDocs_FKIndex1]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicketActvidadesDocs_FKIndex1] ON [dbo].[TblTicketActvidadesDocs]
(
	[idActividades] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TblTicketActvidadesDocs_FKIndex2]    Script Date: 12/01/2017 09:09:29 a. m. ******/
CREATE NONCLUSTERED INDEX [TblTicketActvidadesDocs_FKIndex2] ON [dbo].[TblTicketActvidadesDocs]
(
	[id_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cat_Documentos]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cat_Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[Cat_Documentos]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cat_Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[Cat_HistEtapa]  WITH CHECK ADD FOREIGN KEY([id_Etapa])
REFERENCES [dbo].[Cat_Etapa] ([id_Etapa])
GO
ALTER TABLE [dbo].[Cat_HistEtapa]  WITH CHECK ADD FOREIGN KEY([id_Etapa])
REFERENCES [dbo].[Cat_Etapa] ([id_Etapa])
GO
ALTER TABLE [dbo].[Cat_HistEtapa]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[Cat_HistEtapa]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[CatSistema]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cat_Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[CatSistema]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cat_Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[CatTicketEmpleado]  WITH CHECK ADD FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[TblEmpleado] ([idEmpleado])
GO
ALTER TABLE [dbo].[CatTicketEmpleado]  WITH CHECK ADD FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[TblEmpleado] ([idEmpleado])
GO
ALTER TABLE [dbo].[CatTicketEmpleado]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[CatTicketEmpleado]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblActividades]  WITH CHECK ADD FOREIGN KEY([idTblProyect])
REFERENCES [dbo].[TblProyect] ([idTblProyect])
GO
ALTER TABLE [dbo].[TblActividades]  WITH CHECK ADD FOREIGN KEY([idTblProyect])
REFERENCES [dbo].[TblProyect] ([idTblProyect])
GO
ALTER TABLE [dbo].[TblBitacora]  WITH CHECK ADD FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[TblEmpleado] ([idEmpleado])
GO
ALTER TABLE [dbo].[TblBitacora]  WITH CHECK ADD FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[TblEmpleado] ([idEmpleado])
GO
ALTER TABLE [dbo].[TblBitacora]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblBitacora]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblCC]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblCC]  WITH CHECK ADD FOREIGN KEY([IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblEmpleado]  WITH CHECK ADD FOREIGN KEY([idPuesto])
REFERENCES [dbo].[Cat_Puesto] ([idPuesto])
GO
ALTER TABLE [dbo].[TblEmpleado]  WITH CHECK ADD FOREIGN KEY([idPuesto])
REFERENCES [dbo].[Cat_Puesto] ([idPuesto])
GO
ALTER TABLE [dbo].[TblProyect]  WITH CHECK ADD FOREIGN KEY([TblTicket_IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblProyect]  WITH CHECK ADD FOREIGN KEY([TblTicket_IDTicket])
REFERENCES [dbo].[TblTicket] ([IDTicket])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Estatus])
REFERENCES [dbo].[Cat_Estatus] ([id_Estatus])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Estatus])
REFERENCES [dbo].[Cat_Estatus] ([id_Estatus])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Etapa])
REFERENCES [dbo].[Cat_Etapa] ([id_Etapa])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Etapa])
REFERENCES [dbo].[Cat_Etapa] ([id_Etapa])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Tipo])
REFERENCES [dbo].[Cat_Tipo] ([id_Tipo])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([id_Tipo])
REFERENCES [dbo].[Cat_Tipo] ([id_Tipo])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([idSistema])
REFERENCES [dbo].[CatSistema] ([idSistema])
GO
ALTER TABLE [dbo].[TblTicket]  WITH CHECK ADD FOREIGN KEY([idSistema])
REFERENCES [dbo].[CatSistema] ([idSistema])
GO
ALTER TABLE [dbo].[TblTicketActvidadesDocs]  WITH CHECK ADD FOREIGN KEY([id_Documento])
REFERENCES [dbo].[Cat_Documentos] ([id_Documento])
GO
ALTER TABLE [dbo].[TblTicketActvidadesDocs]  WITH CHECK ADD FOREIGN KEY([id_Documento])
REFERENCES [dbo].[Cat_Documentos] ([id_Documento])
GO
ALTER TABLE [dbo].[TblTicketActvidadesDocs]  WITH CHECK ADD FOREIGN KEY([idActividades])
REFERENCES [dbo].[TblActividades] ([idActividades])
GO
ALTER TABLE [dbo].[TblTicketActvidadesDocs]  WITH CHECK ADD FOREIGN KEY([idActividades])
REFERENCES [dbo].[TblActividades] ([idActividades])
GO
/****** Object:  StoredProcedure [dbo].[AddDocsConfig]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddDocsConfig]
	-- Add the parameters for the stored procedure here
	@Doc int,
	@Ticket int,
	@Guia int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @Existe int
	set @Existe = (select count(*) from TblGuiaAjusteDocumento where idTicket =@Ticket and idGuia= @Guia);
	if (@existe >0)
	begin
	   update TblGuiaAjusteDocumento
	   set idDocumento = @Doc
	   where idTicket =@Ticket and idGuia= @Guia;
	end
	else
	begin
	insert into TblGuiaAjusteDocumento(idTicket,idDocumento,idGuia) values(@Ticket,@Doc,@Guia);
	end
END



GO
/****** Object:  StoredProcedure [dbo].[AddRiesgo]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddRiesgo]
	-- Add the parameters for the stored procedure here
	@idTicket int,
	@Fecha date,
	@Categoria nvarchar(20),
	@Interno int,
	@Descripcion nvarchar(300),
	@Probabilidad int,
	@Impacto int,
	@Semaforo nvarchar(10),
	@Estrategia nvarchar(10),
	@Estatus nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into TblRiesgo(idTicket,Fecha,Categoria,Interno,Descripcion,Probabilidad,Impacto,Semaforo,Estategia,Estatus)
	values (@idTicket,@Fecha,@Categoria,@Interno,@Descripcion,@Probabilidad,@Impacto,@Semaforo,@Estrategia,@Estatus);

	select max(idRiesgo) from TblRiesgo ;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_AddTicket]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddTicket] 
	@idSistema int,
	@idTipo int,
	@idEtapa int,
	@Identificador varchar(15),
	@Nombre varchar(100),
	@Descrip varchar(500),
	@idSubEtapa int,
	@PMO int,
	@Enlace int,
	@Lider int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @Contar int,@Ticket nvarchar(20), @idTicket int
	set @Contar = (select COUNT(*)+ 1 from TblTicket where year(FechaAlta) = year(GETDATE()));
	set @Ticket = 'KSDP' + convert(nvarchar(4),year(GETDATE()))  + RIGHT('00000' + Ltrim(Rtrim(@Contar)),5)
    
	insert into TblTicket(idSistema,id_Tipo,id_Etapa,id_Estatus,Ticket,FechaAlta,Identificador,Nombre,Descripcion,idSubEtapa)
	values (@idSistema,@idTipo,@idEtapa,1,@Ticket,GETDATE(),@Identificador,@Nombre,@Descrip,@idSubEtapa)

	set @idTicket = ((select max(IDTicket) from TblTicket));

	insert into CatTicketEmpleado(idEmpleado,IDTicket)
	values (@PMO,@idTicket)
	insert into CatTicketEmpleado(idEmpleado,IDTicket)
	values (@Enlace,@idTicket)
	insert into CatTicketEmpleado(idEmpleado,IDTicket)
	values (@Lider,@idTicket)

	insert into Cat_HistEtapa(IDTicket,id_Etapa,Fecha)
	values (@idTicket,@idEtapa,GETDATE())

	select IDTicket,Ticket from TblTicket where IDTicket = @idTicket;



END



GO
/****** Object:  StoredProcedure [dbo].[SP_BuscaTicket]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_BuscaTicket]
	-- Add the parameters for the stored procedure here
	@Identificador nvarchar(15),
	@Nombre nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @BuscaIdent int, @BuscaNombre int

	set @BuscaIdent = (select count(*) from TblTicket where LTRIM(rtrim(upper(Identificador)))=LTRIM(rtrim(upper(@Identificador))))
	set @BuscaNombre = (select count(*) from TblTicket where LTRIM(rtrim(upper(Nombre)))=LTRIM(rtrim(upper(@Nombre))))
    -- Insert statements for procedure here
	select @BuscaIdent + @BuscaNombre
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UsuarioSVN]    Script Date: 12/01/2017 09:09:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UsuarioSVN]
	-- Add the parameters for the stored procedure here
	@idUsuario int,
	@Ruta nvarchar(200),
	@Usuario nvarchar(50),
	@Pass nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @existe int 

	set @existe = (select COUNT(*) from cat_svn where idUsuario =@idUsuario);
	if (@existe>0)
	begin
	update cat_svn
	set
	ruta = @Ruta, Usuario =@Usuario,Pass =@Pass
	where idUsuario =@idUsuario;
	end
	else
	begin
	insert into Cat_SVN (idUsuario,Ruta,Usuario,Pass)
	values (@idUsuario,@Ruta,@Usuario,@Pass);
	end
END

GO
USE [master]
GO
ALTER DATABASE [ControlProKSDP] SET  READ_WRITE 
GO
