USE [master]
GO
/****** Object:  Database [COLEGIO]    Script Date: 13-02-2022 23:14:34 ******/
CREATE DATABASE [COLEGIO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'COLEGIO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\COLEGIO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'COLEGIO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\COLEGIO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [COLEGIO] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [COLEGIO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [COLEGIO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [COLEGIO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [COLEGIO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [COLEGIO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [COLEGIO] SET ARITHABORT OFF 
GO
ALTER DATABASE [COLEGIO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [COLEGIO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [COLEGIO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [COLEGIO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [COLEGIO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [COLEGIO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [COLEGIO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [COLEGIO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [COLEGIO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [COLEGIO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [COLEGIO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [COLEGIO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [COLEGIO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [COLEGIO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [COLEGIO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [COLEGIO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [COLEGIO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [COLEGIO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [COLEGIO] SET  MULTI_USER 
GO
ALTER DATABASE [COLEGIO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [COLEGIO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [COLEGIO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [COLEGIO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [COLEGIO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [COLEGIO] SET QUERY_STORE = OFF
GO
USE [COLEGIO]
GO
/****** Object:  Table [dbo].[ALUMNOS]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALUMNOS](
	[ID_ALUMNO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ALUMNOS] PRIMARY KEY CLUSTERED 
(
	[ID_ALUMNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CURSOS]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURSOS](
	[ID_CURSO] [int] IDENTITY(1,1) NOT NULL,
	[DESCRIPCION] [varchar](50) NOT NULL,
	[ID_COLEGIO] [int] NOT NULL,
 CONSTRAINT [PK_CURSOS] PRIMARY KEY CLUSTERED 
(
	[ID_CURSO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EVALUACIONES]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVALUACIONES](
	[ID_EVALUACION] [int] IDENTITY(1,1) NOT NULL,
	[ID_PRUEBA] [int] NOT NULL,
	[ID_ALUMNO] [int] NOT NULL,
	[NOTA] [float] NOT NULL,
 CONSTRAINT [PK_EVALUACIONES] PRIMARY KEY CLUSTERED 
(
	[ID_EVALUACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRUEBAS]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRUEBAS](
	[ID_PRUEBA] [int] IDENTITY(1,1) NOT NULL,
	[ID_CURSO] [int] NOT NULL,
	[DESCRIPCION] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PRUEBAS] PRIMARY KEY CLUSTERED 
(
	[ID_PRUEBA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PROMEDIOS_ALUMNOS]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PROMEDIOS_ALUMNOS]
AS
SELECT        TOP (100) PERCENT B.NOMBRE, ROUND(AVG(A.NOTA), 1) AS PROMEDIO
FROM            dbo.EVALUACIONES AS A INNER JOIN
                         dbo.ALUMNOS AS B ON B.ID_ALUMNO = A.ID_ALUMNO INNER JOIN
                         dbo.PRUEBAS AS C ON C.ID_PRUEBA = A.ID_PRUEBA INNER JOIN
                         dbo.CURSOS AS D ON D.ID_CURSO = C.ID_CURSO
GROUP BY B.NOMBRE
GO
/****** Object:  View [dbo].[ALUMNOS_PROMEDIO_ROJO]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ALUMNOS_PROMEDIO_ROJO]
AS
SELECT        NOMBRE, COUNT(*) AS 'CURSOS CON PROMEDIO ROJO'
FROM            (SELECT        B.NOMBRE
                          FROM            dbo.EVALUACIONES AS A INNER JOIN
                                                    dbo.ALUMNOS AS B ON B.ID_ALUMNO = A.ID_ALUMNO INNER JOIN
                                                    dbo.PRUEBAS AS C ON C.ID_PRUEBA = A.ID_PRUEBA INNER JOIN
                                                    dbo.CURSOS AS D ON D.ID_CURSO = C.ID_CURSO
                          GROUP BY B.NOMBRE, D.DESCRIPCION
                          HAVING         (AVG(A.NOTA) < 4)) AS REPROBADOS
GROUP BY NOMBRE
HAVING        (COUNT(*) > 1)
GO
/****** Object:  Table [dbo].[ALUMNOS_POR_CURSO]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALUMNOS_POR_CURSO](
	[ID_CURSO] [int] NOT NULL,
	[ID_ALUMNO] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ALUMNOS_POR_CURSO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COLEGIOS]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLEGIOS](
	[ID_COLEGIO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_COLEGIOS] PRIMARY KEY CLUSTERED 
(
	[ID_COLEGIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROFESORES]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROFESORES](
	[ID_PROFESOR] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PROFESORES] PRIMARY KEY CLUSTERED 
(
	[ID_PROFESOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROFESORES_POR_CURSO]    Script Date: 13-02-2022 23:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROFESORES_POR_CURSO](
	[ID_CURSO] [int] NOT NULL,
	[ID_PROFESOR] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PROFESORES_POR_CURSO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ALUMNOS_POR_CURSO]  WITH CHECK ADD  CONSTRAINT [FK_ALUMNOS_POR_CURSO_ALUMNOS] FOREIGN KEY([ID_ALUMNO])
REFERENCES [dbo].[ALUMNOS] ([ID_ALUMNO])
GO
ALTER TABLE [dbo].[ALUMNOS_POR_CURSO] CHECK CONSTRAINT [FK_ALUMNOS_POR_CURSO_ALUMNOS]
GO
ALTER TABLE [dbo].[ALUMNOS_POR_CURSO]  WITH CHECK ADD  CONSTRAINT [FK_ALUMNOS_POR_CURSO_CURSOS] FOREIGN KEY([ID_CURSO])
REFERENCES [dbo].[CURSOS] ([ID_CURSO])
GO
ALTER TABLE [dbo].[ALUMNOS_POR_CURSO] CHECK CONSTRAINT [FK_ALUMNOS_POR_CURSO_CURSOS]
GO
ALTER TABLE [dbo].[CURSOS]  WITH CHECK ADD  CONSTRAINT [FK_CURSOS_COLEGIOS] FOREIGN KEY([ID_COLEGIO])
REFERENCES [dbo].[COLEGIOS] ([ID_COLEGIO])
GO
ALTER TABLE [dbo].[CURSOS] CHECK CONSTRAINT [FK_CURSOS_COLEGIOS]
GO
ALTER TABLE [dbo].[EVALUACIONES]  WITH CHECK ADD  CONSTRAINT [FK_EVALUACIONES_ALUMNOS] FOREIGN KEY([ID_ALUMNO])
REFERENCES [dbo].[ALUMNOS] ([ID_ALUMNO])
GO
ALTER TABLE [dbo].[EVALUACIONES] CHECK CONSTRAINT [FK_EVALUACIONES_ALUMNOS]
GO
ALTER TABLE [dbo].[EVALUACIONES]  WITH CHECK ADD  CONSTRAINT [FK_EVALUACIONES_PRUEBAS] FOREIGN KEY([ID_PRUEBA])
REFERENCES [dbo].[PRUEBAS] ([ID_PRUEBA])
GO
ALTER TABLE [dbo].[EVALUACIONES] CHECK CONSTRAINT [FK_EVALUACIONES_PRUEBAS]
GO
ALTER TABLE [dbo].[PROFESORES_POR_CURSO]  WITH CHECK ADD  CONSTRAINT [FK_PROFESORES_POR_CURSO_CURSOS] FOREIGN KEY([ID_CURSO])
REFERENCES [dbo].[CURSOS] ([ID_CURSO])
GO
ALTER TABLE [dbo].[PROFESORES_POR_CURSO] CHECK CONSTRAINT [FK_PROFESORES_POR_CURSO_CURSOS]
GO
ALTER TABLE [dbo].[PROFESORES_POR_CURSO]  WITH CHECK ADD  CONSTRAINT [FK_PROFESORES_POR_CURSO_PROFESORES] FOREIGN KEY([ID_PROFESOR])
REFERENCES [dbo].[PROFESORES] ([ID_PROFESOR])
GO
ALTER TABLE [dbo].[PROFESORES_POR_CURSO] CHECK CONSTRAINT [FK_PROFESORES_POR_CURSO_PROFESORES]
GO
ALTER TABLE [dbo].[PRUEBAS]  WITH CHECK ADD  CONSTRAINT [FK_PRUEBAS_CURSOS] FOREIGN KEY([ID_CURSO])
REFERENCES [dbo].[CURSOS] ([ID_CURSO])
GO
ALTER TABLE [dbo].[PRUEBAS] CHECK CONSTRAINT [FK_PRUEBAS_CURSOS]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "REPROBADOS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 85
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2715
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ALUMNOS_PROMEDIO_ROJO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ALUMNOS_PROMEDIO_ROJO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 269
               Bottom = 102
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 493
               Bottom = 119
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 717
               Bottom = 119
               Right = 903
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1710
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PROMEDIOS_ALUMNOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PROMEDIOS_ALUMNOS'
GO
USE [master]
GO
ALTER DATABASE [COLEGIO] SET  READ_WRITE 
GO
