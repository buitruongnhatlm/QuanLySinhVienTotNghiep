using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class FamilyDAL
    {
        private static FamilyDAL _instance;

        public static FamilyDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new FamilyDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private FamilyDAL() { }

        public DataTable GetListFamily()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListFamily");
        }

        public bool InsertFamily(string hotencha, DateTime? namsinhcha, int dienthoaicha, string hotenme, DateTime? namsinhme, int dienthoaime, string diachi, string ghichu=null)
        {
            DateTime dt = DateTime.ParseExact(namsinhcha.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _namsinhcha = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt2 = DateTime.ParseExact(namsinhme.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _namsinhme = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _query = string.Format("INSERT INTO dbo.GiaDinh ( HoTenCha , NamSinhCha , DienThoaiCha , HoTenMe , NamSinhMe , DienThoaiMe , DiaChi , GhiChu ) VALUES  ( N'{0}' , '{1}' , {2} , N'{3}' , '{4}' , {5} , N'{6}' , N'{7}' ) ", hotencha,_namsinhcha,dienthoaicha,hotenme,_namsinhme,dienthoaime,diachi,ghichu);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool UpdateFamily(int idgiadinh, string hotencha, DateTime? namsinhcha, int dienthoaicha, string hotenme, DateTime? namsinhme, int dienthoaime, string diachi, string ghichu = null)
        {
            DateTime dt = DateTime.ParseExact(namsinhcha.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _namsinhcha = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt2 = DateTime.ParseExact(namsinhme.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _namsinhme = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _query = string.Format(" UPDATE dbo.GiaDinh SET HoTenCha = N'{0}', NamSinhCha = '{1}', DienThoaiCha = {2} , HoTenMe= N'{3}', NamSinhMe='{4}' , DienThoaiMe = {5} , DiaChi= N'{6}' , GhiChu= N'{7}' WHERE IDGiaDinh = {8} ", hotencha, _namsinhcha, dienthoaicha, hotenme, _namsinhme, dienthoaime, diachi, ghichu, idgiadinh);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }

        public bool DeleteFamily(int idgiadinh)
        {
            string _query = string.Format("DELETE dbo.GiaDinh WHERE IDGiaDinh = {0} ", idgiadinh);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public List<FamilyDTO> SearchFamily(string type, string content)
        {
            List<FamilyDTO> _list = new List<FamilyDTO>();
            string _query = "";

            if (type.Equals("HoTenCha"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'HoTenCha', @content = N'{0}'  ", content);
            }
            else if (type.Equals("DienThoaiCha"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'DienThoaiCha', @content = '{0}' ", content);
            }
            else if (type.Equals("HoTenMe"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'HoTenMe', @content = N'{0}'  ", content);
            }
            else if (type.Equals("DienThoaiMe"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'DienThoaiMe', @content = '{0}' ", content);
            }
            else if (type.Equals("DiaChi"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'DiaChi', @content = N'{0}' ", content);
            }
            else if (type.Equals("GhiChu"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchFamily @type = 'GhiChu', @content = N'{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                FamilyDTO _family = new FamilyDTO(row);
                _list.Add(_family);
            }

            return _list;
        }

    }
}
