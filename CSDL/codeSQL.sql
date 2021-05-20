
-- tạo bảng------------------------------------------------------------------------------------------

CREATE DATABASE QuanLySinhVienTotNghiep
GO

CREATE TABLE LoaiTaiKhoan
(
	IDLoaiTaiKhoan INT PRIMARY KEY IDENTITY,
	TenLoaiTaiKhoan NVARCHAR(250) NOT NULL UNIQUE,
	GhiChu NVARCHAR(250)
)

CREATE TABLE TaiKhoan
(
	IDTaikhoan INT PRIMARY KEY IDENTITY,
	TenTaiKhoan VARCHAR(250) NOT NULL UNIQUE,
	MatKhau VARCHAR(250) NOT NULL,
	Email VARCHAR(250),
	SoDienThoai INT NOT NULL,
	GhiChu NVARCHAR(250),
	IDLoaiTaiKhoan INT REFERENCES dbo.LoaiTaiKhoan(IDLoaiTaiKhoan)
)

CREATE TABLE QuanLyVien
(
	IDQuanLyVien INT PRIMARY KEY IDENTITY,
	HoTen NVARCHAR(250) NOT NULL,
	NgaySinh DATE NOT NULL, -- date or string
	GioiTinh NVARCHAR(5) NOT NULL,
	ChungMinhNhanDan INT NOT NULL UNIQUE,
	NoiSinh NVARCHAR(250),
	DiaChiThuongTru NVARCHAR(250) NOT NULL,
	HocHam NVARCHAR(250),
	TrinhDo NVARCHAR(250),
	ChuyenMon NVARCHAR(250),
	DonViCongTac NVARCHAR(250),
	GhiChu NVARCHAR(250),
	IDTaiKhoan INT REFERENCES dbo.TaiKhoan(IDTaikhoan)
)

CREATE TABLE GiaDinh
(
	IDGiaDinh INT PRIMARY KEY IDENTITY,
	HoTenCha NVARCHAR(250) NOT NULL,
	NamSinhCha DATE,
	DienThoaiCha INT,
	HoTenMe NVARCHAR(250) NOT NULL,
	NamSinhMe DATE,
	DienThoaiMe INT,
	DiaChi NVARCHAR(250) NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE LoaiTotNghiep
(
	IDLoaiTotNghiep INT PRIMARY KEY IDENTITY,
	TenLoaiTotNghiep NVARCHAR(250) NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE HeDaoTao
(
	IDHeDaoTao INT PRIMARY KEY IDENTITY,
	TenHeDaoTao NVARCHAR(250) NOT NULL,
	ThoiGianDaoTao INT NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE Nganh
(
	IDNganh INT PRIMARY KEY IDENTITY,
	TenNganh NVARCHAR(250) NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE Khoa
(
	IDKhoa INT PRIMARY KEY IDENTITY,
	MaKhoa INT NOT NULL UNIQUE,
	TenKhoa NVARCHAR(250) NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE Lop
(
	IDLop INT PRIMARY KEY IDENTITY,
	MaLop NVARCHAR(250) NOT NULL UNIQUE,
	TenLop NVARCHAR(250) NOT NULL,
	SoLuongSinhVien INT NOT NULL,
	CoVan NVARCHAR(250),
	GhiChu NVARCHAR(250),
	IDKhoa INT REFERENCES Khoa(IDKhoa)
)

CREATE TABLE ThongTinTotNghiep
(
	IDThongTinTotNghiep INT PRIMARY KEY IDENTITY,
	NgayVaoTruong DATE NOT NULL,
	NgayTotNghiep DATE NOT NULL,
	NgayCapBang DATE NOT NULL,
	DiemChu NVARCHAR(50) NOT NULL,
	DiemSo FLOAT NOT NULL,
	GhiChu NVARCHAR(250),
	IDLoaiTotNghiep INT REFERENCES dbo.LoaiTotNghiep(IDLoaiTotNghiep),
	IDHeDaoTao INT REFERENCES dbo.HeDaoTao(IDHeDaoTao),
	IDNghanh INT REFERENCES dbo.Nganh(IDNganh),
	IDLop INT REFERENCES dbo.Lop(IDLop)
)

CREATE TABLE SinhVien
(
	IDSinhVien INT PRIMARY KEY IDENTITY,
	HoTen NVARCHAR(250) NOT NULL,
	MaSoSinhVien INT NOT NULL UNIQUE,
	GioiTinh NVARCHAR(5) NOT NULL,
	NgaySinh DATE NOT NULL,
	NoiSinh NVARCHAR(250),
	DiaChiThuongTru NVARCHAR(250) NOT NULL,
	DanToc NVARCHAR(50),
	TonGiao NVARCHAR(50),
	ChungMinhNhanDan INT NOT NULL UNIQUE,
	NgayCap DATE NOT NULL,
	NgayVaoDoan DATE,
	NgayVaoDang DATE,
	DienThoai INT NOT NULL,
	Email VARCHAR(100),
	GhiChu NVARCHAR(250),
	IDGiaDinh INT REFERENCES dbo.GiaDinh(IDGiaDinh),
	IDTaiKhoan INT REFERENCES dbo.TaiKhoan(IDTaikhoan),
	IDThongTinTotNghiep INT REFERENCES dbo.ThongTinTotNghiep(IDThongTinTotNghiep)

)

CREATE TABLE DiemChu
(
	IDDiemChu INT PRIMARY KEY,
	TenDiem VARCHAR(5) NOT NULL,
	GhiChu NVARCHAR(250)
)

CREATE TABLE MonHoc
(
	IDMonHoc INT PRIMARY KEY IDENTITY(1,1),
	IDSinhVien INT FOREIGN KEY REFERENCES dbo.SinhVien(IDSinhVien),
	ToanRoiRac INT,
	GiaiTich INT,
	VatLy INT,
	XacSuatThongKe INT,
	KyThuatLapTrinh INT,
	MangMayTinh INT,
	GiaoDucQuocPhong INT,
	CoSoDuLieu INT,
	KienTrucPhanMem INT,
	KyNangGiaoTiep INT,
	LapTrinhHuongDoiTuong INT,
	CauTrucDuLieuGiaiThuat INT,
	HeDieuHanh INT,
	PhanTichThietKe INT, 
	TriTueNhanTao INT,
	PhanMemMaNguonMo INT,
	BaoTriPhanMem INT,
	ThuongMaiDienTu INT,
	DoAn1 INT,
	DoAn2 INT,
	DoAn3 INT,
	ChungChiNgoaiNgu INT,
	ChungChiTinHoc INT,
	BaoHiemYTe INT,
	HocPhanTuChon INT
)

-- nhập dữ liệu --------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.LoaiTaiKhoan
        ( TenLoaiTaiKhoan, GhiChu )
VALUES  ( N'Quản Trị Viên', -- TenLoaiTaiKhoan - varchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.LoaiTaiKhoan
        ( TenLoaiTaiKhoan, GhiChu )
VALUES  ( N'Quản Lý Viên', -- TenLoaiTaiKhoan - varchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.LoaiTaiKhoan
        ( TenLoaiTaiKhoan, GhiChu )
VALUES  ( N'Sinh Viên', -- TenLoaiTaiKhoan - varchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'admin' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'buitruongnhutlm@gmail.com' , -- Email - varchar(250)
          0388199487 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'lethihong' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'buitruongnhatlm@gmail.com' , -- Email - varchar(250)
          012345678 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenvandai' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenvandai@gmail.com' , -- Email - varchar(250)
          0987654322 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDLoaiTaiKhoan - int
        )
INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'buitruongnhut' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'buitruongnhut@gmail.com' , -- Email - varchar(250)
          0924772762 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.QuanLyVien
        ( HoTen ,
          NgaySinh ,
          GioiTinh ,
          ChungMinhNhanDan,
          NoiSinh ,
          DiaChiThuongTru ,
          HocHam ,
          TrinhDo ,
          ChuyenMon ,
          DonViCongTac ,
          GhiChu ,
          IDTaiKhoan
        )
VALUES  ( N'Lê Thị Hồng' , -- HoTen - nvarchar(250)
          GETDATE() , -- NgaySinh - date
          N'Nữ' , -- GioiTinh - nvarchar(5)
          366222399 , -- CMND - int
          N'Kiên Giang' , -- NoiSinh - nvarchar(250)
          N'Long Hòa Bình Thủy Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Thạc Sĩ' , -- HocHam - nvarchar(250)
          N'Đại Học' , -- TrinhDo - nvarchar(250)
          N'Tin Học Ứng Dụng' , -- ChuyenMon - nvarchar(250)
          N'Phòng Công Tác Chính Trị Và Quản Lý Sinh Viên' , -- DonViCongTac - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDTaiKhoan - int
        )

INSERT INTO dbo.QuanLyVien
        ( HoTen ,
          NgaySinh ,
          GioiTinh ,
          ChungMinhNhanDan,
          NoiSinh ,
          DiaChiThuongTru ,
          HocHam ,
          TrinhDo ,
          ChuyenMon ,
          DonViCongTac ,
          GhiChu ,
          IDTaiKhoan
        )
VALUES  ( N'Nguyễn Văn Đại' , -- HoTen - nvarchar(250)
          GETDATE() , -- NgaySinh - date
          N'Nam' , -- GioiTinh - nvarchar(5)
          366333199 , -- CMND - int
          N'Hậu Giang' , -- NoiSinh - nvarchar(250)
          N'Nguyễn Văn Cừ Ninh Kiều Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Thạc Sĩ' , -- HocHam - nvarchar(250)
          N'Đại Học' , -- TrinhDo - nvarchar(250)
          N'Tin Học Ứng Dụng' , -- ChuyenMon - nvarchar(250)
          N'Phòng Công Tác Chính Trị Và Quản Lý Sinh Viên' , -- DonViCongTac - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDTaiKhoan - int
        )

INSERT INTO dbo.GiaDinh
        (  HoTenCha ,
          NamSinhCha ,
          DienThoaiCha ,
          HoTenMe ,
          NamSinhMe ,
          DienThoaiMe ,
          DiaChi ,
          GhiChu
        )
VALUES  ( N'Lê Văn Xứ' , -- HoTenCha - nvarchar(250)
          '1978-01-05' , -- NamSinhCha - date
          0122333444 , -- DienThoaiCha - int
          N'Lê Thị Lan' , -- HoTenMe - nvarchar(250)
          '1980-02-25' , -- NamSinhMe - date
          0199333555 , -- DienThoaiMe - int
          N'Sóc Trăng' , -- DiaChi - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.GiaDinh
        (  HoTenCha ,
          NamSinhCha ,
          DienThoaiCha ,
          HoTenMe ,
          NamSinhMe ,
          DienThoaiMe ,
          DiaChi ,
          GhiChu
        )
VALUES  ( N'Nguyễn Văn Hướng Dương' , -- HoTenCha - nvarchar(250)
          '1985-09-12' , -- NamSinhCha - date
          0166333156 , -- DienThoaiCha - int
          N'Lê Thị Sen' , -- HoTenMe - nvarchar(250)
          '1981-06-30' , -- NamSinhMe - date
          0122335670 , -- DienThoaiMe - int
          N'Bạc Liêu' , -- DiaChi - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )
	
INSERT INTO dbo.GiaDinh
        (  HoTenCha ,
          NamSinhCha ,
          DienThoaiCha ,
          HoTenMe ,
          NamSinhMe ,
          DienThoaiMe ,
          DiaChi ,
          GhiChu
        )
VALUES  ( N'Trần Trúc Đào' , -- HoTenCha - nvarchar(250)
          '1990-02-05' , -- NamSinhCha - date
          0122333991 , -- DienThoaiCha - int
          N'Lê Thị Anh Thảo' , -- HoTenMe - nvarchar(250)
          '1988-05-30' , -- NamSinhMe - date
          0199333761 , -- DienThoaiMe - int
          N'Vũng Tàu' , -- DiaChi - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Xuất Sắc' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Giỏi' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Khá' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Trung Bình' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Trung Bình Yếu' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.LoaiTotNghiep
        ( 
          TenLoaiTotNghiep ,
          GhiChu
        )
VALUES  ( 
          N'Kém' , -- TenLoaiTotNghiep - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.HeDaoTao
        ( 
          TenHeDaoTao ,
          ThoiGianDaoTao ,
          GhiChu
        )
VALUES  ( 
          N'Đại Học Chính Quy' , -- TenHeDaoTao - nvarchar(250)
          8 , -- ThoiGianDaoTao - int
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.HeDaoTao
        ( 
          TenHeDaoTao ,
          ThoiGianDaoTao ,
          GhiChu
        )
VALUES  ( 
          N'Đại Học Giáo Dục Thường Xuyên' , -- TenHeDaoTao - nvarchar(250)
          8 , -- ThoiGianDaoTao - int
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.HeDaoTao
        ( 
          TenHeDaoTao ,
          ThoiGianDaoTao ,
          GhiChu
        )
VALUES  ( 
          N'Đại Học Liên Thông' , -- TenHeDaoTao - nvarchar(250)
          8 , -- ThoiGianDaoTao - int
          N''  -- GhiChu - nvarchar(250)
        )

INSERT INTO dbo.Nganh
        ( TenNganh, GhiChu )
VALUES  ( N'Khoa Học Máy Tính', -- TenNganh - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Nganh
        ( TenNganh, GhiChu )
VALUES  ( N'Kỹ Thuật Phần Mềm', -- TenNganh - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Nganh
        ( TenNganh, GhiChu )
VALUES  ( N'Hệ Thống Thông Tin', -- TenNganh - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 1, -- MaKhoa - int
          N'Khóa 1', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 2, -- MaKhoa - int
          N'Khóa 2', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 3, -- MaKhoa - int
          N'Khóa 3', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 4, -- MaKhoa - int
          N'Khóa 4', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 5, -- MaKhoa - int
          N'Khóa 5', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 6, -- MaKhoa - int
          N'Khóa 6', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Khoa
        ( MaKhoa, TenKhoa, GhiChu )
VALUES  ( 7, -- MaKhoa - int
          N'Khóa 7', -- TenKhoa - nvarchar(250)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0113' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          50 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Hồ Điệp' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0213' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          70 , -- SoLuongSinhVien - int
          N'Lê Trần Phượng Vĩ' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0113' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          30 , -- SoLuongSinhVien - int
          N'Trần Anh Đào' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0213' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Mai' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0113' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          25 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Bằng Lăng' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0213' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          45 , -- SoLuongSinhVien - int
          N'Trần Thị Dâm Bụt' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          1  -- IDKhoa - int
        )

-----------------------------------------------------

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0114' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          70 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Tulip' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0214' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          55 , -- SoLuongSinhVien - int
          N'Trần Bạch Yến' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0114' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          80 , -- SoLuongSinhVien - int
          N'Trần Phong Lan' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0214' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Nguyễn Nhài' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0114' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          35 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Dáng Hương' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0214' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          45 , -- SoLuongSinhVien - int
          N'Trần Thị Thược Dược' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          2 -- IDKhoa - int
        )

--------------------------------------


INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0115' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          40 , -- SoLuongSinhVien - int
          N'Muồng Hoàng Yến' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0215' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          45 , -- SoLuongSinhVien - int
          N'Nguyễn Đỗ Quyên' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0115' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          80 , -- SoLuongSinhVien - int
          N'Lê Mẫu Đơn' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0215' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Trần Văn Súng' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0115' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          35 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Mộc Lan' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0215' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          45 , -- SoLuongSinhVien - int
          N'Trần Thị Giấy' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          3 -- IDKhoa - int
        )

-------------------

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0116' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          50 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Hồ Điệp' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0216' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          50 , -- SoLuongSinhVien - int
          N'Lê Trần Phượng Vĩ' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0116' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          20 , -- SoLuongSinhVien - int
          N'Trần Anh Đào' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0216' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          80 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Mai' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0116' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          55 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Bằng Lăng' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0216' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          85 , -- SoLuongSinhVien - int
          N'Trần Thị Dâm Bụt' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          4  -- IDKhoa - int
        )

------------------------------

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0117' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Tulip' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0217' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          95 , -- SoLuongSinhVien - int
          N'Trần Bạch Yến' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0117' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          40 , -- SoLuongSinhVien - int
          N'Trần Phong Lan' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0217' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Nguyễn Nhài' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0117' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          34 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Dáng Hương' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0217' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          42 , -- SoLuongSinhVien - int
          N'Trần Thị Thược Dược' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          5 -- IDKhoa - int
        )

-------------------------------


INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0118' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Muồng Hoàng Yến' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KTPM0218' , -- MaLop - nvarchar(250)
          N'Kỹ Thuật Phần Mềm' , -- TenLop - nvarchar(250)
          62 , -- SoLuongSinhVien - int
          N'Nguyễn Đỗ Quyên' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0118' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          52 , -- SoLuongSinhVien - int
          N'Lê Mẫu Đơn' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'KHMT0218' , -- MaLop - nvarchar(250)
          N'Khoa Học Máy Tính' , -- TenLop - nvarchar(250)
          60 , -- SoLuongSinhVien - int
          N'Trần Văn Súng' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0118' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          65 , -- SoLuongSinhVien - int
          N'Nguyễn Thị Mộc Lan' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6  -- IDKhoa - int
        )

INSERT INTO dbo.Lop
        ( 
          MaLop ,
          TenLop ,
          SoLuongSinhVien ,
          CoVan ,
          GhiChu ,
          IDKhoa
        )
VALUES  ( 
          N'HTTT0218' , -- MaLop - nvarchar(250)
          N'Hệ Thống Thông Tin' , -- TenLop - nvarchar(250)
          95 , -- SoLuongSinhVien - int
          N'Trần Thị Giấy' , -- CoVan - nvarchar(250)
          N'' , -- GhiChu - nvarchar(250)
          6 -- IDKhoa - int
        )
------------------------------------------------------------
INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 1, -- IDDiemChu - int
          'A', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 2, -- IDDiemChu - int
          'B+', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 3, -- IDDiemChu - int
          'B', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 4, -- IDDiemChu - int
          'C+', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 5, -- IDDiemChu - int
          'C', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 6, -- IDDiemChu - int
          'D+', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 7, -- IDDiemChu - int
          'D', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )

INSERT INTO dbo.DiemChu
        ( IDDiemChu, TenDiem, GhiChu )
VALUES  ( 8, -- IDDiemChu - int
          'F', -- TenDiem - varchar(5)
          N''  -- GhiChu - nvarchar(250)
          )
-------------------------------------------------------- tốt nghiệp
--ktpm0113
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          9.5 , -- DiemChu - nvarchar(50)
          4.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          1,-- IDLop - int
		  1, --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          9.0 , -- DiemChu - nvarchar(50)
          4.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          1,-- IDLop - int
		  1 --IDDiemChu - int
        )

--ktpm0213
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          8.3 , -- DiemChu - nvarchar(50)
          3.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          2,-- IDLop - int
		  2 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          8.0 , -- DiemChu - nvarchar(50)
          3.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          2,-- IDLop - int
		  2 --IDDiemChu - int
        )

--khmt0113
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          5.5 , -- DiemChu - nvarchar(50)
          2.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          5 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          3,-- IDLop - int
		  5 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          6.0 , -- DiemChu - nvarchar(50)
          2.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          5 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          3,-- IDLop - int
		  5 --IDDiemChu - int
        )

--khmt0213
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          7.5 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          4,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          7.9 , -- DiemChu - nvarchar(50)
          3.4 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          4,-- IDLop - int
		  3 --IDDiemChu - int
        )

--httt0113
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          6.7 , -- DiemChu - nvarchar(50)
          2.7 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          5,-- IDLop - int
		  4 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          5.0 , -- DiemChu - nvarchar(50)
          1.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          6 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          5,-- IDLop - int
		  6 --IDDiemChu - int
        )

--httt0213
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          7.1 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          6,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2013-8-1' , -- NgayVaoTruong - date
          '2017-8-1' , -- NgayTotNghiep - date
          '2017-9-1' , -- NgayCapBang - date
          5.0 , -- DiemChu - nvarchar(50)
          1.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          6 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          6,-- IDLop - int
		  6 --IDDiemChu - int
        )

--khóa 2 
--ktpm0114
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          9.0 , -- DiemChu - nvarchar(50)
          4.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          7,-- IDLop - int
		  1 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          8.0 , -- DiemChu - nvarchar(50)
          3.7 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          7,-- IDLop - int
		  2 --IDDiemChu - int
        )
-- ktpm0214
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          7.5 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          8,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          9.8 , -- DiemChu - nvarchar(50)
          4 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          8,-- IDLop - int
		  1 --IDDiemChu - int
        )

--khmt0114
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          4.5 , -- DiemChu - nvarchar(50)
          1.1 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          7 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          9,-- IDLop - int
		  7 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          6.6 , -- DiemChu - nvarchar(50)
          2.6 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          4 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          9,-- IDLop - int
		  4 --IDDiemChu - int
        )
--khmt0214
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          7.5 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          10,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          7.5 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          10,-- IDLop - int
		  3 --IDDiemChu - int
        )

--httt0114
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          7.0 , -- DiemChu - nvarchar(50)
          3.1 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          11,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          8.0 , -- DiemChu - nvarchar(50)
          3.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          11,-- IDLop - int
		  2 --IDDiemChu - int
        )

--httt0214
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          6.0 , -- DiemChu - nvarchar(50)
          2.2 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          5 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          12,-- IDLop - int
		  5 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2014-8-1' , -- NgayVaoTruong - date
          '2018-8-1' , -- NgayTotNghiep - date
          '2018-9-1' , -- NgayCapBang - date
          8.5 , -- DiemChu - nvarchar(50)
          4 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          12,-- IDLop - int
		  1 --IDDiemChu - int
        )

---- khóa 3 -----------------------------------------------------
--ktpm0115
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          7.0 , -- DiemChu - nvarchar(50)
          3.1 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          13,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          4.4 , -- DiemChu - nvarchar(50)
          1.2 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          7 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          13,-- IDLop - int
		  7 --IDDiemChu - int
        )
-- ktpm0215
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          9.8 , -- DiemChu - nvarchar(50)
          4.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          14,-- IDLop - int
		  1 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          7.8 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          2 , -- IDNghanh - int
          14,-- IDLop - int
		  3 --IDDiemChu - int
        )

--khmt0115
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          4.5 , -- DiemChu - nvarchar(50)
          1.1 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          7 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          15,-- IDLop - int
		  7 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          6.9 , -- DiemChu - nvarchar(50)
          2.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          4 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          15,-- IDLop - int
		  4 --IDDiemChu - int
        )
--khmt0215
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          10.0 , -- DiemChu - nvarchar(50)
          4.0 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          16,-- IDLop - int
		  1 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          5.2 , -- DiemChu - nvarchar(50)
          1.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          6 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          1 , -- IDNghanh - int
          16,-- IDLop - int
		  6 --IDDiemChu - int
        )

--httt0115
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          6.3 , -- DiemChu - nvarchar(50)
          2.7 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          4 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          17,-- IDLop - int
		  4 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          8.0 , -- DiemChu - nvarchar(50)
          3.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          17,-- IDLop - int
		  2 --IDDiemChu - int
        )

--httt0215
INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          8.0 , -- DiemChu - nvarchar(50)
          3.5 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          18,-- IDLop - int
		  2 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          7.5 , -- DiemChu - nvarchar(50)
          3.2 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          18,-- IDLop - int
		  3 --IDDiemChu - int
        )

INSERT INTO dbo.ThongTinTotNghiep
        ( NgayVaoTruong ,
          NgayTotNghiep ,
          NgayCapBang ,
          Diem10 ,
          Diem4 ,
          GhiChu ,
          IDLoaiTotNghiep ,
          IDHeDaoTao ,
          IDNghanh ,
          IDLop,
		  IDDiemChu
        )
VALUES  ( '2015-8-1' , -- NgayVaoTruong - date
          '2019-8-1' , -- NgayTotNghiep - date
          '2019-9-1' , -- NgayCapBang - date
          7.6 , -- DiemChu - nvarchar(50)
          3.3 , -- DiemSo - float
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDLoaiTotNghiep - int
          1 , -- IDHeDaoTao - int
          3 , -- IDNghanh - int
          18,-- IDLop - int
		  3 --IDDiemChu - int
        )
-------------------------------------------------------------k1

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Trúc Mai' , -- HoTen - nvarchar(250)
          1300123 , -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1997-12-03' , -- NgaySinh - date
          N'Sóc Trăng' , -- NoiSinh - nvarchar(250)
          N'Sóc Trăng' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          377898990 , -- ChungMinhNhanDan - int
          '2012-02-12' , -- NgayCap - date
          NULL , -- NgayVaoDoan - date
          NULL, -- NgayVaoDang - date
          924772762 , -- DienThoai - int
          'nguyentrucmai@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          1 , -- IDGiaDinh - int
          4 , -- IDTaiKhoan - int
          1  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Bách Hợp' , -- HoTen - nvarchar(250)
          1300223 , -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-6-16' , -- NgaySinh - date
          N'Bạc Liêu' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Thiên Chúa' , -- TonGiao - nvarchar(50)
          377898111 , -- ChungMinhNhanDan - int
          '2012-02-15' , -- NgayCap - date
          '2012-02-23' , -- NgayVaoDoan - date
          NULL, -- NgayVaoDang - date
          246813579 , -- DienThoai - int
          'tranbachhop@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          2 , -- IDGiaDinh - int
          5 , -- IDTaiKhoan - int
          2  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Lê Mồng Gà' , -- HoTen - nvarchar(250)
          1300423 , -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-5-15' , -- NgaySinh - date
          N'Vũng Tàu' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          377220111 , -- ChungMinhNhanDan - int
          '2012-02-19' , -- NgayCap - date
          '2012-05-25' , -- NgayVaoDoan - date
          NULL, -- NgayVaoDang - date
          1357902468 , -- DienThoai - int
          'lemongga@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          3 , -- IDGiaDinh - int
          6 , -- IDTaiKhoan - int
          3  -- IDThongTinTotNghiep - int
        )
------------------------
INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyentranbinhbat' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyentranbinhbat@gmail.com' , -- Email - varchar(250)
          0234567891 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthibonbon' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthibonbon@gmail.com' , -- Email - varchar(250)
          0234567822 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthibo' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthibo@gmail.com' , -- Email - varchar(250)
          0234511122 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'tranvanbuoi' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'tranvanbuoi@gmail.com' , -- Email - varchar(250)
          0211111122 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthicam' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthicam@gmail.com' , -- Email - varchar(250)
          0211134802 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthichanh' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthichanh@gmail.com' , -- Email - varchar(250)
          0211134111 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyentranchomchom' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyentranchomchom@gmail.com' , -- Email - varchar(250)
          0211134222 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthichuoi' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthichuoi@gmail.com' , -- Email - varchar(250)
          0211134101 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthidautay' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthidautay@gmail.com' , -- Email - varchar(250)
          0211555101 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenduahau' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenduahau@gmail.com' , -- Email - varchar(250)
          0211577101 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyendualeo' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyendualeo@gmail.com' , -- Email - varchar(250)
          0211588991 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenduagang' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenduagang@gmail.com' , -- Email - varchar(250)
          0211588123 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )
INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyendua' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyendua@gmail.com' , -- Email - varchar(250)
          0211588555 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'lethithom' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'lethithom@gmail.com' , -- Email - varchar(250)
          0211123555 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'trandudu' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'trandudu@gmail.com' , -- Email - varchar(250)
          0211462457 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenvanle' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenvanle@gmail.com' , -- Email - varchar(250)
          0211123457 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )


INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenvanluu' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenvanluu@gmail.com' , -- Email - varchar(250)
          0214623457 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )
INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenvanmit' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenvanmit@gmail.com' , -- Email - varchar(250)
          0214151457 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenvansake' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenvansake@gmail.com' , -- Email - varchar(250)
          0214151111 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthisori' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthisori@gmail.com' , -- Email - varchar(250)
          0214151590 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthicherry' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthicherry@gmail.com' , -- Email - varchar(250)
          0214160600 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )


INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthitao' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthitao@gmail.com' , -- Email - varchar(250)
          0214160611 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthitac' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthitac@gmail.com' , -- Email - varchar(250)
          0214160612 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

---------------------------------------------------------
INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthivusua' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthivusua@gmail.com' , -- Email - varchar(250)
          02141688812 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'nguyenthithanhlong' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'nguyenthithanhlong@gmail.com' , -- Email - varchar(250)
          0214160622 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'tranmangcau' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'tranmangcau@gmail.com' , -- Email - varchar(250)
          0214160124 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'tranvanxoai' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'tranvanxoai@gmail.com' , -- Email - varchar(250)
          0214162256 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'tranvanoi' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'tranvanoi@gmail.com' , -- Email - varchar(250)
          0214162113 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'levancoc' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'levancoc@gmail.com' , -- Email - varchar(250)
          0214162257 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )

INSERT INTO dbo.TaiKhoan
        ( TenTaiKhoan ,
          MatKhau ,
          Email ,
          SoDienThoai ,
          GhiChu ,
          IDLoaiTaiKhoan
        )
VALUES  ( 'levanman' , -- TenTaiKhoan - varchar(250)
          '123' , -- MatKhau - varchar(250)
          'levanman@gmail.com' , -- Email - varchar(250)
          0214164457 , -- SoDienThoai - int
          N'' , -- GhiChu - nvarchar(250)
          3  -- IDLoaiTaiKhoan - int
        )
-------------------- k1 
INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Bình Bát' , -- HoTen - nvarchar(250)
          1300107 , -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-04-13' , -- NgaySinh - date
          N'Hậu Giang' , -- NoiSinh - nvarchar(250)
          N'Hậu Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366205620 , -- ChungMinhNhanDan - int
          '2012-04-13' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          234567891 , -- DienThoai - int
          'nguyentranbinhbat@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          4 , -- IDGiaDinh - int
          7 , -- IDTaiKhoan - int
          4  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Thị Bòn Bon' , -- HoTen - nvarchar(250)
          1300108 , -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1997-04-12' , -- NgaySinh - date
          N'Cà Mau' , -- NoiSinh - nvarchar(250)
          N'Cà Mau' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366202244 , -- ChungMinhNhanDan - int
          '2012-04-12' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          234567822 , -- DienThoai - int
          'nguyenthibonbon@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          5 , -- IDGiaDinh - int
          8 , -- IDTaiKhoan - int
          5  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Bơ' , -- HoTen - nvarchar(250)
          1300100 , -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1997-05-05' , -- NgaySinh - date
          N'Cà Mau' , -- NoiSinh - nvarchar(250)
          N'Cà Mau' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366123212 , -- ChungMinhNhanDan - int
          '2012-05-12' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          234511122 , -- DienThoai - int
          'nguyenthibo@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          6 , -- IDGiaDinh - int
          9 , -- IDTaiKhoan - int
          6  -- IDThongTinTotNghiep - 
        )
INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Văn Bưởi' , -- HoTen - nvarchar(250)
          1300175 , -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-06-05' , -- NgaySinh - date
          N'Huế' , -- NoiSinh - nvarchar(250)
          N'Huế' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366112456 , -- ChungMinhNhanDan - int
          '2012-05-18' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          234511122 , -- DienThoai - int
          'tranvanbuoi@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          7 , -- IDGiaDinh - int
          10 , -- IDTaiKhoan - int
          7  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Cam' , -- HoTen - nvarchar(250)
          1300225 , -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1997-06-15' , -- NgaySinh - date
          N'Huế' , -- NoiSinh - nvarchar(250)
          N'Huế' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366110101 , -- ChungMinhNhanDan - int
          '2012-05-18' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          211134802 , -- DienThoai - int
          'nguyenthicam@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          8 , -- IDGiaDinh - int
          11 , -- IDTaiKhoan - int
          8  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Chanh' , -- HoTen - nvarchar(250)
          1300015 , -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-06-15' , -- NgaySinh - date
          N'Hải Phòng' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          211134111 , -- ChungMinhNhanDan - int
          '2012-05-18' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          234511122 , -- DienThoai - int
          'nguyenthichanh@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          9 , -- IDGiaDinh - int
          12 , -- IDTaiKhoan - int
          9  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Trần Chôm Chôm' , -- HoTen - nvarchar(250)
          1300015, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-06-15' , -- NgaySinh - date
          N'Vũng Tàu' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366000212 , -- ChungMinhNhanDan - int
          '2012-05-18' , -- NgayCap - date
          GETDATE() , -- NgayVaoDoan - date
          GETDATE() , -- NgayVaoDang - date
          211134222 , -- DienThoai - int
          'nguyentranchomchom@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          10 , -- IDGiaDinh - int
          13 , -- IDTaiKhoan - int
          10  -- IDThongTinTotNghiep - int
        )
INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Chuối' , -- HoTen - nvarchar(250)
          1300229, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-06-25' , -- NgaySinh - date
          N'Nha Trang' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366011612 , -- ChungMinhNhanDan - int
          '2012-12-18' , -- NgayCap - date
          '2012-12-18', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211134101 , -- DienThoai - int
          'nguyenthichuoi@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          11 , -- IDGiaDinh - int
          14 , -- IDTaiKhoan - int
          11  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Dâu Tây' , -- HoTen - nvarchar(250)
          1300249, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-9-25' , -- NgaySinh - date
          N'Đà Lạt' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366020212 , -- ChungMinhNhanDan - int
          '2012-12-18' , -- NgayCap - date
          '2012-12-18', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211555101 , -- DienThoai - int
          'nguyenthidautay@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          12 , -- IDGiaDinh - int
          15 , -- IDTaiKhoan - int
          12  -- IDThongTinTotNghiep - int
        )

----------------------------------------------------------k2--------------------------------------
INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Dưa Hấu' , -- HoTen - nvarchar(250)
          1400050, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-9-05' , -- NgaySinh - date
          N'Kiên Giang' , -- NoiSinh - nvarchar(250)
          N'Kiên Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366020666 , -- ChungMinhNhanDan - int
          '2012-2-18' , -- NgayCap - date
          '2012-2-18', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211577101 , -- DienThoai - int
          'nguyenduahau@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          13 , -- IDGiaDinh - int
          16 , -- IDTaiKhoan - int
          13  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Dưa Leo' , -- HoTen - nvarchar(250)
          1400150, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1996-09-01' , -- NgaySinh - date
          N'Kiên Giang' , -- NoiSinh - nvarchar(250)
          N'Kiên Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366021010 , -- ChungMinhNhanDan - int
          '2012-10-18' , -- NgayCap - date
          '2012-10-18', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211588991 , -- DienThoai - int
          'nguyendualeo@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          14 , -- IDGiaDinh - int
          17 , -- IDTaiKhoan - int
          14  -- IDThongTinTotNghiep - int
        )



INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Dưa Gang' , -- HoTen - nvarchar(250)
          1400112, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1996-9-12' , -- NgaySinh - date
          N'Hậu Giang' , -- NoiSinh - nvarchar(250)
          N'Hậu Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021099 , -- ChungMinhNhanDan - int
          '2011-12-25' , -- NgayCap - date
          '2011-12-25', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211588555 , -- DienThoai - int
          'nguyendua@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          16 , -- IDGiaDinh - int
          18 , -- IDTaiKhoan - int
          16  -- IDThongTinTotNghiep 
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Dừa' , -- HoTen - nvarchar(250)
          1400199, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1996-09-01' , -- NgaySinh - date
          N'Hậu Giang' , -- NoiSinh - nvarchar(250)
          N'Hậu Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021099 , -- ChungMinhNhanDan - int
          '2011-12-25' , -- NgayCap - date
          '2011-12-25', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211588555 , -- DienThoai - int
          'nguyendua@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          17 , -- IDGiaDinh - int
          19 , -- IDTaiKhoan - int
          17  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Lê Thị Thơm' , -- HoTen - nvarchar(250)
          1400299, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1996-01-23' , -- NgaySinh - date
          N'Bạc Liêu' , -- NoiSinh - nvarchar(250)
          N'Bạc Liêu' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021098 , -- ChungMinhNhanDan - int
          '2011-12-24' , -- NgayCap - date
          '2011-12-24', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211123555 , -- DienThoai - int
          'lethithom@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          18 , -- IDGiaDinh - int
          20 , -- IDTaiKhoan - int
          18  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Đu Đủ' , -- HoTen - nvarchar(250)
          1400003, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-9-01' , -- NgaySinh - date
          N'An Giang' , -- NoiSinh - nvarchar(250)
          N'Kiên Giang' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021033 , -- ChungMinhNhanDan - int
          '2012-2-22' , -- NgayCap - date
          '2012-2-22', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211462457 , -- DienThoai - int
          'trandudu@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          19 , -- IDGiaDinh - int
          21 , -- IDTaiKhoan - int
          19  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Văn Lê' , -- HoTen - nvarchar(250)
          1400443, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-4-01' , -- NgaySinh - date
          N'Bạc Liêu' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021066 , -- ChungMinhNhanDan - int
          '2012-12-22' , -- NgayCap - date
          '2012-12-22', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          211123457 , -- DienThoai - int
          'nguyenvanle@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          20 , -- IDGiaDinh - int
          22 , -- IDTaiKhoan - int
          20  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Văn Lựu' , -- HoTen - nvarchar(250)
          1400643, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1995-12-01' , -- NgaySinh - date
          N'Bạc Liêu' , -- NoiSinh - nvarchar(250)
          N'Bạc Liêu' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366021166 , -- ChungMinhNhanDan - int
          '2012-10-22' , -- NgayCap - date
          '2012-10-22', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214623457 , -- DienThoai - int
          'nguyenvanluu@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          21 , -- IDGiaDinh - int
          23 , -- IDTaiKhoan - int
          21  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Văn Mít' , -- HoTen - nvarchar(250)
          1400056, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-12-12' , -- NgaySinh - date
          N'Bạc Liêu' , -- NoiSinh - nvarchar(250)
          N'Bạc Liêu' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Phật Giáo' , -- TonGiao - nvarchar(50)
          366003066 , -- ChungMinhNhanDan - int
          '2011-10-22' , -- NgayCap - date
          '2011-10-22', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214151457 , -- DienThoai - int
          'nguyenvanmit@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          22 , -- IDGiaDinh - int
          24 , -- IDTaiKhoan - int
          22  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Văn Sa Kê' , -- HoTen - nvarchar(250)
          1400159, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1997-09-12' , -- NgaySinh - date
          N'Hà Nội' , -- NoiSinh - nvarchar(250)
          N'Hà Nội' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          366221166 , -- ChungMinhNhanDan - int
          '2011-10-29' , -- NgayCap - date
          '2011-10-29', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214151111 , -- DienThoai - int
          'nguyenvansake@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          23 , -- IDGiaDinh - int
          25 , -- IDTaiKhoan - int
          23  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Sơ Ri' , -- HoTen - nvarchar(250)
          1400100, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1998-09-12' , -- NgaySinh - date
          N'Hà Tây' , -- NoiSinh - nvarchar(250)
          N'Hà Tây' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          367121166 , -- ChungMinhNhanDan - int
          '2011-11-19' , -- NgayCap - date
          '2011-11-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214151590 , -- DienThoai - int
          'nguyenthisori@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          24 , -- IDGiaDinh - int
          26 , -- IDTaiKhoan - int
          24  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Cherry' , -- HoTen - nvarchar(250)
          1400900, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1998-09-12' , -- NgaySinh - date
          N'Hà Tây' , -- NoiSinh - nvarchar(250)
          N'Hà Tây' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          367121160 , -- ChungMinhNhanDan - int
          '2011-11-19' , -- NgayCap - date
          '2011-11-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214160600 , -- DienThoai - int
          'nguyenthicherry@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          25 , -- IDGiaDinh - int
          27 , -- IDTaiKhoan - int
          25  -- IDThongTinTotNghiep - int
        )

-------------------------------------------k3

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Táo' , -- HoTen - nvarchar(250)
          1500199, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1998-09-30' , -- NgaySinh - date
          N'Hà Nam' , -- NoiSinh - nvarchar(250)
          N'Hà Nam' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          367121106 , -- ChungMinhNhanDan - int
          '2011-11-22' , -- NgayCap - date
          '2011-11-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214160611 , -- DienThoai - int
          'nguyenthitao@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          26 , -- IDGiaDinh - int
          28 , -- IDTaiKhoan - int
          26  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Tắc' , -- HoTen - nvarchar(250)
          1500999, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1994-09-30' , -- NgaySinh - date
          N'Hà Nam' , -- NoiSinh - nvarchar(250)
          N'Hà Nam' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Thiên Chúa' , -- TonGiao - nvarchar(50)
          368121106 , -- ChungMinhNhanDan - int
          '2011-10-29' , -- NgayCap - date
          '2011-10-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214160612 , -- DienThoai - int
          'nguyenthitac@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          27 , -- IDGiaDinh - int
          29 , -- IDTaiKhoan - int
          27  -- 

        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Vú Sữa' , -- HoTen - nvarchar(250)
          1500599, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1994-01-30' , -- NgaySinh - date
          N'Cần Thơ' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Thiên Chúa' , -- TonGiao - nvarchar(50)
          368121101 , -- ChungMinhNhanDan - int
          '2011-10-19' , -- NgayCap - date
          '2012-10-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          2141688812 , -- DienThoai - int
          'nguyenthivusua@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          28 , -- IDGiaDinh - int
          30 , -- IDTaiKhoan - int
          28  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Thị Thanh Long' , -- HoTen - nvarchar(250)
          1500399, -- MaSoSinhVien - int
          N'Nữ' , -- GioiTinh - nvarchar(5)
          '1998-01-30' , -- NgaySinh - date
          N'Cần Thơ' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          358121101 , -- ChungMinhNhanDan - int
          '2011-12-19' , -- NgayCap - date
          '2012-12-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214160622 , -- DienThoai - int
          'nguyenthithanhlong@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          29 , -- IDGiaDinh - int
          31 , -- IDTaiKhoan - int
          29  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Nguyễn Mãng Cầu' , -- HoTen - nvarchar(250)
          1500099, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1998-01-31' , -- NgaySinh - date
          N'Cần Thơ' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          358104101 , -- ChungMinhNhanDan - int
          '2011-12-19' , -- NgayCap - date
          '2012-12-19', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214160124 , -- DienThoai - int
          'tranmangcau@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          30 , -- IDGiaDinh - int
          32 , -- IDTaiKhoan - int
          30  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Văn Xoài' , -- HoTen - nvarchar(250)
          1500791, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1998-01-15' , -- NgaySinh - date
          N'Cần Thơ' , -- NoiSinh - nvarchar(250)
          N'Cần Thơ' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          358194101 , -- ChungMinhNhanDan - int
          '2011-12-9' , -- NgayCap - date
          '2012-12-9', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214162256 , -- DienThoai - int
          'tranvanxoai@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          31 , -- IDGiaDinh - int
          33 , -- IDTaiKhoan - int
          31  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Trần Văn Ổi' , -- HoTen - nvarchar(250)
          1500991, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1993-01-15' , -- NgaySinh - date
          N'Vĩnh Long' , -- NoiSinh - nvarchar(250)
          N'Vĩnh Long' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          358194242 , -- ChungMinhNhanDan - int
          '2011-02-9' , -- NgayCap - date
          '2012-02-9', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214162113 , -- DienThoai - int
          'tranvanoi@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          32 , -- IDGiaDinh - int
          34 , -- IDTaiKhoan - int
          32  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Lê Văn Cốc' , -- HoTen - nvarchar(250)
          1501992, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1993-01-16' , -- NgaySinh - date
          N'Vĩnh Long' , -- NoiSinh - nvarchar(250)
          N'Vĩnh Long' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          358194244 , -- ChungMinhNhanDan - int
          '2011-02-19' , -- NgayCap - date
          '2012-02-29', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214162257 , -- DienThoai - int
          'levancoc@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          33 , -- IDGiaDinh - int
          35 , -- IDTaiKhoan - int
          33  -- IDThongTinTotNghiep - int
        )

INSERT INTO dbo.SinhVien
        ( HoTen ,
          MaSoSinhVien ,
          GioiTinh ,
          NgaySinh ,
          NoiSinh ,
          DiaChiThuongTru ,
          DanToc ,
          TonGiao ,
          ChungMinhNhanDan ,
          NgayCap ,
          NgayVaoDoan ,
          NgayVaoDang ,
          DienThoai ,
          Email ,
          GhiChu ,
          IDGiaDinh ,
          IDTaiKhoan ,
          IDThongTinTotNghiep
        )
VALUES  ( N'Lê Văn Mận' , -- HoTen - nvarchar(250)
          1501906, -- MaSoSinhVien - int
          N'Nam' , -- GioiTinh - nvarchar(5)
          '1993-01-26' , -- NgaySinh - date
          N'Vĩnh Long' , -- NoiSinh - nvarchar(250)
          N'Vĩnh Long' , -- DiaChiThuongTru - nvarchar(250)
          N'Kinh' , -- DanToc - nvarchar(50)
          N'Không' , -- TonGiao - nvarchar(50)
          389194244 , -- ChungMinhNhanDan - int
          '2011-02-29' , -- NgayCap - date
          '2012-01-09', -- NgayVaoDoan - date
          NULL , -- NgayVaoDang - date
          214164457 , -- DienThoai - int
          'levanman@gmail.com' , -- Email - varchar(100)
          N'' , -- GhiChu - nvarchar(250)
          34 , -- IDGiaDinh - int
          36 , -- IDTaiKhoan - int
          34  -- IDThongTinTotNghiep - int
        )