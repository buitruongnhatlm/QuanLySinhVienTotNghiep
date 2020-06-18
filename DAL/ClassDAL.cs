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

        public bool UpdateClass(int idlop, string malop, string tenlop, int soluongsinhvien, string covan, int idkhoa, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.Lop SET MaLop= '{0}' , TenLop = N'{1}', SoLuongSinhVien={2} , CoVan=N'{3}', GhiChu=N'{4}', IDKhoa={5} WHERE IDLop = {6} ",malop,tenlop,soluongsinhvien,covan,ghichu,idkhoa,idlop);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteClass(int idlop)
        {
            string _query = string.Format(" DELETE dbo.Lop WHERE IDLop = {0} ", idlop);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public List<ClassDTO> SearchClass(string type, string content)
        {
            List<ClassDTO> _list = new List<ClassDTO>();
            string _query = "";

            if (type.Equals("MaLop"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchClass @type = 'MaLop',  @content = N'{0}' ",content);
            }
            else if (type.Equals("TenLop"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchClass @type = 'TenLop',  @content = N'{0}' ", content);
            }
            else if (type.Equals("CoVan"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchClass @type = 'CoVan', @content = N'{0}' ", content);
            }
            else if (type.Equals("GhiChu"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchClass @type = 'GhiChu', @content = N'{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                ClassDTO _class = new ClassDTO(row);
                _list.Add(_class);
            }
            return _list;
        }
    }
}
