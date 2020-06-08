using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class AccountDAL
    {
        // sử dụng singleton pattern
        private static AccountDAL _instance;

        public static AccountDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new AccountDAL();
                }

                return _instance;
            }
            private set => _instance = value;
        }

        private AccountDAL() { }

        public bool Login(string tentaikhoan, string matkhau)
        {
            string _query = "EXECUTE dbo.pro_Login @TenTaiKhoan , @MatKhau ";

            DataTable _result = DataProvider.Instance.ExcuteQuery(_query, new object[] { tentaikhoan, matkhau });

            return _result.Rows.Count > 0;

        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListAccount");
        }


        public bool InsertAccount(string tentaikhoan, string matkhau, string email, int sodienthoai, string ghichu, int idloaitaikhoan)
        {
            string _query = string.Format("INSERT INTO dbo.TaiKhoan (TenTaiKhoan,MatKhau,Email,SoDienThoai,GhiChu,IDLoaiTaiKhoan) VALUES (N'{0}',N'{1}',N'{2}',{3}, N'{4}',{5})",tentaikhoan,matkhau,email,sodienthoai,ghichu,idloaitaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool  UpdateAccount(string tentaikhoan, string email, int sodienthoai, string ghichu, int idloaitaikhoan)
        {
            string _query = string.Format("UPDATE dbo.TaiKhoan SET Email=N'{0}', SoDienThoai={1} , GhiChu=N'{2}' , IDLoaiTaiKhoan={3} WHERE TenTaiKhoan = N'{4}' ",email,sodienthoai,ghichu,idloaitaikhoan,tentaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteAccount(string tentaikhoan)
        {
            string _query = string.Format("DELETE dbo.TaiKhoan WHERE TenTaiKhoan=N'{0}' ",tentaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

    }
}
