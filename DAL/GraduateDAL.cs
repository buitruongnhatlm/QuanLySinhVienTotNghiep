using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class GraduateDAL
    {
        private static GraduateDAL _instance;

        public static GraduateDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new GraduateDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private GraduateDAL() { }

        public DataTable GetListGraduate()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListGraduate ");
        }

        public DataTable GetListNotGraduate()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListNotGraduate ");
        }

        #region lỗi cash nên Insert update trực tiếp
        //public bool InsertGraduate(DateTime? ngayvaotruong, DateTime? ngaytotnghiep, DateTime? ngaycapbang, float diem4,
        //                     int idloaitotnghiep, int idhedaotao, int idnganh, int idlop, int iddiemchu, string ghichu = null)
        //{
        //    DateTime dt = DateTime.ParseExact(ngayvaotruong.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngayvaotruong = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt2 = DateTime.ParseExact(ngaytotnghiep.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaytotnghiep = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt3 = DateTime.ParseExact(ngaycapbang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaycapbang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    string _query = string.Format(" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,GhiChu) VALUES ('{0}','{1}','{2}',{3},{4},{5},{6},{7},{8},N'{9}') ",
        //       _ngayvaotruong, _ngaytotnghiep, _ngaycapbang, diem4, idloaitotnghiep, idhedaotao, idnganh, idlop, iddiemchu, ghichu);

        //    int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //    return _result > 0;

        //}

        //public bool UpdateGraduate(int idthongtintotnghiep, DateTime ngayvaotruong, DateTime ngaytotnghiep, DateTime ngaycapbang, int diem4,
        //                     int idloaitotnghiep, int idhedaotao, int idnganh, int idlop, int iddiemchu, string ghichu = null)
        //{
        //    DateTime dt = DateTime.ParseExact(ngayvaotruong.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngayvaotruong = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt2 = DateTime.ParseExact(ngaytotnghiep.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaytotnghiep = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt3 = DateTime.ParseExact(ngaycapbang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaycapbang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    string _query = string.Format(" UPDATE dbo.ThongTinTotNghiep SET NgayVaoTruong = '{0}' , NgayTotNghiep= '{1}' , NgayCapBang= '{2}' , Diem4= {3} , IDLoaiTotNghiep= {4} , IDHeDaoTao= {5} , IDNghanh= {6} , IDLop= {7} , IDDiemChu= {8} , GhiChu= N'{9}' WHERE IDThongTinTotNghiep = {10} ",
        //        _ngayvaotruong, _ngaytotnghiep, _ngaycapbang, diem4, idloaitotnghiep, idhedaotao, idnganh, idlop, iddiemchu, ghichu, idthongtintotnghiep);

        //    int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //    return _result > 0;
        //}

        #endregion

        public bool DeleteGraduate(int idthongtintotnghiep)
        {
            string _query = string.Format(" DELETE dbo.ThongTinTotNghiep WHERE IDThongTinTotNghiep= {0} ",idthongtintotnghiep);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public List<GraduateDTO> SearchGraduate(string type, string content)
        {
            List<GraduateDTO> _list = new List<GraduateDTO>();
            string _query = "";

            if (type.Equals("IDThongTinTotNghiep"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchGraduate @type = 'IDThongTinTotNghiep', @content = N''   ", content);
            }
            else if (type.Equals("GhiChu"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchGraduate @type = 'GhiChu', @content = '{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                GraduateDTO _graduate = new GraduateDTO(row);
                _list.Add(_graduate);
            }

            return _list;
        }

    }
}
