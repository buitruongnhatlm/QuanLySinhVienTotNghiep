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
using QuanLySinhVienTotNghiep.ViewModelHomePage;
using QuanLySinhVienTotNghiep;
using MaterialDesignThemes.Wpf;

namespace QuanLySinhVienTotNghiep
{

    public partial class HomePage : Window
    {
        public HomePage()
        {
            InitializeComponent();

            var _menuSinhVien = new List<SubItem>();
            _menuSinhVien.Add(new SubItem("Tra Cứu Thông Tin", new UserControlInfoStudent()));
            _menuSinhVien.Add(new SubItem("Thêm Sinh Viên", new UserControlUpdateStudent()));
            _menuSinhVien.Add(new SubItem("Cập Nhật Sinh Viên"));
            _menuSinhVien.Add(new SubItem("Xóa Sinh Viên"));
            var _item1 = new ItemMenu("Sinh Viên", _menuSinhVien, PackIconKind.School);

            var _menuQuanLyVien = new List<SubItem>();
            _menuQuanLyVien.Add(new SubItem("Tra Cứu Thông Tin"));
            _menuQuanLyVien.Add(new SubItem("Thêm Quản Lý Viên"));
            _menuQuanLyVien.Add(new SubItem("Cập Nhật Quản Lý Viên"));
            _menuQuanLyVien.Add(new SubItem("Xóa Quản Lý Viên"));
            var _item2 = new ItemMenu("Quản Lý Viên", _menuQuanLyVien, PackIconKind.Teacher);

            var _menuTaiKhoan = new List<SubItem>();
            _menuTaiKhoan.Add(new SubItem("Tra Cứu Thông Tin"));
            _menuTaiKhoan.Add(new SubItem("Thêm Tài Khoản"));
            _menuTaiKhoan.Add(new SubItem("Cập Nhật Tài Khoản"));
            _menuTaiKhoan.Add(new SubItem("Xóa Tài Khoản"));
            var _item3 = new ItemMenu("Tài Khoản", _menuTaiKhoan, PackIconKind.Account);

            var _menuBaoCao = new List<SubItem>();
            _menuBaoCao.Add(new SubItem("Tạo Báo Cáo"));
            _menuBaoCao.Add(new SubItem("Danh Sách Báo Cáo"));
            var _item4 = new ItemMenu("Báo Cáo", _menuBaoCao, PackIconKind.Report);

            var _menuThongKe = new List<SubItem>();
            _menuThongKe.Add(new SubItem("Xem Thống Kê"));
            _menuThongKe.Add(new SubItem("Tùy Chỉnh"));
            var _item5 = new ItemMenu("Thống Kê", _menuThongKe, PackIconKind.Library);

            var _menuIn = new List<SubItem>();
            _menuIn.Add(new SubItem("In Thông Tin Cá Nhân Sinh Viên"));
            _menuIn.Add(new SubItem("In Danh Sách Sinh Viên"));
            _menuIn.Add(new SubItem("In Thông Tin Cá Nhân Quản Trị Viên"));
            _menuIn.Add(new SubItem("In Danh Sách Quản Trị Viên"));
            _menuIn.Add(new SubItem("In Danh Mục Khác"));
            var _item6 = new ItemMenu("In", _menuIn, PackIconKind.Printer);

            var _menuXuatFile = new List<SubItem>();
            _menuXuatFile.Add(new SubItem("Xuất Danh Sách Sinh Viên"));
            _menuXuatFile.Add(new SubItem("Xuất Danh Sách Quản Trị Viên"));
            _menuXuatFile.Add(new SubItem("Xuất Danh Mục Khác"));
            var _item7 = new ItemMenu("Xuất File Excel", _menuXuatFile, PackIconKind.MicrosoftExcel);


            var _menuCaiDat = new List<SubItem>();
            _menuCaiDat.Add(new SubItem("Cài Đặt Hệ Thống"));
            _menuCaiDat.Add(new SubItem("Sao Lưu Dữ Liệu"));
            _menuCaiDat.Add(new SubItem("Cài Đặt Bảo Mật"));
            var _item8 = new ItemMenu("Cài Đặt", _menuCaiDat, PackIconKind.Settings);

            Menu.Children.Add(new UserControlMenuItem(_item1,this));
            Menu.Children.Add(new UserControlMenuItem(_item2, this));
            Menu.Children.Add(new UserControlMenuItem(_item4, this));
            Menu.Children.Add(new UserControlMenuItem(_item5, this));
            Menu.Children.Add(new UserControlMenuItem(_item6, this));
            Menu.Children.Add(new UserControlMenuItem(_item7, this));
            Menu.Children.Add(new UserControlMenuItem(_item3, this));
            Menu.Children.Add(new UserControlMenuItem(_item8, this));

        }

        internal void SwitchScreen(object sender)
        {
            var screen = ((UserControl)sender);

            if (screen != null)
            {
                StackPanelMain.Children.Clear();
                StackPanelMain.Children.Add(screen);
            }
        }
    }
}
