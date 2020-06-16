using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class PasswordDAL
    {
        private static PasswordDAL instance;

        public static PasswordDAL Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new PasswordDAL();
                }

                return instance;

            }

            set => instance = value;
        }

        private PasswordDAL() { }

        public bool ResetPassword(string tentaikhoan)
        {
            // Đặt lại Mật Khẩu Mặc Định Là 123 được mã hóa thành chuỗi 3244185981728979115075721453575112
            string _Query = string.Format(" UPDATE dbo.TaiKhoan SET MatKhau = 123456 WHERE TenTaiKhoan ='{0}' ",tentaikhoan);
            int Result = DataProvider.Instance.ExcuteNonQuery(_Query);
            return Result > 0;
        }

        public PasswordDTO GetMailByUser(string tentaikhoan)
        {
            string _Query = string.Format(" SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan ='{0}' ",tentaikhoan);

            DataTable _Table = DataProvider.Instance.ExcuteQuery(_Query);

            foreach (DataRow item in _Table.Rows)
            {
                return new PasswordDTO(item);
            }

            return null;

        }

    }
}
