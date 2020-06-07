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

    }
}
