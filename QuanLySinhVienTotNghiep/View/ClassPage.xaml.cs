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
            MessageBox.Show(cbbKhoa.SelectedIndex.ToString());
        }
    }
}
