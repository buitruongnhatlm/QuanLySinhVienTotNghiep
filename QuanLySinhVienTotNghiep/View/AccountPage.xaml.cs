using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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
            LoadData();

        }

        private void BtnThemTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            string _email = txtEmail.Text;
            string _tenTenKhoan = txtTenTaiKhoan.Text;
            string _matKhau = pwbMatKhau.Password;
            string _soDienThoai =txtDienThoai.Text;

            string[] _temp = _soDienThoai.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);

            int sodienthoai = Convert.ToInt32(temp2);
            string _ghiChu = txtGhiChu.Text;
            int _idLoaiTaiKhoan=0;
            if (cbbLoaiTaiKhoan.SelectedIndex == 0)
            {
                _idLoaiTaiKhoan = 1;
            }
            else if (cbbLoaiTaiKhoan.SelectedIndex == 1)
            {
                _idLoaiTaiKhoan = 2;
            }
            else if (cbbLoaiTaiKhoan.SelectedIndex == 2)
            {
                _idLoaiTaiKhoan = 3;
            }

            if (CheckDataInput(_email,_tenTenKhoan,_matKhau,_soDienThoai))
            {
               AddAccount(_tenTenKhoan, _matKhau, _email, sodienthoai,_idLoaiTaiKhoan, _ghiChu);
            }

        }

        private void BtnSuaTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            string _email = txtEmail.Text;
            string _matKhau = pwbMatKhau.Password;
            string _soDienThoai = txtDienThoai.Text;
            string _tenTenKhoan="";

            DataRowView _rowCurrent = dtgAccount.SelectedItem as DataRowView;
            if(_rowCurrent!=null)
            {
                _tenTenKhoan = _rowCurrent["TenTaiKhoan"].ToString();
            }

            string[] _temp = _soDienThoai.Split('-');
            string temp2 = string.Concat(_temp[0], _temp[1], _temp[2]);

            int sodienthoai = Convert.ToInt32(temp2);
            string _ghiChu = txtGhiChu.Text;
            int _idLoaiTaiKhoan = 0;
            if (cbbLoaiTaiKhoan.SelectedIndex == 0)
            {
                _idLoaiTaiKhoan = 1;
            }
            else if (cbbLoaiTaiKhoan.SelectedIndex == 1)
            {
                _idLoaiTaiKhoan = 2;
            }
            else if (cbbLoaiTaiKhoan.SelectedIndex == 2)
            {
                _idLoaiTaiKhoan = 3;
            }

            string _patternEmail = "^[a-zA-Z0-9]{3,20}@[a-zA-Z0-9]{2,10}.[a-zA-Z]{2,3}$";
            string _patternSoDienThoai = @"^(01|03|05|07|08|09)+(-)+(\d{4}-\d{4})$";

            Regex _regexEmail = new Regex(_patternEmail);
            Regex _regexSoDienThoai = new Regex(_patternSoDienThoai);

            if (!_regexEmail.IsMatch(_email) )
            {
                MessageBox.Show("email không hợp lệ");
            }
            else if(!_regexSoDienThoai.IsMatch(_soDienThoai))
            {
                MessageBox.Show("Số điện thoại không hợp lệ");
            }
            else
            {
                EditAccount(_tenTenKhoan, _email, sodienthoai, _idLoaiTaiKhoan, _ghiChu);
            }
            
        }

        private void BtnXoaTaiKhoan_Click(object sender, RoutedEventArgs e)
        {
            string _tenTenKhoan = "";
            DataRowView _rowCurrent = dtgAccount.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if(MessageBox.Show("Are you sure Delete?", "Delete Confirmation",MessageBoxButton.YesNo)==MessageBoxResult.Yes)
                {
                    _tenTenKhoan = _rowCurrent["TenTaiKhoan"].ToString();
                    DeleteAccount(_tenTenKhoan);
                }
            }
        }

        public void LoadData()
        {
            dtgAccount.ItemsSource = AccountDAL.Instance.GetListAccount().DefaultView;
        }

        private void DtgAccount_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow!=null)
            {
                txtTenTaiKhoan.Text = _dataRow["TenTaiKhoan"].ToString();
                pwbMatKhau.Password = _dataRow["MatKhau"].ToString();
                txtEmail.Text = _dataRow["Email"].ToString();
                txtDienThoai.Text = _dataRow["SoDienThoai"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                switch (Convert.ToInt32(_dataRow["IDLoaiTaiKhoan"]))
                {
                    case 1:
                        cbbLoaiTaiKhoan.SelectedIndex = 0;
                        break;
                    case 2:
                        cbbLoaiTaiKhoan.SelectedIndex = 1;
                        break;
                    case 3:
                        cbbLoaiTaiKhoan.SelectedIndex = 2;
                        break;

                }

            }

        }

        public bool CheckDataInput(string email, string tentaikhoan, string matkhau, string sodienthoai)
        {
            string _patternEmail = "^[a-zA-Z0-9]{3,20}@[a-zA-Z0-9]{2,10}.[a-zA-Z]{2,3}$";
            string _patternTenTaiKhoan = @"^[a-zA-Z0-9_]{5,24}$";
            string _patternSoDienThoai = @"^(01|03|05|07|08|09)+(-)+(\d{4}-\d{4})$";

            Regex _regexEmail = new Regex(_patternEmail);
            Regex _regexTenTaiKhoan = new Regex(_patternTenTaiKhoan);
            Regex _regexSoDienThoai = new Regex(_patternSoDienThoai);

            if (_regexEmail.IsMatch(email) && _regexTenTaiKhoan.IsMatch(tentaikhoan) && ValidatePassword(matkhau) && _regexSoDienThoai.IsMatch(sodienthoai))
            {
                return true;
            }
            else
            {
                MessageBox.Show("Lỗi");
                return false;
            }
            
        }

        public void AddAccount(string tentaikhoan, string matkhau, string email, int sodienthoai, int idloaitaikhoan, string ghichu=null)
        {
            if (AccountDAL.Instance.InsertAccount(tentaikhoan, matkhau, email, sodienthoai, idloaitaikhoan, ghichu))
            {
                MessageBox.Show("Thêm Tài Khoản Thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Thêm Tài Khoản Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();

        }

        public void EditAccount(string tentaikhoan, string email, int sodienthoai, int idloaitaikhoan, string ghichu=null)
        {
            if (AccountDAL.Instance.UpdateAccount(tentaikhoan, email, sodienthoai, idloaitaikhoan, ghichu))
            {
                MessageBox.Show("Cập nhật thông tin tài khoản thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Đã xảy ra lỗi\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void DeleteAccount(string tentaikhoan)
        {
            if(AccountDAL.Instance.DeleteAccount(tentaikhoan))
            {
                MessageBox.Show("Xóa Tài Khoản Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadData();

        }

        public List<AccountDTO> SearchAccount(string account)
        {
            List<AccountDTO> _listAccount = AccountDAL.Instance.SearchAccount(account);
            return _listAccount;
        }

         #region KIỂM TRA MẬT KHẨU
        private bool ValidatePassword(string password)
        {

            if (string.IsNullOrWhiteSpace(password))
            {
                MessageBox.Show("Mật khẩu không được chứa khoảng trắng");
            }

            var _patternNumber = new Regex(@"[0-9]+");
            var _patternUpperChar = new Regex(@"[A-Z]+");
            var _patternLowerChar = new Regex(@"[a-z]+");
            var _patternMaxChars = new Regex(@".{8,25}");

            if (!_patternLowerChar.IsMatch(password))
            {
                MessageBox.Show("Mật khẩu phải chứa ít nhất 1 kí tự viết thường");
                return false;
            }
            else if (!_patternUpperChar.IsMatch(password))
            {
                MessageBox.Show("Mật khẩu phải chứa ít nhất 1 kí tự viết hoa");
                return false;
            }
            else if (!_patternMaxChars.IsMatch(password))
            {
                MessageBox.Show("Mật khẩu phải có độ dài từ 8 đến 25 kí tự");
                return false;
            }
            else if (!_patternNumber.IsMatch(password))
            {
                MessageBox.Show("Mật khẩu phải chứa ít nhất 1 kí tự số");
                return false;
            }
            else
            {
                return true;
            }
        }


        #endregion

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
           dtgAccount.ItemsSource = SearchAccount(txtSearchAccount.Text);
        }
    }
}


