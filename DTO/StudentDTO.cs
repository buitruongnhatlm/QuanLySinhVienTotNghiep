using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class StudentDTO
    {
        private string _HoTen;
        private int _MaSoSinhVien;
        private string _GioiTinh;
        private DateTime _NgaySinh;
        private string _NoiSinh;
        private string _DiaChiThuongTru;
        private string _DanToc;
        private string _TonGiao;
        private int _ChungMinhNhanDan;
        private DateTime _NgayCap;
        private DateTime _NgayVaoDoan;
        private DateTime _NgayVaoDang;
        private int _DienThoai;
        private string _Email;
        private string _GhiChu;
        private int _IDGiaDinh;
        private int _IDTaiKhoan;
        private int _IDThongTinTotNghiep;

        public string HoTen { get => _HoTen; set => _HoTen = value; }
        public int MaSoSinhVien { get => _MaSoSinhVien; set => _MaSoSinhVien = value; }
        public string GioiTinh { get => _GioiTinh; set => _GioiTinh = value; }
        public DateTime NgaySinh { get => _NgaySinh; set => _NgaySinh = value; }
        public string NoiSinh { get => _NoiSinh; set => _NoiSinh = value; }
        public string DiaChiThuongTru { get => _DiaChiThuongTru; set => _DiaChiThuongTru = value; }
        public string DanToc { get => _DanToc; set => _DanToc = value; }
        public string TonGiao { get => _TonGiao; set => _TonGiao = value; }
        public int ChungMinhNhanDan { get => _ChungMinhNhanDan; set => _ChungMinhNhanDan = value; }
        public DateTime NgayCap { get => _NgayCap; set => _NgayCap = value; }
        public DateTime NgayVaoDoan { get => _NgayVaoDoan; set => _NgayVaoDoan = value; }
        public DateTime NgayVaoDang { get => _NgayVaoDang; set => _NgayVaoDang = value; }
        public string Email { get => _Email; set => _Email = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDGiaDinh { get => _IDGiaDinh; set => _IDGiaDinh = value; }
        public int IDTaiKhoan { get => _IDTaiKhoan; set => _IDTaiKhoan = value; }
        public int IDThongTinTotNghiep { get => _IDThongTinTotNghiep; set => _IDThongTinTotNghiep = value; }
        public int DienThoai { get => _DienThoai; set => _DienThoai = value; }

        public StudentDTO(string hoten, int masosinhvien, string gioitinh, DateTime ngaysinh, string noisinh, string diachithuongtru,
            string dantoc, string tongiao, int chungminhnhandan, DateTime ngaycap, DateTime ngayvaodoan, DateTime ngayvaodang,
            int dienthoai, string email, string ghichu, int idgiadinh, int idtaikhoan, int idthongtintotnghiep)
        {
            this.HoTen = hoten;
            this.MaSoSinhVien = masosinhvien;
            this.GioiTinh = gioitinh;
            this.NgaySinh = ngaysinh;
            this.NoiSinh = noisinh;
            this.DiaChiThuongTru = diachithuongtru;
            this.DanToc = dantoc;
            this.TonGiao = tongiao;
            this.ChungMinhNhanDan = chungminhnhandan;
            this.NgayCap = ngaycap;
            this.NgayVaoDoan = ngayvaodoan;
            this.NgayVaoDang = ngayvaodang;
            this.DienThoai = dienthoai;
            this.Email = email;
            this.GhiChu = ghichu;
            this.IDGiaDinh = idgiadinh;
            this.IDTaiKhoan = idtaikhoan;
            this.IDThongTinTotNghiep = idthongtintotnghiep;

        }

        public StudentDTO(DataRow _row)
        {
            this.HoTen = _row["HoTen"].ToString();
            this.MaSoSinhVien = Convert.ToInt32(_row["MaSoSinhVien"]);
            this.GioiTinh = _row["GioiTinh"].ToString();
            this.NgaySinh = Convert.ToDateTime(_row["NgaySinh"]);
            this.NoiSinh = _row["NoiSinh"].ToString();
            this.DiaChiThuongTru = _row["DiaChiThuongTru"].ToString();
            this.DanToc = _row["DanToc"].ToString();
            this.TonGiao = _row["TonGiao"].ToString();
            this.ChungMinhNhanDan = Convert.ToInt32(_row["ChungMinhNhanDan"]);
            this.NgayCap = Convert.ToDateTime(_row["NgayCap"]);
            this.NgayVaoDoan = Convert.ToDateTime(_row["NgayVaoDoan"]);
            this.NgayVaoDang = Convert.ToDateTime(_row["NgayVaoDang"]);
            this.DienThoai = Convert.ToInt32(_row["DienThoai"]);
            this.Email = _row["Email"].ToString();
            this.GhiChu = _row["GhiChu"].ToString();
            this.IDGiaDinh = Convert.ToInt32(_row["IDGiaDinh"]);
            this.IDTaiKhoan = Convert.ToInt32(_row["IDTaiKhoan"]);
            this.IDThongTinTotNghiep = Convert.ToInt32(_row["IDThongTinTotNghiep"]);
        }


    }
}
