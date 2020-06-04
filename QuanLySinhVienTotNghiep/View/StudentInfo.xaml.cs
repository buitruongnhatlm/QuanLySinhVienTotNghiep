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

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for StudentInfo.xaml
    /// </summary>
    public partial class StudentInfo : Page
    {
        public StudentInfo()
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

            switch (index)
            {
                case 0:
                    FrameTabMain.Content = new StudentPage();
                    break;
                case 1:
                    FrameTabMain.Content = new FamilyPage();
                    break;

            }
        }

    }
}
