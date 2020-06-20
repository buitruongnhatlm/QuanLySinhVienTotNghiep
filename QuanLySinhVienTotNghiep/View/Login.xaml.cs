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
using Panel = System.Windows.Forms.Panel;
using System.Security.Cryptography;
using System.Drawing;
using Color = System.Drawing.Color;
using System.Drawing.Drawing2D;
using Pen = System.Drawing.Pen;
using Brushes = System.Drawing.Brushes;

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
            CreateCaptcha();
        }

        private void btnDangNhap_Click(object sender, RoutedEventArgs e)
        {
            string _matKhau = txtMatKhau.Password;
            string _taikhoan = txtTaiKhoan.Text;
            if (!string.IsNullOrEmpty(txtRecaptcha.Text))
            {
                if (txtRecaptcha.Text.Equals(txtbCaptcha.Text))
                {
                    if (CheckLogin(_taikhoan, _matKhau))
                    {
                        Home _home = new Home();
                        _home._sender(txtTaiKhoan.Text);
                        _home.Show();
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("Sai tên tài khoản hoặc mật khẩu", "THÔNG BÁO");
                    }
                }
                else
                {
                    MessageBox.Show("Mã xác nhận không chính xác");
                    CreateCaptcha();
                }
            }
            else
            {
                MessageBox.Show("Bạn chưa nhập mã xác nhận");
                CreateCaptcha();
            }
               
        }

        private bool CheckLogin(string taiKhoan, string matKhau)
        {
            return AccountDAL.Instance.Login(taiKhoan,matKhau);
        }

        private void BtnRefesh_Click(object sender, RoutedEventArgs e)
        {
            CreateCaptcha();
        }

        #region TẠO CAPTCHA
        void CreateCaptcha()
        {
            Random _random = new Random();
            int _numberCaptcha = _random.Next(6, 8); // random số lượng captcha từ 6 tới 8 kí tự
            string _stringCaptcha = ""; // chuỗi captcha
            int i = 0; // biến chạy
            do
            {
                int _char = _random.Next(48, 123); // random 1 kí tự trong bảng mã ASCII
                // nếu số đó nằm trong bảng ASCII tương ứng là số, chữ thường hoặc chữ hoa thì...
                if ((_char >= 48 && _char <= 57) || (_char >= 65 && _char <= 90) || (_char >= 97 && _char <= 122)) 
                {
                    _stringCaptcha = _stringCaptcha + (char)_char; // ép số đó sang chữ tương ứng trong ASCII và cộng vào chuỗi captcha
                    i++;
                    if (i == _numberCaptcha) // nếu biến chạy bằng tổng số captcha thì kết thúc
                    {
                        break;
                    }
                }
            } while (true);

            txtbCaptcha.Text = _stringCaptcha;
        }
        #endregion

        private void BtnClosed_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void BtnQuenMatKhau_Click(object sender, RoutedEventArgs e)
        {
            ForgetPassword _window = new ForgetPassword();
            _window.ShowDialog();
        }

    }
}
