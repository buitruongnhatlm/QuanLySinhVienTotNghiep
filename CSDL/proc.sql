CREATE PROCEDURE pro_Login
@TenTaiKhoan NVARCHAR(100), @MatKhau NVARCHAR(100)
AS
BEGIN
SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan=@TenTaiKhoan AND MatKhau = @MatKhau
END
GO

CREATE PROCEDURE pro_GetListAccount
AS
BEGIN
	SELECT * FROM  dbo.TaiKhoan
END
GO

CREATE PROCEDURE pro_GetListStudent
AS
BEGIN
	SELECT * FROM dbo.SinhVien	
END
GO

CREATE PROCEDURE pro_GetListFamily
AS
BEGIN
	SELECT * FROM dbo.GiaDinh	
END
GO

CREATE PROCEDURE pro_GetListManager
AS
BEGIN
SELECT qlv.IDQuanLyVien, qlv.HoTen, qlv.NgaySinh, qlv.GioiTinh, qlv.ChungMinhNhanDan, qlv.NoiSinh, qlv.DiaChiThuongTru,
qlv.HocHam, qlv.TrinhDo, qlv.ChuyenMon, qlv.DonViCongTac, qlv.GhiChu, tk.TenTaiKhoan
FROM dbo.QuanLyVien qlv, dbo.TaiKhoan tk
WHERE qlv.IDTaiKhoan = tk.IDTaikhoan
END
GO

CREATE PROCEDURE pro_GetListGraduateType
AS
BEGIN
SELECT * FROM dbo.LoaiTotNghiep
END
GO


CREATE PROCEDURE pro_GetListTraining
AS
BEGIN
SELECT * FROM dbo.HeDaoTao
END
GO

CREATE PROCEDURE pro_GetListCourse
AS
BEGIN
	SELECT * FROM dbo.Khoa
END
GO

CREATE PROCEDURE pro_GetListProfession
AS
BEGIN
	SELECT * FROM nganh
END
GO

CREATE PROCEDURE pro_GetListGraduate
AS
BEGIN
SELECT tn.IDThongTinTotNghiep,  tn.NgayVaoTruong, tn.NgayTotNghiep, tn.NgayCapBang, tn.Diem10, tn.Diem4, tn.GhiChu,
ltn.TenLoaiTotNghiep, hdt.TenHeDaoTao, n.TenNganh, l.MaLop, d.IDDiemChu, d.TenDiem
FROM dbo.ThongTinTotNghiep tn, dbo.Lop l, dbo.LoaiTotNghiep ltn, dbo.HeDaoTao hdt, dbo.Nganh n, dbo.DiemChu d
WHERE tn.IDLoaiTotNghiep = ltn.IDLoaiTotNghiep AND tn.IDHeDaoTao = hdt.IDHeDaoTao AND tn.IDNghanh= n.IDNganh AND
tn.IDLop = l.IDLop AND tn.IDDiemChu = d.IDDiemChu
END
GO

CREATE PROCEDURE pro_GetListClass
AS
BEGIN
SELECT L.IDLop, L.MaLop, L.TenLop, L.SoLuongSinhVien, L.CoVan, K.TenKhoa, L.GhiChu
FROM dbo.Lop L, dbo.Khoa K WHERE l.IDKhoa = k.IDKhoa
END
GO

CREATE FUNCTION dbo.[func_ConvertToUnsign]
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

CREATE PROCEDURE pro_SearchAccount
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

CREATE PROCEDURE pro_SearchStudent
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

CREATE PROCEDURE pro_SearchFamily
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

CREATE PROCEDURE pro_SearchManager
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

CREATE PROCEDURE pro_InsertManager
@HoTen NVARCHAR(250), @NgaySinh DATE, @GioiTinh NVARCHAR(5), @CMND INT, @NoiSinh NVARCHAR(250),
@DiaChiThuongTru NVARCHAR(250), @HocHam NVARCHAR(100), @TrinhDo NVARCHAR(100), @ChuyenMon NVARCHAR(100),
@DonViCongTac NVARCHAR(250), @IDTaiKhoan INT, @GhiChu NVARCHAR(250)= NULL
AS
BEGIN
	INSERT INTO dbo.QuanLyVien ( HoTen , NgaySinh , GioiTinh , ChungMinhNhanDan , NoiSinh , DiaChiThuongTru , HocHam , TrinhDo , ChuyenMon , DonViCongTac , GhiChu , IDTaiKhoan)
	VALUES  ( @HoTen , @NgaySinh , @GioiTinh , @CMND , @NoiSinh , @DiaChiThuongTru , @HocHam , @TrinhDo , @ChuyenMon , @DonViCongTac , @GhiChu , @IDTaiKhoan )
END
GO

EXECUTE dbo.pro_InsertManager @HoTen = N'', @NgaySinh = '2020-06-16', @GioiTinh = N'Nữ', @CMND = 366272394, @NoiSinh = N'Cần Thơ', @DiaChiThuongTru = N'Bạc Liêu', 
@HocHam = N'Thạc Sĩ', @TrinhDo = N'Cao Học', @ChuyenMon = N'Hệ Thống Thông Tin', @DonViCongTac = N'Khoa Hệ Thống Thông Tin', @IDTaiKhoan = 4, @GhiChu = N''

CREATE PROCEDURE pro_UpdatetManager
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

EXECUTE dbo.pro_UpdatetManager @IDQuanLyVien=4, @HoTen = N'Nguyễn Thị Trúc Em', @NgaySinh = '2020-06-16', @GioiTinh = N'Nữ', @CMND = 366202394, @NoiSinh = N'Hậu Giang', @DiaChiThuongTru = N'Bạc Liêu', 
@HocHam = N'Thạc Sĩ', @TrinhDo = N'Cao Học', @ChuyenMon = N'Hệ Thống Thông Tin', @DonViCongTac = N'Khoa Hệ Thống Thông Tin', @IDTaiKhoan = 4, @GhiChu = N''

CREATE PROCEDURE pro_DeleteManager
@IDQuanLyVien INT
AS
BEGIN
	DELETE dbo.QuanLyVien WHERE IDQuanLyVien = @IDQuanLyVien
END
GO

CREATE PROCEDURE pro_SearchGraduate
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='IDThongTinTotNghiep')
SELECT * FROM dbo.ThongTinTotNghiep WHERE IDThongTinTotNghiep LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.ThongTinTotNghiep WHERE GhiChu LIKE N'%'+@content+'%'
END
GO


CREATE PROCEDURE pro_SearchClass
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


CREATE PROCEDURE pro_GetListStudent
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

CREATE PROCEDURE pro_GetIDAccountByUsername
@username VARCHAR(100)
AS
BEGIN
SELECT IDTaikhoan FROM dbo.TaiKhoan WHERE TenTaiKhoan=@username
END
GO

EXECUTE dbo.pro_GetIDAccountByUsername @username = 'lethihong'


CREATE PROCEDURE pro_GetAccountCurrent
@username VARCHAR(150)
AS
BEGIN
SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan = @username
END
GO

CREATE PROCEDURE pro_GetStudentCurrent
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

EXECUTE dbo.pro_GetStudentCurrent @idtaikhoan = 12
GO

CREATE PROCEDURE pro_GetFamilyByStudent
@idsinhvien int
AS
BEGIN
SELECT gd.IDGiaDinh ,gd.HoTenCha ,gd.NamSinhCha ,gd.DienThoaiCha ,gd.HoTenMe ,gd.NamSinhMe ,gd.DienThoaiMe ,gd.DiaChi ,gd.GhiChu
FROM dbo.SinhVien sv, dbo.GiaDinh gd
WHERE sv.IDGiaDinh = gd.IDGiaDinh AND gd.IDGiaDinh IN (SELECT IDGiaDinh FROM dbo.SinhVien WHERE IDSinhVien = @idsinhvien )
END
GO

EXECUTE dbo.pro_GetFamilyByStudent @idsinhvien = 7 -- int


CREATE PROCEDURE pro_GetIDSinhVienByIDTaiKhoan
@idtaikhoan INT
AS
BEGIN
SELECT IDSinhVien
FROM dbo.TaiKhoan tk, dbo.SinhVien sv
WHERE tk.IDTaikhoan = sv.IDTaiKhoan AND sv.IDTaiKhoan IN (SELECT IDTaikhoan FROM dbo.TaiKhoan WHERE IDTaikhoan=@idtaikhoan)
END
GO

CREATE PROCEDURE pro_GetListSubjectDebt
AS
BEGIN
SELECT mh.IDMonHoc, sv.HoTen, mh.ToanRoiRac, mh.GiaiTich,mh.XacSuatThongKe, mh.KyThuatLapTrinh, mh.MangMayTinh,
mh.CoSoDuLieu, mh.KyNangGiaoTiep, mh.LapTrinhHuongDoiTuong, mh.CauTrucDuLieuGiaiThuat, mh.HeDieuHanh, mh.PhanTichThietKe,
mh.TriTueNhanTao, mh.PhanMemMaNguonMo, mh.BaoTriPhanMem, mh.ThuongMaiDienTu, mh.DoAn1, mh.DoAn2, mh.DoAn3,
mh.ChungChiNgoaiNgu, mh.HocPhanTuChon 
FROM dbo.MonHoc mh, dbo.SinhVien sv
WHERE mh.IDSinhVien = sv.IDSinhVien
END
go
-----------------------
CREATE PROCEDURE pro_GetListGraduate
AS
BEGIN
	SELECT * FROM dbo.ThongTinTotNghiep
END
GO

EXECUTE dbo.pro_GetListGraduate

INSERT INTO dbo.ThongTinTotNghiep ( NgayVaoTruong , NgayTotNghiep , NgayCapBang , Diem10 , Diem4, IDLoaiTotNghiep , IDHeDaoTao , IDNghanh , IDLop , IDDiemChu , GhiChu)
VALUES  ( GETDATE() , GETDATE() , GETDATE() , 0.0 , 0.0 , 0 , 0 , 0 , 0 , 0  , N'')

UPDATE dbo.ThongTinTotNghiep SET NgayVaoTruong = '', NgayTotNghiep='', NgayCapBang='', Diem10='', Diem4='', IDLoaiTotNghiep='', IDHeDaoTao='', IDNghanh='', IDLop='', IDDiemChu='', GhiChu='' WHERE IDThongTinTotNghiep = ''
GO

CREATE PROCEDURE pro_SearchGraduate
@type VARCHAR(50), @content NVARCHAR(100)
AS
BEGIN
IF(@type='IDThongTinTotNghiep')
SELECT * FROM dbo.ThongTinTotNghiep WHERE IDThongTinTotNghiep LIKE N'%'+@content+'%'
ELSE IF(@type='Diem10')
SELECT * FROM dbo.ThongTinTotNghiep WHERE Diem10 LIKE N'%'+@content+'%'
ELSE IF(@type='Diem4')
SELECT * FROM dbo.ThongTinTotNghiep WHERE Diem4 LIKE N'%'+@content+'%'
ELSE IF(@type='GhiChu')
SELECT * FROM dbo.ThongTinTotNghiep WHERE GhiChu LIKE N'%'+@content+'%'
END
GO

EXECUTE dbo.pro_SearchGraduate @type = '', @content = N'' 
GO

CREATE PROCEDURE pro_GetListGraduateType
AS
BEGIN
SELECT * FROM dbo.HeDaoTao
END
GO

EXECUTE dbo.pro_GetListGraduateType
GO

UPDATE dbo.LoaiTotNghiep SET TenLoaiTotNghiep = '', GhiChu ='' WHERE IDLoaiTotNghiep =
GO

CREATE PROCEDURE pro_GetListTraining
AS
BEGIN
SELECT * FROM dbo.HeDaoTao
END
GO

UPDATE dbo.HeDaoTao SET TenHeDaoTao='', ThoiGianDaoTao ='', GhiChu='' WHERE IDHeDaoTao=
GO

EXECUTE dbo.pro_GetListTraining
GO

SELECT * FROM dbo.DiemChu
GO

DROP TABLE dbo.DiemChu

UPDATE dbo.DiemChu SET TenDiem ='', GhiChu='' WHERE IDDiemChu=

CREATE PROCEDURE pro_GetListGraduateType
AS
BEGIN
SELECT * FROM dbo.LoaiTotNghiep
END
GO




