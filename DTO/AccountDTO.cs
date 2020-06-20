using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class AccountDTO
    {
        private string _TenTaiKhoan;
        private string _MatKhau;
        private string _Email;
        private int _SoDienThoai;
        private string _GhiChu;
        private int _IDLoaiTaiKhoan;

        public string TenTaiKhoan { get => _TenTaiKhoan; set => _TenTaiKhoan = value; }
        public string MatKhau { get => _MatKhau; set => _MatKhau = value; }
        public string Email { get => _Email; set => _Email = value; }
        public int SoDienThoai { get => _SoDienThoai; set => _SoDienThoai = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDLoaiTaiKhoan { get => _IDLoaiTaiKhoan; set => _IDLoaiTaiKhoan = value; }

        public AccountDTO(string tentaikhoan, string matkhau, string email, int sodienthoai, string ghichu, int idloaitaikhoan )
        {
            this.TenTaiKhoan = tentaikhoan;
            this.MatKhau = matkhau;
            this.Email = email;
            this.SoDienThoai = sodienthoai;
            this.GhiChu = ghichu;
            this.IDLoaiTaiKhoan = idloaitaikhoan;
        }

        public AccountDTO(DataRow row)
        {
            this.TenTaiKhoan = row["TenTaiKhoan"].ToString();
            this.MatKhau = row["MatKhau"].ToString();
            this.Email = row["Email"].ToString();
            this.SoDienThoai = Convert.ToInt32(row["SoDienThoai"]);
            this.GhiChu = row["GhiChu"].ToString();
            this.IDLoaiTaiKhoan = Convert.ToInt32(row["IDLoaiTaiKhoan"]);
        }

    }

    public class Account
    {
        private int _IDTaiKhoan;
        private string _TenTaiKhoan;
        private string _MatKhau;
        private string _Email;
        private int _SoDienThoai;
        private string _GhiChu;
        private int _IDLoaiTaiKhoan;

        public int IDTaiKhoan { get => _IDTaiKhoan; set => _IDTaiKhoan = value; }
        public string TenTaiKhoan { get => _TenTaiKhoan; set => _TenTaiKhoan = value; }
        public string MatKhau { get => _MatKhau; set => _MatKhau = value; }
        public string Email { get => _Email; set => _Email = value; }
        public int SoDienThoai { get => _SoDienThoai; set => _SoDienThoai = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDLoaiTaiKhoan { get => _IDLoaiTaiKhoan; set => _IDLoaiTaiKhoan = value; }

        public Account(int idtaikhoan, string tentaikhoan, string matkhau, string email, int sodienthoai, string ghichu, int idloaitaikhoan)
        {
            this.IDTaiKhoan = idtaikhoan;
            this.TenTaiKhoan = tentaikhoan;
            this.MatKhau = matkhau;
            this.Email = email;
            this.SoDienThoai = sodienthoai;
            this.GhiChu = ghichu;
            this.IDLoaiTaiKhoan = idloaitaikhoan;
        }

        public Account(DataRow row)
        {
            this.IDTaiKhoan = Convert.ToInt32(row["IDTaikhoan"].ToString());
        }

    }
    
}
