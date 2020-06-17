using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class ProfessionDAL
    {
        private static ProfessionDAL _instance;

        public static ProfessionDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new ProfessionDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private ProfessionDAL() { }

        public DataTable GetListProfession()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListProfession ");
        }

        public bool InsertProfession(string tennganh, string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.Nganh ( TenNganh, GhiChu ) VALUES  ( N'{0}', N'{1}') ",tennganh,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateProfession(int idnganh, string tennganh, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.Nganh SET TenNganh = N'{0}', GhiChu = N'{1}' WHERE IDNganh = '{2}' ",tennganh,ghichu,idnganh);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteProfession(int idnganh)
        {
            string _query = string.Format(" DELETE dbo.Nganh WHERE IDNganh = {0} ",idnganh);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }
    }
}
