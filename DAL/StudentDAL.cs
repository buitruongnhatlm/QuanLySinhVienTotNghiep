using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class StudentDAL
   {
        private static StudentDAL _instance;

        public static StudentDAL Instance
        {
            get
            {
                if(_instance==null)
                {
                    _instance = new StudentDAL();
                }
                return _instance;
            }

           private set => _instance = value;
        }

        private StudentDAL() { }

        public DataTable GetListStudent()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListStudent");
        }

        public bool InsertStudent(string hoten, int mssv, string gioitinh, DateTime? ngaysinh, string noisinh, string diachi, 
            string dantoc, string tongiao, int cmnd, DateTime? ngaycap, DateTime? ngayvaodoan, DateTime? ngayvaodang, int dienthoai,
            string email, int idgiadinh, int idtaikhoan, int idthongtintotnghiep, string ghichu = null)
        {

            DateTime dt = DateTime.ParseExact(ngaysinh.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaysinh = dt.ToString("dd/M/yyyy", CultureInfo.InvariantCulture);

            DateTime dt2 = DateTime.ParseExact(ngaycap.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaycap = dt.ToString("dd/M/yyyy", CultureInfo.InvariantCulture);

            DateTime dt3 = DateTime.ParseExact(ngayvaodoan.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngayvaodoan = dt.ToString("dd/M/yyyy", CultureInfo.InvariantCulture);

            DateTime dt4 = DateTime.ParseExact(ngayvaodang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngayvaodang = dt.ToString("dd/M/yyyy", CultureInfo.InvariantCulture);

            //string _query = string.Format("INSERT INTO dbo.SinhVien (HoTen,MaSoSinhVien,GioiTinh,NgaySinh,NoiSinh,DiaChiThuongTru,DanToc,TonGiao,ChungMinhNhanDan,NgayCap,NgayVaoDoan,NgayVaoDang,DienThoai,Email,GhiChu,IDGiaDinh,IDTaiKhoan,IDThongTinTotNghiep) " +
            //"VALUES (N'{0}',{1},N'{2}',{3},N'{4}',N'{5}',N'{6}',N'{7}',{8},{9},{10},{11},{12},'{13}',N'{14}',{15},{16},{17})", hoten,mssv,gioitinh,ngaysinh,noisinh,diachi,dantoc,tongiao,cmnd,ngaycap,ngayvaodoan,ngayvaodang,dienthoai,email,ghichu, idgiadinh,idtaikhoan,idthongtintotnghiep);

            string _query = string.Format("INSERT INTO dbo.SinhVien ( HoTen, MaSoSinhVien, GioiTinh, NgaySinh, NoiSinh, DiaChiThuongTru, DanToc, TonGiao, ChungMinhNhanDan, NgayCap, NgayVaoDoan, NgayVaoDang, DienThoai, Email, GhiChu, IDGiaDinh, IDTaiKhoan, IDThongTinTotNghiep) VALUES ( N'{0}', {1}, N'{2}', {3}, N'{4}', N'{5}', N'{6}', N'{7}', {8}, {9}, {10}, {11}, {12}, '{13}', N'{14}', {15}, {16}, {17})",hoten,mssv,gioitinh,_ngaysinh,noisinh,diachi,dantoc,tongiao,cmnd,_ngaycap,_ngayvaodoan,_ngayvaodang,dienthoai,email,ghichu,idgiadinh,idtaikhoan,idthongtintotnghiep);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool UpdateAccount(string tentaikhoan, string email, int sodienthoai, int idloaitaikhoan, string ghichu = null)
        {
            string _query = string.Format("UPDATE dbo.TaiKhoan SET Email=N'{0}', SoDienThoai={1} , GhiChu=N'{2}' , IDLoaiTaiKhoan={3} WHERE TenTaiKhoan = N'{4}' ", email, sodienthoai, ghichu, idloaitaikhoan, tentaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteAccount(string tentaikhoan)
        {
            string _query = string.Format("DELETE dbo.TaiKhoan WHERE TenTaiKhoan=N'{0}' ", tentaikhoan);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;

        }
        //public List<AccountDTO> SearchAccount(string account)
        //{
        //    List<AccountDTO> _list = new List<AccountDTO>();
        //    string _query = string.Format("SELECT * FROM dbo.TaiKhoan WHERE dbo.[func_ConvertToUnsign](TenTaiKhoan) LIKE N'%' + dbo.[func_ConvertToUnsign](N'{0}') + '%' ", account);
        //    DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
        //    foreach (DataRow row in _table.Rows)
        //    {
        //        AccountDTO _accountDTO = new AccountDTO(row);
        //        _list.Add(_accountDTO);
        //    }
        //    return _list;
        //}

    }
}
