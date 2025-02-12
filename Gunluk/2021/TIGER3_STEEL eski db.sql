USE [master]
GO

/****** Object:  Database [TIGER3_STEEL]    Script Date: 1.10.2021 09:18:17 ******/
CREATE DATABASE [TIGER3_STEEL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TIGER3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TIGER3_STEEL.mdf' , SIZE = 2572288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TIGER3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TIGER3_STEEL_log.ldf' , SIZE = 219264KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TIGER3_STEEL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [TIGER3_STEEL] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET ARITHABORT ON 
GO

ALTER DATABASE [TIGER3_STEEL] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [TIGER3_STEEL] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [TIGER3_STEEL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [TIGER3_STEEL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET  DISABLE_BROKER 
GO

ALTER DATABASE [TIGER3_STEEL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [TIGER3_STEEL] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [TIGER3_STEEL] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [TIGER3_STEEL] SET  MULTI_USER 
GO

ALTER DATABASE [TIGER3_STEEL] SET PAGE_VERIFY NONE  
GO
select * from vw_120