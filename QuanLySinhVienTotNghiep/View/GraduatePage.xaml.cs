using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
using DAL;
using DTO;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for GraduatePage.xaml
    /// </summary>
    public partial class GraduatePage : Page
    {
        public GraduatePage()
        {
            InitializeComponent();
            LoadDataToCombobox();
            LoadDataToGrid();
        }

        private void DtgGraduate_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                dtngayvaotruong.Text = _dataRow["NgayVaoTruong"].ToString();
                dtngaytotnghiep.Text = _dataRow["NgayTotNghiep"].ToString();
                dtngaycapbang.Text = _dataRow["NgayCapBang"].ToString();
                txtDiem10.Text = _dataRow["Diem10"].ToString();
                txtDiem4.Text = _dataRow["Diem4"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                cbbLoaitotnghiep.Text = _dataRow["TenLoaiTotNghiep"].ToString();
                cbbHedaotao.Text = _dataRow["TenHeDaoTao"].ToString();
                cbbnganh.Text= _dataRow["TenNganh"].ToString();
                cbbLop.Text = _dataRow["MaLop"].ToString();
                cbbDiemChu.SelectedIndex = Convert.ToInt32(_dataRow["IDDiemChu"])-1;
            }
        }

        private void BtnThemLop_Click(object sender, RoutedEventArgs e)
        {
             DateTime? _ngayvaotruong = dtngayvaotruong.SelectedDate;
             DateTime? _ngaytotnghiep = dtngaytotnghiep.SelectedDate;
             DateTime? _ngaycapbang = dtngaycapbang.SelectedDate;

            decimal _temp1 = decimal.Parse(txtDiem10.Text);
            decimal _temp2 = decimal.Round(_temp1,1);
            float _diem10 = float.Parse(_temp2.ToString());

            decimal _temp3 = decimal.Parse(txtDiem4.Text);
            decimal _temp4 = decimal.Round(_temp3,1);
            float _diem4 = float.Parse(_temp4.ToString());

            string _ghichu = txtGhiChu.Text;
            int _idloaitotnghiep = cbbLoaitotnghiep.SelectedIndex + 1;
            int _idhedaotao = cbbHedaotao.SelectedIndex + 1;
            int _idnganh = cbbnganh.SelectedIndex + 1;
            int _idlop = cbbLop.SelectedIndex + 1;
            int _idDiemChu = cbbDiemChu.SelectedIndex + 1;

            const string sql = @" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem10,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,GhiChu) VALUES (@ngayvaotruong,@ngaytotnghiep,@ngaycapbang,@diem10,@diem4,@idloaitotnghiep,@idhedaotao,@idnganh,@idlop,@iddiemchu,@ghichu) ";
            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add(new SqlParameter("@Ngayvaotruong", SqlDbType.Date) { Value = _ngayvaotruong });
                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _ngaytotnghiep });
                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _ngaycapbang });
                cmd.Parameters.Add(new SqlParameter("@Diem10", SqlDbType.Decimal) { Value = _temp2 });
                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _temp4 });

                cmd.Parameters.Add(new SqlParameter("@IDLoaiTotNghiep", SqlDbType.Int) { Value = _idloaitotnghiep });
                cmd.Parameters.Add(new SqlParameter("@IDHeDaoTao", SqlDbType.Int, 100) { Value = _idhedaotao });
                cmd.Parameters.Add(new SqlParameter("@IDNganh", SqlDbType.Int) { Value = _idnganh });
                cmd.Parameters.Add(new SqlParameter("@IDLop", SqlDbType.Int) { Value = _idlop });
                cmd.Parameters.Add(new SqlParameter("@IDDiemChu", SqlDbType.Int) { Value = _idDiemChu });
                cmd.Parameters.Add(new SqlParameter("@GhiChu", SqlDbType.NVarChar) { Value = _ghichu });

                conn.Open();

                DataTable _table = new DataTable();
                SqlDataAdapter _adapter = new SqlDataAdapter(cmd);

                _adapter.Fill(_table);

                conn.Close();
            }

            LoadDataToGrid();

        }

        private void BtnCapNhat_Click(object sender, RoutedEventArgs e)
        {
            int _idthongtintotnghiep = 0;
            DataRowView _rowCurrent = dtgGraduate.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idthongtintotnghiep = Convert.ToInt32(_rowCurrent["IDThongTinTotNghiep"]);
            }

            DateTime? _ngayvaotruong = dtngayvaotruong.SelectedDate;
            DateTime? _ngaytotnghiep = dtngaytotnghiep.SelectedDate;
            DateTime? _ngaycapbang = dtngaycapbang.SelectedDate;

            decimal _temp1 = decimal.Parse(txtDiem10.Text);
            decimal _temp2 = decimal.Round(_temp1, 1);
            float _diem10 = float.Parse(_temp2.ToString());

            decimal _temp3 = decimal.Parse(txtDiem4.Text);
            decimal _temp4 = decimal.Round(_temp3, 1);
            float _diem4 = float.Parse(_temp4.ToString());

            string _ghichu = txtGhiChu.Text;
            int _idloaitotnghiep = cbbLoaitotnghiep.SelectedIndex + 1;
            int _idhedaotao = cbbHedaotao.SelectedIndex + 1;
            int _idnganh = cbbnganh.SelectedIndex + 1;
            int _idlop = cbbLop.SelectedIndex + 1;
            int _idDiemChu = cbbDiemChu.SelectedIndex + 1;

            const string _query = @" UPDATE dbo.ThongTinTotNghiep SET NgayVaoTruong = @Ngayvaotruong , NgayTotNghiep = @NgayTotNghiep  , NgayCapBang = @NgayCapBang , Diem10= @Diem10 , Diem4= @Diem4 , IDLoaiTotNghiep= @IDLoaiTotNghiep , IDHeDaoTao= @IDHeDaoTao , IDNghanh= @IDNganh , IDLop= @IDLop , IDDiemChu= @IDDiemChu , GhiChu= @GhiChu WHERE IDThongTinTotNghiep = @IDThongTinTotNghiep ";
            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
            using (SqlCommand cmd = new SqlCommand(_query, conn))
            {
                cmd.Parameters.Add(new SqlParameter("@Ngayvaotruong", SqlDbType.Date) { Value = _ngayvaotruong });
                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _ngaytotnghiep });
                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _ngaycapbang });
                cmd.Parameters.Add(new SqlParameter("@Diem10", SqlDbType.Decimal) { Value = _temp2 });
                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _temp4 });

                cmd.Parameters.Add(new SqlParameter("@IDLoaiTotNghiep", SqlDbType.Int) { Value = _idloaitotnghiep });
                cmd.Parameters.Add(new SqlParameter("@IDHeDaoTao", SqlDbType.Int, 100) { Value = _idhedaotao });
                cmd.Parameters.Add(new SqlParameter("@IDNganh", SqlDbType.Int) { Value = _idnganh });
                cmd.Parameters.Add(new SqlParameter("@IDLop", SqlDbType.Int) { Value = _idlop });
                cmd.Parameters.Add(new SqlParameter("@IDDiemChu", SqlDbType.Int) { Value = _idDiemChu });
                cmd.Parameters.Add(new SqlParameter("@GhiChu", SqlDbType.NVarChar) { Value = _ghichu });
                cmd.Parameters.Add(new SqlParameter("@IDThongTinTotNghiep", SqlDbType.Int) { Value = _idthongtintotnghiep });

                conn.Open();

                DataTable _table = new DataTable();
                SqlDataAdapter _adapter = new SqlDataAdapter(cmd);

                _adapter.Fill(_table);

                conn.Close();
            }

            LoadDataToGrid();
        }

        private void BtnXoa_Click(object sender, RoutedEventArgs e)
        {
            int idthongtintotnghiep = 0;
            DataRowView _rowCurrent = dtgGraduate.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    idthongtintotnghiep = Convert.ToInt32(_rowCurrent["IDThongTinTotNghiep"].ToString());
                    DeleteGraduate(idthongtintotnghiep);
                }
            }
        }

        public void DeleteGraduate(int idthongtintotnghiep)
        {
            if (GraduateDAL.Instance.DeleteGraduate(idthongtintotnghiep))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadDataToGrid();

        }

        public void LoadDataToGrid()
        {
            dtgGraduate.ItemsSource = GraduateDAL.Instance.GetListGraduate().DefaultView;
        }

        public void LoadDataToCombobox()
        {
            cbbLoaitotnghiep.ItemsSource = GraduateTypeDAL.Instance.GetListGraduateTypeToCombobox();
            cbbHedaotao.ItemsSource = TrainingDAL.Instance.GetListTrainingToCombobox();
            cbbnganh.ItemsSource = ProfessionDAL.Instance.GetListProfessionToCombobox();
            cbbLop.ItemsSource = ClassDAL.Instance.GetListClassToCombobox();
            cbbDiemChu.ItemsSource = MarkDAL.Instance.GetListMarkToCombobox();
            cbbLoaitotnghiep.DisplayMemberPath = "TenLoaiTotNghiep";
            cbbHedaotao.DisplayMemberPath = "TenHeDaoTao";
            cbbnganh.DisplayMemberPath = "TenNganh";
            cbbLop.DisplayMemberPath = "MaLop";
            cbbDiemChu.DisplayMemberPath = "TenDiem";
        }

    }
}
