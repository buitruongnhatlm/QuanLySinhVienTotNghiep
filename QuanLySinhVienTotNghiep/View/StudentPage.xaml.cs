using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.Win32;
using System.IO;
using System.Data.SqlClient;
using System.Runtime.Serialization;
using OfficeOpenXml;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for StudentPage.xaml
    /// </summary>
    public partial class StudentPage : Page
    {
        public StudentPage()
        {
            InitializeComponent();
            LoadData();
        }


        public void LoadData()
        {
            dtgStudent.ItemsSource = StudentDAL.Instance.GetListStudent().DefaultView;
        }

        public void AddStudent(string hoten, int mssv, string gioitinh, DateTime? ngaysinh, string noisinh, string diachi,
            string dantoc, string tongiao, int cmnd, DateTime? ngaycap, DateTime? ngayvaodoan, DateTime? ngayvaodang, int dienthoai,
            string email, int idgiadinh, int idtaikhoan, int idthongtintotnghiep, string ghichu = null)
        {
            if (StudentDAL.Instance.InsertStudent(hoten,mssv,gioitinh,ngaysinh,noisinh,diachi,dantoc,tongiao,cmnd,ngaycap,ngayvaodoan,ngayvaodang,dienthoai,email,idgiadinh,idtaikhoan,idthongtintotnghiep,ghichu))
            {
                MessageBox.Show("Thêm Sinh Viên Thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Thêm Sinh Viên Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();

        }

        public void EditStudent(int idsinhvien, string hoten, int mssv, string gioitinh, DateTime? ngaysinh, string noisinh, string diachi,
            string dantoc, string tongiao, int cmnd, DateTime? ngaycap, DateTime? ngayvaodoan, DateTime? ngayvaodang, int dienthoai,
            string email, int idgiadinh, int idtaikhoan, int idthongtintotnghiep, string ghichu = null)
        {
            if (StudentDAL.Instance.UpdateStudent(idsinhvien, hoten, mssv, gioitinh, ngaysinh, noisinh, diachi, dantoc, tongiao, cmnd, ngaycap, ngayvaodoan, ngayvaodang, dienthoai, email, idgiadinh, idtaikhoan, idthongtintotnghiep, ghichu))
            {
                MessageBox.Show("Cập nhật thông tin sinh viên thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Đã xảy ra lỗi\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void DeleteStudent(int idsinhvien)
        {
            if (StudentDAL.Instance.DeleteStudent(idsinhvien))
            {
                MessageBox.Show("Xóa Sinh Viên Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadData();

        }

        public List<StudentDTO> SearchStudent(string type, string content)
        {
            List<StudentDTO> _listStudent = StudentDAL.Instance.SearchStudent(type, content);
            return _listStudent;
        }

        private void DtgStudent_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtHoTen.Text = _dataRow["HoTen"].ToString();
                txtMSSV.Text = _dataRow["MaSoSinhVien"].ToString();
                dateNgaySinh.Text =_dataRow["NgaySinh"].ToString();
                txtNoiSinh.Text = _dataRow["NoiSinh"].ToString();
                txtDiaChi.Text = _dataRow["DiaChiThuongTru"].ToString();
                txtDanToc.Text = _dataRow["DanToc"].ToString();
                txtTonGiao.Text = _dataRow["TonGiao"].ToString();
                txtCMND.Text = _dataRow["ChungMinhNhanDan"].ToString();
                dateNgayCap.Text = _dataRow["NgayCap"].ToString();
                dateNgayVaoDoan.Text = _dataRow["NgayVaoDoan"].ToString();
                dateNgayVaoDang.Text = _dataRow["NgayVaoDang"].ToString();

                string t = _dataRow["DienThoai"].ToString(); 
                string temp1 = t.Substring(0, 1);
                string temp2 = t.Substring(1, 4);
                string temp3 = t.Substring(5, 4);
                txtDienThoai.Text = "0" +temp1 + "-" + temp2 + "-" + temp3;

                txtEmail.Text = _dataRow["Email"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                txtGiaDinh.Text = _dataRow["IDGiaDinh"].ToString();
                txtTaiKhoan.Text = _dataRow["IDTaiKhoan"].ToString();
                txtTotNghiep.Text = _dataRow["IDThongTinTotNghiep"].ToString();

                switch (_dataRow["GioiTinh"].ToString())
                {
                    case "Nam":
                        cbbGioiTinh.SelectedIndex = 0;
                        break;
                    case "Nữ":
                        cbbGioiTinh.SelectedIndex = 1;
                        break;

                }

            }
        }

        private void BtnThemSinhVien_Click(object sender, RoutedEventArgs e)
        {


            string _hoTen = txtHoTen.Text;
            string _gioiTinh = "";

            if (cbbGioiTinh.SelectedIndex == 0)
            {
                _gioiTinh = "Nam";
            }
            else if (cbbGioiTinh.SelectedIndex == 1)
            {
                _gioiTinh = "Nữ";
            }

            // datatype? allow null
            DateTime? _ngaySinh = dateNgaySinh.SelectedDate;
            string _noiSinh = txtNoiSinh.Text;
            string _diaChiThuongTru = txtDiaChi.Text;
            string _danToc = txtDanToc.Text;
            string _tonGiao = txtTonGiao.Text;

            string _chungMinhNhanDan = txtCMND.Text;
            int chungMinhNhanDan = Convert.ToInt32(txtCMND.Text);

            string _maSoSinhVien = txtMSSV.Text;
            int maSoSinhVien = Convert.ToInt32(_maSoSinhVien);

            DateTime? _ngayCap = dateNgayCap.SelectedDate;
            DateTime? _ngayVaoDoan = dateNgayVaoDoan.SelectedDate;
            DateTime? _ngayVaoDang = dateNgayVaoDang.SelectedDate;

            string _dienThoai = txtDienThoai.Text;
            string[] _temp = _dienThoai.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);
            int dienThoai = Convert.ToInt32(temp2);

            string _email = txtEmail.Text;
            string _ghiChu = txtGhiChu.Text;
            int _idGiaDinh = Convert.ToInt32(txtGiaDinh.Text);
            int _idTaiKhoan = Convert.ToInt32(txtTaiKhoan.Text);
            int _idThongTinTotNghiep = Convert.ToInt32(txtTotNghiep.Text);

            if (CheckDataInput(_email, _hoTen, _dienThoai, _chungMinhNhanDan, _maSoSinhVien, _noiSinh, _diaChiThuongTru, _danToc, _tonGiao))
            {
                AddStudent(_hoTen, maSoSinhVien, _gioiTinh, _ngaySinh, _noiSinh, _diaChiThuongTru, _danToc, _tonGiao, chungMinhNhanDan, _ngayCap, _ngayVaoDoan, _ngayVaoDang, dienThoai, _email, _idGiaDinh, _idTaiKhoan, _idThongTinTotNghiep, _ghiChu);
            }

        }

        private void BtnCapNhatSinhVien_Click(object sender, RoutedEventArgs e)
        {
            int _idsinhvien = 0;
            DataRowView _rowCurrent = dtgStudent.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idsinhvien = Convert.ToInt32(_rowCurrent["IDSinhVien"].ToString());
            }
            
            string _hoTen = txtHoTen.Text;
            string _gioiTinh = "";

            if (cbbGioiTinh.SelectedIndex == 0)
            {
                _gioiTinh = "Nam";
            }
            else if (cbbGioiTinh.SelectedIndex == 1)
            {
                _gioiTinh = "Nữ";
            }

            // datatype? allow null
            DateTime? _ngaySinh = dateNgaySinh.SelectedDate;
            string _noiSinh = txtNoiSinh.Text;
            string _diaChiThuongTru = txtDiaChi.Text;
            string _danToc = txtDanToc.Text;
            string _tonGiao = txtTonGiao.Text;

            string _chungMinhNhanDan = txtCMND.Text;
            int chungMinhNhanDan = Convert.ToInt32(txtCMND.Text);

            string _maSoSinhVien = txtMSSV.Text;
            int maSoSinhVien = Convert.ToInt32(_maSoSinhVien);

            DateTime? _ngayCap = dateNgayCap.SelectedDate;
            DateTime? _ngayVaoDoan = dateNgayVaoDoan.SelectedDate;
            DateTime? _ngayVaoDang = dateNgayVaoDang.SelectedDate;

            string _dienThoai = txtDienThoai.Text;
            string[] _temp = _dienThoai.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);
            int dienThoai = Convert.ToInt32(temp2);

            string _email = txtEmail.Text;
            string _ghiChu = txtGhiChu.Text;
            int _idGiaDinh = Convert.ToInt32(txtGiaDinh.Text);
            int _idTaiKhoan = Convert.ToInt32(txtTaiKhoan.Text);
            int _idThongTinTotNghiep = Convert.ToInt32(txtTotNghiep.Text);

            if (CheckDataInput(_email, _hoTen, _dienThoai, _chungMinhNhanDan, _maSoSinhVien, _noiSinh, _diaChiThuongTru, _danToc, _tonGiao))
            {
                EditStudent(_idsinhvien,_hoTen, maSoSinhVien, _gioiTinh, _ngaySinh, _noiSinh, _diaChiThuongTru, _danToc, _tonGiao, chungMinhNhanDan, _ngayCap, _ngayVaoDoan, _ngayVaoDang, dienThoai, _email, _idGiaDinh, _idTaiKhoan, _idThongTinTotNghiep, _ghiChu);
            }
        }

        private void BtnXoaSinhVien_Click(object sender, RoutedEventArgs e)
        {
            int _idsinhvien=0;
            DataRowView _rowCurrent = dtgStudent.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idsinhvien = Convert.ToInt32(_rowCurrent["IDSinhVien"].ToString());
                    DeleteStudent(_idsinhvien);
                }
            }
        }

        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {
            List<StudentDTO> _ListStudent = new List<StudentDTO>();

            try
            {
                ExcelPackage.LicenseContext = LicenseContext.Commercial; // giấy phép sử dụng thư viện bản thương mại

                var _package = new ExcelPackage(new FileInfo("ImportListStudent.xlsx")); // Mở file Excel

                ExcelWorksheet _sheetCurrent = _package.Workbook.Worksheets[0]; // mở sheet (trang) 1 trong file excel

                // duyệt tuần tự dòng thứ 2 tới dòng cuối của file
                // duyệt file excel tương tự duyệt mảng 2 chiều
                // chỉ số cột trong excel bắt đầu từ 1

                for (int row = _sheetCurrent.Dimension.Start.Row + 1; row <= _sheetCurrent.Dimension.End.Row; row++)
                {
                    try
                    {
                        int col = 1;

                        // lấy ra tên ở vị trí dòng 2 cột 1, col++ sau khi thực hiện câu lệnh tăng cột lên 1 (toán tử hậu tố)

                        string _HoTen = _sheetCurrent.Cells[row, col++].Value.ToString();

                        int _MaSoSinhVien = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());

                        string _GioiTinh = _sheetCurrent.Cells[row, col++].Value.ToString();

                        // tạo biến tạm bằng giá trị trong ô ngày sinh 
                        var NgaySinhTemp = _sheetCurrent.Cells[row, col++].Value;
                        DateTime _NgaySinh = new DateTime();
                        // kiểm tra biến tạm có null hoặc rỗng không
                        if (NgaySinhTemp != null)
                        {
                            try
                            {
                                // nếu thỏa cố gắng ép kiểu nó 
                                _NgaySinh = (DateTime)NgaySinhTemp;
                            }
                            catch (Exception ex)
                            { MessageBox.Show(ex.ToString()); }
                        }

                        string _NoiSinh = _sheetCurrent.Cells[row, col++].Value.ToString();

                        string _DiaChiThuongTru = _sheetCurrent.Cells[row, col++].Value.ToString();

                        string _DanToc = _sheetCurrent.Cells[row, col++].Value.ToString();

                        string _TonGiao = _sheetCurrent.Cells[row, col++].Value.ToString();

                        int _chungMinhNhanDan = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());

                        // tạo biến tạm bằng giá trị trong ô ngày sinh 
                        var NgayCapTemp = _sheetCurrent.Cells[row, col++].Value;
                        DateTime _NgayCap = new DateTime();
                        // kiểm tra biến tạm có null hoặc rỗng không
                        if (NgayCapTemp != null)
                        {
                            try
                            {
                                // nếu thỏa cố gắng ép kiểu nó 
                                _NgayCap = (DateTime)NgayCapTemp;
                            }
                            catch (Exception ex)
                            { MessageBox.Show(ex.ToString()); }
                        }

                        // tạo biến tạm bằng giá trị trong ô ngày sinh 
                        var NgayVaoDoanTemp = _sheetCurrent.Cells[row, col++].Value;
                        DateTime _NgayVaoDoan = new DateTime();
                        // kiểm tra biến tạm có null hoặc rỗng không
                        if (NgayVaoDoanTemp != null)
                        {
                            try
                            {
                                // nếu thỏa cố gắng ép kiểu nó 
                                _NgayVaoDoan = (DateTime)NgayVaoDoanTemp;
                            }
                            catch (Exception ex)
                            { MessageBox.Show(ex.ToString()); }
                        }

                        // tạo biến tạm bằng giá trị trong ô ngày sinh 
                        var NgayVaoDangTemp = _sheetCurrent.Cells[row, col++].Value;
                        DateTime _NgayVaoDang = new DateTime();
                        // kiểm tra biến tạm có null hoặc rỗng không
                        if (NgayVaoDangTemp != null)
                        {
                            try
                            {
                                // nếu thỏa cố gắng ép kiểu nó 
                                _NgayVaoDang = (DateTime)NgayVaoDangTemp;
                            }
                            catch (Exception ex)
                            { MessageBox.Show(ex.ToString()); }
                        }

                        string _dienThoai = _sheetCurrent.Cells[row, col++].Value.ToString();
                        string[] _temp = _dienThoai.Split('-');
                        string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);
                        int _DienThoai = Convert.ToInt32(temp2);


                        string _Email = _sheetCurrent.Cells[row, col++].Value.ToString();
                        string _GhiChu = _sheetCurrent.Cells[row, col++].Value.ToString();
                        int _IDGiaDinh = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                        int _IDTaiKhoan = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                        int _IDThongTinTotNghiep = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());

                        // tạo sinh viên mới với các thuộc tính là các thuộc tính vừa đọc được trong file excel
                        StudentDTO _student = new StudentDTO(_HoTen, _MaSoSinhVien, _GioiTinh, _NgaySinh, _NoiSinh, _DiaChiThuongTru, _DanToc, _TonGiao, _chungMinhNhanDan,
                            _NgayCap,_NgayVaoDoan, _NgayVaoDang, _DienThoai, _Email, _GhiChu, _IDGiaDinh, _IDTaiKhoan, _IDThongTinTotNghiep);

                        // add user mới vào danh sách
                        _ListStudent.Add(_student);

                        AddStudent(_HoTen, _MaSoSinhVien, _GioiTinh, _NgaySinh, _NoiSinh, _DiaChiThuongTru, _DanToc, _TonGiao, _chungMinhNhanDan,
                            _NgayCap, _NgayVaoDoan, _NgayVaoDang, _DienThoai, _Email, _IDGiaDinh, _IDTaiKhoan, _IDThongTinTotNghiep,_GhiChu);
                    }

                    catch (Exception ex) { MessageBox.Show(ex.Message); }
                }

            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }

            dtgStudent.ItemsSource = _ListStudent;
        }
            
        public bool CheckDataInput(string email, string hoten, string sodienthoai, string cmnd, string mssv, string noisinh, string diachi, string dantoc, string tongiao)
        {
            string _patternEmail = @"^[a-zA-Z0-9]{3,20}@[a-zA-Z0-9]{2,10}.[a-zA-Z]{2,3}$";
            string _patternMSSV = @"^[0-9]{7}$";
            string _patternCMND = @"^[0-9]{9}$";
            string _patternChar = @"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" + "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" + "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";
            string _patternSoDienThoai = @"^(01|03|05|07|08|09)+(-)+(\d{4}-\d{4})$";

            Regex _regexEmail = new Regex(_patternEmail);
            Regex _regexChar = new Regex(_patternChar);
            Regex _regexSoDienThoai = new Regex(_patternSoDienThoai);
            Regex _regexMSSV = new Regex(_patternMSSV);
            Regex _regexCMND = new Regex(_patternCMND);

            if (_regexEmail.IsMatch(email) && _regexChar.IsMatch(hoten) && _regexSoDienThoai.IsMatch(sodienthoai) && _regexMSSV.IsMatch(mssv)
            && _regexCMND.IsMatch(cmnd) && _regexChar.IsMatch(noisinh) && _regexChar.IsMatch(diachi) && _regexChar.IsMatch(dantoc) && _regexChar.IsMatch(tongiao))
            {
                return true;
            }
            else
            {
                MessageBox.Show("Dữ Liệu Nhập vào không đúng định dạng");
                return false;
            }

        }

        private void BtnSearchStudent_Click(object sender, RoutedEventArgs e)
        {
            string type = "";
            if (cbbLoaiTimKiem.SelectedIndex == 0)
            {
                type = "HoTen";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 1)
            {
                type = "MaSoSinhVien";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 2)
            {
                type = "GioiTinh";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 3)
            {
                type = "NoiSinh";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 4)
            {
                type = "ChungMinhNhanDan";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 5)
            {
                type = "DienThoai";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 6)
            {
                type = "Email";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 7)
            {
                type = "GhiChu";
            }

            dtgStudent.ItemsSource = SearchStudent(type, txtSearchStudent.Text);
        }
    }
}
