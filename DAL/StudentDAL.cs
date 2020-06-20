using DTO;
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

        public DataTable GetListStudentByStudent()
        {
            return DataProvider.Instance.ExcuteQuery("EXECUTE dbo.pro_GetListStudent");
        }

        public DataTable GetStudentCurrent(int idtaikhoan)
        {
            string _query = string.Format("EXECUTE dbo.pro_GetStudentCurrent @idtaikhoan = {0} ",idtaikhoan);
            return DataProvider.Instance.ExcuteQuery(_query);
        }

        public int GetIDStudentByIDAccount(int idtaikhoan)
        {

            int _idsinhvien = 1;

            string _query = string.Format("EXECUTE dbo.pro_GetIDSinhVienByIDTaiKhoan @idtaikhoan = {0} ", idtaikhoan);

            DataTable _result = DataProvider.Instance.ExcuteQuery(_query, new object[] { idtaikhoan });

            foreach (DataRow row in _result.Rows)
            {
                Student _student = new Student(row);
                _idsinhvien = _student.IDSinhVien;
            }

            return _idsinhvien;

        }

        public bool InsertStudent(string hoten, int mssv, string gioitinh, DateTime? ngaysinh, string noisinh, string diachi, 
            string dantoc, string tongiao, int cmnd, DateTime? ngaycap, DateTime? ngayvaodoan, DateTime? ngayvaodang, int dienthoai,
            string email, int idgiadinh, int idtaikhoan, int idthongtintotnghiep, string ghichu = null)
        {

            DateTime dt = DateTime.ParseExact(ngaysinh.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaysinh = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt2 = DateTime.ParseExact(ngaycap.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaycap = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt3 = DateTime.ParseExact(ngayvaodoan.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngayvaodoan = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _ngayvaodang="01/01/0001";
            if (ngayvaodang!=null)
            {
                DateTime dt4 = DateTime.ParseExact(ngayvaodang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
                _ngayvaodang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);
            }

            string _query = string.Format("INSERT INTO dbo.SinhVien ( HoTen, MaSoSinhVien, GioiTinh, NgaySinh, NoiSinh, DiaChiThuongTru, DanToc, TonGiao, ChungMinhNhanDan, NgayCap, NgayVaoDoan, NgayVaoDang, DienThoai, Email, GhiChu, IDGiaDinh, IDTaiKhoan, IDThongTinTotNghiep) VALUES ( N'{0}', {1}, N'{2}', '{3}' , N'{4}', N'{5}', N'{6}', N'{7}', {8}, '{9}' , '{10}' , '{11}' , {12}, '{13}', N'{14}', {15}, {16}, {17})",hoten,mssv,gioitinh,_ngaysinh,noisinh,diachi,dantoc,tongiao,cmnd,_ngaycap,_ngayvaodoan,_ngayvaodang,dienthoai,email,ghichu,idgiadinh,idtaikhoan,idthongtintotnghiep);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool UpdateStudent(int idsinhvien,string hoten, int mssv, string gioitinh, DateTime? ngaysinh, string noisinh, string diachi,
            string dantoc, string tongiao, int cmnd, DateTime? ngaycap, DateTime? ngayvaodoan, DateTime? ngayvaodang, int dienthoai,
            string email, int idgiadinh, int idtaikhoan, int idthongtintotnghiep, string ghichu = null)
        {

            DateTime dt = DateTime.ParseExact(ngaysinh.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaysinh = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt2 = DateTime.ParseExact(ngaycap.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngaycap = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt3 = DateTime.ParseExact(ngayvaodoan.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngayvaodoan = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            DateTime dt4 = DateTime.ParseExact(ngayvaodang.ToString(), "dd/MM/yyyy hh:mm:ss", CultureInfo.InvariantCulture);
            string _ngayvaodang = dt.ToString("yyyy/MM/dd", CultureInfo.InvariantCulture);

            string _query = string.Format("UPDATE dbo.SinhVien SET HoTen=N'{0}', MaSoSinhVien={1} , GioiTinh=N'{2}' , NgaySinh='{3}' , NoiSinh=N'{4}' , DiaChiThuongTru = N'{5}', DanToc = N'{6}', TonGiao = N'{7}', ChungMinhNhanDan = {8}, NgayCap = '{9}', NgayVaoDoan = '{10}', NgayVaoDang = '{11}', DienThoai = {12}, Email = '{13}', GhiChu = N'{14}', IDGiaDinh = '{15}', IDTaiKhoan = '{16}', IDThongTinTotNghiep = '{17}' WHERE IDSinhVien = {18} ",
                hoten,mssv,gioitinh,_ngaysinh,noisinh,diachi,dantoc,tongiao,cmnd,_ngaycap,_ngayvaodoan,_ngayvaodang,dienthoai,email,ghichu,idgiadinh,idtaikhoan,idthongtintotnghiep,idsinhvien);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteStudent(int idsinhvien)
        {
            string _query = string.Format("DELETE dbo.SinhVien WHERE IDSinhVien={0} ", idsinhvien);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public List<StudentDTO> SearchStudent(string type, string content)
        {
            List<StudentDTO> _list = new List<StudentDTO>();
            string _query = "";

            if (type.Equals("HoTen"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'HoTen',  @content = N'{0}' ", content);
            }
            else if (type.Equals("MaSoSinhVien"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'MaSoSinhVien',  @content = '{0}' ", content);
            }
            else if (type.Equals("GioiTinh"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'GioiTinh', @content = N'{0}'  ", content);
            }
            else if (type.Equals("NoiSinh"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'NoiSinh' , @content = N'{0}' ", content);
            }
            else if (type.Equals("ChungMinhNhanDan"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'ChungMinhNhanDan',  @content = '{0}' ", content);
            }
            else if (type.Equals("DienThoai"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'DienThoai' , @content = '{0}' ", content);
            }
            else if (type.Equals("Email"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'Email' , @content = '{0}' ", content);
            }
            else if (type.Equals("GhiChu"))
            {
                _query = string.Format(" EXECUTE dbo.pro_SearchStudent @type = 'GhiChu' , @content = N'{0}' ", content);
            }

            DataTable _table = DataProvider.Instance.ExcuteQuery(_query);
            foreach (DataRow row in _table.Rows)
            {
                StudentDTO _student = new StudentDTO(row);
                _list.Add(_student);
            }

            return _list;
        }

    }
}
