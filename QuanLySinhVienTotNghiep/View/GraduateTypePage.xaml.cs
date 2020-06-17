using System;
using System.Collections.Generic;
using System.Data;
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
using DTO;
using DAL;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for GraduateTypePage.xaml
    /// </summary>
    public partial class GraduateTypePage : Page
    {
        public GraduateTypePage()
        {
            InitializeComponent();
            LoadDataToDataGrid();
        }

        private void BtnThemLoaiTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            string _tenloaitotnghiep = txtTenLoaiTotNghiep.Text;
            string _ghichu = txtGhiChu.Text;

            if (CheckDataInput(_tenloaitotnghiep))
            {
                AddGraduateType(_tenloaitotnghiep, _ghichu);
                ClearDataTextbox(txtTenLoaiTotNghiep, txtGhiChu);
            }
        }

        private void BtnCapNhatLoaiTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            int _idloaitotnghiep = 0;
            DataRowView _rowCurrent = dtgGraduateType.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                _idloaitotnghiep = Convert.ToInt32(_rowCurrent["IDLoaiTotNghiep"].ToString());
            }

            string _tenloaitotnghiep = txtTenLoaiTotNghiep.Text;
            string _ghichu = txtGhiChu.Text;

            if (CheckDataInput(_tenloaitotnghiep))
            {
                EditGraduateType(_idloaitotnghiep, _tenloaitotnghiep, _ghichu);
                ClearDataTextbox(txtTenLoaiTotNghiep, txtGhiChu);
            }

        }

        private void BtnXoaLoaiTotNghiep_Click(object sender, RoutedEventArgs e)
        {
            int _idloaitotnghiep = 0;
            DataRowView _rowCurrent = dtgGraduateType.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idloaitotnghiep = Convert.ToInt32(_rowCurrent["IDLoaiTotNghiep"]);
                    DeleteGraduateType(_idloaitotnghiep);
                    ClearDataTextbox(txtTenLoaiTotNghiep,txtGhiChu);
                }
            }
        }


        private void BtnThemHeDaoTao_Click(object sender, RoutedEventArgs e)
        {
            string _tenhedaotao = txtTenHeDaoTao.Text;
            int _thoigiandaotao = Convert.ToInt32(txtThoiGianDaoTao.Text);
            string _ghichu = txtGhiChu.Text;

            if (CheckDataInput(_tenhedaotao))
            {
                AddTraining(_tenhedaotao, _thoigiandaotao, _ghichu);
                ClearDataTextbox(txtTenHeDaoTao, txtThoiGianDaoTao, txtGhiChuHeDaoTao);
            }
        }

        private void BtnCapNhatHeDaoTao_Click(object sender, RoutedEventArgs e)
        {
            int _idHeDaoTao = 0;
            DataRowView _rowCurrent = dtgHeDaoTao.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                _idHeDaoTao = Convert.ToInt32(_rowCurrent["IDHeDaoTao"].ToString());
            }

            string _tenhedaotao = txtTenHeDaoTao.Text;
            int _thoigiandaotao = Convert.ToInt32(txtThoiGianDaoTao.Text);
            string _ghichu = txtGhiChuHeDaoTao.Text;

            if (CheckDataInput(_tenhedaotao))
            {
                EditTraining(_idHeDaoTao, _tenhedaotao, _thoigiandaotao, _ghichu);
                ClearDataTextbox(txtTenHeDaoTao, txtThoiGianDaoTao, txtGhiChuHeDaoTao);
            }
        }

        private void BtnXoaHeDaoTao_Click(object sender, RoutedEventArgs e)
        {
            int _idhedaotao = 0;
            DataRowView _rowCurrent = dtgHeDaoTao.SelectedItem as DataRowView;

            if (_rowCurrent != null)
            {
                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _idhedaotao = Convert.ToInt32(_rowCurrent["IDHeDaoTao"]);
                    DeleteTraining(_idhedaotao);
                    ClearDataTextbox(txtTenHeDaoTao, txtThoiGianDaoTao, txtGhiChuHeDaoTao);
                }
            }
        }


        private void BtnThemDiem_Click(object sender, RoutedEventArgs e)
        {
            string _tendiem = txtDiemChu.Text;
            int _iddiemchu = Convert.ToInt32(txtIDiemChu.Text);
            string _ghichu = txtGhiChuDiem.Text;

            AddMark(_iddiemchu, _tendiem, _ghichu);
            ClearDataTextbox(txtDiemChu, txtIDiemChu, txtGhiChuDiem);

        }

        private void BtnCapNhatDiem_Click(object sender, RoutedEventArgs e)
        {
            int _idDiem = Convert.ToInt32(txtIDiemChu.Text);
            string _tendiem = txtDiemChu.Text;
            string _ghichu = txtGhiChuDiem.Text;

            EditMark(_idDiem, _tendiem, _ghichu);
            ClearDataTextbox(txtIDiemChu, txtDiemChu, txtGhiChuDiem);
        }

        private void BtnXoaDiem_Click(object sender, RoutedEventArgs e)
        {
            int _iddiem = 0;

                if (MessageBox.Show("Are you sure Delete?", "Delete Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    _iddiem = Convert.ToInt32(txtIDiemChu.Text);
                    DeleteMark(_iddiem);
                    ClearDataTextbox(txtDiemChu, txtIDiemChu, txtGhiChuDiem);
                }
        }

        private void DtgHeDaoTao_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtTenHeDaoTao.Text = _dataRow["TenHeDaoTao"].ToString();
                txtThoiGianDaoTao.Text = _dataRow["ThoiGianDaoTao"].ToString();
                txtGhiChuHeDaoTao.Text = _dataRow["GhiChu"].ToString();
            }
        }

        private void DtgGraduateType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtTenLoaiTotNghiep.Text = _dataRow["TenLoaiTotNghiep"].ToString();
                txtGhiChu.Text = _dataRow["GhiChu"].ToString();
            }
        }

        private void DtgDiem_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataGrid _dataGrid = sender as DataGrid;
            DataRowView _dataRow = _dataGrid.SelectedItem as DataRowView;

            if (_dataGrid != null && _dataRow != null)
            {
                txtIDiemChu.Text = _dataRow["IDDiemChu"].ToString();
                txtDiemChu.Text = _dataRow["TenDiem"].ToString();
                txtGhiChuDiem.Text = _dataRow["GhiChu"].ToString();
            }
        }


        public void AddGraduateType(string tenloaitotnghiep, string ghichu = null)
        {
            if (GraduateTypeDAL.Instance.InsertGraduateType(tenloaitotnghiep,ghichu))
            {
                MessageBox.Show("Thêm Loại Tốt Nghiệp Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Loại Tốt Nghiệp Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToGraduateTypeDataGrid();
        }

        public void AddTraining(string tenloaitotnghiep,int thoigiandaotao ,string ghichu=null)
        {
            if (TrainingDAL.Instance.InsertTraining(tenloaitotnghiep,thoigiandaotao,ghichu))
            {
                MessageBox.Show("Thêm Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }
            LoadDataToTrainingDataGrid();
        }

        public void AddMark(int iddiemchu, string tendiem, string ghichu = null)
        {
            if (MarkDAL.Instance.InsertMark(iddiemchu, tendiem, ghichu))
            {
                MessageBox.Show("Thêm Thành Công");
            }
            else
            {
                MessageBox.Show("Thêm Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToMarkGrid();
        }

        public void EditGraduateType(int idloaitotnghiep, string tenloaitotnghiep, string ghichu = null)
        {
            if (GraduateTypeDAL.Instance.UpdateGraduateType(idloaitotnghiep,tenloaitotnghiep, ghichu))
            {
                MessageBox.Show("Cập Nhật Loại Tốt Nghiệp Thành Công");
            }
            else
            {
                MessageBox.Show("Cập Nhật Loại Tốt Nghiệp Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToGraduateTypeDataGrid();
        }

        public void EditTraining(int idhedaotao, string tenhedaotao, int thoigiandaotao, string ghichu=null)
        {
            if (TrainingDAL.Instance.UpdateTraining(idhedaotao,tenhedaotao,thoigiandaotao,ghichu))
            {
                MessageBox.Show("Cập Nhật Thành Công");
            }
            else
            {
                MessageBox.Show("Cập Nhật Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToTrainingDataGrid();
        }

        public void EditMark(int iddiemchu, string tendiem, string ghichu = null)
        {
            if (MarkDAL.Instance.UpdateMark(iddiemchu, tendiem, ghichu))
            {
                MessageBox.Show("Cập Nhật Thành Công");
            }
            else
            {
                MessageBox.Show("Cập Nhật Không Thành Công\n Vui Lòng Kiểm Tra lại", "Thông Báo");
            }

            LoadDataToMarkGrid();
        }

        public void DeleteGraduateType(int idloaitotnghiep)
        {
            if (GraduateTypeDAL.Instance.DeleteGraduateType(idloaitotnghiep))
            {
                MessageBox.Show("Xóa Loại Tốt Nghiệp Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadDataToGraduateTypeDataGrid();
        }

        public void DeleteTraining(int idhedaotao)
        {
            if (TrainingDAL.Instance.DeleteTraining(idhedaotao))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadDataToTrainingDataGrid();
        }

        public void DeleteMark(int iddiemchu)
        {
            if (MarkDAL.Instance.DeleteMark(iddiemchu))
            {
                MessageBox.Show("Xóa Thành Công", "Thông Báo");
            }
            else
            {
                MessageBox.Show("Xóa không thành công do xảy ra lỗi", "Thông Báo");
            }

            LoadDataToMarkGrid();
        }

        public void ClearDataTextbox(params TextBox[] array)
        {
            foreach (TextBox item in array)
            {
                item.Text = "";
            }
        }

        public void LoadDataToGraduateTypeDataGrid()
        {
            dtgGraduateType.ItemsSource = GraduateTypeDAL.Instance.GetListGraduateType().DefaultView;
        }

        public void LoadDataToTrainingDataGrid()
        {
            dtgHeDaoTao.ItemsSource = TrainingDAL.Instance.GetListTraining().DefaultView;
        }

        public void LoadDataToMarkGrid()
        {
            dtgDiem.ItemsSource = MarkDAL.Instance.GetListMark().DefaultView;
        }

        public bool CheckDataInput(string tenloaitotnghiep)
        {
            string _patternChar = @"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" + "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" + "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";

            Regex _regexChar = new Regex(_patternChar);

            if (_regexChar.IsMatch(tenloaitotnghiep))
            {
                return true;
            }
            else
            {
                MessageBox.Show("Dữ Liệu Nhập vào không đúng định dạng");
                return false;
            }

        }

        public void LoadDataToDataGrid()
        {
            LoadDataToGraduateTypeDataGrid();
            LoadDataToTrainingDataGrid();
            LoadDataToMarkGrid();
        }

        
    }
}
