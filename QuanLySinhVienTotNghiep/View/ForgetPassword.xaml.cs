using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using DAL;
using DTO;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for ForgetPassword.xaml
    /// </summary>
    public partial class ForgetPassword : Window
    {
        public ForgetPassword()
        {
            InitializeComponent();
        }

        private void BtnXacNhan_Click(object sender, RoutedEventArgs e)
        {
            string _tentaikhoan = txtTaiKhoan.Text;

            if (_tentaikhoan == "" || PasswordDAL.Instance.ResetPassword(_tentaikhoan) == false)
            {
                MessageBox.Show("Tài khoản không tồn tại trong hệ thống\n Vui lòng kiểm tra lại", "Thông Báo", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            else
            {
                ResetPassword(_tentaikhoan);

                string _Email = (PasswordDAL.Instance.GetMailByUser(_tentaikhoan) as PasswordDTO).Email;

                Thread threa1 = new Thread(() =>
                {
                    SendMail(_Email, _tentaikhoan);
                });

                threa1.Start();

            }
        }

        void ResetPassword(string tentaikhoan)
        {
            PasswordDAL.Instance.ResetPassword(tentaikhoan);
        }

        void SendMail(string to, string user)
        {
            try
            {

                string _From = "buitruongnhut@gmail.com";
                string _Subject = "Xin Chào " + to + " Chúng Tôi Từ Phần Mềm Quản Lý Sinh Viên, Trường Đại Học KTCN Cần Thơ Cấp Lại Mật Khẩu Cho Bạn";
                string _Mess = "Mật Khẩu Mặc Định Cho Tài Khoản: " + user + " Là: 123 Bạn Có Thể Thay Đổi Mật Khẩu Trong Mục Thông Tin Cá Nhân Hoặc Liên Hệ Quản Lý Phần Mềm Để Được Hỗ Trợ";

                MailMessage _message = new MailMessage(_From, to, _Subject, _Mess);

                SmtpClient _client = new SmtpClient("smtp.gmail.com", 587);

                _client.EnableSsl = true;

                _client.Credentials = new NetworkCredential("buitruongnhut@gmail.com", "23190203992nN");

                _client.Send(_message);

                MessageBox.Show("Đã gửi mật khẩu mặt định vào Mail. Vui lòng kiểm tra\n Bạn có thể dùng mật khẩu đó đăng nhập lại");

            }

            catch { }

        }

        private void BtnClosed_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
