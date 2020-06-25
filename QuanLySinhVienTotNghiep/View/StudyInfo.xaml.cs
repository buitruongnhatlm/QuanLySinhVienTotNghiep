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
    /// Interaction logic for StudyInfo.xaml
    /// </summary>
    public partial class StudyInfo : Page
    {
        public StudyInfo()
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

            GridCursor.Margin = new Thickness((240 * index), 30, 0, 0);

            switch (index)
            {
                case 0:
                    FrameTabMain.Content = new GraduatePage();
                    break;
                case 1:
                    FrameTabMain.Content = new NotGraduatePage();
                    break;
                case 2:
                    FrameTabMain.Content = new ClassPage();
                    break;
                case 3:
                    FrameTabMain.Content = new GraduateTypePage();
                    break;
                case 4:
                    FrameTabMain.Content = new CoursePage();
                    break;

            }
        }

    }
}
