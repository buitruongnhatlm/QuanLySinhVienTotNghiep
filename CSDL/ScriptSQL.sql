USE [master]
GO
/****** Object:  Database [QuanLySinhVienTotNghiep]    Script Date: 26/06/2020 16:16:36 ******/
CREATE DATABASE [QuanLySinhVienTotNghiep]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLySinhVienTotNghiep', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLySinhVienTotNghiep.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLySinhVienTotNghiep_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLySinhVienTotNghiep_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLySinhVienTotNghiep].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLySinhVienTotNghiep', N'ON'
GO
USE [QuanLySinhVienTotNghiep]
GO
/****** Object:  UserDefinedFunction [dbo].[func_ConvertToUnsign]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[func_ConvertToUnsign]
( @strInput NVARCHAR(4000) ) 
RETURNS NVARCHAR(4000) 
AS
BEGIN 
IF @strInput IS NULL 
	RETURN @strInput 
IF @strInput = '' 
	RETURN @strInput 
DECLARE @RT NVARCHAR(4000) 
DECLARE @SIGN_CHARS NCHAR(136) 
DECLARE @UNSIGN_CHARS NCHAR (136) 
SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208) 
SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
DECLARE @COUNTER int 
DECLARE @COUNTER1 int 
SET @COUNTER = 1 
WHILE (@COUNTER <=LEN(@strInput)) 
BEGIN SET @COUNTER1 = 1 
WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
BEGIN
IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END









GO
/****** Object:  Table [dbo].[DiemChu]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DiemChu](
	[IDDiemChu] [int] NOT NULL,
	[TenDiem] [varchar](5) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDiemChu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GiaDinh]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaDinh](
	[IDGiaDinh] [int] IDENTITY(1,1) NOT NULL,
	[HoTenCha] [nvarchar](250) NOT NULL,
	[NamSinhCha] [date] NULL,
	[DienThoaiCha] [int] NULL,
	[HoTenMe] [nvarchar](250) NOT NULL,
	[NamSinhMe] [date] NULL,
	[DienThoaiMe] [int] NULL,
	[DiaChi] [nvarchar](250) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGiaDinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HeDaoTao]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeDaoTao](
	[IDHeDaoTao] [int] IDENTITY(1,1) NOT NULL,
	[TenHeDaoTao] [nvarchar](250) NOT NULL,
	[ThoiGianDaoTao] [int] NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDHeDaoTao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[IDKhoa] [int] IDENTITY(1,1) NOT NULL,
	[MaKhoa] [int] NOT NULL,
	[TenKhoa] [nvarchar](250) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiTaiKhoan]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTaiKhoan](
	[IDLoaiTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiTaiKhoan] [nvarchar](250) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLoaiTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiTotNghiep]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTotNghiep](
	[IDLoaiTotNghiep] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiTotNghiep] [nvarchar](250) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLoaiTotNghiep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lop]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lop](
	[IDLop] [int] IDENTITY(1,1) NOT NULL,
	[MaLop] [nvarchar](250) NOT NULL,
	[TenLop] [nvarchar](250) NOT NULL,
	[SoLuongSinhVien] [int] NOT NULL,
	[CoVan] [nvarchar](250) NULL,
	[GhiChu] [nvarchar](250) NULL,
	[IDKhoa] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[IDMonHoc] [int] IDENTITY(1,1) NOT NULL,
	[IDSinhVien] [int] NULL,
	[ToanRoiRac] [int] NULL,
	[GiaiTich] [int] NULL,
	[XacSuatThongKe] [int] NULL,
	[KyThuatLapTrinh] [int] NULL,
	[MangMayTinh] [int] NULL,
	[CoSoDuLieu] [int] NULL,
	[KyNangGiaoTiep] [int] NULL,
	[LapTrinhHuongDoiTuong] [int] NULL,
	[CauTrucDuLieuGiaiThuat] [int] NULL,
	[HeDieuHanh] [int] NULL,
	[PhanTichThietKe] [int] NULL,
	[TriTueNhanTao] [int] NULL,
	[PhanMemMaNguonMo] [int] NULL,
	[BaoTriPhanMem] [int] NULL,
	[ThuongMaiDienTu] [int] NULL,
	[DoAn1] [int] NULL,
	[DoAn2] [int] NULL,
	[DoAn3] [int] NULL,
	[ChungChiNgoaiNgu] [int] NULL,
	[HocPhanTuChon] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMonHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Nganh]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nganh](
	[IDNganh] [int] IDENTITY(1,1) NOT NULL,
	[TenNganh] [nvarchar](250) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDNganh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuanLyVien]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanLyVien](
	[IDQuanLyVien] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](250) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [nvarchar](5) NOT NULL,
	[ChungMinhNhanDan] [int] NOT NULL,
	[NoiSinh] [nvarchar](250) NULL,
	[DiaChiThuongTru] [nvarchar](250) NOT NULL,
	[HocHam] [nvarchar](250) NULL,
	[TrinhDo] [nvarchar](250) NULL,
	[ChuyenMon] [nvarchar](250) NULL,
	[DonViCongTac] [nvarchar](250) NULL,
	[GhiChu] [nvarchar](250) NULL,
	[IDTaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDQuanLyVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SinhVien](
	[IDSinhVien] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](250) NOT NULL,
	[MaSoSinhVien] [int] NOT NULL,
	[GioiTinh] [nvarchar](5) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[NoiSinh] [nvarchar](250) NULL,
	[DiaChiThuongTru] [nvarchar](250) NOT NULL,
	[DanToc] [nvarchar](50) NULL,
	[TonGiao] [nvarchar](50) NULL,
	[ChungMinhNhanDan] [int] NOT NULL,
	[NgayCap] [date] NOT NULL,
	[NgayVaoDoan] [date] NULL,
	[NgayVaoDang] [date] NULL,
	[DienThoai] [int] NOT NULL,
	[Email] [varchar](100) NULL,
	[GhiChu] [nvarchar](250) NULL,
	[IDGiaDinh] [int] NULL,
	[IDTaiKhoan] [int] NULL,
	[IDThongTinTotNghiep] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[IDTaikhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenTaiKhoan] [varchar](250) NOT NULL,
	[MatKhau] [varchar](250) NOT NULL,
	[Email] [varchar](250) NULL,
	[SoDienThoai] [int] NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
	[IDLoaiTaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTaikhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThongTinTotNghiep]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinTotNghiep](
	[IDThongTinTotNghiep] [int] IDENTITY(1,1) NOT NULL,
	[NgayVaoTruong] [date] NOT NULL,
	[NgayTotNghiep] [date] NULL,
	[NgayCapBang] [date] NULL,
	[Diem4] [float] NULL,
	[GhiChu] [nvarchar](250) NULL,
	[IDLoaiTotNghiep] [int] NULL,
	[IDHeDaoTao] [int] NULL,
	[IDNghanh] [int] NULL,
	[IDLop] [int] NULL,
	[IDDiemChu] [int] NULL,
	[TrangThai] [nvarchar](25) NULL,
	[NoMon] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDThongTinTotNghiep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (1, N'A', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (2, N'B+', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (3, N'B', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (4, N'C+', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (5, N'C', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (6, N'D+', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (7, N'D', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (8, N'F', N'')
INSERT [dbo].[DiemChu] ([IDDiemChu], [TenDiem], [GhiChu]) VALUES (9, N'O', N'')
SET IDENTITY_INSERT [dbo].[GiaDinh] ON 

INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (1, N'Lê Văn Xứ', CAST(N'1978-01-05' AS Date), 122333444, N'Lê Thị Lan', CAST(N'1980-02-25' AS Date), 193335551, N'Sóc Trăng', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (2, N'Nguyễn Văn Hướng Dương', CAST(N'1985-09-12' AS Date), 166333156, N'Lê Thị Sen', CAST(N'1981-06-30' AS Date), 122335670, N'Bạc Liêu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (3, N'Trần Trúc Đào', CAST(N'1990-02-05' AS Date), 122333991, N'Lê Thị Anh Thảo', CAST(N'1988-05-30' AS Date), 199333761, N'Vũng Tàu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (4, N'Nguyễn Văn Trà', CAST(N'1989-02-11' AS Date), 166333333, N'Lê Thị Thanh Trà', CAST(N'1990-06-26' AS Date), 342335112, N'Hậu Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (5, N'Trần Văn Thông', CAST(N'1979-01-28' AS Date), 122553156, N'Lê Thị Hồng Trà', CAST(N'1988-01-01' AS Date), 342335117, N'Cà Mau', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (6, N'Trần Vạn Thọ', CAST(N'1970-01-01' AS Date), 122553123, N'Lê Thị Trúc Đào', CAST(N'1988-01-01' AS Date), 342335113, N'Cà Mau', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (7, N'Trần Loa Kèn', CAST(N'1977-01-01' AS Date), 922553123, N'Lê Thị Huệ', CAST(N'1988-09-09' AS Date), 923553123, N'Huế', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (8, N'Trần Trạng Nguyên', CAST(N'1975-02-02' AS Date), 323553567, N'Lê Huỳnh Oải Hương', CAST(N'1977-01-09' AS Date), 323553567, N'Huế', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (9, N'Bồ Công Anh', CAST(N'1995-12-29' AS Date), 123456789, N'Lê Thị Cúc', CAST(N'1977-01-09' AS Date), 123456789, N'Hải Phòng', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (10, N'Trần Dương Sỉ', CAST(N'1982-02-22' AS Date), 334449991, N'Lê Thị Bưởi', CAST(N'1991-01-09' AS Date), 123459867, N'Vũng Tàu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (11, N'Trần Thanh Vĩ', CAST(N'1980-02-22' AS Date), 334441234, N'Lê Thị Phượng Vĩ', CAST(N'1971-12-09' AS Date), 123451122, N'Nha Trang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (12, N'Trần Văn Điệp', CAST(N'1979-02-12' AS Date), 931121234, N'Nguyễn Thị Hồ Điệp', CAST(N'1981-12-19' AS Date), 123332112, N'Đà Lạt', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (13, N'Trần Văn Đào', CAST(N'1972-04-12' AS Date), 761121234, N'Nguyễn Thị Mai', CAST(N'1987-02-19' AS Date), 121262112, N'Kiên Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (14, N'Trần Cát Tường', CAST(N'1975-06-12' AS Date), 761112234, N'Nguyễn Tường Vi', CAST(N'1987-02-23' AS Date), 921262116, N'Kiên Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (15, N'Trần Thanh Thanh', CAST(N'1979-06-22' AS Date), 931121234, N'Nguyễn Thị Cẩm Tú', CAST(N'1989-02-23' AS Date), 121262223, N'An Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (16, N'Trần Thanh Hướng', CAST(N'1955-02-22' AS Date), 661111236, N'Nguyễn Thị Dạ Hương', CAST(N'1989-02-13' AS Date), 321262225, N'Hậu Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (17, N'Trần Dần', CAST(N'1970-06-22' AS Date), 661110011, N'Dạ Lý Hương', CAST(N'1987-02-25' AS Date), 121262256, N'Bạc Liêu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (18, N'Trần Yến Thảo', CAST(N'1977-06-25' AS Date), 661115698, N'Nguyễn Thị Dã Yến Thảo', CAST(N'1987-07-25' AS Date), 721262200, N'Bạc Liêu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (19, N'Trần Văn Mười', CAST(N'1997-06-25' AS Date), 661111239, N'Nguyễn Thị Dành Dành', CAST(N'1967-07-25' AS Date), 121262209, N'Bạc Liêu', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (20, N'Trần Bông Gòn', CAST(N'1980-01-01' AS Date), 145111230, N'Lê Thị Hải Đường', CAST(N'1987-11-25' AS Date), 121261234, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (21, N'Trần Văn Huệ', CAST(N'1988-08-08' AS Date), 945110901, N'Lê Thị Hòe', CAST(N'1989-12-25' AS Date), 321333234, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (22, N'Trần Văn Hồng', CAST(N'1978-08-18' AS Date), 345110092, N'Nguyễn Thị Hồng Môn', CAST(N'1981-02-25' AS Date), 921333909, N'Vinh', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (23, N'Trần Kim', CAST(N'1979-08-18' AS Date), 345123455, N'Nguyễn Thị Kim Đồng', CAST(N'1989-02-25' AS Date), 213331313, N'Hà Nội', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (24, N'Trần Ngân', CAST(N'1989-08-19' AS Date), 745987455, N'Nguyễn Thị Kim Ngân', CAST(N'1988-12-02' AS Date), 121333170, N'Hà Tây', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (25, N'Trần Văn Tiến', CAST(N'1999-08-20' AS Date), 945121111, N'Nguyễn Thị Lạc Tiên', CAST(N'1989-12-15' AS Date), 121377991, N'Hà Nam', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (26, N'Trần Văn Anh', CAST(N'1999-08-22' AS Date), 745121999, N'Nguyễn Thị Vân Anh', CAST(N'1989-12-15' AS Date), 121377992, N'Hà Nam', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (27, N'Trần Văn Bình', CAST(N'1992-08-22' AS Date), 341341118, N'Nguyễn Thị Lục Bình', CAST(N'1981-02-15' AS Date), 121377123, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (28, N'Trần Ly', CAST(N'1992-08-25' AS Date), 341341559, N'Nguyễn Thị Lưu Ly', CAST(N'1980-12-15' AS Date), 121377199, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (29, N'Trần Văn Đơn', CAST(N'1992-09-27' AS Date), 121377671, N'Nguyễn Thị Mẫu Đơn', CAST(N'1980-11-11' AS Date), 121377679, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (30, N'Trần Văn Mười', CAST(N'1990-09-22' AS Date), 121371112, N'Nguyễn Thị Mười Giờ', CAST(N'1980-11-12' AS Date), 121371115, N'Cần Thơ', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (31, N'Trần Văn Ngọc', CAST(N'1991-09-25' AS Date), 121372222, N'Nguyễn Thị Ngọc Nữ', CAST(N'1980-11-12' AS Date), 921333909, N'Vĩnh Long', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (32, N'Trần Văn Ngãi', CAST(N'1991-11-15' AS Date), 121371111, N'Nguyễn Thị Ngãi Tiên', CAST(N'1980-11-01' AS Date), 921333909, N'Vĩnh Long', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (33, N'Nguyễn Văn Ô', CAST(N'1992-11-18' AS Date), 121372223, N'Lê Thị Ô Môi', CAST(N'1980-01-12' AS Date), 121372229, N'Vĩnh Long', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (34, N'Nguyễn Văn Phù', CAST(N'1991-11-15' AS Date), 121371114, N'Lê Thị Phù Dung', CAST(N'1991-11-15' AS Date), 121371112, N'An Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (35, N'Nguyễn Văn Quỳnh', CAST(N'1991-01-18' AS Date), 121372225, N'Lê Thị Quỳnh', CAST(N'1992-11-15' AS Date), 121372225, N'An Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (36, N'Nguyễn Văn Sơn', CAST(N'1991-01-18' AS Date), 121372230, N'Lê Thị Son', CAST(N'1991-01-18' AS Date), 121372230, N'An Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (37, N'Trần Văn Hiền', CAST(N'1991-01-27' AS Date), 321372231, N'Nguyễn Thị Thúy', CAST(N'1991-01-27' AS Date), 321372233, N'Kiên Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (38, N'Trần Văn Phú', CAST(N'1991-01-27' AS Date), 321372235, N'Nguyễn Thị Thúy Ái', CAST(N'1991-01-27' AS Date), 321372235, N'Kiên Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (39, N'Trần Thanh Đa', CAST(N'1991-01-27' AS Date), 321372237, N'Nguyễn Thị Ái', CAST(N'1991-01-27' AS Date), 321372237, N'Kiên Giang', N'')
INSERT [dbo].[GiaDinh] ([IDGiaDinh], [HoTenCha], [NamSinhCha], [DienThoaiCha], [HoTenMe], [NamSinhMe], [DienThoaiMe], [DiaChi], [GhiChu]) VALUES (40, N'Trần Thanh Thanh', CAST(N'1991-01-27' AS Date), 521372237, N'Nguyễn Thị Thanh', CAST(N'1991-01-27' AS Date), 521372237, N'Kiên Giang', N'')
SET IDENTITY_INSERT [dbo].[GiaDinh] OFF
SET IDENTITY_INSERT [dbo].[HeDaoTao] ON 

INSERT [dbo].[HeDaoTao] ([IDHeDaoTao], [TenHeDaoTao], [ThoiGianDaoTao], [GhiChu]) VALUES (1, N'Đại Học Chính Quy', 8, N'')
INSERT [dbo].[HeDaoTao] ([IDHeDaoTao], [TenHeDaoTao], [ThoiGianDaoTao], [GhiChu]) VALUES (2, N'Đại Học Giáo Dục Thường Xuyên', 8, N'')
INSERT [dbo].[HeDaoTao] ([IDHeDaoTao], [TenHeDaoTao], [ThoiGianDaoTao], [GhiChu]) VALUES (3, N'Đại Học Liên Thông', 8, N'')
SET IDENTITY_INSERT [dbo].[HeDaoTao] OFF
SET IDENTITY_INSERT [dbo].[Khoa] ON 

INSERT [dbo].[Khoa] ([IDKhoa], [MaKhoa], [TenKhoa], [GhiChu]) VALUES (1, 1, N'Khóa 1', N'')
INSERT [dbo].[Khoa] ([IDKhoa], [MaKhoa], [TenKhoa], [GhiChu]) VALUES (2, 2, N'Khóa 2', N'')
INSERT [dbo].[Khoa] ([IDKhoa], [MaKhoa], [TenKhoa], [GhiChu]) VALUES (3, 3, N'Khóa 3', N'')
SET IDENTITY_INSERT [dbo].[Khoa] OFF
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] ON 

INSERT [dbo].[LoaiTaiKhoan] ([IDLoaiTaiKhoan], [TenLoaiTaiKhoan], [GhiChu]) VALUES (1, N'Quản Trị Viên', N'')
INSERT [dbo].[LoaiTaiKhoan] ([IDLoaiTaiKhoan], [TenLoaiTaiKhoan], [GhiChu]) VALUES (2, N'Quản Lý Viên', N'')
INSERT [dbo].[LoaiTaiKhoan] ([IDLoaiTaiKhoan], [TenLoaiTaiKhoan], [GhiChu]) VALUES (3, N'Sinh Viên', N'')
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] OFF
SET IDENTITY_INSERT [dbo].[LoaiTotNghiep] ON 

INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (1, N'Xuất Sắc', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (2, N'Giỏi', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (3, N'Khá', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (4, N'Trung Bình Khá', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (5, N'Trung Bình', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (6, N'Trung Bình Yếu', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (7, N'Yếu', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (8, N'Kém', N'')
INSERT [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep], [TenLoaiTotNghiep], [GhiChu]) VALUES (9, N'Chưa Tốt Nghiệp', N'')
SET IDENTITY_INSERT [dbo].[LoaiTotNghiep] OFF
SET IDENTITY_INSERT [dbo].[Lop] ON 

INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (1, N'KTPM0113', N'Kỹ Thuật Phần Mềm', 50, N'Nguyễn Thị Hồ Điệp', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (2, N'KTPM0213', N'Kỹ Thuật Phần Mềm', 70, N'Lê Trần Phượng Vĩ', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (3, N'KHMT0113', N'Khoa Học Máy Tính', 30, N'Trần Anh Đào', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (4, N'KHMT0213', N'Khoa Học Máy Tính', 60, N'Nguyễn Thị Mai', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (5, N'HTTT0113', N'Hệ Thống Thông Tin', 25, N'Nguyễn Thị Bằng Lăng', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (6, N'HTTT0213', N'Hệ Thống Thông Tin', 45, N'Trần Thị Dâm Bụt', N'', 1)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (7, N'KTPM0114', N'Kỹ Thuật Phần Mềm', 70, N'Nguyễn Thị Tulip', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (8, N'KTPM0214', N'Kỹ Thuật Phần Mềm', 55, N'Trần Bạch Yến', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (9, N'KHMT0114', N'Khoa Học Máy Tính', 80, N'Trần Phong Lan', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (10, N'KHMT0214', N'Khoa Học Máy Tính', 60, N'Nguyễn Nhài', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (11, N'HTTT0114', N'Hệ Thống Thông Tin', 35, N'Nguyễn Thị Dáng Hương', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (12, N'HTTT0214', N'Hệ Thống Thông Tin', 45, N'Trần Thị Thược Dược', N'', 2)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (13, N'KTPM0115', N'Kỹ Thuật Phần Mềm', 40, N'Muồng Hoàng Yến', N'', 3)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (14, N'KTPM0215', N'Kỹ Thuật Phần Mềm', 45, N'Nguyễn Đỗ Quyên', N'', 3)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (15, N'KHMT0115', N'Khoa Học Máy Tính', 80, N'Lê Mẫu Đơn', N'', 3)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (16, N'KHMT0215', N'Khoa Học Máy Tính', 60, N'Trần Văn Súng', N'', 3)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (17, N'HTTT0115', N'Hệ Thống Thông Tin', 35, N'Nguyễn Thị Mộc Lan', N'', 3)
INSERT [dbo].[Lop] ([IDLop], [MaLop], [TenLop], [SoLuongSinhVien], [CoVan], [GhiChu], [IDKhoa]) VALUES (18, N'HTTT0215', N'Hệ Thống Thông Tin', 45, N'Trần Thị Giấy', N'', 3)
SET IDENTITY_INSERT [dbo].[Lop] OFF
SET IDENTITY_INSERT [dbo].[MonHoc] ON 

INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (1, 5, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (2, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (3, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (5, 16, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (6, 17, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (7, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (8, 19, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (9, 29, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (10, 30, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (11, 31, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (12, 32, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (13, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (14, 36, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (15, 37, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (16, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (21, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[MonHoc] ([IDMonHoc], [IDSinhVien], [ToanRoiRac], [GiaiTich], [XacSuatThongKe], [KyThuatLapTrinh], [MangMayTinh], [CoSoDuLieu], [KyNangGiaoTiep], [LapTrinhHuongDoiTuong], [CauTrucDuLieuGiaiThuat], [HeDieuHanh], [PhanTichThietKe], [TriTueNhanTao], [PhanMemMaNguonMo], [BaoTriPhanMem], [ThuongMaiDienTu], [DoAn1], [DoAn2], [DoAn3], [ChungChiNgoaiNgu], [HocPhanTuChon]) VALUES (22, 3, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[MonHoc] OFF
SET IDENTITY_INSERT [dbo].[Nganh] ON 

INSERT [dbo].[Nganh] ([IDNganh], [TenNganh], [GhiChu]) VALUES (1, N'Khoa Học Máy Tính', N'')
INSERT [dbo].[Nganh] ([IDNganh], [TenNganh], [GhiChu]) VALUES (2, N'Kỹ Thuật Phần Mềm', N'')
INSERT [dbo].[Nganh] ([IDNganh], [TenNganh], [GhiChu]) VALUES (3, N'Hệ Thống Thông Tin', N'')
SET IDENTITY_INSERT [dbo].[Nganh] OFF
SET IDENTITY_INSERT [dbo].[QuanLyVien] ON 

INSERT [dbo].[QuanLyVien] ([IDQuanLyVien], [HoTen], [NgaySinh], [GioiTinh], [ChungMinhNhanDan], [NoiSinh], [DiaChiThuongTru], [HocHam], [TrinhDo], [ChuyenMon], [DonViCongTac], [GhiChu], [IDTaiKhoan]) VALUES (1, N'Lê Thị Hồng', CAST(N'2020-05-27' AS Date), N'Nữ', 366222399, N'Kiên Giang', N'Long Hòa Bình Thủy Cần Thơ', N'Thạc Sĩ', N'Đại Học', N'Tin Học Ứng Dụng', N'Phòng Công Tác Chính Trị Và Quản Lý Sinh Viên', N'', 2)
INSERT [dbo].[QuanLyVien] ([IDQuanLyVien], [HoTen], [NgaySinh], [GioiTinh], [ChungMinhNhanDan], [NoiSinh], [DiaChiThuongTru], [HocHam], [TrinhDo], [ChuyenMon], [DonViCongTac], [GhiChu], [IDTaiKhoan]) VALUES (2, N'Nguyễn Văn Đại', CAST(N'2020-05-27' AS Date), N'Nam', 366333199, N'Hậu Giang', N'Nguyễn Văn Cừ Ninh Kiều Cần Thơ', N'Thạc Sĩ', N'Đại Học', N'Tin Học Ứng Dụng', N'Phòng Công Tác Chính Trị Và Quản Lý Sinh Viên', N'', 3)
SET IDENTITY_INSERT [dbo].[QuanLyVien] OFF
SET IDENTITY_INSERT [dbo].[SinhVien] ON 

INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (1, N'Nguyễn Trúc Mai', 1300123, N'Nữ', CAST(N'1997-12-03' AS Date), N'Sóc Trăng', N'Sóc Trăng', N'Kinh', N'Phật Giáo', 377898990, CAST(N'2012-02-12' AS Date), CAST(N'2012-02-23' AS Date), CAST(N'2012-02-12' AS Date), 924772762, N'nguyentrucmai@gmail.com', N'', 1, 4, 1)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (2, N'Trần Bách Hợp', 1300223, N'Nam', CAST(N'1997-06-16' AS Date), N'Bạc Liêu', N'Cần Thơ', N'Kinh', N'Thiên Chúa', 377898111, CAST(N'2012-02-15' AS Date), CAST(N'2012-02-23' AS Date), CAST(N'2012-02-12' AS Date), 346813579, N'tranbachhop@gmail.com', N'', 2, 5, 2)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (3, N'Lê Mồng Gà', 1300423, N'Nam', CAST(N'1997-05-15' AS Date), N'Vũng Tàu', N'Cần Thơ', N'Kinh', N'Không', 377220111, CAST(N'2012-02-19' AS Date), CAST(N'2012-05-25' AS Date), CAST(N'2012-02-12' AS Date), 135790246, N'lemongga@gmail.com', N'', 3, 6, 3)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (4, N'Trần Bình Bát', 1300107, N'Nam', CAST(N'1997-04-13' AS Date), N'Hậu Giang', N'Hậu Giang', N'Kinh', N'Không', 366205620, CAST(N'2012-04-13' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 534567891, N'nguyentranbinhbat@gmail.com', N'', 4, 7, 4)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (5, N'Trần Thị Bòn Bon', 1300108, N'Nữ', CAST(N'1997-04-12' AS Date), N'Cà Mau', N'Cà Mau', N'Kinh', N'Không', 366202244, CAST(N'2012-04-12' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 534567822, N'nguyenthibonbon@gmail.com', N'', 5, 8, 5)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (6, N'Nguyễn Thị Bơ', 1300100, N'Nữ', CAST(N'1997-05-05' AS Date), N'Cà Mau', N'Cà Mau', N'Kinh', N'Không', 366123212, CAST(N'2012-05-12' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 334567822, N'nguyenthibo@gmail.com', N'', 6, 9, 6)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (7, N'Trần Văn Bưởi', 1300175, N'Nam', CAST(N'1997-06-05' AS Date), N'Huế', N'Huế', N'Kinh', N'Không', 366112456, CAST(N'2012-05-18' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 734567822, N'tranvanbuoi@gmail.com', N'', 7, 10, 7)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (8, N'Nguyễn Thị Cam', 1300225, N'Nữ', CAST(N'1997-06-15' AS Date), N'Huế', N'Huế', N'Kinh', N'Không', 366110101, CAST(N'2012-05-18' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 934567822, N'nguyenthicam@gmail.com', N'', 8, 11, 8)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (9, N'Nguyễn Thị Chanh', 1300015, N'Nữ', CAST(N'1996-06-15' AS Date), N'Hải Phòng', N'Cần Thơ', N'Kinh', N'Không', 211134111, CAST(N'2012-05-18' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 396813579, N'nguyenthichanh@gmail.com', N'', 9, 12, 9)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (10, N'Nguyễn Trần Chôm Chôm', 1300115, N'Nữ', CAST(N'1996-06-15' AS Date), N'Vũng Tàu', N'Cần Thơ', N'Kinh', N'Không', 366000212, CAST(N'2012-05-18' AS Date), CAST(N'2020-05-29' AS Date), CAST(N'2020-05-29' AS Date), 346813079, N'nguyentranchomchom@gmail.com', N'', 10, 13, 10)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (11, N'Nguyễn Thị Chuối', 1300229, N'Nữ', CAST(N'1996-06-25' AS Date), N'Nha Trang', N'Cần Thơ', N'Kinh', N'Không', 366011612, CAST(N'2012-12-18' AS Date), CAST(N'2012-12-18' AS Date), CAST(N'2012-12-18' AS Date), 596813579, N'nguyenthichuoi@gmail.com', N'', 11, 14, 11)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (12, N'Nguyễn Thị Dâu Tây', 1300249, N'Nữ', CAST(N'1996-09-25' AS Date), N'Đà Lạt', N'Cần Thơ', N'Kinh', N'Không', 366020212, CAST(N'2012-12-18' AS Date), CAST(N'2012-12-18' AS Date), CAST(N'2012-12-18' AS Date), 396833579, N'nguyenthidautay@gmail.com', N'', 12, 15, 12)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (13, N'Nguyễn Dưa Hấu', 1400050, N'Nữ', CAST(N'1996-09-05' AS Date), N'Kiên Giang', N'Kiên Giang', N'Kinh', N'Không', 366020666, CAST(N'2012-02-18' AS Date), CAST(N'2012-02-18' AS Date), CAST(N'2012-12-18' AS Date), 396813589, N'nguyenduahau@gmail.com', N'', 13, 16, 13)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (14, N'Nguyễn Dưa Leo', 1400150, N'Nam', CAST(N'1996-09-01' AS Date), N'Kiên Giang', N'Kiên Giang', N'Kinh', N'Không', 366021010, CAST(N'2012-10-18' AS Date), CAST(N'2012-10-18' AS Date), CAST(N'2012-12-18' AS Date), 711588991, N'nguyendualeo@gmail.com', N'', 14, 17, 14)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (15, N'Nguyễn Dưa Gang', 1400112, N'Nam', CAST(N'1996-09-12' AS Date), N'Hậu Giang', N'Hậu Giang', N'Kinh', N'Phật Giáo', 366021099, CAST(N'2011-12-25' AS Date), CAST(N'2011-12-25' AS Date), CAST(N'2012-12-18' AS Date), 711588555, N'nguyendua@gmail.com', N'', 16, 18, 16)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (16, N'Nguyễn Dừa', 1400199, N'Nam', CAST(N'1996-09-01' AS Date), N'Hậu Giang', N'Hậu Giang', N'Kinh', N'Phật Giáo', 366021098, CAST(N'2011-12-25' AS Date), CAST(N'2011-12-25' AS Date), CAST(N'2012-12-18' AS Date), 311588555, N'nguyendua@gmail.com', N'', 17, 19, 17)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (17, N'Lê Thị Thơm', 1400299, N'Nữ', CAST(N'1996-01-23' AS Date), N'Bạc Liêu', N'Bạc Liêu', N'Kinh', N'Phật Giáo', 396021098, CAST(N'2011-12-24' AS Date), CAST(N'2011-12-24' AS Date), CAST(N'2012-12-18' AS Date), 311123555, N'lethithom@gmail.com', N'', 18, 20, 18)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (18, N'Trần Đu Đủ', 1400003, N'Nam', CAST(N'1997-09-01' AS Date), N'An Giang', N'Kiên Giang', N'Kinh', N'Phật Giáo', 366021033, CAST(N'2012-02-22' AS Date), CAST(N'2012-02-22' AS Date), CAST(N'2012-12-18' AS Date), 911462457, N'trandudu@gmail.com', N'', 19, 21, 19)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (19, N'Nguyễn Văn Lê', 1400443, N'Nam', CAST(N'1997-04-01' AS Date), N'Bạc Liêu', N'Cần Thơ', N'Kinh', N'Phật Giáo', 366021066, CAST(N'2012-12-22' AS Date), CAST(N'2012-12-22' AS Date), CAST(N'2012-12-18' AS Date), 311123457, N'nguyenvanle@gmail.com', N'', 20, 22, 20)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (20, N'Nguyễn Văn Lựu', 1400643, N'Nam', CAST(N'1995-12-01' AS Date), N'Bạc Liêu', N'Bạc Liêu', N'Kinh', N'Phật Giáo', 366021166, CAST(N'2012-10-22' AS Date), CAST(N'2012-10-22' AS Date), CAST(N'2011-10-19' AS Date), 314623457, N'nguyenvanluu@gmail.com', N'', 21, 23, 21)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (21, N'Nguyễn Văn Mít', 1400056, N'Nam', CAST(N'1997-12-12' AS Date), N'Bạc Liêu', N'Bạc Liêu', N'Kinh', N'Phật Giáo', 366003066, CAST(N'2011-10-22' AS Date), CAST(N'2011-10-22' AS Date), CAST(N'2011-10-19' AS Date), 914151457, N'nguyenvanmit@gmail.com', N'', 22, 24, 22)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (22, N'Nguyễn Văn Sa Kê', 1400159, N'Nam', CAST(N'1997-09-12' AS Date), N'Hà Nội', N'Hà Nội', N'Kinh', N'Không', 366221166, CAST(N'2011-10-29' AS Date), CAST(N'2011-10-29' AS Date), CAST(N'2011-10-19' AS Date), 714151111, N'nguyenvansake@gmail.com', N'', 23, 25, 23)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (23, N'Nguyễn Thị Sơ Ri', 1400100, N'Nữ', CAST(N'1998-09-12' AS Date), N'Hà Tây', N'Hà Tây', N'Kinh', N'Không', 367121166, CAST(N'2011-11-19' AS Date), CAST(N'2011-11-19' AS Date), CAST(N'2011-10-19' AS Date), 514151590, N'nguyenthisori@gmail.com', N'', 24, 26, 24)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (24, N'Nguyễn Thị Cherry', 1400900, N'Nữ', CAST(N'1998-09-12' AS Date), N'Hà Tây', N'Hà Tây', N'Kinh', N'Không', 367121160, CAST(N'2011-11-19' AS Date), CAST(N'2011-11-19' AS Date), CAST(N'2011-10-19' AS Date), 314160600, N'nguyenthicherry@gmail.com', N'', 25, 27, 25)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (25, N'Nguyễn Thị Táo', 1500199, N'Nữ', CAST(N'1998-09-30' AS Date), N'Hà Nam', N'Hà Nam', N'Kinh', N'Không', 367121106, CAST(N'2011-11-22' AS Date), CAST(N'2011-11-19' AS Date), CAST(N'2011-10-19' AS Date), 114160611, N'nguyenthitao@gmail.com', N'', 26, 28, 26)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (26, N'Nguyễn Thị Tắc', 1500999, N'Nữ', CAST(N'1994-09-30' AS Date), N'Hà Nam', N'Hà Nam', N'Kinh', N'Thiên Chúa', 368121106, CAST(N'2011-10-29' AS Date), CAST(N'2011-10-19' AS Date), CAST(N'2011-10-19' AS Date), 314160612, N'nguyenthitac@gmail.com', N'', 27, 29, 27)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (27, N'Nguyễn Thị Vú Sữa', 1500599, N'Nữ', CAST(N'1994-01-30' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Thiên Chúa', 368121101, CAST(N'2011-10-19' AS Date), CAST(N'2012-10-19' AS Date), CAST(N'2011-10-19' AS Date), 914168881, N'nguyenthivusua@gmail.com', N'', 28, 30, 28)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (28, N'Nguyễn Thị Thanh Long', 1500399, N'Nữ', CAST(N'1998-01-30' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Không', 358121101, CAST(N'2011-12-19' AS Date), CAST(N'2012-12-19' AS Date), CAST(N'1996-09-25' AS Date), 714160622, N'nguyenthithanhlong@gmail.com', N'', 29, 31, 29)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (29, N'Nguyễn Mãng Cầu', 1500099, N'Nam', CAST(N'1998-01-31' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Không', 358104101, CAST(N'2011-12-19' AS Date), CAST(N'2012-12-19' AS Date), CAST(N'1996-09-25' AS Date), 514160124, N'tranmangcau@gmail.com', N'', 30, 32, 30)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (30, N'Trần Văn Xoài', 1500791, N'Nam', CAST(N'1998-01-15' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Không', 358194101, CAST(N'2011-12-09' AS Date), CAST(N'2012-12-09' AS Date), CAST(N'1996-09-25' AS Date), 514162256, N'tranvanxoai@gmail.com', N'', 31, 33, 31)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (31, N'Trần Văn Ổi', 1500991, N'Nam', CAST(N'1993-01-15' AS Date), N'Vĩnh Long', N'Vĩnh Long', N'Kinh', N'Không', 358194242, CAST(N'2011-02-09' AS Date), CAST(N'2012-02-09' AS Date), CAST(N'1996-09-25' AS Date), 314162113, N'tranvanoi@gmail.com', N'', 32, 34, 32)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (32, N'Lê Văn Cốc', 1501992, N'Nam', CAST(N'1993-01-16' AS Date), N'Vĩnh Long', N'Vĩnh Long', N'Kinh', N'Không', 358194244, CAST(N'2011-02-19' AS Date), CAST(N'2012-02-29' AS Date), CAST(N'1996-09-25' AS Date), 311555102, N'levancoc@gmail.com', N'', 33, 35, 33)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (34, N'Nguyễn Thị Dâu Tây', 1990249, N'Nữ', CAST(N'1996-09-25' AS Date), N'Đà Lạt', N'Cần Thơ', N'Kinh', N'Không', 390020212, CAST(N'1996-09-25' AS Date), CAST(N'1996-09-25' AS Date), CAST(N'1996-09-25' AS Date), 311555101, N'nguyenthidautay@gmail.com', N'', 12, 15, 12)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (35, N'Nguyễn Văn Tràng', 1990229, N'Nam', CAST(N'1996-09-25' AS Date), N'Đà Lạt', N'Cần Thơ', N'Kinh', N'Không', 391120212, CAST(N'1996-09-25' AS Date), CAST(N'1996-09-25' AS Date), CAST(N'1996-09-25' AS Date), 311555101, N'nguyenvantrang@gmail.com', N'', 35, 36, 35)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (36, N'Nguyễn Thị Gải', 1991229, N'Nữ', CAST(N'1996-09-29' AS Date), N'Đà Lạt', N'Đà Lạt', N'Kinh', N'Không', 391120213, CAST(N'1996-09-29' AS Date), CAST(N'1996-09-29' AS Date), CAST(N'1996-09-29' AS Date), 511555101, N'nguyenthigai@gmail.com', N'', 36, 37, 36)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (37, N'Nguyễn Thị Nở', 1991239, N'Nữ', CAST(N'1996-09-08' AS Date), N'Hà Nội', N'Hà Nội', N'Kinh', N'Không', 391120218, CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), 711555101, N'nguyenthino@gmail.com', N'', 37, 37, 37)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (38, N'Nguyễn Thị Mầu', 1891239, N'Nữ', CAST(N'1996-09-08' AS Date), N'Hà Nội', N'Hà Nội', N'Kinh', N'Không', 396120218, CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), 311555101, N'nguyenthimau@gmail.com', N'', 38, 40, 38)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (39, N'Nguyễn Văn An', 1911239, N'Nữ', CAST(N'1996-09-08' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Không', 399120219, CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), 711555101, N'nguyenvanan@gmail.com', N'', 39, 41, 39)
INSERT [dbo].[SinhVien] ([IDSinhVien], [HoTen], [MaSoSinhVien], [GioiTinh], [NgaySinh], [NoiSinh], [DiaChiThuongTru], [DanToc], [TonGiao], [ChungMinhNhanDan], [NgayCap], [NgayVaoDoan], [NgayVaoDang], [DienThoai], [Email], [GhiChu], [IDGiaDinh], [IDTaiKhoan], [IDThongTinTotNghiep]) VALUES (40, N'Nguyễn Thị Mộng', 1911233, N'Nữ', CAST(N'1996-09-08' AS Date), N'Cần Thơ', N'Cần Thơ', N'Kinh', N'Không', 340120219, CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), CAST(N'1996-09-08' AS Date), 711555123, N'nguyenthimong@gmail.com', N'', 40, 45, 40)
SET IDENTITY_INSERT [dbo].[SinhVien] OFF
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (1, N'admin', N'123', N'buitruongnhutlm@gmail.com', 388199487, N'', 1)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (2, N'lethihong', N'123', N'buitruongnhatlm@gmail.com', 123456789, N'', 2)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (3, N'nguyenvandai', N'123', N'nguyenvandai@gmail.com', 987654322, N'', 2)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (4, N'nguyentrucmai', N'123', N'nguyentrucmai@gmail.com', 924772762, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (5, N'tranbachhop', N'123', N'tranbachhop@gmail.com', 146813579, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (6, N'lemongga', N'123', N'lemongga@gmail.com', 135792468, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (7, N'nguyentranbinhbat', N'123', N'nguyentranbinhbat@gmail.com', 134567891, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (8, N'nguyenthibonbon', N'123', N'nguyenthibonbon@gmail.com', 334567822, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (9, N'nguyenthibo', N'123', N'nguyenthibo@gmail.com', 534511122, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (10, N'tranvanbuoi', N'123', N'tranvanbuoi@gmail.com', 511111122, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (11, N'nguyenthicam', N'123', N'nguyenthicam@gmail.com', 711134802, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (12, N'nguyenthichanh', N'123', N'nguyenthichanh@gmail.com', 311134111, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (13, N'nguyentranchomchom', N'123', N'nguyentranchomchom@gmail.com', 111134222, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (14, N'nguyenthichuoi', N'123', N'nguyenthichuoi@gmail.com', 911134101, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (15, N'nguyenthidautay', N'123', N'nguyenthidautay@gmail.com', 711555101, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (16, N'nguyenduahau', N'123', N'nguyenduahau@gmail.com', 311577101, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (17, N'nguyendualeo', N'123', N'nguyendualeo@gmail.com', 911588991, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (18, N'nguyenduagang', N'123', N'nguyenduagang@gmail.com', 911588123, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (19, N'nguyendua', N'123', N'nguyendua@gmail.com', 311588555, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (20, N'lethithom', N'123', N'lethithom@gmail.com', 311123555, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (21, N'trandudu', N'123', N'trandudu@gmail.com', 311462457, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (22, N'nguyenvanle', N'123', N'nguyenvanle@gmail.com', 311123457, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (23, N'nguyenvanluu', N'123', N'nguyenvanluu@gmail.com', 314623457, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (24, N'nguyenvanmit', N'123', N'nguyenvanmit@gmail.com', 114151457, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (25, N'nguyenvansake', N'123', N'nguyenvansake@gmail.com', 114151111, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (26, N'nguyenthisori', N'123', N'nguyenthisori@gmail.com', 114151590, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (27, N'nguyenthicherry', N'123', N'nguyenthicherry@gmail.com', 314160600, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (28, N'nguyenthitao', N'123', N'nguyenthitao@gmail.com', 314160611, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (29, N'nguyenthitac', N'123', N'nguyenthitac@gmail.com', 314160612, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (30, N'nguyenthivusua', N'123', N'nguyenthivusua@gmail.com', 141688812, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (31, N'nguyenthithanhlong', N'123', N'nguyenthithanhlong@gmail.com', 314160622, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (32, N'tranmangcau', N'123', N'tranmangcau@gmail.com', 914160124, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (33, N'tranvanxoai', N'123', N'tranvanxoai@gmail.com', 714162256, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (34, N'tranvanoi', N'123', N'tranvanoi@gmail.com', 714162113, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (35, N'levancoc', N'123', N'levancoc@gmail.com', 714162257, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (36, N'nguyenvantrang', N'n12345678N', N'nguyenvantrang@gmail.com', 330309191, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (37, N'nguyenthigai', N'n12345678N', N'nguyenthigai@gmail.com', 330309191, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (38, N'nguyenthino', N'n12345678N', N'nguyenthino@gmail.com', 330309192, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (40, N'nguyenthimau', N'n12345678N', N'nguyenthimau@gmail.com', 331319192, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (41, N'nguyenvanan', N'n12345678N', N'nguyenvanan@gmail.com', 391319193, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (42, N'nguyenvanbinh', N'n12345678N', N'nguyenvanbinh@gmail.com', 391319199, N'', 2)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (43, N'nguyenvanchinh', N'n12345678N', N'nguyenvanchinh@gmail.com', 739131999, N'', 3)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (44, N'nguyenvanmuoi', N'n12345678N', N'nguyenvanmuoi@gmail.com', 739131991, N'', 2)
INSERT [dbo].[TaiKhoan] ([IDTaikhoan], [TenTaiKhoan], [MatKhau], [Email], [SoDienThoai], [GhiChu], [IDLoaiTaiKhoan]) VALUES (45, N'nguyenthimong', N'n12345678N', N'nguyenthimong@gmail.com', 709131991, N'', 3)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
SET IDENTITY_INSERT [dbo].[ThongTinTotNghiep] ON 

INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (1, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (2, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (3, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 3.5, N'', 2, 1, 2, 2, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (4, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 3.5, N'', 2, 1, 2, 2, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (5, CAST(N'2013-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 3, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (6, CAST(N'2013-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 3, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (7, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 3.3, N'', 3, 1, 1, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (8, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 3.4, N'', 3, 1, 1, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (9, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 2.7, N'', 3, 1, 3, 5, 4, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (10, CAST(N'2013-08-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 1.5, N'', 6, 1, 3, 5, 6, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (11, CAST(N'2013-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 6, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (12, CAST(N'2013-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 6, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (13, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 4, N'', 1, 1, 2, 7, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (14, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 3.7, N'', 2, 1, 2, 7, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (15, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 3.3, N'', 3, 1, 2, 8, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (16, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 4, N'', 1, 1, 2, 8, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (17, CAST(N'2014-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 9, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (18, CAST(N'2014-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 9, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (19, CAST(N'2014-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 10, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (20, CAST(N'2014-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 10, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (21, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 3.1, N'', 3, 1, 3, 11, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (22, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 3.5, N'', 2, 1, 3, 11, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (23, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 2.2, N'', 5, 1, 3, 12, 5, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (24, CAST(N'2014-08-01' AS Date), CAST(N'2018-08-01' AS Date), CAST(N'2018-09-01' AS Date), 4, N'', 1, 1, 3, 12, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (25, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-09-01' AS Date), 3.1, N'', 3, 1, 2, 13, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (26, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-09-01' AS Date), 1.2, N'', 7, 1, 2, 13, 7, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (27, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-09-01' AS Date), 4, N'', 1, 1, 2, 14, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (28, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-09-01' AS Date), 3.3, N'', 3, 1, 2, 14, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (29, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-09-01' AS Date), 1.1, N'', 7, 1, 1, 15, 7, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (30, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 15, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (31, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 16, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (32, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 1, 16, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (33, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 17, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (34, CAST(N'2015-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-08-01' AS Date), 1.5, N'', 7, 1, 3, 17, 6, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (35, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (36, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (37, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (38, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (39, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (40, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (41, CAST(N'2099-09-09' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (42, CAST(N'2099-09-09' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (43, CAST(N'2015-08-01' AS Date), CAST(N'0001-01-01' AS Date), CAST(N'0001-01-01' AS Date), 0, N'', 9, 1, 3, 18, 9, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (44, CAST(N'2099-09-09' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (45, CAST(N'2099-09-09' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (46, CAST(N'2099-10-10' AS Date), CAST(N'2017-08-02' AS Date), CAST(N'2017-09-02' AS Date), 3.1, N'', 2, 1, 3, 4, 2, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (47, CAST(N'2099-11-11' AS Date), CAST(N'2017-08-03' AS Date), CAST(N'2017-09-03' AS Date), 2, N'', 4, 1, 1, 5, 4, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (48, CAST(N'2099-12-12' AS Date), CAST(N'2017-08-04' AS Date), CAST(N'2017-09-04' AS Date), 1, N'', 3, 1, 2, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (49, CAST(N'2099-01-13' AS Date), CAST(N'2017-08-05' AS Date), CAST(N'2017-09-05' AS Date), 3.5, N'', 2, 1, 3, 6, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (50, CAST(N'2098-01-01' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (51, CAST(N'2098-01-02' AS Date), CAST(N'2017-08-02' AS Date), CAST(N'2017-09-02' AS Date), 3.1, N'', 2, 1, 3, 4, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (52, CAST(N'2098-01-03' AS Date), CAST(N'2017-08-03' AS Date), CAST(N'2017-09-03' AS Date), 2, N'', 4, 1, 1, 5, 4, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (53, CAST(N'2098-01-04' AS Date), CAST(N'2017-08-04' AS Date), CAST(N'2017-09-04' AS Date), 1, N'', 3, 1, 2, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (54, CAST(N'2098-01-05' AS Date), CAST(N'2017-08-05' AS Date), CAST(N'2017-09-05' AS Date), 3.5, N'', 2, 1, 3, 6, 2, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (55, CAST(N'2098-01-07' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (56, CAST(N'2098-01-08' AS Date), CAST(N'2017-08-02' AS Date), CAST(N'2017-09-02' AS Date), 3.1, N'', 2, 1, 3, 4, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (57, CAST(N'2098-01-09' AS Date), CAST(N'2017-08-03' AS Date), CAST(N'2017-09-03' AS Date), 2, N'', 4, 1, 1, 5, 4, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (58, CAST(N'2098-01-10' AS Date), CAST(N'2017-08-04' AS Date), CAST(N'2017-09-04' AS Date), 1, N'', 3, 1, 2, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (59, CAST(N'2098-01-11' AS Date), CAST(N'2017-08-05' AS Date), CAST(N'2017-09-05' AS Date), 3.5, N'', 2, 1, 3, 6, 2, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (60, CAST(N'2098-01-07' AS Date), CAST(N'2017-08-01' AS Date), CAST(N'2017-09-01' AS Date), 4, N'', 1, 1, 2, 1, 1, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (61, CAST(N'2098-01-08' AS Date), CAST(N'2017-08-02' AS Date), CAST(N'2017-09-02' AS Date), 3.1, N'', 2, 1, 3, 4, 2, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (62, CAST(N'2098-01-09' AS Date), CAST(N'2017-08-03' AS Date), CAST(N'2017-09-03' AS Date), 2, N'', 4, 1, 1, 5, 4, N'Chưa Tốt Nghiệp', N'Có')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (63, CAST(N'2098-01-10' AS Date), CAST(N'2017-08-04' AS Date), CAST(N'2017-09-04' AS Date), 1, N'', 3, 1, 2, 4, 3, N'Đã Tốt Nghiệp', N'Không')
INSERT [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep], [NgayVaoTruong], [NgayTotNghiep], [NgayCapBang], [Diem4], [GhiChu], [IDLoaiTotNghiep], [IDHeDaoTao], [IDNghanh], [IDLop], [IDDiemChu], [TrangThai], [NoMon]) VALUES (64, CAST(N'2098-01-11' AS Date), CAST(N'2017-08-05' AS Date), CAST(N'2017-09-05' AS Date), 3.5, N'', 2, 1, 3, 6, 2, N'Chưa Tốt Nghiệp', N'Có')
SET IDENTITY_INSERT [dbo].[ThongTinTotNghiep] OFF
/****** Object:  Index [UQ__Khoa__65390404D61E2C30]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[Khoa] ADD UNIQUE NONCLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__LoaiTaiK__3F111EA333B0E42F]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[LoaiTaiKhoan] ADD UNIQUE NONCLUSTERED 
(
	[TenLoaiTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Lop__3B98D27218A3B707]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[Lop] ADD UNIQUE NONCLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__QuanLyVi__BED1A8951AB335CB]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[QuanLyVien] ADD UNIQUE NONCLUSTERED 
(
	[ChungMinhNhanDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__5D801499149E4F10]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[SinhVien] ADD UNIQUE NONCLUSTERED 
(
	[MaSoSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__BED1A895F1E48BFB]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[SinhVien] ADD UNIQUE NONCLUSTERED 
(
	[ChungMinhNhanDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__TaiKhoan__B106EAF8F9D635B8]    Script Date: 26/06/2020 16:16:38 ******/
ALTER TABLE [dbo].[TaiKhoan] ADD UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lop]  WITH CHECK ADD FOREIGN KEY([IDKhoa])
REFERENCES [dbo].[Khoa] ([IDKhoa])
GO
ALTER TABLE [dbo].[MonHoc]  WITH CHECK ADD FOREIGN KEY([IDSinhVien])
REFERENCES [dbo].[SinhVien] ([IDSinhVien])
GO
ALTER TABLE [dbo].[QuanLyVien]  WITH CHECK ADD FOREIGN KEY([IDTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([IDTaikhoan])
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD FOREIGN KEY([IDGiaDinh])
REFERENCES [dbo].[GiaDinh] ([IDGiaDinh])
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD FOREIGN KEY([IDTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([IDTaikhoan])
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD FOREIGN KEY([IDThongTinTotNghiep])
REFERENCES [dbo].[ThongTinTotNghiep] ([IDThongTinTotNghiep])
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([IDLoaiTaiKhoan])
REFERENCES [dbo].[LoaiTaiKhoan] ([IDLoaiTaiKhoan])
GO
ALTER TABLE [dbo].[ThongTinTotNghiep]  WITH CHECK ADD FOREIGN KEY([IDDiemChu])
REFERENCES [dbo].[DiemChu] ([IDDiemChu])
GO
ALTER TABLE [dbo].[ThongTinTotNghiep]  WITH CHECK ADD FOREIGN KEY([IDHeDaoTao])
REFERENCES [dbo].[HeDaoTao] ([IDHeDaoTao])
GO
ALTER TABLE [dbo].[ThongTinTotNghiep]  WITH CHECK ADD FOREIGN KEY([IDLoaiTotNghiep])
REFERENCES [dbo].[LoaiTotNghiep] ([IDLoaiTotNghiep])
GO
ALTER TABLE [dbo].[ThongTinTotNghiep]  WITH CHECK ADD FOREIGN KEY([IDLop])
REFERENCES [dbo].[Lop] ([IDLop])
GO
ALTER TABLE [dbo].[ThongTinTotNghiep]  WITH CHECK ADD FOREIGN KEY([IDNghanh])
REFERENCES [dbo].[Nganh] ([IDNganh])
GO
/****** Object:  StoredProcedure [dbo].[pro_DeleteManager]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_DeleteManager]
@IDQuanLyVien INT
AS
BEGIN
	DELETE dbo.QuanLyVien WHERE IDQuanLyVien = @IDQuanLyVien
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetAccountCurrent]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetAccountCurrent]
@username VARCHAR(150)
AS
BEGIN
SELECT sv.HoTen,sv.MaSoSinhVien,sv.GioiTinh,sv.NgaySinh,sv.NoiSinh,sv.DiaChiThuongTru,sv.DanToc,sv.TonGiao,
sv.ChungMinhNhanDan,sv.NgayCap,sv.NgayVaoDoan,sv.NgayVaoDang,sv.DienThoai,sv.Email,sv.GhiChu,tk.TenTaiKhoan TENTAIKHOAN,
sv.IDGiaDinh,sv.IDThongTinTotNghiep
FROM dbo.SinhVien sv, dbo.TaiKhoan tk
WHERE sv.IDTaiKhoan = tk.IDTaikhoan AND TENTAIKHOAN = @username
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetFamilyByStudent]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetFamilyByStudent]
@idsinhvien int
AS
BEGIN
SELECT gd.IDGiaDinh ,gd.HoTenCha ,gd.NamSinhCha ,gd.DienThoaiCha ,gd.HoTenMe ,gd.NamSinhMe ,gd.DienThoaiMe ,gd.DiaChi ,gd.GhiChu
FROM dbo.SinhVien sv, dbo.GiaDinh gd
WHERE sv.IDGiaDinh = gd.IDGiaDinh AND gd.IDGiaDinh IN (SELECT IDGiaDinh FROM dbo.SinhVien WHERE IDSinhVien = @idsinhvien )
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetIDAccountByUsername]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetIDAccountByUsername]
@username VARCHAR(100)
AS
BEGIN
SELECT IDTaikhoan FROM dbo.TaiKhoan WHERE TenTaiKhoan=@username
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetIDSinhVienByIDTaiKhoan]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetIDSinhVienByIDTaiKhoan]
@idtaikhoan INT
AS
BEGIN
SELECT IDSinhVien
FROM dbo.TaiKhoan tk, dbo.SinhVien sv
WHERE tk.IDTaikhoan = sv.IDTaiKhoan AND sv.IDTaiKhoan IN (SELECT IDTaikhoan FROM dbo.TaiKhoan WHERE IDTaikhoan=@idtaikhoan)
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetListAccount]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListAccount]
AS
BEGIN
	SELECT * FROM  dbo.TaiKhoan
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListClass]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListClass]
AS
BEGIN
SELECT L.IDLop, L.MaLop, L.TenLop, L.SoLuongSinhVien, L.CoVan, K.TenKhoa, L.GhiChu
FROM dbo.Lop L, dbo.Khoa K WHERE l.IDKhoa = k.IDKhoa
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListCourse]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListCourse]
AS
BEGIN
	SELECT * FROM dbo.Khoa
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListFamily]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListFamily]
AS
BEGIN
	SELECT * FROM dbo.GiaDinh	
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListGraduate]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetListGraduate]
AS
BEGIN
SELECT tn.IDThongTinTotNghiep,  tn.NgayVaoTruong, tn.NgayTotNghiep, tn.NgayCapBang, tn.Diem4, tn.GhiChu,
ltn.TenLoaiTotNghiep, hdt.TenHeDaoTao, n.TenNganh, l.MaLop, d.IDDiemChu, d.TenDiem, tn.TrangThai, tn.NoMon
FROM dbo.ThongTinTotNghiep tn, dbo.Lop l, dbo.LoaiTotNghiep ltn, dbo.HeDaoTao hdt, dbo.Nganh n, dbo.DiemChu d
WHERE tn.IDLoaiTotNghiep = ltn.IDLoaiTotNghiep AND tn.IDHeDaoTao = hdt.IDHeDaoTao AND tn.IDNghanh= n.IDNganh AND
tn.IDLop = l.IDLop AND tn.IDDiemChu = d.IDDiemChu AND tn.TrangThai = N'Đã Tốt Nghiệp'
END





GO
/****** Object:  StoredProcedure [dbo].[pro_GetListGraduateType]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListGraduateType]
AS
BEGIN
SELECT * FROM dbo.LoaiTotNghiep
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListManager]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListManager]
AS
BEGIN
SELECT qlv.IDQuanLyVien, qlv.HoTen, qlv.NgaySinh, qlv.GioiTinh, qlv.ChungMinhNhanDan, qlv.NoiSinh, qlv.DiaChiThuongTru,
qlv.HocHam, qlv.TrinhDo, qlv.ChuyenMon, qlv.DonViCongTac, qlv.GhiChu, tk.TenTaiKhoan
FROM dbo.QuanLyVien qlv, dbo.TaiKhoan tk
WHERE qlv.IDTaiKhoan = tk.IDTaikhoan
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListNotGraduate]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetListNotGraduate]
AS
BEGIN
SELECT tn.IDThongTinTotNghiep,  tn.NgayVaoTruong, tn.NgayTotNghiep, tn.NgayCapBang, tn.Diem4, tn.GhiChu,
ltn.TenLoaiTotNghiep, hdt.TenHeDaoTao, n.TenNganh, l.MaLop, d.IDDiemChu, d.TenDiem, tn.TrangThai, tn.NoMon
FROM dbo.ThongTinTotNghiep tn, dbo.Lop l, dbo.LoaiTotNghiep ltn, dbo.HeDaoTao hdt, dbo.Nganh n, dbo.DiemChu d
WHERE tn.IDLoaiTotNghiep = ltn.IDLoaiTotNghiep AND tn.IDHeDaoTao = hdt.IDHeDaoTao AND tn.IDNghanh= n.IDNganh AND
tn.IDLop = l.IDLop AND tn.IDDiemChu = d.IDDiemChu AND tn.TrangThai = N'Chưa Tốt Nghiệp' 
END




GO
/****** Object:  StoredProcedure [dbo].[pro_GetListProfession]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_GetListProfession]
AS
BEGIN
	SELECT * FROM nganh
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetListStudent]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetListStudent]
AS
BEGIN
SELECT sv.IDSinhVien, sv.HoTen, sv.MaSoSinhVien, sv.GioiTinh, sv.NgaySinh, sv.NoiSinh,
sv.DiaChiThuongTru, sv.DanToc, sv.TonGiao, sv.ChungMinhNhanDan, sv.NgayCap, sv.NgayVaoDoan,
sv.NgayVaoDang, sv.DienThoai, sv.Email, sv.GhiChu,
tk.TenTaiKhoan, sv.IDGiaDinh ,sv.IDThongTinTotNghiep
FROM dbo.SinhVien sv, dbo.GiaDinh gd, dbo.TaiKhoan tk
WHERE sv.IDGiaDinh = gd.IDGiaDinh AND sv.IDTaiKhoan = tk.IDTaikhoan
END







GO
/****** Object:  StoredProcedure [dbo].[pro_GetListSubjectDebt]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetListSubjectDebt]
AS
BEGIN
SELECT mh.IDMonHoc, sv.HoTen, mh.ToanRoiRac, mh.GiaiTich,mh.XacSuatThongKe, mh.KyThuatLapTrinh, mh.MangMayTinh,
mh.CoSoDuLieu, mh.KyNangGiaoTiep, mh.LapTrinhHuongDoiTuong, mh.CauTrucDuLieuGiaiThuat, mh.HeDieuHanh, mh.PhanTichThietKe,
mh.TriTueNhanTao, mh.PhanMemMaNguonMo, mh.BaoTriPhanMem, mh.ThuongMaiDienTu, mh.DoAn1, mh.DoAn2, mh.DoAn3,
mh.ChungChiNgoaiNgu, mh.HocPhanTuChon 
FROM dbo.MonHoc mh, dbo.SinhVien sv
WHERE mh.IDSinhVien = sv.IDSinhVien
END


GO
/****** Object:  StoredProcedure [dbo].[pro_GetListTraining]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pro_GetListTraining]
AS
BEGIN
SELECT * FROM dbo.HeDaoTao
END








GO
/****** Object:  StoredProcedure [dbo].[pro_GetStudentCurrent]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_GetStudentCurrent]
@idtaikhoan int
AS
BEGIN
SELECT sv.HoTen,sv.MaSoSinhVien,sv.GioiTinh,sv.NgaySinh,sv.NoiSinh,sv.DiaChiThuongTru,sv.DanToc,sv.TonGiao,
sv.ChungMinhNhanDan,sv.NgayCap,sv.NgayVaoDoan,sv.NgayVaoDang,sv.DienThoai,sv.Email,sv.GhiChu,tk.TenTaiKhoan,
sv.IDGiaDinh,sv.IDThongTinTotNghiep
FROM dbo.SinhVien sv, dbo.TaiKhoan tk
WHERE sv.IDTaiKhoan = tk.IDTaikhoan AND sv.IDTaiKhoan IN (SELECT IDTaikhoan FROM dbo.TaiKhoan WHERE IDTaikhoan = @idtaikhoan)  
END







GO
/****** Object:  StoredProcedure [dbo].[pro_InsertManager]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_InsertManager]
@HoTen NVARCHAR(250), @NgaySinh DATE, @GioiTinh NVARCHAR(5), @CMND INT, @NoiSinh NVARCHAR(250),
@DiaChiThuongTru NVARCHAR(250), @HocHam NVARCHAR(100), @TrinhDo NVARCHAR(100), @ChuyenMon NVARCHAR(100),
@DonViCongTac NVARCHAR(250), @IDTaiKhoan INT, @GhiChu NVARCHAR(250)= NULL
AS
BEGIN
	INSERT INTO dbo.QuanLyVien ( HoTen , NgaySinh , GioiTinh , ChungMinhNhanDan , NoiSinh , DiaChiThuongTru , HocHam , TrinhDo , ChuyenMon , DonViCongTac , GhiChu , IDTaiKhoan)
	VALUES  ( @HoTen , @NgaySinh , @GioiTinh , @CMND , @NoiSinh , @DiaChiThuongTru , @HocHam , @TrinhDo , @ChuyenMon , @DonViCongTac , @GhiChu , @IDTaiKhoan )
END








GO
/****** Object:  StoredProcedure [dbo].[pro_Login]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_Login]
@TenTaiKhoan NVARCHAR(100), @MatKhau NVARCHAR(100)
AS
BEGIN
SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan=@TenTaiKhoan AND MatKhau = @MatKhau
END








GO
/****** Object:  StoredProcedure [dbo].[pro_SearchAccount]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_SearchAccount]
@type VARCHAR(50), @content VARCHAR(100)
AS
BEGIN
IF(@type='TenTaiKhoan')
SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan LIKE '%'+@content+'%'
ELSE IF(@type='SoDienThoai')
SELECT * FROM dbo.TaiKhoan WHERE SoDienThoai LIKE '%'+@content+'%'
ELSE IF(@type='Email')
SELECT * FROM dbo.TaiKhoan WHERE Email LIKE '%'+@content+'%'
ELSE IF(@type='Ghi Chu')
SELECT * FROM dbo.TaiKhoan WHERE GhiChu LIKE '%'+@content+'%'
END








GO
/****** Object:  StoredProcedure [dbo].[pro_SearchClass]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pro_SearchClass]
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='MaLop')
SELECT * FROM dbo.Lop WHERE MaLop LIKE N'%'+@content+'%'
ELSE IF(@type='TenLop')
SELECT * FROM dbo.Lop WHERE TenLop LIKE N'%'+@content+'%'
ELSE IF(@type='CoVan')
SELECT * FROM dbo.Lop WHERE CoVan LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.Lop WHERE GhiChu LIKE N'%'+@content+'%'
END








GO
/****** Object:  StoredProcedure [dbo].[pro_SearchFamily]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_SearchFamily]
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='HoTenCha')
SELECT * FROM dbo.GiaDinh WHERE HoTenCha LIKE N'%'+@content+'%'
ELSE IF(@type='DienThoaiCha')
SELECT * FROM dbo.GiaDinh WHERE DienThoaiCha LIKE N'%'+@content+'%'
ELSE IF(@type='HoTenMe')
SELECT * FROM dbo.GiaDinh WHERE HoTenMe LIKE N'%'+@content+'%'
ELSE IF(@type='DienThoaiMe')
SELECT * FROM dbo.GiaDinh WHERE DienThoaiMe LIKE N'%'+@content+'%'
ELSE IF(@type='DiaChi')
SELECT * FROM dbo.GiaDinh WHERE DiaChi LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.GiaDinh WHERE GhiChu LIKE N'%'+@content+'%'
END








GO
/****** Object:  StoredProcedure [dbo].[pro_SearchGraduate]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_SearchGraduate]
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='IDThongTinTotNghiep')
SELECT * FROM dbo.ThongTinTotNghiep WHERE IDThongTinTotNghiep LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.ThongTinTotNghiep WHERE GhiChu LIKE N'%'+@content+'%'
END







GO
/****** Object:  StoredProcedure [dbo].[pro_SearchManager]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_SearchManager]
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='HoTen')
SELECT * FROM dbo.QuanLyVien WHERE HoTen LIKE N'%'+@content+'%'
ELSE IF(@type='GioiTinh')
SELECT * FROM dbo.QuanLyVien WHERE GioiTinh LIKE N'%'+@content+'%'
ELSE IF(@type='ChungMinhNhanDan')
SELECT * FROM dbo.QuanLyVien WHERE ChungMinhNhanDan LIKE N'%'+@content+'%'
ELSE IF(@type='TaiKhoan')
SELECT * FROM dbo.QuanLyVien WHERE IDTaiKhoan LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.QuanLyVien WHERE GhiChu LIKE N'%'+@content+'%'
END








GO
/****** Object:  StoredProcedure [dbo].[pro_SearchStudent]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_SearchStudent]
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='HoTen')
SELECT * FROM dbo.SinhVien WHERE HoTen LIKE N'%'+@content+'%'
ELSE IF(@type='MaSoSinhVien')
SELECT * FROM dbo.SinhVien WHERE MaSoSinhVien LIKE N'%'+@content+'%'
ELSE IF(@type='GioiTinh')
SELECT * FROM dbo.SinhVien WHERE GioiTinh LIKE N'%'+@content+'%'
ELSE IF(@type='NoiSinh')
SELECT * FROM dbo.SinhVien WHERE NoiSinh LIKE N'%'+@content+'%'
ELSE IF(@type='ChungMinhNhanDan')
SELECT * FROM dbo.SinhVien WHERE ChungMinhNhanDan LIKE N'%'+@content+'%'
ELSE IF(@type='DienThoai')
SELECT * FROM dbo.SinhVien WHERE DienThoai LIKE N'%'+@content+'%'
ELSE IF(@type='Email')
SELECT * FROM dbo.SinhVien WHERE Email LIKE N'%'+@content+'%'
ELSE IF(@type='Ghi Chu')
SELECT * FROM dbo.SinhVien WHERE GhiChu LIKE N'%'+@content+'%'
END








GO
/****** Object:  StoredProcedure [dbo].[pro_UpdatetManager]    Script Date: 26/06/2020 16:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_UpdatetManager]
@IDQuanLyVien int, @HoTen NVARCHAR(250), @NgaySinh DATE, @GioiTinh NVARCHAR(5), @CMND INT, @NoiSinh NVARCHAR(250),
@DiaChiThuongTru NVARCHAR(250), @HocHam NVARCHAR(100), @TrinhDo NVARCHAR(100), @ChuyenMon NVARCHAR(100),
@DonViCongTac NVARCHAR(250), @IDTaiKhoan INT, @GhiChu NVARCHAR(250)= NULL
AS
BEGIN
	UPDATE dbo.QuanLyVien set HoTen = @HoTen , NgaySinh = @NgaySinh , GioiTinh = @GioiTinh , ChungMinhNhanDan = @CMND , 
	NoiSinh = @NoiSinh , DiaChiThuongTru = @DiaChiThuongTru , HocHam = @HocHam , TrinhDo = @TrinhDo , ChuyenMon = @ChuyenMon , 
	DonViCongTac = @DonViCongTac , GhiChu = @GhiChu , IDTaiKhoan = @IDTaiKhoan WHERE IDQuanLyVien = @IDQuanLyVien
END







GO
USE [master]
GO
ALTER DATABASE [QuanLySinhVienTotNghiep] SET  READ_WRITE 
GO
