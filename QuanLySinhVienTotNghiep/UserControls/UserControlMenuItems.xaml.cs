﻿using System;
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
using QuanLySinhVienTotNghiep.ViewModelHomePage;

namespace QuanLySinhVienTotNghiep.UserControls
{
    /// <summary>
    /// Interaction logic for UserControlMenuItems.xaml
    /// </summary>
    public partial class UserControlMenuItems : UserControl
    {
        MainWindow _context;
        public UserControlMenuItems(ItemMenu itemMenu, MainWindow context)
        {
            InitializeComponent();

            _context = context;
            ExpanderMenu.Visibility = itemMenu.SubItems == null ? Visibility.Collapsed : Visibility.Visible;

        }
    }
}
