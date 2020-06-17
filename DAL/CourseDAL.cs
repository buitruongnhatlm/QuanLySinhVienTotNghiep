using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
   public class CourseDAL
    {
        private static CourseDAL _instance;

        public static CourseDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new CourseDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private CourseDAL() { }

        public DataTable GetListCourse()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListCourse ");
        }

        public bool InsertCourse(int makhoa, string tenkhoa, string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.Khoa ( MaKhoa, TenKhoa, GhiChu ) VALUES ( {0}, N'{1}', N'{2}' ) ",makhoa,tenkhoa,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateCourse(int idkhoa, int makhoa, string tenkhoa, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.Khoa SET MaKhoa={0},TenKhoa=N'{1}',GhiChu=N'{2}' WHERE IDKhoa={3} ",makhoa,tenkhoa,ghichu,idkhoa);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteCourse(int idkhoa)
        {
            string _query = string.Format(" DELETE dbo.Khoa WHERE IDKhoa= {0} ",idkhoa);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }
    }
}
