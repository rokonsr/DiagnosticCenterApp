USE [master]
GO
/****** Object:  Database [DCDB]    Script Date: 5/5/2017 10:03:49 PM ******/
CREATE DATABASE [DCDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DCDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DCDB.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DCDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DCDB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DCDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DCDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DCDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DCDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DCDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DCDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DCDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DCDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DCDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DCDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DCDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DCDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DCDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DCDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DCDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DCDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DCDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DCDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DCDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DCDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DCDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DCDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DCDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DCDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DCDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DCDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DCDB] SET  MULTI_USER 
GO
ALTER DATABASE [DCDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DCDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DCDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DCDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DCDB', N'ON'
GO
USE [DCDB]
GO
/****** Object:  StoredProcedure [dbo].[uspCreateTest]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspCreateTest]
	-- Add the parameters for the stored procedure here
	@TestName nvarchar(100),
	@TestFee float(53),
	@TestType int
AS
BEGIN
	
	INSERT INTO TestSetup (TestName, TestFee, TestTypeId)
	VALUES (@TestName, @TestFee, @TestType)

END



GO
/****** Object:  StoredProcedure [dbo].[uspCreateTestRequest]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspCreateTestRequest]
	-- Add the parameters for the stored procedure here
	@PatientName nvarchar(100),
	@DateOfBirth datetime,
	@MobileNumber nvarchar(20),
	@TestId int,
	@TotalAmount decimal
AS
BEGIN
	
	IF(@MobileNumber != 'Reset')
	BEGIN
		INSERT INTO PatientInfo(PatientName, DateOfBirth, MobileNumber, TotalAmount, PaidAmount, CreatedDate)
		VALUES (@PatientName, @DateOfBirth, @MobileNumber, @TotalAmount, 0, GETDATE())
	END
	
		INSERT INTO TestRequestInfo(PatientId, TestSetupId, CreatedDate)
		VALUES (IDENT_CURRENT('[dbo].PatientInfo'), @TestId, GETDATE())
	

END



GO
/****** Object:  StoredProcedure [dbo].[uspCreateTestType]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspCreateTestType]
	@TestType nvarchar(100)
AS
BEGIN
	
	INSERT INTO TestType(TestTypeName) VALUES(@TestType)

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetBillSummary]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetBillSummary] 
	-- Add the parameters for the stored procedure here
	@BillNumber int
AS
BEGIN
	
	SELECT PatientId, PatientName, DateOfBirth, MobileNumber, TotalAmount, PaidAmount, TotalAmount - PaidAmount as DueAmount, CreatedDate FROM PatientInfo 
	WHERE PatientId = @BillNumber

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetPaidAmount]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetPaidAmount]
	-- Add the parameters for the stored procedure here
	@BillNumber int,
	@PaidAmount NUMERIC(18,2)
AS
BEGIN
	
	IF((SELECT TotalAmount FROM PatientInfo WHERE PatientId = @BillNumber) >= @PaidAmount + (SELECT PaidAmount FROM PatientInfo WHERE PatientId = @BillNumber))
	BEGIN
		UPDATE PatientInfo SET PaidAmount = PaidAmount + @PaidAmount WHERE PatientId = @BillNumber
	END
	
END



GO
/****** Object:  StoredProcedure [dbo].[uspGetTestDetailsForBill]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTestDetailsForBill]
	-- Add the parameters for the stored procedure here
	@BillNumber int
AS
BEGIN
	
	SELECT TestRequestId, PatientId, TestName, TestFee, CreatedDate FROM TestRequestInfo tri
	INNER JOIN TestSetup ts ON tri.TestSetupId= ts.TestSetupId	
	WHERE PatientId = @BillNumber

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetTestFee]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTestFee]
	-- Add the parameters for the stored procedure here
	@TestTypeId int
AS
BEGIN
	
	SELECT * FROM TestSetup WHERE TestSetupId = @TestTypeId

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetTestSetupForGv]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTestSetupForGv]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	SELECT TestSetupId, TestName, TestFee, TestTypeName FROM TestSetup ts
	INNER JOIN TestType tt ON ts.TestTypeId = tt.TestTypeId
	ORDER BY TestName

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetTestTypeList]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTestTypeList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	
	SELECT * FROM TestType ORDER BY TestTypeName

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetTestwiseReport]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTestwiseReport]
	-- Add the parameters for the stored procedure here
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN

	SELECT * INTO #TestRequest FROM TestRequestInfo
	WHERE CreatedDate BETWEEN CONVERT(DATE, @FROMDATE + '00:00:00.000', 103) AND CONVERT(DATE, @TODATE + '23:59:59.999', 103)

	SELECT TestName, COUNT(tri.TestSetupId) AS TotalTest, SUM(TestFee) AS TestFee FROM #TestRequest tri
	INNER JOIN TestSetup ts ON tri.TestSetupId = ts.TestSetupId
	GROUP BY TestName

END



GO
/****** Object:  StoredProcedure [dbo].[uspGettypewiseReport]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGettypewiseReport]
	-- Add the parameters for the stored procedure here
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
	
	SELECT * INTO #TestRequest FROM TestRequestInfo
	WHERE CreatedDate BETWEEN CONVERT(DATE, @FROMDATE + '00:00:00.000', 103) AND CONVERT(DATE, @TODATE + '23:59:59.999', 103)


	SELECT TestTypeName, COUNT(tt.TestTypeId) AS TotalTest, SUM(TestFee) AS TestFee FROM #TestRequest tri
	LEFT JOIN TestSetup ts ON tri.TestSetupId = ts.TestSetupId
	LEFT JOIN TestType tt ON ts.TestTypeId = tt.TestTypeId
	GROUP BY TestTypeName

	--SELECT * INTO #TestRequest FROM TestRequestInfo
	--WHERE CreatedDate BETWEEN CONVERT(DATE, @FROMDATE + '00:00:00.000', 103) AND CONVERT(DATE, @TODATE + '23:59:59.999', 103)

	--SELECT TestName, COUNT(tri.TestSetupId) AS TotalTest, SUM(TestFee) AS TestFee FROM #TestRequest tri
	--INNER JOIN TestSetup ts ON tri.TestSetupId = ts.TestSetupId
	--GROUP BY TestName

END



GO
/****** Object:  StoredProcedure [dbo].[uspGetUnpaidBillwiseReport]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetUnpaidBillwiseReport]
	-- Add the parameters for the stored procedure here
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
	
	SELECT * FROM PatientInfo
	WHERE CreatedDate BETWEEN CONVERT(DATE, @FROMDATE + '00:00:00.000', 103) AND CONVERT(DATE, @TODATE + '23:59:59.999', 103)
	AND TotalAmount - PaidAmount > 0

END



GO
/****** Object:  Table [dbo].[PatientInfo]    Script Date: 5/5/2017 10:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientInfo](
	[PatientId] [int] IDENTITY(10000,1) NOT NULL,
	[PatientName] [nvarchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[MobileNumber] [nvarchar](20) NOT NULL,
	[TotalAmount] [decimal](18, 0) NULL,
	[PaidAmount] [decimal](18, 0) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientInfo] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestRequestInfo]    Script Date: 5/5/2017 10:03:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestRequestInfo](
	[TestRequestId] [int] IDENTITY(1000,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[TestSetupId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TestRequestInfo] PRIMARY KEY CLUSTERED 
(
	[TestRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestSetup]    Script Date: 5/5/2017 10:03:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestSetup](
	[TestSetupId] [int] IDENTITY(1,1) NOT NULL,
	[TestName] [nvarchar](100) NOT NULL,
	[TestFee] [float] NOT NULL,
	[TestTypeId] [int] NOT NULL,
 CONSTRAINT [PK_TestSetup] PRIMARY KEY CLUSTERED 
(
	[TestSetupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestType]    Script Date: 5/5/2017 10:03:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestType](
	[TestTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TestType] PRIMARY KEY CLUSTERED 
(
	[TestTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[PatientInfo] ON 

INSERT [dbo].[PatientInfo] ([PatientId], [PatientName], [DateOfBirth], [MobileNumber], [TotalAmount], [PaidAmount], [CreatedDate]) VALUES (10000, N'Rokon', CAST(0xC53C0B00 AS Date), N'01730302110', CAST(1000 AS Decimal(18, 0)), CAST(600 AS Decimal(18, 0)), CAST(0x0000A76A0169C5FB AS DateTime))
INSERT [dbo].[PatientInfo] ([PatientId], [PatientName], [DateOfBirth], [MobileNumber], [TotalAmount], [PaidAmount], [CreatedDate]) VALUES (10001, N'Rokon', CAST(0xC53C0B00 AS Date), N'01730302110', CAST(600 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0x0000A76A016AF4FE AS DateTime))
SET IDENTITY_INSERT [dbo].[PatientInfo] OFF
SET IDENTITY_INSERT [dbo].[TestRequestInfo] ON 

INSERT [dbo].[TestRequestInfo] ([TestRequestId], [PatientId], [TestSetupId], [CreatedDate]) VALUES (1000, 10000, 1, CAST(0x0000A76A0169C5FF AS DateTime))
INSERT [dbo].[TestRequestInfo] ([TestRequestId], [PatientId], [TestSetupId], [CreatedDate]) VALUES (1001, 10000, 2, CAST(0x0000A76A0169C602 AS DateTime))
INSERT [dbo].[TestRequestInfo] ([TestRequestId], [PatientId], [TestSetupId], [CreatedDate]) VALUES (1002, 10000, 3, CAST(0x0000A76A0169C606 AS DateTime))
INSERT [dbo].[TestRequestInfo] ([TestRequestId], [PatientId], [TestSetupId], [CreatedDate]) VALUES (1003, 10001, 2, CAST(0x0000A76A016AF505 AS DateTime))
INSERT [dbo].[TestRequestInfo] ([TestRequestId], [PatientId], [TestSetupId], [CreatedDate]) VALUES (1004, 10001, 1, CAST(0x0000A76A016AF509 AS DateTime))
SET IDENTITY_INSERT [dbo].[TestRequestInfo] OFF
SET IDENTITY_INSERT [dbo].[TestSetup] ON 

INSERT [dbo].[TestSetup] ([TestSetupId], [TestName], [TestFee], [TestTypeId]) VALUES (1, N'Blood Group', 100, 1)
INSERT [dbo].[TestSetup] ([TestSetupId], [TestName], [TestFee], [TestTypeId]) VALUES (2, N'ECG', 500, 2)
INSERT [dbo].[TestSetup] ([TestSetupId], [TestName], [TestFee], [TestTypeId]) VALUES (3, N'Spinal Cord', 400, 3)
SET IDENTITY_INSERT [dbo].[TestSetup] OFF
SET IDENTITY_INSERT [dbo].[TestType] ON 

INSERT [dbo].[TestType] ([TestTypeId], [TestTypeName]) VALUES (1, N'Blood')
INSERT [dbo].[TestType] ([TestTypeId], [TestTypeName]) VALUES (2, N'ECG')
INSERT [dbo].[TestType] ([TestTypeId], [TestTypeName]) VALUES (3, N'X-Ray')
INSERT [dbo].[TestType] ([TestTypeId], [TestTypeName]) VALUES (4, N'Urine')
SET IDENTITY_INSERT [dbo].[TestType] OFF
ALTER TABLE [dbo].[TestRequestInfo]  WITH CHECK ADD  CONSTRAINT [FK_TestRequestInfo_PatientInfo] FOREIGN KEY([PatientId])
REFERENCES [dbo].[PatientInfo] ([PatientId])
GO
ALTER TABLE [dbo].[TestRequestInfo] CHECK CONSTRAINT [FK_TestRequestInfo_PatientInfo]
GO
ALTER TABLE [dbo].[TestRequestInfo]  WITH CHECK ADD  CONSTRAINT [FK_TestRequestInfo_TestSetup] FOREIGN KEY([TestSetupId])
REFERENCES [dbo].[TestSetup] ([TestSetupId])
GO
ALTER TABLE [dbo].[TestRequestInfo] CHECK CONSTRAINT [FK_TestRequestInfo_TestSetup]
GO
ALTER TABLE [dbo].[TestSetup]  WITH CHECK ADD  CONSTRAINT [FK_TestSetup_TestType] FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestType] ([TestTypeId])
GO
ALTER TABLE [dbo].[TestSetup] CHECK CONSTRAINT [FK_TestSetup_TestType]
GO
USE [master]
GO
ALTER DATABASE [DCDB] SET  READ_WRITE 
GO
