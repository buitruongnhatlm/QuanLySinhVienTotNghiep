using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
   public class ClassDAL
   {
        // sử dụng singleton pattern
        private static ClassDAL _instance;

        public static ClassDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new ClassDAL();
                }

                return _instance;
            }
            private set => _instance = value;
        }

        private ClassDAL() { }

        public DataTable GetListClass()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListClass ");
        }

        public bool InsertClass(string malop, string tenlop, int soluongsinhvien, string covan, int idkhoa, string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.Lop ( MaLop ,TenLop , SoLuongSinhVien, CoVan , IDKhoa, GhiChu) VALUES (N'{0}', N'{1}', {2}, N'{3}', {4} , N'{5}') ",malop,tenlop,soluongsinhvien,covan,idkhoa,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        //public bool UpdateAccount(string tentaikhoan, string email, int sodienthoai, int idloaitaikhoan, string ghichu = null)
        //{
        //    string _query = string.Format("UPDATE dbo.TaiKhoan SET Email=N'{0}', SoDienThoai={1} , GhiChu=N'{2}' , IDLoaiTaiKhoan={3} WHERE TenTaiKhoan = N'{4}' ", email, sodienthoai, ghichu, idloaitaikhoan, tentaikhoan);
        //    int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //    return _result > 0;
        //}

        //public bool DeleteAccount(string tentaikhoan)
        //{
        //    string _query = string.Format("DELETE dbo.TaiKhoan WHERE TenTaiKhoan=N'{0}' ", tentaikhoan);
        //    int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //    return _result > 0;
        //}

        //public List<AccountDTO> SearchAccount(string type, string content)
        //{
        //    List<AccountDTO> _list = new List<AccountDTO>();
        //    string _query = "";

        //    if (type.Equals("TenTaiKhoan"))
        //    {
        //        _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='TenTaiKhoan' , @content = '{0}' ", content);
        //    }
        //    else if (type.Equals("SoDienThoai"))
        //    {

        //        _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='SoDienThoai' , @content = '{0}' ", content);
        //    }
        //    else if (type.Equals("Email"))
        //    {

        //        _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='Email' , @content = '{0}' ", content);
        //    }
        //    else if (type.Equals("GhiChu"))
        //    {

        //        _query = string.Format(" EXECUTE dbo.pro_SearchAccount @type ='GhiChu' , @content = '{0}' ", content);
        //    }

        //    DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
        //    foreach (DataRow row in _table.Rows)
        //    {
        //        AccountDTO _accountDTO = new AccountDTO(row);
        //        _list.Add(_accountDTO);
        //    }
        //    return _list;
        //}
    }
}
