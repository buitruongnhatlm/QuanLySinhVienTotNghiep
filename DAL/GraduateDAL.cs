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

        //public bool InsertGraduate(DateTime? ngayvaotruong, DateTime? ngaytotnghiep, DateTime? ngaycapbang, float diem10, float diem4,
        //                     int idloaitotnghiep, int idhedaotao, int idnganh, int idlop, int iddiemchu, string ghichu = null)
        //{
        //    DateTime dt = DateTime.ParseExact(ngayvaotruong.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngayvaotruong = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt2 = DateTime.ParseExact(ngaytotnghiep.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaytotnghiep = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt3 = DateTime.ParseExact(ngaycapbang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaycapbang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //        string _query = string.Format(" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem10,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,GhiChu) VALUES ('{0}','{1}','{2}',{3},{4},{5},{6},{7},{8},{9},N'{10}') ",
        //           _ngayvaotruong, _ngaytotnghiep, _ngaycapbang, diem10, diem4, idloaitotnghiep, idhedaotao, idnganh, idlop, iddiemchu, ghichu);

        //    //string _query = string.Format("EXECUTE dbo.pro_InsertGraduate @ngayvaotruong = '{0}' , @ngaytotnghiep = '{1}' , @ngaycapbang = '{2}' , @diem10 = {3} , @diem4 = {4} ,  @ghichu = N'{5}', @idloaitotnghiep = {6} , @idhedaotao = {7} , @idnganh = {8} , @idlop = {9} , @iddiemchu = {10} ",
        //    //    _ngayvaotruong,ngaytotnghiep,_ngaycapbang,diem10,diem4,ghichu,idloaitotnghiep,idhedaotao,idnganh,idlop,iddiemchu);

        //      int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //     return _result > 0;

        //}

        //public bool UpdateGraduate(int idthongtintotnghiep, DateTime ngayvaotruong, DateTime ngaytotnghiep, DateTime ngaycapbang, int diem10, int diem4,
        //                     int idloaitotnghiep, int idhedaotao, int idnganh, int idlop, int iddiemchu, string ghichu = null)
        //{
        //    DateTime dt = DateTime.ParseExact(ngayvaotruong.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngayvaotruong = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt2 = DateTime.ParseExact(ngaytotnghiep.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaytotnghiep = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    DateTime dt3 = DateTime.ParseExact(ngaycapbang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
        //    string _ngaycapbang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

        //    string _query = string.Format(" UPDATE dbo.ThongTinTotNghiep SET NgayVaoTruong = '{0}' , NgayTotNghiep= '{1}' , NgayCapBang= '{2}' , Diem10= {3} , Diem4= {4} , IDLoaiTotNghiep= {5} , IDHeDaoTao= {6} , IDNghanh= {7} , IDLop= {8} , IDDiemChu= {9} , GhiChu= N'{10}' WHERE IDThongTinTotNghiep = {11} ",
        //        _ngayvaotruong,_ngaytotnghiep,_ngaycapbang,diem10,diem4,idloaitotnghiep,idhedaotao,idnganh,idlop,iddiemchu,ghichu,idthongtintotnghiep);

        //    int _result = DataProvider.Instance.ExcuteNonQuery(_query);
        //    return _result > 0;
        //}

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
