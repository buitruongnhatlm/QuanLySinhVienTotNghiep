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

namespace QuanLySinhVienTotNghiep.View
{

    public partial class Home : Window
    {
        public Home()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Sự kiện chuyển tab
        /// </summary>
        /// <param name="index"> tab chuyển tới</param>
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int index = int.Parse(((Button)e.Source).Uid);

            GridCursor.Margin = new Thickness(10 + (150 * index), 0, 0, 0);

            switch (index)
            {
                case 0:
                    FrameTabMain.Content = new StudentPage();
                    break;
                case 1:
                    FrameTabMain.Content = new AccountPage();
                    break;
                case 2:
                    break;
                case 3:
                    break;
                case 4:
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
    }
}
