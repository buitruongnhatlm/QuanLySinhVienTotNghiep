using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class GraduateDTO
    {
        private int _IDThongTinTotNghiep;
        private DateTime? _NgayVaoTruong;
        private DateTime? _NgayTotNghiep;
        private DateTime? _NgayCapBang;
        private decimal _Diem4;
        private string _GhiChu;
        private int _IDLoaiTotNghiep;
        private int _IDHeDaoTao;
        private int _IDNghanh;
        private int _IDLop;
        private int _IDDiemChu;
        private string _TrangThai;
        private string _NoMon;

        public DateTime? NgayVaoTruong { get => _NgayVaoTruong; set => _NgayVaoTruong = value; }
        public DateTime? NgayTotNghiep { get => _NgayTotNghiep; set => _NgayTotNghiep = value; }
        public DateTime? NgayCapBang { get => _NgayCapBang; set => _NgayCapBang = value; }
        public decimal Diem4 { get => _Diem4; set => _Diem4 = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDLoaiTotNghiep { get => _IDLoaiTotNghiep; set => _IDLoaiTotNghiep = value; }
        public int IDHeDaoTao { get => _IDHeDaoTao; set => _IDHeDaoTao = value; }
        public int IDNganh { get => _IDNghanh; set => _IDNghanh = value; }
        public int IDLop { get => _IDLop; set => _IDLop = value; }
        public int IDDiemChu { get => _IDDiemChu; set => _IDDiemChu = value; }
        public string TrangThai { get => _TrangThai; set => _TrangThai = value; }
        public string NoMon { get => _NoMon; set => _NoMon = value; }
        public int IDThongTinTotNghiep { get => _IDThongTinTotNghiep; set => _IDThongTinTotNghiep = value; }

        public GraduateDTO(int idthongtintotnghiep, DateTime? ngayvaotruong, DateTime? ngaytotnghiep, DateTime? ngaycapbang, decimal diem4,
                int idloaitotnghiep, int idhedaotao, int idnganh, int idlop, int iddiemchu, string trangthai, string nomon, string ghichu)
        {
            this.IDThongTinTotNghiep = idthongtintotnghiep;
            this.NgayVaoTruong = ngayvaotruong;
            this.NgayTotNghiep = ngaytotnghiep;
            this.NgayCapBang = ngaycapbang;
            this.Diem4 = diem4;
            this.GhiChu = ghichu;
            this.IDLoaiTotNghiep = idloaitotnghiep;
            this.IDHeDaoTao = idhedaotao;
            this.IDNganh = idnganh;
            this.IDLop = idlop;
            this.IDDiemChu = iddiemchu;
            this.TrangThai = trangthai;
            this.NoMon = nomon;
        }

        public GraduateDTO(DataRow row)
        {
            this.IDThongTinTotNghiep = Convert.ToInt32(row["IDThongTinTotNghiep"]);
            this.NgayVaoTruong = Convert.ToDateTime(row["NgayVaoTruong"]);
            this.NgayTotNghiep = Convert.ToDateTime(row["NgayTotNghiep"]);
            this.NgayCapBang = Convert.ToDateTime(row["NgayCapBang"]);
            this.Diem4 = Convert.ToDecimal(row["Diem4"]);
            this.IDLoaiTotNghiep = Convert.ToInt32(row["IDLoaiTotNghiep"]);
            this.IDHeDaoTao = Convert.ToInt32(row["IDHeDaoTao"]);
            this.IDNganh = Convert.ToInt32(row["IDNganh"]);
            this.IDLop = Convert.ToInt32(row["IDLop"]);
            this.IDDiemChu = Convert.ToInt32(row["IDDiemChu"]);
            this.TrangThai = row["TrangThai"].ToString();
            this.NoMon = row["NoMon"].ToString();

            if (row["GhiChu"] != null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }

        }

    }

    public class Graduate
    {
        private int _IDThongTinTotNghiep;
        private DateTime? _NgayVaoTruong;
        private DateTime? _NgayTotNghiep;
        private DateTime? _NgayCapBang;
        private double _Diem4;
        private string _GhiChu;
        private string _TenLoaiTotNghiep;
        private string _TenHeDaoTao;
        private string _TenNganh;
        private string _MaLop;
        private string _TenDiem;
        private string _TrangThai;
        private string _NoMon;

        public int IDThongTinTotNghiep { get => _IDThongTinTotNghiep; set => _IDThongTinTotNghiep = value; }
        public DateTime? NgayVaoTruong { get => _NgayVaoTruong; set => _NgayVaoTruong = value; }
        public DateTime? NgayTotNghiep { get => _NgayTotNghiep; set => _NgayTotNghiep = value; }
        public DateTime? NgayCapBang { get => _NgayCapBang; set => _NgayCapBang = value; }
        public double Diem4 { get => _Diem4; set => _Diem4 = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public string TrangThai { get => _TrangThai; set => _TrangThai = value; }
        public string NoMon { get => _NoMon; set => _NoMon = value; }
        public string TenLoaiTotNghiep { get => _TenLoaiTotNghiep; set => _TenLoaiTotNghiep = value; }
        public string TenHeDaoTao { get => _TenHeDaoTao; set => _TenHeDaoTao = value; }
        public string TenNganh { get => _TenNganh; set => _TenNganh = value; }
        public string MaLop { get => _MaLop; set => _MaLop = value; }
        public string TenDiem { get => _TenDiem; set => _TenDiem = value; }
    }
    
}
