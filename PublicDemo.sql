/*******************************************************************************************
*   Dette script opretter Demo Databasen Puclic
*	Databse bruges til opgaver på w3 ressource's SQL øvelser
*	Se: https://www.w3resource.com/sql-exercises/
*
*	Her opretter vi databasen
*
*	Længere nede opretter vi tabeller, constraints (primærnøgler og fremmednøgler),
*	og indsætter demo data.
*
*	Scriptet er tilrettet til [m$] SQL Servers, transactsql, fra PostGres script fra 
*	https://www.w3resource.com/sql-exercises/sqlex.tar.gz
*	af Søren Magnusson, smag@tec.dk
*
*********************************************************************************************/


USE [master]
GO

DROP DATABASE IF EXISTS [public]
GO

CREATE DATABASE [public]
 CONTAINMENT = NONE
GO

ALTER DATABASE [public] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [public].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

-- her kommer en masse indstillinger som jeg ikke ved om er nødvendige, og som er hugget fra et andet sted
ALTER DATABASE [public] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [public] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [public] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [public] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [public] SET ARITHABORT OFF 
GO

ALTER DATABASE [public] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [public] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [public] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [public] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [public] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [public] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [public] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [public] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [public] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [public] SET  DISABLE_BROKER 
GO

ALTER DATABASE [public] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [public] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [public] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [public] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [public] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [public] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [public] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [public] SET RECOVERY FULL 
GO

ALTER DATABASE [public] SET  MULTI_USER 
GO

ALTER DATABASE [public] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [public] SET DB_CHAINING OFF 
GO

ALTER DATABASE [public] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [public] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [public] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [public] SET QUERY_STORE = OFF
GO

USE [public]
GO

ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [public] SET  READ_WRITE 
GO


/********************************************************************
*
*	Her oprettes tabeller
*
********************************************************************/

/********************************************************************
*
*	Cretate table bonus
*
********************************************************************/

--ALTER TABLE [dbo].[bonus]  DROP CONSTRAINT IF EXISTS [FK_bog_forf]
--GO

DROP TABLE IF EXISTS [dbo].[bonus] 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bonus] (
    [emp_name] [nvarchar](15),
    [job_name] [nvarchar](10),
    [salary] [int],
    [commission] [int]
--	,
--	CONSTRAINT [PK_bonus] PRIMARY KEY (emp_name)
)
GO




/********************************************************************
*
*	Cretate table department
*
********************************************************************/

DROP TABLE IF EXISTS [dbo].[department] 
GO

CREATE TABLE [dbo].[department] (
    [dep_id] [int] NOT NULL,
    [dep_name] [nvarchar](20),
    [dep_location] [nvarchar](15),
	CONSTRAINT [PK_department] PRIMARY KEY ([dep_id])
);


/********************************************************************
*
*	Cretate table employees
*
********************************************************************/

CREATE TABLE [dbo].[employees] (
    [emp_id] [int] NOT NULL,
    [emp_name] [nvarchar](15),
    [job_name] [nvarchar](10),
    [manager_id] [int],
    [hire_date] date,
    [salary] [numeric](10,2),
    [commission] [numeric](7,2),
    [dep_id] [int],
	CONSTRAINT [PK_employees] PRIMARY KEY ([emp_id])
);


/*
ALTER TABLE [dbo].[bog]  WITH CHECK ADD  CONSTRAINT [FK_bog_forf] FOREIGN KEY([forfatter])
REFERENCES [dbo].[forf] ([cprnr])
GO

ALTER TABLE [dbo].[bog] CHECK CONSTRAINT [FK_bog_forf]
GO
*/

ALTER TABLE [dbo].[employees] WITH CHECK
	ADD CONSTRAINT [FK_dep_id] FOREIGN KEY([dep_id]) REFERENCES [dbo].[department] ([dep_id])
GO

ALTER TABLE [dbo].[employees] CHECK CONSTRAINT [FK_dep_id]
GO


/********************************************************************
*
*	Cretate table salary_grade
*
********************************************************************/

CREATE TABLE [dbo].[salary_grade] (
    [grade] [int],
    [min_sal] [int],
    [max_sal] [int]
);


/********************************************************************
*
*	Her indsættes data i  tabeller
*
********************************************************************/

/********************************************************************
*
*	Data i [department]
*
********************************************************************/
INSERT INTO [dbo].[department] VALUES 
(1001,	'FINANCE',		'SYDNEY'),
(2001,	'AUDIT',		'MELBOURNE'),
(3001,	'MARKETING',	'PERTH'),
(4001,	'PRODUCTION',	'BRISBANE')


/********************************************************************
*
*	Data i [employees]
*
********************************************************************/
INSERT INTO [dbo].[employees] VALUES
(68319,	'KAYLING',   'PRESIDENT',   NULL,   '1991-11-18',	6000.00,   	NULL,	    1001),
(66928,	'BLAZE'  ,   'MANAGER',     68319,	'1991-05-01',	2750.00,   	NULL,	    3001),
(67832,	'CLARE'  ,   'MANAGER',     68319,	'1991-06-09',	2550.00,   	NULL,	    1001),
(65646,	'JONAS'  ,   'MANAGER',     68319,	'1991-04-02',	2957.00,   	NULL,	    2001),
(64989,	'ADELYN' ,   'SALESMAN',    66928,	'1991-02-20',	1700.00,   	400.00,     3001),
(65271,	'WADE'   ,   'SALESMAN',    66928,	'1991-02-22',	1350.00,   	600.00,     3001),
(66564,	'MADDEN' ,   'SALESMAN',    66928,	'1991-09-28',	1350.00,   	1500.00,    3001),
(68454,	'TUCKER' ,   'SALESMAN',    66928,	'1991-09-08',	1600.00,   	0.00,	    3001),
(68736,	'ADNRES' ,   'CLERK'   ,    67858,	'1997-05-23',	1200.00,   	NULL,	    2001),
(69000,	'JULIUS' ,   'CLERK'   ,    66928,	'1991-12-03',	1050.00,   	NULL,	    3001),
(69324,	'MARKER' ,   'CLERK'   ,    67832,	'1992-01-23',	1400.00,   	NULL,	    1001),
(67858,	'SCARLET',   'ANALYST',     65646,	'1997-04-19',	3100.00,   	NULL,	    2001),
(69062,	'FRANK'  ,   'ANALYST',     65646,	'1991-12-03',	3100.00,   	NULL,	    2001),
(63679,	'SANDRIN',	'CLERK'    ,    69062,	'1990-12-18',	900.00, 	NULL,	    2001)


/********************************************************************
*
*	Data i [salary_grade]
*
********************************************************************/
INSERT INTO [dbo].[salary_grade] VALUES
(1,	800,    1300),
(2,	1301,	1500),
(3,	1501,	2100),
(4,	2101,	3100),
(5,	3101,	9999)