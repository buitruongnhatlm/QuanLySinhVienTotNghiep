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
    /// <summary>
    /// Interaction logic for FamilyPage.xaml
    /// </summary>
    public partial class FamilyPage : Page
    {
        public FamilyPage()
        {
            InitializeComponent();
            LoadData();
        }

        private void ThemGiaDinh_Click(object sender, RoutedEventArgs e)
        {
            string _hoTenCha = txtHoTenCha.Text;
            string _hoTenMe = txtHoTenMe.Text;

            // datatype? allow null
            DateTime? _namSinhCha = dtNamSinhCha.SelectedDate;
            DateTime? _namSinhMe = dtNamSinhMe.SelectedDate;

            string _diaChi = txtDiaChi.Text;
            string _ghiChu = txtGhiChu.Text;

            string _dienThoaiCha = txtDienThoaiCha.Text;
            string[] _temp = _dienThoaiCha.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);
            int dienThoaiCha = Convert.ToInt32(temp2);

            string _dienThoaiMe = txtDienThoaiMe.Text;
            string[] _temp3 = _dienThoaiMe.Split('-');
            string temp4 = string.Concat(_temp3[0], _temp3[1], _temp3[2]);
            int dienThoaiMe = Convert.ToInt32(temp4);

            if (CheckDataInput(_hoTenCha, _dienThoaiCha, _hoTenMe, _dienThoaiMe,_diaChi))
            {
                AddFamily(_hoTenCha,_namSinhCha,dienThoaiCha,_hoTenMe,_namSinhMe,dienThoaiMe, _diaChi, _ghiChu);
            }
        }

        private void CapNhat_Click(object sender, RoutedEventArgs e)
        {
            int _idgiadinh = 0;
            DataRowView _rowCurrent = dtgFamily.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                _idgiadinh = Convert.ToInt32(_rowCurrent["IDGiaDinh"].ToString());
            }

            string _hoTenCha = txtHoTenCha.Text;
            string _hoTenMe = txtHoTenMe.Text;

            // datatype? allow null
            DateTime? _namSinhCha = dtNamSinhCha.SelectedDate;
            DateTime? _namSinhMe = dtNamSinhMe.SelectedDate;

            string _diaChi = txtDiaChi.Text;
            string _ghiChu = txtGhiChu.Text;

            string _dienThoaiCha = txtDienThoaiCha.Text;
            string[] _temp = _dienThoaiCha.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);
            int dienThoaiCha = Convert.ToInt32(temp2);

            string _dienThoaiMe = txtDienThoaiMe.Text;
            string[] _temp3 = _dienThoaiMe.Split('-');
            string temp4 = string.Concat(_temp3[0], _temp3[1], _temp3[2]);
            int dienThoaiMe = Convert.ToInt32(temp4);

            if (CheckDataInput(_hoTenCha, _dienThoaiCha, _hoTenMe, _dienThoaiMe, _diaChi))
            {
                EditFamily(_idgiadinh,_hoTenCha, _namSinhCha, dienThoaiCha, _hoTenMe, _namSinhMe, dienThoaiMe, _diaChi, _ghiChu);
            }
        }

        private void XoaGiaDinh_Click(object sender, RoutedEventArgs e)
        {
            int _idgiadinh = 0;
            DataRowView _rowCurrent = dtgFamily.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idgiadinh = Convert.ToInt32(_rowCurrent["IDGiaDinh"].ToString());
                    DeleteFamily(_idgiadinh);
                }
            }
        }

        public void AddFamily(string hotencha, DateTime? namsinhcha, int dienthoaicha, string hotenme, DateTime? namsinhme, int dienthoaime, string diachi, string ghichu=null)
        {
            if(FamilyDAL.Instance.InsertFamily(hotencha,namsinhcha,dienthoaicha,hotenme,namsinhme,dienthoaime,diachi,ghichu))
            {
                MessageBox.Show("Thêm Thông Tin Gia Đình Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Sinh Viên Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void EditFamily(int idgiadinh, string hotencha, DateTime? namsinhcha, int dienthoaicha, string hotenme, DateTime? namsinhme, int dienthoaime, string diachi, string ghichu = null)
        {
            if (FamilyDAL.Instance.UpdateFamily(idgiadinh, hotencha, namsinhcha, dienthoaicha, hotenme, namsinhme, dienthoaime, diachi, ghichu))
            {
                MessageBox.Show("Cập Nhật Thông Tin Gia Đình Thành Công");
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void DeleteFamily(int idgiadinh)
        {
            if (FamilyDAL.Instance.DeleteFamily(idgiadinh))
            {
                MessageBox.Show("Xóa Thông Tin Gia Đình Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadData();

        }

        public void LoadData()
        {
            dtgFamily.ItemsSource = FamilyDAL.Instance.GetListFamily().DefaultView;
        }

        public bool CheckDataInput(string hotencha, string dienthoaicha, string hotenme, string dienthoaime, string diachi)
        {
            string _patternChar = @"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" + "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" + "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";
            string _patternSoDienThoai = @"^(01|03|05|07|08|09)+(-)+(\d{4}-\d{4})$";

            Regex _regexChar = new Regex(_patternChar);
            Regex _regexSoDienThoai = new Regex(_patternSoDienThoai);

            if (_regexChar.IsMatch(hotencha) && _regexSoDienThoai.IsMatch(dienthoaicha) && _regexChar.IsMatch(hotenme) && _regexSoDienThoai.IsMatch(dienthoaime) && _regexChar.IsMatch(diachi))
            {
                return true;
            }
            else
            {
                MessageBox.Show("Dữ Liệu Nhập vào không đúng định dạng");
                return false;
            }

        }

        private void DtgFamily_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtHoTenCha.Text = _dataRow["HoTenCha"].ToString();
                txtDienThoaiCha.Text = _dataRow["DienThoaiCha"].ToString();
                dtNamSinhCha.Text = _dataRow["NamSinhCha"].ToString();
                txtHoTenMe.Text = _dataRow["HoTenMe"].ToString();
                txtDienThoaiMe.Text = _dataRow["DienThoaiMe"].ToString();
                dtNamSinhMe.Text = _dataRow["NamSinhMe"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                txtDiaChi.Text = _dataRow["DiaChi"].ToString();
            }
        }

        public List<FamilyDTO> SearchFamily(string type, string content)
        {
            List<FamilyDTO> _listFamily = FamilyDAL.Instance.SearchFamily(type, content);
            return _listFamily;
        }

        private void BtnSearchFamily_Click(object sender, RoutedEventArgs e)
        {
            string type = "";
            if (cbbLoaiTimKiem.SelectedIndex == 0)
            {
                type = "HoTenCha";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 1)
            {
                type = "DienThoaiCha";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 2)
            {
                type = "HoTenMe";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 3)
            {
                type = "DienThoaiMe";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 4)
            {
                type = "DiaChi";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 5)
            {
                type = "GhiChu";
            }

            dtgFamily.ItemsSource = SearchFamily(type, txtSearchFamily.Text);
        }
    }
}
