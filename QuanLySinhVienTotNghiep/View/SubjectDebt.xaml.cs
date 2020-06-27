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
using DTO;
using DAL;
using System.Data;
using Microsoft.Win32;
using System.IO;
using OfficeOpenXml.Style;
using System.Diagnostics;
using Spire.Xls;
using System.Collections;
using System.Reflection;
using OfficeOpenXml;
using System.Windows.Controls.Primitives;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for SubjectDebt.xaml
    /// </summary>
    public partial class SubjectDebt : Window
    {
        public SubjectDebt()
        {
            InitializeComponent();
            LoadData();
        }

        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {
            List<GraduateDTO> _List = new List<GraduateDTO>();

            try
            {
                OfficeOpenXml.ExcelPackage.LicenseContext = OfficeOpenXml.LicenseContext.Commercial; // giấy phép sử dụng thư viện bản thương mại

                OpenFileDialog _opendialog = new OpenFileDialog();
                _opendialog.Filter = "Excel Files|*.xls;*.xlsx";

                if (_opendialog.ShowDialog() == true)
                {
                    string _filepath = _opendialog.FileName;

                    var _package = new OfficeOpenXml.ExcelPackage(new FileInfo(_filepath)); // Mở file Excel

                    OfficeOpenXml.ExcelWorksheet _sheetCurrent = _package.Workbook.Worksheets[0]; // mở sheet (trang) 1 trong file excel

                    // duyệt tuần tự dòng thứ 2 tới dòng cuối của file
                    // duyệt file excel tương tự duyệt mảng 2 chiều
                    // chỉ số cột trong excel bắt đầu từ 1

                    for (int row = _sheetCurrent.Dimension.Start.Row + 1; row <= _sheetCurrent.Dimension.End.Row; row++)
                    {
                        try
                        {
                            int col = 1;

                            #region lấy ra tên ở vị trí dòng 2 cột 1, col++ sau khi thực hiện câu lệnh tăng cột lên 1 (toán tử hậu tố)

                            int _idmonhoc = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _idsinhvien = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _toanroirac = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _giaitich = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _xacsuatthongke = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _kythuatlaptrinh = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _mangmaytinh = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _cosodulieu = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _kynanggiaotiep = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _laptrinhhuongdoituong = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _cautrucdulieugiaithuat = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _hedieuhanh = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _phantichthietke = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _trituenhantao = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _phanmemmanguonmo = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _baotriphanmem = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _thuongmaidientu = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _doan1 = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _doan2 = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _doan3 = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _chungchingoaingu = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);
                            int _hocphantuchon = Convert.ToInt32(_sheetCurrent.Cells[row, col++].Value);

                            #endregion

                            // tạo mới với các thuộc tính là các thuộc tính vừa đọc được trong file excel
                            AddSubjectDebt(_idsinhvien, _toanroirac, _giaitich, _xacsuatthongke, _kythuatlaptrinh, _mangmaytinh, _cosodulieu, _kynanggiaotiep, _laptrinhhuongdoituong, _cautrucdulieugiaithuat, _hedieuhanh,
                                _phantichthietke, _trituenhantao, _phanmemmanguonmo, _baotriphanmem, _thuongmaidientu, _doan1, _doan2, _doan3, _chungchingoaingu, _hocphantuchon);

                        }

                        catch (Exception ex) { MessageBox.Show(ex.Message); }
                    }

                }

            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }

            LoadData();
        }

        private void BtnThemMonHoc_Click(object sender, RoutedEventArgs e)
        {
            int _idsinhvien = Convert.ToInt32(txtSinhVien.Text);

            #region exam toggle button check

            int _toanroirac = 0;
            if (tgbtnToanRoiRac.IsChecked == true)
            {
                _toanroirac = 1;
            }

            int _giaitich = 0;
            if (tgbtnGiaiTich.IsChecked == true)
            {
                _giaitich = 1;
            }

            int _xacsuatthongke = 0;
            if (tgbtnXacSuat.IsChecked == true)
            {
                _xacsuatthongke = 1;
            }

            int _kythuatlaptrinh = 0;
            if (tgbtnKyThuatLapTrinh.IsChecked == true)
            {
                _kythuatlaptrinh = 1;
            }

            int _mangmaytinh = 0;
            if (tgbtnMangMayTinh.IsChecked == true)
            {
                _mangmaytinh = 1;
            }

            int _cosodulieu = 0;
            if (tgbtnCoSoDuLieu.IsChecked == true)
            {
                _cosodulieu = 1;
            }

            int _kynanggiaotiep = 0;
            if (tgbtnKyNangGiaoTiep.IsChecked == true)
            {
                _kynanggiaotiep = 1;
            }

            int _laptrinhhuongdoituong = 0;
            if (tgbtnLapTrinhHuongDoiTuong.IsChecked == true)
            {
                _laptrinhhuongdoituong = 1;
            }

            int _cautrucdulieugiaithuat = 0;
            if (tgbtnCauTrucDuLieu.IsChecked == true)
            {
                _cautrucdulieugiaithuat = 1;
            }

            int _hedieuhanh = 0;
            if (tgbtnHeDieuHanh.IsChecked == true)
            {
                _hedieuhanh = 1;
            }

            int _phantichthietke = 0;
            if (tgbtnPhanTichThietKe.IsChecked == true)
            {
                _phantichthietke = 1;
            }

            int _trituenhantao = 0;
            if (tgbtnTriTueNhanTao.IsChecked == true)
            {
                _trituenhantao = 1;
            }

            int _phanmemmanguonmo = 0;
            if (tgbtnPhanMemMaNguonMo.IsChecked == true)
            {
                _phanmemmanguonmo = 1;
            }

            int _baotriphanmem = 0;
            if (tgbtnBaoTriPhanMem.IsChecked == true)
            {
                _baotriphanmem = 1;
            }

            int _thuongmaidientu = 0;
            if (tgbtnThuongMaiDienTu.IsChecked == true)
            {
                _thuongmaidientu = 1;
            }

            int _doan1 = 0;
            if (tgbtnDoAn1.IsChecked == true)
            {
                _doan1 = 1;
            }

            int _doan2 = 0;
            if (tgbtnDoAn2.IsChecked == true)
            {
                _doan2 = 1;
            }

            int _doan3 = 0;
            if (tgbtnDoAn3.IsChecked == true)
            {
                _doan3 = 1;
            }

            int _chungchingoaingu = 0;
            if (tgbtnChungChiNgoaiNgu.IsChecked == true)
            {
                _chungchingoaingu = 1;
            }

            int _hocphantuchon = 0;
            if (tgbtnHocPhanTuChon.IsChecked == true)
            {
                _hocphantuchon = 1;
            }

            #endregion

            AddSubjectDebt(_idsinhvien, _toanroirac, _giaitich, _xacsuatthongke, _kythuatlaptrinh, _mangmaytinh, _cosodulieu, _kynanggiaotiep, _laptrinhhuongdoituong, _cautrucdulieugiaithuat, _hedieuhanh,
                               _phantichthietke, _trituenhantao, _phanmemmanguonmo, _baotriphanmem, _thuongmaidientu, _doan1, _doan2, _doan3, _chungchingoaingu, _hocphantuchon);

        }

        private void BtnCapNhatMonHoc_Click(object sender, RoutedEventArgs e)
        {
            int _idmonhoc = 0;
            DataRowView _rowCurrent = dtgSubjectDebt.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                _idmonhoc = Convert.ToInt32(_rowCurrent["IDMonHoc"].ToString());
            }

            #region exam toggle button check

            int _toanroirac = 0;
            if (tgbtnToanRoiRac.IsChecked == true)
            {
                _toanroirac = 1;
            }

            int _giaitich = 0;
            if (tgbtnGiaiTich.IsChecked == true)
            {
                _giaitich = 1;
            }

            int _xacsuatthongke = 0;
            if (tgbtnXacSuat.IsChecked == true)
            {
                _xacsuatthongke = 1;
            }

            int _kythuatlaptrinh = 0;
            if (tgbtnKyThuatLapTrinh.IsChecked == true)
            {
                _kythuatlaptrinh = 1;
            }

            int _mangmaytinh = 0;
            if (tgbtnMangMayTinh.IsChecked == true)
            {
                _mangmaytinh = 1;
            }

            int _cosodulieu = 0;
            if (tgbtnCoSoDuLieu.IsChecked == true)
            {
                _cosodulieu = 1;
            }

            int _kynanggiaotiep = 0;
            if (tgbtnKyNangGiaoTiep.IsChecked == true)
            {
                _kynanggiaotiep = 1;
            }

            int _laptrinhhuongdoituong = 0;
            if (tgbtnLapTrinhHuongDoiTuong.IsChecked == true)
            {
                _laptrinhhuongdoituong = 1;
            }

            int _cautrucdulieugiaithuat = 0;
            if (tgbtnCauTrucDuLieu.IsChecked == true)
            {
                _cautrucdulieugiaithuat = 1;
            }

            int _hedieuhanh = 0;
            if (tgbtnHeDieuHanh.IsChecked == true)
            {
                _hedieuhanh = 1;
            }

            int _phantichthietke = 0;
            if (tgbtnPhanTichThietKe.IsChecked == true)
            {
                _phantichthietke = 1;
            }

            int _trituenhantao = 0;
            if (tgbtnTriTueNhanTao.IsChecked == true)
            {
                _trituenhantao = 1;
            }

            int _phanmemmanguonmo = 0;
            if (tgbtnPhanMemMaNguonMo.IsChecked == true)
            {
                _phanmemmanguonmo = 1;
            }

            int _baotriphanmem = 0;
            if (tgbtnBaoTriPhanMem.IsChecked == true)
            {
                _baotriphanmem = 1;
            }

            int _thuongmaidientu = 0;
            if (tgbtnThuongMaiDienTu.IsChecked == true)
            {
                _thuongmaidientu = 1;
            }

            int _doan1 = 0;
            if (tgbtnDoAn1.IsChecked == true)
            {
                _doan1 = 1;
            }

            int _doan2 = 0;
            if (tgbtnDoAn2.IsChecked == true)
            {
                _doan2 = 1;
            }

            int _doan3 = 0;
            if (tgbtnDoAn3.IsChecked == true)
            {
                _doan3 = 1;
            }

            int _chungchingoaingu = 0;
            if (tgbtnChungChiNgoaiNgu.IsChecked == true)
            {
                _chungchingoaingu = 1;
            }

            int _hocphantuchon = 0;
            if (tgbtnHocPhanTuChon.IsChecked == true)
            {
                _hocphantuchon = 1;
            }

            #endregion

            EditSubjectDebt(_idmonhoc, _toanroirac, _giaitich, _xacsuatthongke, _kythuatlaptrinh, _mangmaytinh, _cosodulieu, _kynanggiaotiep, _laptrinhhuongdoituong, _cautrucdulieugiaithuat, _hedieuhanh,
                               _phantichthietke, _trituenhantao, _phanmemmanguonmo, _baotriphanmem, _thuongmaidientu, _doan1, _doan2, _doan3, _chungchingoaingu, _hocphantuchon);

        }

        private void BtnXoaMoHoc_Click(object sender, RoutedEventArgs e)
        {
            int _idmonhoc = 0;
            DataRowView _rowCurrent = dtgSubjectDebt.SelectedItem as DataRowView;
            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idmonhoc = Convert.ToInt32(_rowCurrent["IDMonHoc"].ToString());
                    DeleteSubjectDebt(_idmonhoc);
                }
            }
        }

        public void LoadData()
        {
            dtgSubjectDebt.ItemsSource = SubjectDebtDAL.Instance.GetListSubjectDebt().DefaultView;
        }

        private void DtgSubjectDebt_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtSinhVien.Text = _dataRow["HoTen"].ToString();

                #region exam check toggle button
                if (Convert.ToInt32(_dataRow["ToanRoiRac"].ToString()) == 1)
                {
                    tgbtnToanRoiRac.IsChecked = true;
                }
                else
                {
                    tgbtnToanRoiRac.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["GiaiTich"].ToString()) == 1)
                {
                    tgbtnGiaiTich.IsChecked = true;
                }
                else
                {
                    tgbtnGiaiTich.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["XacSuatThongKe"].ToString()) == 1)
                {
                    tgbtnXacSuat.IsChecked = true;
                }
                else
                {
                    tgbtnXacSuat.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["KyThuatLapTrinh"].ToString()) == 1)
                {
                    tgbtnKyThuatLapTrinh.IsChecked = true;
                }
                else
                {
                    tgbtnKyThuatLapTrinh.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["MangMayTinh"].ToString()) == 1)
                {
                    tgbtnMangMayTinh.IsChecked = true;
                }
                else
                {
                    tgbtnMangMayTinh.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["CoSoDuLieu"].ToString()) == 1)
                {
                    tgbtnCoSoDuLieu.IsChecked = true;
                }
                else
                {
                    tgbtnCoSoDuLieu.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["KyNangGiaoTiep"].ToString()) == 1)
                {
                    tgbtnKyNangGiaoTiep.IsChecked = true;
                }
                else
                {
                    tgbtnKyNangGiaoTiep.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["LapTrinhHuongDoiTuong"].ToString()) == 1)
                {
                    tgbtnLapTrinhHuongDoiTuong.IsChecked = true;
                }
                else
                {
                    tgbtnLapTrinhHuongDoiTuong.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["CauTrucDuLieuGiaiThuat"].ToString()) == 1)
                {
                    tgbtnCauTrucDuLieu.IsChecked = true;
                }
                else
                {
                    tgbtnCauTrucDuLieu.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["HeDieuHanh"].ToString()) == 1)
                {
                    tgbtnHeDieuHanh.IsChecked = true;
                }
                else
                {
                    tgbtnHeDieuHanh.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["PhanTichThietKe"].ToString()) == 1)
                {
                    tgbtnPhanTichThietKe.IsChecked = true;
                }
                else
                {
                    tgbtnPhanTichThietKe.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["TriTueNhanTao"].ToString()) == 1)
                {
                    tgbtnTriTueNhanTao.IsChecked = true;
                }
                else
                {
                    tgbtnTriTueNhanTao.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["PhanMemMaNguonMo"].ToString()) == 1)
                {
                    tgbtnPhanMemMaNguonMo.IsChecked = true;
                }
                else
                {
                    tgbtnPhanMemMaNguonMo.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["BaoTriPhanMem"].ToString()) == 1)
                {
                    tgbtnBaoTriPhanMem.IsChecked = true;
                }
                else
                {
                    tgbtnBaoTriPhanMem.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["ThuongMaiDienTu"].ToString()) == 1)
                {
                    tgbtnThuongMaiDienTu.IsChecked = true;
                }
                else
                {
                    tgbtnThuongMaiDienTu.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["DoAn1"].ToString()) == 1)
                {
                    tgbtnDoAn1.IsChecked = true;
                }
                else
                {
                    tgbtnDoAn1.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["DoAn2"].ToString()) == 1)
                {
                    tgbtnDoAn2.IsChecked = true;
                }
                else
                {
                    tgbtnDoAn2.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["DoAn3"].ToString()) == 1)
                {
                    tgbtnDoAn3.IsChecked = true;
                }
                else
                {
                    tgbtnDoAn3.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["ChungChiNgoaiNgu"].ToString()) == 1)
                {
                    tgbtnChungChiNgoaiNgu.IsChecked = true;
                }
                else
                {
                    tgbtnChungChiNgoaiNgu.IsChecked = false;
                }

                if (Convert.ToInt32(_dataRow["HocPhanTuChon"].ToString()) == 1)
                {
                    tgbtnHocPhanTuChon.IsChecked = true;
                }
                else
                {
                    tgbtnHocPhanTuChon.IsChecked = false;
                }

                #endregion

            }
        }

        public void AddSubjectDebt(int idsinhvien, int toanroirac, int giaitich, int xacsuatthongke, int kythuatlaptrinh,
            int mangmaytinh, int cosodulieu, int kynanggiaotiep, int laptrinhhuongdoituong, int cautrucdulieugiaithuat, int hedieuhanh,
            int phantichthietke, int trituenhantao, int phanmemmanguonmo, int baotriphanmem, int thuongmaidientu, int doan1,
            int doan2, int doan3, int chungchingoaingu, int hocphantuchon)
        {
            if (SubjectDebtDAL.Instance.InsertSubjectDebt(idsinhvien, toanroirac, giaitich, xacsuatthongke, kythuatlaptrinh, mangmaytinh, cosodulieu, kynanggiaotiep, laptrinhhuongdoituong, cautrucdulieugiaithuat, hedieuhanh,
            phantichthietke, trituenhantao, phanmemmanguonmo, baotriphanmem, thuongmaidientu, doan1, doan2, doan3, chungchingoaingu, hocphantuchon))
            {
                MessageBox.Show("Thêm Thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void EditSubjectDebt(int idmonhoc, int toanroirac, int giaitich, int xacsuatthongke, int kythuatlaptrinh,
            int mangmaytinh, int cosodulieu, int kynanggiaotiep, int laptrinhhuongdoituong, int cautrucdulieugiaithuat, int hedieuhanh,
            int phantichthietke, int trituenhantao, int phanmemmanguonmo, int baotriphanmem, int thuongmaidientu, int doan1,
            int doan2, int doan3, int chungchingoaingu, int hocphantuchon)
        {
            if (SubjectDebtDAL.Instance.UpdateSubjectDebt(idmonhoc, toanroirac, giaitich, xacsuatthongke, kythuatlaptrinh, mangmaytinh, cosodulieu, kynanggiaotiep, laptrinhhuongdoituong, cautrucdulieugiaithuat, hedieuhanh,
                    phantichthietke, trituenhantao, phanmemmanguonmo, baotriphanmem, thuongmaidientu, doan1, doan2, doan3, chungchingoaingu, hocphantuchon))
            {
                MessageBox.Show("Cập nhật thông tin thành Công", "Thông Báo");
            }

            else
            {
                MessageBox.Show("Đã xảy ra lỗi\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadData();
        }

        public void DeleteSubjectDebt(int idmonhoc)
        {
            if (SubjectDebtDAL.Instance.DeleteSubjectDebt(idmonhoc))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadData();

        }

        private void BtnClosed_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
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
                    string[] _arrColumnHeader = { "Số Thứ Tự", "Tên Sinh Viên" , "Toán Rời Rạc" ,"Giải Tích","Xác Suất Thống Kê","Kỹ Thuật Lập Trình",
                    "Mạng Máy Tính","Cơ Sở Dữ Liệu","Kỹ Năng Giao Tiếp","Lập Trình Hướng Đối Tượng","Cấu Trúc Dữ Liệu Giải Thuật","Hệ Điều Hành",
                    "Phân Tích Thiết Kế","Trí Tuệ Nhân Tạo","Phần Mềm Mã Nguồn Mở","Bảo Trì Phần Mềm","Thương Mại Điện Tử",
                    "Đồ án 1","Đồ án 2","Đồ án 3","Chứng Chỉ Ngoại Ngữ","Học Phần Tự Chọn"};

                    var _countColumn = _arrColumnHeader.Count(); // đếm số lượng cột

                   // Gom cột
                    _currentSheet.Cells[1, 1].Value = "BÁO CÁO SINH VIÊN NỢ MÔN";
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

                    DataView view = (DataView)dtgSubjectDebt.ItemsSource;
                    DataTable dataTable = view.Table.Clone();
                    foreach (DataRowView item in view)
                    {
                        dataTable.ImportRow(item.Row);
                    }

                    var dataTableFromDataGrid = dataTable;

                    IEnumerable<SubjectDTO> l = GetEntities<SubjectDTO>(dataTableFromDataGrid);

                    List<SubjectDTO> list = l.ToList();

                    //với mỗi item trong danh sách sẽ ghi trên một dòng
                    foreach (var item in list)
                    {
                        _colIndex = 1; // cột 1

                        _rowIndex++; // dòng sẽ tự tăng

                        //gán trường TÊN cho cột 1, dòng++ các dòng sẽ tăng lên dòng tiếp theo khi gán xong
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.IDMonHoc;

                        //gán trường cho cột 1, dòng++, phải sắp xếp để không sai định dạng khi xuất ra file excel
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.HoTen.ToString();
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.ToanRoiRac;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.GiaiTich;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.XacSuatThongKe;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.KyThuatLapTrinh;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.MangMayTinh;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.CoSoDuLieu;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.KyNangGiaoTiep;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.LapTrinhHuongDoiTuong;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.CauTrucDuLieuGiaiThuat;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.HeDieuHanh;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.PhanTichThietke;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.TriTueNhanTao;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.PhanMemMaNguonMo;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.BaoTriPhanMem;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.ThuongMaiDienTu;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.DoAn1;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.DoAn2;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.DoAn3;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.ChungChiNgoaiNgu;
                        _currentSheet.Cells[_rowIndex, _colIndex++].Value = item.HocPhanTuChon;
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
