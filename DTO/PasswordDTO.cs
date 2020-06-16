using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class PasswordDTO
    {
        private string _TenTaiKhoan;
        private string _Email;
        private int _IDLoaiTaiKhoan;

        public string TenTaiKhoan { get => _TenTaiKhoan; set => _TenTaiKhoan = value; }
        public string Email { get => _Email; set => _Email = value; }
        public int IDLoaiTaiKhoan { get => _IDLoaiTaiKhoan; set => _IDLoaiTaiKhoan = value; }

        public PasswordDTO(string tentaikhoan, string matkhau, string email, int sodienthoai, string ghichu, int idloaitaikhoan)
        {
            this.TenTaiKhoan = tentaikhoan;
            this.Email = email;
            this.IDLoaiTaiKhoan = idloaitaikhoan;
        }

        public PasswordDTO(DataRow row)
        {
            this.TenTaiKhoan = row["TenTaiKhoan"].ToString();
            this.Email = row["Email"].ToString();
            this.IDLoaiTaiKhoan = Convert.ToInt32(row["IDLoaiTaiKhoan"]);
        }

    }
}
