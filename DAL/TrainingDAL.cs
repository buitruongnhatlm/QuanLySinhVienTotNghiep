using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace DAL
{
   public class TrainingDAL
   {
        private static TrainingDAL _instance;

        public static TrainingDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new TrainingDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private TrainingDAL() { }

        public DataTable GetListTraining()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListTraining");
        }

        public bool InsertTraining(string TenHeDaoTao,int Thoigiandaotao, string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.HeDaoTao ( TenHeDaoTao , ThoiGianDaoTao , GhiChu ) VALUES  ( N'{0}' , {1} , N'{2}') ",TenHeDaoTao,Thoigiandaotao,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateTraining(int idhedaotao, string TenHeDaoTao, int Thoigiandaotao, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.HeDaoTao SET TenHeDaoTao= N'{0}', ThoiGianDaoTao = {1} , GhiChu= N'{2}' WHERE IDHeDaoTao= {3} ",TenHeDaoTao,Thoigiandaotao,ghichu,idhedaotao);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteTraining(int idhedaotao)
        {
            string _query = string.Format(" DELETE dbo.HeDaoTao WHERE IDHeDaoTao= {0} ", idhedaotao);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }
    }
}
