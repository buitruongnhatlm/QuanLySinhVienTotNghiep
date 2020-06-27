using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
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
using Microsoft.Win32;
using OfficeOpenXml;
using OfficeOpenXml.Style;

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
                txtDiem4.Text = _dataRow["Diem4"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
                cbbLoaitotnghiep.Text = _dataRow["TenLoaiTotNghiep"].ToString();
                cbbHedaotao.Text = _dataRow["TenHeDaoTao"].ToString();
                cbbnganh.Text= _dataRow["TenNganh"].ToString();
                cbbLop.Text = _dataRow["MaLop"].ToString();
                cbbDiemChu.SelectedIndex = Convert.ToInt32(_dataRow["IDDiemChu"])-1;
                txtTrangThai.Text = _dataRow["TrangThai"].ToString();
                txtNoMon.Text = _dataRow["NoMon"].ToString();
            }
        }

        private void BtnThemLop_Click(object sender, RoutedEventArgs e)
        {
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

            const string sql = @" INSERT INTO dbo.ThongTinTotNghiep (NgayVaoTruong,NgayTotNghiep,NgayCapBang,Diem4,IDLoaiTotNghiep,IDHeDaoTao,IDNghanh,IDLop,IDDiemChu,TrangThai,NoMon,GhiChu) VALUES (@ngayvaotruong,@ngaytotnghiep,@ngaycapbang,@diem4,@idloaitotnghiep,@idhedaotao,@idnganh,@idlop,@iddiemchu,@trangthai,@nomon,@ghichu) ";
            using (SqlConnection conn = new SqlConnection(@"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True"))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add(new SqlParameter("@Ngayvaotruong", SqlDbType.Date) { Value = _ngayvaotruong });
                cmd.Parameters.Add(new SqlParameter("@NgayTotNghiep", SqlDbType.Date, 100) { Value = _ngaytotnghiep });
                cmd.Parameters.Add(new SqlParameter("@NgayCapBang", SqlDbType.Date) { Value = _ngaycapbang });
                cmd.Parameters.Add(new SqlParameter("@Diem4", SqlDbType.Decimal) { Value = _diem4 });

                cmd.Parameters.Add(new SqlParameter("@TrangThai", SqlDbType.NVarChar,25) { Value = _trangthai });
                cmd.Parameters.Add(new SqlParameter("@NoMon", SqlDbType.NVarChar,10) { Value = _nomon });

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
                            if (_sheetCurrent.Cells[row, col++].Value != null)
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
                            GraduateDTO _Graduate = new GraduateDTO(_IDThongTinTotNghiep, _NgayVaoTruong, _NgayTotNghiep, _NgayCapBang,
                            _Diem4, _IDLoaiTotNghiep, _IDHeDaoTao, _IDNganh, _IDLop, _IDDiemChu, _TrangThai, _NoMon, _GhiChu);

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

                            //add user mới vào danh sách
                            _List.Add(_Graduate);

                        }

                        catch (Exception ex) { MessageBox.Show(ex.Message); }
                    }

                }

            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }

            dtgGraduate.ItemsSource = _List;
            LoadDataToGrid();
        }

        private void BtnExportExcel_Click(object sender, RoutedEventArgs e)
        {
            ExcelPackage.LicenseContext = LicenseContext.Commercial; // giấy phép sử dụng thư viện bản thương mại

            string _filePath = ""; // đường dẫn lưu file

            SaveFileDialog _SFD = new SaveFileDialog();
            _SFD.Filter = "Excel Files|*.xlsx";  // tạo định dạng file

            if (_SFD.ShowDialog() == true)
            {
                _filePath = _SFD.FileName;
            }

            if (string.IsNullOrEmpty(_filePath))
            {
                MessageBox.Show("Đường dẫn không hợp lệ");
            }

            try
            {
                using (ExcelPackage _package = new ExcelPackage())
                {
                    _package.Workbook.Properties.Author = "NHAT100"; // Tên author của file
                    _package.Workbook.Properties.Title = "SinhVienNoMon"; // tên title của file
                    _package.Workbook.Worksheets.Add("NHATsheet"); // tạo 1 sheet mới

                    ExcelWorksheet _currentSheet = _package.Workbook.Worksheets[0];

                    _currentSheet.Name = "NHATsheet"; // tên sheet
                    _currentSheet.Cells.Style.Font.Size = 13; // cỡ chữ
                    _currentSheet.Cells.Style.Font.Name = "Times New Roman"; // tên font
                    _currentSheet.Cells.Style.Font.Italic = true;

                    // mảng chứa danh sách column header của file excel
                    string[] _arrColumnHeader = { "Số Thứ Tự","Ngày Vào Trường","Ngày Tốt Nghiệp","Ngày Cấp Bằng","Điểm 4","Ghi Chú","Loại Tốt Nghiệp",
                    "Hệ Đào Tạo","Ngành","Lớp","Điểm Chữ","Trạng Thái","Nợ Môn"};

                    var _countColumn = _arrColumnHeader.Count(); // đếm số lượng cột

                    // Gom cột
                    _currentSheet.Cells[1, 1].Value = "BÁO CÁO SINH VIÊN TỐT NGHIỆP";
                    _currentSheet.Cells[1, 1, 1, _countColumn].Merge = true; // merge cell từ cột 1 dòng 1 đến dòng 1 cột 2
                    _currentSheet.Cells[1, 1, 1, _countColumn].Style.Font.Bold = true;
                    _currentSheet.Cells[1, 1, 1, _countColumn].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                    int _colIndex = 1;
                    int _rowIndex = 2;

                    //định dạng add dữ liệu cho header
                    foreach (var item in _arrColumnHeader)
                    {
                        var _cell = _currentSheet.Cells[_rowIndex, _colIndex];

                        // set màu
                        var _fill = _cell.Style.Fill;
                        _fill.PatternType = ExcelFillStyle.Solid;
                        _fill.BackgroundColor.SetColor(System.Drawing.Color.SkyBlue);

                        // tùy chỉnh border
                        var _border = _cell.Style.Border;
                        _border.Top.Style = _border.Bottom.Style = _border.Left.Style = _border.Right.Style = ExcelBorderStyle.Thick;

                        //gán giá trị
                        _cell.Value = item;
                        _colIndex++;
                    }

                    DataView view = (DataView)dtgGraduate.ItemsSource;
                    DataTable dataTable = view.Table.Clone();
                    foreach (DataRowView item in view)
                    {
                        dataTable.ImportRow(item.Row);
                    }

                    var dataTableFromDataGrid = dataTable;

                    IEnumerable<Graduate> l = GetEntities<Graduate>(dataTableFromDataGrid);

                    List<Graduate> list = l.ToList();

                    //với mỗi item trong danh sách sẽ ghi trên một dòng
                    foreach (var item in list)
                    {
                        _colIndex = 1; // cột 1

                        _rowIndex++; // dòng sẽ tự tăng

                        //gán trường TÊN cho cột 1, dòng++ các dòng sẽ tăng lên dòng tiếp theo khi gán xong
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.IDThongTinTotNghiep;


                        DateTime _temp1 = DateTime.Parse(item.NgayVaoTruong.ToString());
                        String NgayVaoTruong = _temp1.ToString("dd-MM-yyyy");

                        DateTime _temp2 = DateTime.Parse(item.NgayTotNghiep.ToString());
                        String NgayTotNghiep = _temp2.ToString("dd-MM-yyyy");

                        DateTime _temp3 = DateTime.Parse(item.NgayCapBang.ToString());
                        String _NgayCapBang = _temp3.ToString("dd-MM-yyyy");

                        //gán trường cho cột 1, dòng++, phải sắp xếp để không sai định dạng khi xuất ra file excel
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = NgayVaoTruong;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = NgayTotNghiep;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = _NgayCapBang;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.Diem4;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.GhiChu;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TenLoaiTotNghiep;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TenHeDaoTao;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TenNganh;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.MaLop;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TenDiem.ToString();
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TrangThai;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.NoMon;
                    }

                    //lưu file lại
                    Byte[] _byte = _package.GetAsByteArray();
                    File.WriteAllBytes(_filePath, _byte);
                }

                MessageBox.Show("Xuất file thành công");
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }

        }

        public IEnumerable<T> GetEntities<T>(DataTable dt)
        {
            if (dt == null)
            {
                return null;
            }

            List<T> returnValue = new List<T>();
            List<string> typeProperties = new List<string>();

            T typeInstance = Activator.CreateInstance<T>();

            foreach (DataColumn column in dt.Columns)
            {
                var prop = typeInstance.GetType().GetProperty(column.ColumnName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public);
                if (prop != null)
                {
                    typeProperties.Add(column.ColumnName);
                }
            }

            foreach (DataRow row in dt.Rows)
            {
                T entity = Activator.CreateInstance<T>();

                foreach (var propertyName in typeProperties)
                {

                    if (row[propertyName] != DBNull.Value)
                    {
                        string str = row[propertyName].GetType().FullName;

                        if (entity.GetType().GetProperty(propertyName).PropertyType == typeof(System.String))
                        {
                            object Val = row[propertyName].ToString();
                            entity.GetType().GetProperty(propertyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public).SetValue(entity, Val, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public, null, null, null);
                        }
                        else if (entity.GetType().GetProperty(propertyName).PropertyType == typeof(System.Guid))
                        {
                            object Val = Guid.Parse(row[propertyName].ToString());
                            entity.GetType().GetProperty(propertyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public).SetValue(entity, Val, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public, null, null, null);
                        }
                        else
                        {
                            entity.GetType().GetProperty(propertyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public).SetValue(entity, row[propertyName], BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public, null, null, null);
                        }
                    }
                    else
                    {
                        entity.GetType().GetProperty(propertyName, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public).SetValue(entity, null, BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public, null, null, null);
                    }
                }

                returnValue.Add(entity);
            }

            return returnValue.AsEnumerable();
        }
    }
}
