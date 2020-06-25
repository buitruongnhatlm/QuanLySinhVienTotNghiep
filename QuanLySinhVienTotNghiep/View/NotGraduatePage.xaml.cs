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
using System.Data;
using System.Data.SqlClient;
using OfficeOpenXml;
using Microsoft.Win32;
using System.IO;
using System.Globalization;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for NotGraduatePage.xaml
    /// </summary>
    public partial class NotGraduatePage : Page
    {
        public NotGraduatePage()
        {
            InitializeComponent();
            LoadDataToGrid();
            LoadDataToCombobox();
        }

        private void DtgNotGraduate_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                dtngayvaotruong.Text = _dataRow["NgayVaoTruong"].ToString();
                dtngaytotnghiep.Text = _dataRow["NgayTotNghiep"].ToString();
                dtngaycapbang.Text = _dataRow["NgayCapBang"].ToString();
                txtDiem4.Text = _dataRow["Diem4"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                cbbLoaitotnghiep.Text = _dataRow["TenLoaiTotNghiep"].ToString();
                cbbHedaotao.Text = _dataRow["TenHeDaoTao"].ToString();
                cbbnganh.Text = _dataRow["TenNganh"].ToString();
                cbbLop.Text = _dataRow["MaLop"].ToString();
                cbbDiemChu.SelectedIndex = Convert.ToInt32(_dataRow["IDDiemChu"]) - 1;
                txtTrangThai.Text = _dataRow["TrangThai"].ToString();
                txtNoMon.Text = _dataRow["NoMon"].ToString();
            }
        }

        private void BtnThemChuaTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            DateTime? _ngayvaotruong;
            if(dtngayvaotruong.SelectedDate == null)
            {
                _ngayvaotruong = Convert.ToDateTime("01/01/0001");
            }
            else
            {
                _ngayvaotruong = dtngayvaotruong.SelectedDate;
            }


            DateTime? _ngaytotnghiep;
            if(dtngaytotnghiep.SelectedDate ==null)
            {
                _ngaytotnghiep = Convert.ToDateTime("01/01/0001");
            }
            else
            {
                _ngaytotnghiep = dtngaytotnghiep.SelectedDate;
            }

            DateTime? _ngaycapbang;
            if(dtngaycapbang.SelectedDate==null)
            {
                _ngaycapbang = Convert.ToDateTime("01/01/0001");
            }
            else
            {
                _ngaycapbang = dtngaycapbang.SelectedDate;
            }

            decimal _diem4 = decimal.Parse(txtDiem4.Text);

            string _ghichu = txtGhiChu.Text;
            string _trangthai = txtTrangThai.Text;
            string _nomon = txtNoMon.Text;

            int _idloaitotnghiep = cbbLoaitotnghiep.SelectedIndex + 1;
            int _idhedaotao = cbbHedaotao.SelectedIndex + 1;
            int _idnganh = cbbnganh.SelectedIndex + 1;
            int _idlop = cbbLop.SelectedIndex + 1;
            int _idDiemChu = cbbDiemChu.SelectedIndex + 1;

            const string sql = @" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,TrangThai,NoMon,GhiChu) VALUES (@ngayvaotruong,@ngaytotnghiep,@ngaycapbang,@diem4,@idloaitotnghiep,@idhedaotao,@idnganh,@idlop,@iddiemchu,@trangthai,@nomon,@ghichu) ";
            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add(new SqlParameter("@NgayVaoTruong", SqlDbType.Date) { Value = _ngayvaotruong });
                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _ngaytotnghiep });
                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _ngaycapbang });
                
                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _diem4 });

                cmd.Parameters.Add(new SqlParameter("@TrangThai", SqlDbType.NVarChar, 25) { Value = _trangthai });
                cmd.Parameters.Add(new SqlParameter("@NoMon", SqlDbType.NVarChar, 10) { Value = _nomon });

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

        private void BtnSuaChuaTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            int _idthongtintotnghiep = 0;
            DataRowView _rowCurrent = dtgNotGraduate.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idthongtintotnghiep = Convert.ToInt32(_rowCurrent["IDThongTinTotNghiep"]);
            }

            DateTime? _ngayvaotruong = dtngayvaotruong.SelectedDate;
            DateTime? _ngaytotnghiep = dtngaytotnghiep.SelectedDate;
            DateTime? _ngaycapbang = dtngaycapbang.SelectedDate;

            decimal _diem4 = decimal.Parse(txtDiem4.Text);

            string _ghichu = txtGhiChu.Text;
            string _trangthai = txtTrangThai.Text;
            string _nomon = txtNoMon.Text;

            int _idloaitotnghiep = cbbLoaitotnghiep.SelectedIndex + 1;
            int _idhedaotao = cbbHedaotao.SelectedIndex + 1;
            int _idnganh = cbbnganh.SelectedIndex + 1;
            int _idlop = cbbLop.SelectedIndex + 1;
            int _idDiemChu = cbbDiemChu.SelectedIndex + 1;

            const string _query = @" UPDATE dbo.ThongTinTotNghiep SET NgayVaoTruong = @Ngayvaotruong , NgayTotNghiep = @NgayTotNghiep  , NgayCapBang = @NgayCapBang , Diem4= @Diem4 , IDLoaiTotNghiep= @IDLoaiTotNghiep , IDHeDaoTao= @IDHeDaoTao , IDNghanh= @IDNganh , IDLop= @IDLop , IDDiemChu= @IDDiemChu , GhiChu = @GhiChu , TrangThai = @TrangThai , NoMon = @NoMon WHERE IDThongTinTotNghiep = @IDThongTinTotNghiep ";
            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
            using (SqlCommand cmd = new SqlCommand(_query, conn))
            {
                cmd.Parameters.Add(new SqlParameter("@Ngayvaotruong", SqlDbType.Date) { Value = _ngayvaotruong });
                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _ngaytotnghiep });
                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _ngaycapbang });
                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _diem4 });

                cmd.Parameters.Add(new SqlParameter("@TrangThai", SqlDbType.NVarChar, 25) { Value = _trangthai });
                cmd.Parameters.Add(new SqlParameter("@NoMon", SqlDbType.NVarChar, 10) { Value = _nomon });

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

        private void BtnXoaChuaTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            int idthongtintotnghiep = 0;
            DataRowView _rowCurrent = dtgNotGraduate.SelectedItem as DataRowView;
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
            dtgNotGraduate.ItemsSource = GraduateDAL.Instance.GetListNotGraduate().DefaultView;
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

        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {
            List<GraduateDTO> _List = new List<GraduateDTO>();

            try
            {
                ExcelPackage.LicenseContext = LicenseContext.Commercial; // giấy phép sử dụng thư viện bản thương mại

                OpenFileDialog _opendialog = new OpenFileDialog();
                _opendialog.Filter = "Excel Files|*.xls;*.xlsx";

                if (_opendialog.ShowDialog() == true)
                {
                    string _filepath = _opendialog.FileName;

                    var _package = new ExcelPackage(new FileInfo(_filepath)); // Mở file Excel
                    //var _package = new ExcelPackage(new FileInfo("ImportListStudent.xlsx")); // Mở file Excel

                    ExcelWorksheet _sheetCurrent = _package.Workbook.Worksheets[0]; // mở sheet (trang) 1 trong file excel

                    // duyệt tuần tự dòng thứ 2 tới dòng cuối của file
                    // duyệt file excel tương tự duyệt mảng 2 chiều
                    // chỉ số cột trong excel bắt đầu từ 1

                    for (int row = _sheetCurrent.Dimension.Start.Row + 1; row <= _sheetCurrent.Dimension.End.Row; row++)
                    {
                        try
                        {
                            int col = 1;

                            // lấy ra tên ở vị trí dòng 2 cột 1, col++ sau khi thực hiện câu lệnh tăng cột lên 1 (toán tử hậu tố)

                            int _IDThongTinTotNghiep = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);

                            // tạo biến tạm bằng giá trị trong ô ngày sinh 
                            var NgayVaoTruongTemp = _sheetCurrent.Cells[row, col++].Value;
                            DateTime _NgayVaoTruong = new DateTime();
                            // kiểm tra biến tạm có null hoặc rỗng không
                            if (NgayVaoTruongTemp != null)
                            {
                                try
                                {
                                    // nếu thỏa cố gắng ép kiểu nó 
                                    _NgayVaoTruong = (DateTime)NgayVaoTruongTemp;
                                }
                                catch (Exception ex)    
                                { MessageBox.Show(ex.ToString()); }
                            }

                             // tạo biến tạm bằng giá trị trong ô ngày sinh 
                            var NgayTotNghiepTemp = _sheetCurrent.Cells[row, col++].Value;
                            DateTime _NgayTotNghiep = new DateTime();
                            // kiểm tra biến tạm có null hoặc rỗng không
                            if (NgayTotNghiepTemp != null)
                            {
                                try
                                {
                                    // nếu thỏa cố gắng ép kiểu nó 
                                    _NgayTotNghiep = (DateTime)NgayTotNghiepTemp;
                                }
                                catch (Exception ex)
                                { MessageBox.Show(ex.ToString()); }
                            }                                   

                            // tạo biến tạm bằng giá trị trong ô ngày sinh 
                            var NgayCapBangTemp = _sheetCurrent.Cells[row, col++].Value;
                            DateTime _NgayCapBang = new DateTime();
                            // kiểm tra biến tạm có null hoặc rỗng không
                            if (NgayCapBangTemp != null)
                            {
                                try
                                {
                                    // nếu thỏa cố gắng ép kiểu nó 
                                    _NgayCapBang = (DateTime)NgayCapBangTemp;
                                }
                                catch (Exception ex)
                                { MessageBox.Show(ex.ToString()); }
                            }

                            decimal _Diem4 = decimal.Parse(_sheetCurrent.Cells[row, col++].Value.ToString());

                            string _GhiChu;
                            if (_sheetCurrent.Cells[row, col++].Value!=null)
                            {
                                 _GhiChu = _sheetCurrent.Cells[row, col++].Value.ToString();
                            }
                            else
                            {
                                _GhiChu = "";
                            }
                            

                            int _IDLoaiTotNghiep = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                            int _IDHeDaoTao = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                            int _IDNganh = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                            int _IDLop = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());
                            int _IDDiemChu = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value.ToString());

                            string _TrangThai = _sheetCurrent.Cells[row, col++].Value.ToString();
                            string _NoMon = _sheetCurrent.Cells[row, col++].Value.ToString();

                            // tạo thông tin tốt nghiệp mới với các thuộc tính là các thuộc tính vừa đọc được trong file excel
                            //GraduateDTO _NotGraduate = new GraduateDTO(_NgayVaoTruong, _NgayTotNghiep, _NgayCapBang,
                            //_Diem4, _IDLoaiTotNghiep, _IDHeDaoTao, _IDNganh, _IDLop, _IDDiemChu, _TrangThai, _NoMon, _GhiChu);

                            #region ThemTT
                            const string sql = @" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,TrangThai,NoMon,GhiChu) VALUES (@ngayvaotruong,@ngaytotnghiep,@ngaycapbang,@diem4,@idloaitotnghiep,@idhedaotao,@idnganh,@idlop,@iddiemchu,@trangthai,@nomon,@ghichu) ";
                            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
                            using (SqlCommand cmd = new SqlCommand(sql, conn))
                            {
                                cmd.Parameters.Add(new SqlParameter("@Ngayvaotruong", SqlDbType.Date) { Value = _NgayVaoTruong });
                                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _NgayTotNghiep });
                                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _NgayCapBang });
                                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _Diem4 });

                                cmd.Parameters.Add(new SqlParameter("@TrangThai", SqlDbType.NVarChar, 25) { Value = _TrangThai });
                                cmd.Parameters.Add(new SqlParameter("@NoMon", SqlDbType.NVarChar, 10) { Value = _NoMon });

                                cmd.Parameters.Add(new SqlParameter("@IDLoaiTotNghiep", SqlDbType.Int) { Value = _IDLoaiTotNghiep });
                                cmd.Parameters.Add(new SqlParameter("@IDHeDaoTao", SqlDbType.Int, 100) { Value = _IDHeDaoTao });
                                cmd.Parameters.Add(new SqlParameter("@IDNganh", SqlDbType.Int) { Value = _IDNganh });
                                cmd.Parameters.Add(new SqlParameter("@IDLop", SqlDbType.Int) { Value = _IDLop });
                                cmd.Parameters.Add(new SqlParameter("@IDDiemChu", SqlDbType.Int) { Value = _IDDiemChu });
                                cmd.Parameters.Add(new SqlParameter("@GhiChu", SqlDbType.NVarChar) { Value = _GhiChu });

                                conn.Open();

                                DataTable _table = new DataTable();
                                SqlDataAdapter _adapter = new SqlDataAdapter(cmd);

                                _adapter.Fill(_table);

                                conn.Close();
                            }
                            #endregion

                            // add user mới vào danh sách
                           // _List.Add(_NotGraduate);

                        }

                        catch (Exception ex) { MessageBox.Show(ex.Message); }
                    }

                }

            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }

           // dtgNotGraduate.ItemsSource = _List;
            LoadDataToGrid();
            MessageBox.Show("them thanh cong");
        }
    }
}
