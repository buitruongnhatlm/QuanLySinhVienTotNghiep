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
        int _TYPE;
        string _TENTAIKHOAN;

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

        public int GetIDAccountByUsername(string tentaikhoan)
        {
            int _idtaikhoan = 1;

            string _query = string.Format("EXECUTE dbo.pro_GetIDAccountByUsername @username = '{0}' ",tentaikhoan);

            DataTable _result = DataProvider.Instance.ExcuteQuery(_query, new object[] { tentaikhoan });

            foreach (DataRow row in _result.Rows)
            {
                Account _account = new Account(row);
                _idtaikhoan = _account.IDTaiKhoan;
            }

            return _idtaikhoan;
        }

        public List<AccountDTO> GetListAccountToCombobox()
        {
            List<AccountDTO> _List = new List<AccountDTO>();

            string _Query = "SELECT * FROM dbo.TaiKhoan";

            DataTable _Table = DataProvider.Instance.ExcuteQuery(_Query);

            foreach (DataRow item in _Table.Rows)
            {
                AccountDTO _account = new AccountDTO(item);
                _List.Add(_account);
            }

            return _List;
        }

        public List<AccountDTO> GetAccountToCombobox(string tentaikhoan)
        {
            List<AccountDTO> _List = new List<AccountDTO>();

            string _Query = string.Format("SELECT * FROM dbo.TaiKhoan WHERE TenTaiKhoan='{0}' ",tentaikhoan);

            DataTable _Table = DataProvider.Instance.ExcuteQuery(_Query);

            foreach (DataRow item in _Table.Rows)
            {
                AccountDTO _account = new AccountDTO(item);
                _List.Add(_account);
            }

            return _List;
        }

        public bool Login(string tentaikhoan, string matkhau)
        {
            string _query = "EXECUTE dbo.pro_Login @TenTaiKhoan , @MatKhau ";

            DataTable _result = DataProvider.Instance.ExcuteQuery(_query, new object[] { tentaikhoan, matkhau });

            foreach (DataRow row in _result.Rows)
            {
                AccountDTO _accountDTO = new AccountDTO(row);
                _TYPE = _accountDTO.IDLoaiTaiKhoan;
                _TENTAIKHOAN = _accountDTO.TenTaiKhoan;
            }

            return _result.Rows.Count > 0;

        }

        public int GetAccountType()
        {
            return _TYPE;
        }

        public string GetUsername()
        {
            return _TENTAIKHOAN;
        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListAccount");
        }

        public bool InsertAccount(string tentaikhoan, string matkhau, string email, int sodienthoai, int idloaitaikhoan, string ghichu = null)
        {
            string _query = string.Format("INSERT INTO dbo.TaiKhoan (TenTaiKhoan,MatKhau,Email,SoDienThoai,GhiChu,IDLoaiTaiKhoan) VALUES (N'{0}',N'{1}',N'{2}',{3}, N'{4}',{5})",tentaikhoan,matkhau,email,sodienthoai,ghichu,idloaitaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool  UpdateAccount(string tentaikhoan, string email, int sodienthoai, int idloaitaikhoan, string ghichu=null)
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

        public List<AccountDTO> SearchAccount(string type, string content)
        {
            List<AccountDTO> _list = new List<AccountDTO>();
            string _query = "";

            if (type.Equals("TenTaiKhoan"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='TenTaiKhoan' , @content = '{0}' ", content);
            }
            else if (type.Equals("SoDienThoai"))
            {

                _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='SoDienThoai' , @content = '{0}' ", content);
            }
            else if (type.Equals("Email"))
            {

                _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='Email' , @content = '{0}' ", content);
            }
            else if (type.Equals("GhiChu"))
            {

                _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='GhiChu' , @content = '{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                AccountDTO _accountDTO = new AccountDTO(row);
                _list.Add(_accountDTO);
            }
            return _list;
        }

    }
}
