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
using System.Windows.Shapes;
using MaterialDesignThemes.Wpf;
using DAL;
using DTO;


namespace QuanLySinhVienTotNghiep.View
{

    public partial class Home : Window
    {
        public delegate void SendMessage(string message);
        public SendMessage _sender;

        public Home()
        {
            InitializeComponent();
            _sender = new SendMessage(GetMessage);
        }

        /// <summary>
        /// Sự kiện chuyển tab
        /// </summary>
        /// <param name="index"> tab chuyển tới</param>
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int index = int.Parse(((Button)e.Source).Uid);

            GridCursor.Margin = new Thickness(10 + (230 * index), 0, 0, 0);

            switch (index)
            {
                case 0:
                    FrameTabMain.Content = new StudentInfo();
                    break;
                case 1:
                    FrameTabMain.Content = new StudyInfo();
                    break;
                case 2:
                    FrameTabMain.Content = new AccountPage();
                    break;
                case 3:
                    FrameTabMain.Content = new ManagerPage();
                    break;
            }
        }

        /// <summary>
        /// Sự kiện người dùng log out
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ButtonPopupLogout_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Are you sure Log Out?", "Remind", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                Login main = new Login();
                main.Show();
                this.Close();
            }
            
        }

        private void BtnClosed_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Are you sure Exit?", "Remind", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                Application.Current.Shutdown();
            }
        }

        private void GetMessage(string message)
        {
            txtbUser.Text = message;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            int idloaitaikhoan = AccountDAL.Instance.GetAccountType();
            if(idloaitaikhoan==2)
            {
                btnQUANLYVIEN.Visibility = Visibility.Hidden;
            }
            else if(idloaitaikhoan==3)
            {
                btnTAIKHOAN.Visibility = Visibility.Hidden;
                btnHOCVU.Visibility = Visibility.Hidden;
                btnQUANLYVIEN.Visibility = Visibility.Hidden;
            }
        }
    }
}
