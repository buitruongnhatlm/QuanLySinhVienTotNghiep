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
    public class ManagerDAL
    {
        private static ManagerDAL _instance;

        public static ManagerDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new ManagerDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private ManagerDAL() { }

        public DataTable GetListManager()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListManager ");
        }

        public bool InsertManager(string hoten, DateTime? ngaysinh, string gioitinh, int chungminhnhandan, string noisinh,
            string diachithuongtru, string hocham, string trinhdo, string chuyenmon, string donvicongtac, int idtaikhoan, string ghichu = null)
        {
            DateTime dt = DateTime.ParseExact(ngaysinh.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaysinh = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _query = string.Format(" EXECUTE dbo.pro_InsertManager @HoTen = N'{0}', @NgaySinh = '{1}', @GioiTinh = N'{2}', @CMND = {3} , @NoiSinh = N'{4}', @DiaChiThuongTru = N'{5}', @HocHam = N'{6}', @TrinhDo = N'{7}', @ChuyenMon = N'{8}', @DonViCongTac = N'{9}', @IDTaiKhoan = {10}, @GhiChu = N'{11}' ", 
                        hoten, _ngaysinh, gioitinh, chungminhnhandan, noisinh, diachithuongtru, hocham, trinhdo, chuyenmon, donvicongtac, idtaikhoan, ghichu);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool UpdateManager(int idquanlyvien, string hoten, DateTime? ngaysinh, string gioitinh, int chungminhnhandan, string noisinh,
                        string diachithuongtru, string hocham, string trinhdo, string chuyenmon, string donvicongtac, int idtaikhoan, string ghichu = null)
        {
            DateTime dt = DateTime.ParseExact(ngaysinh.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaysinh = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _query = string.Format(" EXECUTE dbo.pro_UpdatetManager @IDQuanLyVien = {0} , @HoTen = N'{1}', @NgaySinh = '{2}', @GioiTinh = N'{3}', @CMND = {4}, @NoiSinh = N'{5}', @DiaChiThuongTru = N'{6}', @HocHam = N'{7}', @TrinhDo = N'{8}', @ChuyenMon = N'{9}', @DonViCongTac = N'{10}', @IDTaiKhoan = {11}, @GhiChu = N'{12}' ",
                                             idquanlyvien, hoten, _ngaysinh, gioitinh, chungminhnhandan, noisinh, diachithuongtru, hocham, trinhdo, chuyenmon, donvicongtac, idtaikhoan, ghichu);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteManager(int idquanlyvien)
        {
            string _query = string.Format(" EXECUTE dbo.pro_DeleteManager @IDQuanLyVien = {0} ",idquanlyvien);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public List<ManagerDTO> SearchManager(string type, string content)
        {
            List<ManagerDTO> _list = new List<ManagerDTO>();
            string _query = "";

            if (type.Equals("HoTen"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchManager @type = 'HoTen', @content = N'{0}' ", content);
            }
            else if (type.Equals("GioiTinh"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchManager @type = 'GioiTinh', @content = N'{0}' ", content);
            }
            else if (type.Equals("ChungMinhNhanDan"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchManager @type = 'ChungMinhNhanDan', @content = N'{0}' ", content);
            }
            else if (type.Equals("TaiKhoan"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchManager @type = 'TaiKhoan', @content = N'{0}' ", content);
            }
            else if (type.Equals("GhiChu"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchManager @type = 'GhiChu', @content = N'{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                ManagerDTO _manager = new ManagerDTO(row);
                _list.Add(_manager);
            }

            return _list;
        }

    }
}
