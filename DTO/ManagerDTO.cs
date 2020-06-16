using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class ManagerDTO
    {
        private string _HoTen;
        private DateTime _NgaySinh;
        private string _GioiTinh;
        private int _ChungMinhNhanDan;
        private string _NoiSinh;
        private string _DiaChiThuongTru;
        private string _Hocham;
        private string _TrinhDo;
        private string _ChuyenMon;
        private string _DonViCongTac;
        private string _GhiChu;
        private int _IDTaiKhoan;

        public string HoTen { get => _HoTen; set => _HoTen = value; }
        public DateTime NgaySinh { get => _NgaySinh; set => _NgaySinh = value; }
        public string GioiTinh { get => _GioiTinh; set => _GioiTinh = value; }
        public int ChungMinhNhanDan { get => _ChungMinhNhanDan; set => _ChungMinhNhanDan = value; }
        public string NoiSinh { get => _NoiSinh; set => _NoiSinh = value; }
        public string DiaChiThuongTru { get => _DiaChiThuongTru; set => _DiaChiThuongTru = value; }
        public string Hocham { get => _Hocham; set => _Hocham = value; }
        public string TrinhDo { get => _TrinhDo; set => _TrinhDo = value; }
        public string ChuyenMon { get => _ChuyenMon; set => _ChuyenMon = value; }
        public string DonViCongTac { get => _DonViCongTac; set => _DonViCongTac = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDTaiKhoan { get => _IDTaiKhoan; set => _IDTaiKhoan = value; }

        public ManagerDTO(string hoten, DateTime ngaysinh, string gioitinh, int chungminhnhandan, string noisinh, 
            string diachithuongtru, string hocham, string trinhdo, string chuyenmon, string donvicongtac, string ghichu, int idtaikhoan)
        {
            this.HoTen = hoten;
            this.NgaySinh = ngaysinh;
            this.GioiTinh = gioitinh;
            this.ChungMinhNhanDan = chungminhnhandan;
            this.NoiSinh = noisinh;
            this.DiaChiThuongTru = diachithuongtru;
            this.Hocham = hocham;
            this.TrinhDo = trinhdo;
            this.ChuyenMon = chuyenmon;
            this.DonViCongTac = donvicongtac;
            this.GhiChu = ghichu;
            this.IDTaiKhoan = idtaikhoan;
        }

        public ManagerDTO(DataRow row)
        {
            this.HoTen = row["HoTen"].ToString();
            this.NgaySinh = Convert.ToDateTime(row["NgaySinh"]);
            this.GioiTinh = row["GioiTinh"].ToString();
            this.ChungMinhNhanDan = Convert.ToInt32(row["ChungMinhNhanDan"]);
            this.NoiSinh = row["NoiSinh"].ToString();
            this.DiaChiThuongTru = row["DiaChiThuongTru"].ToString();
            this.Hocham = row["HocHam"].ToString();
            this.DonViCongTac = row["DonViCongTac"].ToString();
            this.ChuyenMon = row["ChuyenMon"].ToString();

            if (!string.IsNullOrEmpty(row["GhiChu"].ToString()))
            {
                this.GhiChu = row["GhiChu"].ToString();
            }

            this.IDTaiKhoan = Convert.ToInt32(row["IDTaiKhoan"].ToString());
        }
    }
}
