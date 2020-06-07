using System;
using System.Collections.Generic;
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
using DTO;
using DAL;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, RoutedEventArgs e)
        {
            string _taiKhoan = txtTaiKhoan.Text;
            string _matKhau = txtMatKhau.Password;
            if (CheckLogin(_taiKhoan,_matKhau))
            {
                Home _page = new Home();
                _page.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu", "THÔNG BÁO", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        private bool CheckLogin(string taiKhoan, string matKhau)
        {
            return AccountDAL.Instance.Login(taiKhoan,matKhau);
        }
    }
}
