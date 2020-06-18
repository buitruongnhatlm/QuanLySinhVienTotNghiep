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
    /// Interaction logic for ClassPage.xaml
    /// </summary>
    public partial class ClassPage : Page
    {
        public ClassPage()
        {
            InitializeComponent();
            LoadDataToGrid();
            LoadDataToCombobox();
        }

        private void DtgLop_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtMaLop.Text = _dataRow["MaLop"].ToString();
                txtTenLop.Text = _dataRow["TenLop"].ToString();
                txtSoLuongSinhVien.Text = _dataRow["SoLuongSinhVien"].ToString();
                txtCoVan.Text = _dataRow["CoVan"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                cbbKhoa.Text = _dataRow["TenKhoa"].ToString();
            }
        }

        public void LoadDataToGrid()
        {
            dtgLop.ItemsSource = ClassDAL.Instance.GetListClass().DefaultView;
        }

        public void LoadDataToCombobox()
        {
            cbbKhoa.ItemsSource = CourseDAL.Instance.GetListCourseToCombobox();
            cbbKhoa.DisplayMemberPath = "TenKhoa";
        }

        private void BtnThemLop_Click(object sender, RoutedEventArgs e)
        {
            string _malop = txtMaLop.Text;
            string _tenlop = txtTenLop.Text;
            int _soluongsinhvien = Convert.ToInt32(txtSoLuongSinhVien.Text);
            string _covan = txtCoVan.Text;
            int _idkhoa = cbbKhoa.SelectedIndex + 1;
            string _ghichu = txtGhiChu.Text;

            if (CheckDataInput(_tenlop,_covan,_soluongsinhvien))
            {
                AddClass(_malop,_tenlop,_soluongsinhvien,_covan,_idkhoa, _ghichu);
            }
        }

        public void AddClass(string malop, string tenlop, int soluongsinhvien, string covan, int idkhoa, string ghichu = null)
        {
            if (ClassDAL.Instance.InsertClass(malop,tenlop,soluongsinhvien,covan,idkhoa,ghichu))
            {
                MessageBox.Show("Thêm Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToGrid();
            ClearDataTextbox(txtMaLop,txtTenLop,txtSoLuongSinhVien,txtCoVan,txtGhiChu);
        }

        public void EditClass(int idlop, string malop, string tenlop, int soluongsinhvien, string covan, int idkhoa, string ghichu = null)
        {
            if (ClassDAL.Instance.UpdateClass(idlop, malop, tenlop, soluongsinhvien, covan, idkhoa, ghichu))
            {
                MessageBox.Show("Cập nhật Thành Công");
            }
            else
            {
                MessageBox.Show("Cập nhật Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToGrid();
            ClearDataTextbox(txtMaLop, txtTenLop, txtSoLuongSinhVien, txtCoVan, txtGhiChu);
        }

        public void DeleteClass(int idlop)
        {
            if (ClassDAL.Instance.DeleteClass(idlop))
            {
                MessageBox.Show("Xóa Thành Công");
            }
            else
            {
                MessageBox.Show("Xóa Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToGrid();
            ClearDataTextbox(txtMaLop, txtTenLop, txtSoLuongSinhVien, txtCoVan, txtGhiChu);
        }

        public bool CheckDataInput(string tenlop, string covan, int soluongsinhvien)
        {
            string _patternChar = @"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" + "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" + "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";

            Regex _regexChar = new Regex(_patternChar);

            if (_regexChar.IsMatch(tenlop) && _regexChar.IsMatch(covan))
            {
                if(soluongsinhvien >= 5 && soluongsinhvien <= 300)
                {
                    return true;
                }
                else
                {
                    MessageBox.Show(" Số lượng sinh viên của lớp phải từ 5 đến 300 ");
                    return false;
                }

            }
            else
            {
                MessageBox.Show("Dữ Liệu Nhập vào không đúng định dạng");
                return false;
            }

        }

        private void BtnCapNhat_Click(object sender, RoutedEventArgs e)
        {
            int _idlop = 0;
            DataRowView _rowCurrent = dtgLop.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idlop = Convert.ToInt32(_rowCurrent["IDLop"].ToString());
            }

            string _malop = txtMaLop.Text;
            string _tenlop = txtTenLop.Text;
            int _soluongsinhvien = Convert.ToInt32(txtSoLuongSinhVien.Text);
            string _covan = txtCoVan.Text;
            string _ghichu = txtGhiChu.Text;
            int _idkhoa = cbbKhoa.SelectedIndex + 1;

            if (CheckDataInput(_tenlop,_covan,_soluongsinhvien))
            {
                EditClass(_idlop,_malop,_tenlop,_soluongsinhvien,_covan,_idkhoa,_ghichu);
            }
        }

        private void BtnXoa_Click(object sender, RoutedEventArgs e)
        {
            int _idlop = 0;
            DataRowView _rowCurrent = dtgLop.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idlop = Convert.ToInt32(_rowCurrent["IDLop"].ToString());
                    DeleteClass(_idlop);
                }
            }
        }

        public void ClearDataTextbox(params TextBox[] array)
        {
            foreach (TextBox item in array)
            {
                item.Text = "";
            }
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            string type = "";
            if (cbbLoaiTimKiem.SelectedIndex == 0)
            {
                type = "MaLop";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 1)
            {
                type = "TenLop";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 2)
            {
                type = "CoVan";
            }
            else if (cbbLoaiTimKiem.SelectedIndex == 3)
            {
                type = "GhiChu";
            }

            dtgLop.ItemsSource = SearchClass(type, txtSearch.Text);
        }

        public List<ClassDTO> SearchClass(string type, string content)
        {
            List<ClassDTO> _list = ClassDAL.Instance.SearchClass(type, content);
            return _list;
        }

    }
}
