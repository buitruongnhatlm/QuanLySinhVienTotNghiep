using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
   public class MarkDAL
    {
        private static MarkDAL _instance;

        public static MarkDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new MarkDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private MarkDAL() { }

        public DataTable GetListMark()
        {
            return DataProvider.Instance.ExcuteQuery(" SELECT * FROM dbo.DiemChu ");
        }

        public bool InsertMark(int iddiemchu, string tendiem, string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.DiemChu ( IDDiemChu, TenDiem, GhiChu ) VALUES  ( {0}, N'{1}', N'{2}' ) ",iddiemchu,tendiem,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateMark(int iddiemchu, string tendiem, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.DiemChu SET TenDiem = N'{0}', GhiChu = N'{1}' WHERE IDDiemChu = {2} ",tendiem,ghichu,iddiemchu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteMark(int iddiemchu)
        {
            string _query = string.Format(" DELETE dbo.DiemChu WHERE IDDiemChu= {0} ", iddiemchu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }
    }
}
