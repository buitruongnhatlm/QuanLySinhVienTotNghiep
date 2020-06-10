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
                txtDienThoai.Text = _dataRow["DienThoai"].ToString();
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
            string _gioiTinh="";
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

            if (CheckDataInput(_email,_hoTen,_dienThoai, _chungMinhNhanDan, _maSoSinhVien,_noiSinh,_diaChiThuongTru,_danToc,_tonGiao))
            {
                AddStudent(_hoTen,maSoSinhVien,_gioiTinh,_ngaySinh,_noiSinh,_diaChiThuongTru,_danToc,_tonGiao,chungMinhNhanDan,_ngayCap,_ngayVaoDoan,_ngayVaoDang, dienThoai,_email,_idGiaDinh,_idTaiKhoan,_idThongTinTotNghiep,_ghiChu);
            }

        }

        private void BtnCapNhatSinhVien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void BtnXoaSinhVien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {

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
    }
}
