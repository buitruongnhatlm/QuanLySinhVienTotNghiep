using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
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
    /// Interaction logic for CoursePage.xaml
    /// </summary>
    public partial class CoursePage : Page
    {
        public CoursePage()
        {
            InitializeComponent();
            LoadDataToGrid();
        }



        private void DtgNganh_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void BtnThemNganh_Click(object sender, RoutedEventArgs e)
        {

        }

        private void BtnCapNhatNganh_Click(object sender, RoutedEventArgs e)
        {

        }

        private void BtnXoaNganh_Click(object sender, RoutedEventArgs e)
        {

        }

        private void DtgKhoa_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtMaKhoa.Text = _dataRow["MaKhoa"].ToString();
                txtTenKhoa.Text = _dataRow["TenKhoa"].ToString();
                txtGhiChuKhoa.Text = _dataRow["GhiChu"].ToString();
            }
        }

        private void BtnThemKhoa_Click(object sender, RoutedEventArgs e)
        {
            int _makhoa = Convert.ToInt32(txtMaKhoa.Text);
            string _tenkhoa = txtTenKhoa.Text;
            string _ghichu = txtGhiChuKhoa.Text;

            AddCourse(_makhoa, _tenkhoa, _ghichu);
            ClearDataTextbox(txtMaKhoa, txtTenKhoa, txtGhiChuKhoa);

        }

        private void BtnCapNhatKhoa_Click(object sender, RoutedEventArgs e)
        {
            int _idkhoa = 0;
            DataRowView _rowCurrent = dtgKhoa.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                _idkhoa = Convert.ToInt32(_rowCurrent["IDKhoa"].ToString());
            }

            int _maKhoa = Convert.ToInt32(txtMaKhoa.Text);
            string _tenkhoa = txtTenKhoa.Text;
            string _ghichu = txtGhiChuKhoa.Text;

            EditCourse(_idkhoa,_maKhoa ,_tenkhoa, _ghichu);
            ClearDataTextbox(txtMaKhoa,txtTenKhoa,txtGhiChuKhoa);
        }

        private void BtnXoaKhoa_Click(object sender, RoutedEventArgs e)
        {
            int _idkhoa = 0;
            DataRowView _rowCurrent = dtgKhoa.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idkhoa = Convert.ToInt32(_rowCurrent["IDKhoa"]);
                    DeleteCourse(_idkhoa);
                    ClearDataTextbox(txtMaKhoa, txtTenKhoa, txtGhiChuKhoa);
                }
            }
        }

        public void LoadDataToCourseGrid()
        {
            dtgKhoa.ItemsSource = CourseDAL.Instance.GetListCourse().DefaultView;
        }

        public void LoadDataToGrid()
        {
            LoadDataToCourseGrid();
        }

        public void ClearDataTextbox(params TextBox[] array)
        {
            foreach (TextBox item in array)
            {
                item.Text = "";
            }
        }

        public void AddCourse(int makhoa, string tenkhoa , string ghichu = null)
        {
            if (CourseDAL.Instance.InsertCourse(makhoa, tenkhoa, ghichu))
            {
                MessageBox.Show("Thêm Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToCourseGrid();
        }

        public void EditCourse(int idkhoa , int makhoa, string tenkhoa, string ghichu = null)
        {
            if (CourseDAL.Instance.UpdateCourse(idkhoa, makhoa, tenkhoa, ghichu))
            {
                MessageBox.Show("Cập Nhật Thành Công");
            }
            else
            {
                MessageBox.Show("Cập Nhật Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToCourseGrid();
        }

        public void DeleteCourse(int idkhoa)
        {
            if (CourseDAL.Instance.DeleteCourse(idkhoa))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadDataToCourseGrid();
        }

    }
}
