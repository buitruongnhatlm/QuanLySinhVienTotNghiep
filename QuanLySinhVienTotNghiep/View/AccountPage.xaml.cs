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
        }

        private void BtnThemTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            FillDataGrid();
        }

        private void FillDataGrid()

        {
            string _query = "SELECT IDTaikhoan, TenTaiKhoan, MatKhau, Email, SoDienThoai, GhiChu, IDLoaiTaiKhoan FROM dbo.TaiKhoan";

            DataProvider _provider = new DataProvider();

            dtgAccount.ItemsSource = _provider.ExcuteQuery(_query).DefaultView;

        }

    }
}


