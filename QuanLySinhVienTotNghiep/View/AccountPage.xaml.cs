using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for AccountPage.xaml
    /// </summary>
    public partial class AccountPage : Page
    {
        public AccountPage()
        {
            InitializeComponent();
            LoadData();
            
        }

        private void BtnThemTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
          
        }

        public void LoadData()
        {
            dtgAccount.ItemsSource = AccountDAL.Instance.GetListAccount().DefaultView;
        }

        private void DtgAccount_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null)
            {
                txtTenTaiKhoan.Text = _dataRow["TenTaiKhoan"].ToString();
                pwbMatKhau.Password = _dataRow["MatKhau"].ToString();
                txtEmail.Text = _dataRow["Email"].ToString();
                txtDienThoai.Text = _dataRow["SoDienThoai"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                switch (Convert.ToInt32(_dataRow["IDLoaiTaiKhoan"]))
                {
                    case 1:
                        cbbLoaiTaiKhoan.SelectedIndex = 0;
                        break;
                    case 2:
                        cbbLoaiTaiKhoan.SelectedIndex = 1;
                        break;
                    case 3:
                        cbbLoaiTaiKhoan.SelectedIndex = 2;
                        break;

                }

            }

        }
    }
}


