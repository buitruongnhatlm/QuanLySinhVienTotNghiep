using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
   public class GraduateTypeDAL
    {
        private static GraduateTypeDAL _instance;

        public static GraduateTypeDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new GraduateTypeDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private GraduateTypeDAL() { }

        public DataTable GetListGraduateType()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListGraduateType");
        }

        public List<GraduateTypeDTO> GetListGraduateTypeToCombobox()
        {
            List<GraduateTypeDTO> _List = new List<GraduateTypeDTO>();

            string _Query = "SELECT * FROM dbo.LoaiTotNghiep";

            DataTable _Table = DataProvider.Instance.ExcuteQuery(_Query);

            foreach (DataRow item in _Table.Rows)
            {
                GraduateTypeDTO _graduate = new GraduateTypeDTO(item);
                _List.Add(_graduate);
            }

            return _List;
        }

        public bool InsertGraduateType(string tenloaitotnghiep,string ghichu = null)
        {
            string _query = string.Format(" INSERT INTO dbo.LoaiTotNghiep ( TenLoaiTotNghiep, GhiChu ) VALUES ( N'{0}', N'{1}') ",tenloaitotnghiep,ghichu);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateGraduateType(int idloaitotnghiep, string tenloaitotnghiep, string ghichu = null)
        {
            string _query = string.Format(" UPDATE dbo.LoaiTotNghiep SET TenLoaiTotNghiep = N'{0}' , GhiChu = N'{1}' WHERE IDLoaiTotNghiep = {2} ",tenloaitotnghiep,ghichu,idloaitotnghiep);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteGraduateType(int idloaitotnghiep)
        {
            string _query = string.Format(" DELETE dbo.LoaiTotNghiep WHERE IDLoaiTotNghiep= {0} ",idloaitotnghiep);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

    }
}
