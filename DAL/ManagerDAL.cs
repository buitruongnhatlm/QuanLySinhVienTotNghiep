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
                        hoten, ngaysinh, gioitinh, chungminhnhandan, noisinh, diachithuongtru, hocham, trinhdo, chuyenmon, donvicongtac, ghichu, idtaikhoan);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

    }
}
