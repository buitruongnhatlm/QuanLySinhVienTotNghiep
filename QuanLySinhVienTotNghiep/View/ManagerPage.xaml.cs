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
using DAL;
using DTO;

namespace QuanLySinhVienTotNghiep.View
{

    public partial class ManagerPage : Page
    {
        public ManagerPage()
        {
            InitializeComponent();
            LoadData();
            LoadDataToCombobox();
        }

        public void LoadData()
        {
            dtgManager.ItemsSource = ManagerDAL.Instance.GetListManager().DefaultView;
        }

        public void AddManager(string hoten, DateTime? ngaysinh, string gioitinh, int chungminhnhandan, string noisinh,string diachithuongtru, 
                                    string hocham, string trinhdo, string chuyenmon, string donvicongtac, int idtaikhoan, string ghichu = null)
        {
            if (ManagerDAL.Instance.InsertManager(hoten,ngaysinh,gioitinh,chungminhnhandan,noisinh,diachithuongtru,hocham,trinhdo,chuyenmon,donvicongtac,idtaikhoan, ghichu))
            {
                MessageBox.Show("Thêm Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void EditManager(int idquanlyvien,string hoten, DateTime? ngaysinh, string gioitinh, int chungminhnhandan, string noisinh, string diachithuongtru,
                            string hocham, string trinhdo, string chuyenmon, string donvicongtac, int idtaikhoan, string ghichu = null)
        {
            if (ManagerDAL.Instance.UpdateManager(idquanlyvien, hoten, ngaysinh, gioitinh, chungminhnhandan, noisinh, diachithuongtru, hocham, trinhdo, chuyenmon, donvicongtac, idtaikhoan, ghichu))
            {
                MessageBox.Show("Cập Nhật Thành Công");
            }
            else
            {
                MessageBox.Show("Cập Nhật Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void DeleteManager(int idquanlyvien)
        {
            if (ManagerDAL.Instance.DeleteManager(idquanlyvien))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa Không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadData();

        }

        public List<ManagerDTO> SearchManager(string type, string content)
        {
            List<ManagerDTO> _list = ManagerDAL.Instance.SearchManager(type, content);
            return _list;
        }

        private void DtgManager_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtHoTen.Text = _dataRow["HoTen"].ToString();
                dtNgaySinh.Text = _dataRow["NgaySinh"].ToString();

                switch (_dataRow["GioiTinh"].ToString())
                {
                    case "Nam":
                        cbbGioiTinh.SelectedIndex = 0;
                        break;
                    case "Nữ":
                        cbbGioiTinh.SelectedIndex = 1;
                        break;

                }

                txtCMND.Text = _dataRow["ChungMinhNhanDan"].ToString();
                txtNoiSinh.Text = _dataRow["NoiSinh"].ToString();
                txtDiaChi.Text = _dataRow["DiaChiThuongTru"].ToString();
                txtHocHam.Text = _dataRow["HocHam"].ToString();
                txtTrinhDo.Text = _dataRow["TrinhDo"].ToString();
                txtChuyenMon.Text = _dataRow["ChuyenMon"].ToString();
                txtDonViCongTac.Text = _dataRow["DonViCongTac"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                cbbTaiKhoan.Text = _dataRow["TenTaiKhoan"].ToString();
            }
        }

        public bool CheckDataInput(string hoten, string cmnd, string noisinh, string diachi, string hocham, string trinhdo, string chuyenmon, string donvicongtac)
        {
            string _patternCMND = @"^[0-9]{9}$";
            string _patternChar = @"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" + "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" + "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";

            Regex _regexChar = new Regex(_patternChar);
            Regex _regexCMND = new Regex(_patternCMND);

                if (_regexChar.IsMatch(hoten) && _regexCMND.IsMatch(cmnd) && _regexChar.IsMatch(noisinh) && _regexChar.IsMatch(diachi) &&
                    _regexChar.IsMatch(hocham) && _regexChar.IsMatch(trinhdo) && _regexChar.IsMatch(chuyenmon) && _regexChar.IsMatch(donvicongtac))
                {
                    return true;
                }
                else
                {
                    MessageBox.Show("Dữ Liệu Nhập vào không đúng định dạng","Thông Báo");
                    return false;
                }

        }

        private void BtnThemQuanLy_Click(object sender, RoutedEventArgs e)
        {
            string _hoTen = txtHoTen.Text;

            string _tentaikhoan = cbbTaiKhoan.Text;

            int _idtaikhoan = AccountDAL.Instance.GetIDAccountByUsername(_tentaikhoan);

            // datatype? allow null
            DateTime? _namSinh = dtNgaySinh.SelectedDate;

            string _diaChi = txtDiaChi.Text;
           
            string _ghiChu = txtGhiChu.Text;

            string _gioiTinh = "";

            if (cbbGioiTinh.SelectedIndex == 0)
            {
                _gioiTinh = "Nam";
            }
            else if (cbbGioiTinh.SelectedIndex == 1)
            {
                _gioiTinh = "Nữ";
            }

            string _hocHam = txtHocHam.Text;
            string _diaChiThuongTru = txtDiaChi.Text;

            string _chungMinhNhanDan = txtCMND.Text;
            int chungMinhNhanDan = Convert.ToInt32(txtCMND.Text);

            string _noiSinh = txtNoiSinh.Text;
            string _trinhDo = txtTrinhDo.Text;
            string _chuyenMon = txtChuyenMon.Text;
            string _donViCongTac = txtDonViCongTac.Text;

            if (CheckDataInput(_hoTen, _chungMinhNhanDan, _noiSinh, _diaChiThuongTru,_hocHam,_trinhDo,_chuyenMon,_donViCongTac))
            {
                AddManager(_hoTen, _namSinh, _gioiTinh, chungMinhNhanDan, _noiSinh, _diaChiThuongTru,_hocHam,_trinhDo,_chuyenMon,_donViCongTac, _idtaikhoan, _ghiChu);
            }
        }

        private void BtnCapNhat_Click(object sender, RoutedEventArgs e)
        {
            int _idquanlyvien = 0;
            DataRowView _rowCurrent = dtgManager.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idquanlyvien = Convert.ToInt32(_rowCurrent["IDQuanLyVien"].ToString());
            }

            string _tentaikhoan = cbbTaiKhoan.Text;

            int _idtaikhoan = AccountDAL.Instance.GetIDAccountByUsername(_tentaikhoan);

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
            DateTime? _ngaySinh = dtNgaySinh.SelectedDate;
            string _noiSinh = txtNoiSinh.Text;
            string _diaChiThuongTru = txtDiaChi.Text;
            string _hocHam = txtHocHam.Text;
            string _trinhDo = txtTrinhDo.Text;

            string _chungMinhNhanDan = txtCMND.Text;
            int chungMinhNhanDan = Convert.ToInt32(txtCMND.Text);

            string _chuyenMon = txtChuyenMon.Text;
            string _ghiChu = txtGhiChu.Text;
            string _donViCongTac = txtDonViCongTac.Text;

            if (CheckDataInput(_hoTen, _chungMinhNhanDan, _noiSinh, _diaChiThuongTru, _hocHam,_trinhDo,_chuyenMon,_donViCongTac))
            {
                EditManager(_idquanlyvien, _hoTen, _ngaySinh, _gioiTinh,chungMinhNhanDan, _noiSinh, _diaChiThuongTru, _hocHam, _trinhDo, _chuyenMon, _donViCongTac, _idtaikhoan, _ghiChu);
            }
        }

        private void BtnXoaQuanLy_Click(object sender, RoutedEventArgs e)
        {
            int _idQuanLyVien = 0;
            DataRowView _rowCurrent = dtgManager.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idQuanLyVien = Convert.ToInt32(_rowCurrent["IDQuanLyVien"].ToString());
                    DeleteManager(_idQuanLyVien);
                }
            }
        }

        private void BtnSearchManager_Click(object sender, RoutedEventArgs e)
        {
            string type = "";
            if (cbbLoaiTimKiem.SelectedIndex == 0)
            {
                type = "HoTen";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 1)
            {
                type = "GioiTinh";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 2)
            {
                type = "ChungMinhNhanDan";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 3)
            {
                type = "TaiKhoan";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 4)
            {
                type = "GhiChu";
            }

            dtgManager.ItemsSource = SearchManager(type, txtSearchManager.Text);
        }

        public void LoadDataToCombobox()
        {
            cbbTaiKhoan.ItemsSource = AccountDAL.Instance.GetListAccountToCombobox();
            cbbTaiKhoan.DisplayMemberPath = "TenTaiKhoan";
        }
    }
}
