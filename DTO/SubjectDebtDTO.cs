using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class SubjectDebtDTO
    {
        private int _IDSinhVien;
        private int _ToanRoiRac;
        private int _GiaiTich;
        private int _XacSuatThongKe;
        private int _KyThuatLapTrinh;
        private int _MangMayTinh;
        private int _CoSoDuLieu;
        private int _KyNangGiaoTiep;
        private int _LapTrinhHuongDoiTuong;
        private int _CauTrucDuLieuGiaiThuat;
        private int _HeDieuHanh;
        private int _PhanTichThietke;
        private int _TriTueNhanTao;
        private int _PhanMemMaNguonMo;
        private int _BaoTriPhanMem;
        private int _ThuongMaiDienTu;
        private int _DoAn1;
        private int _DoAn2;
        private int _DoAn3;
        private int _ChungChiNgoaiNgu;
        private int _HocPhanTuChon;

        public int IDSinhVien { get => _IDSinhVien; set => _IDSinhVien = value; }
        public int ToanRoiRac { get => _ToanRoiRac; set => _ToanRoiRac = value; }
        public int GiaiTich { get => _GiaiTich; set => _GiaiTich = value; }
        public int XacSuatThongKe { get => _XacSuatThongKe; set => _XacSuatThongKe = value; }
        public int KyThuatLapTrinh { get => _KyThuatLapTrinh; set => _KyThuatLapTrinh = value; }
        public int MangMayTinh { get => _MangMayTinh; set => _MangMayTinh = value; }
        public int CoSoDuLieu { get => _CoSoDuLieu; set => _CoSoDuLieu = value; }
        public int KyNangGiaoTiep { get => _KyNangGiaoTiep; set => _KyNangGiaoTiep = value; }
        public int LapTrinhHuongDoiTuong { get => _LapTrinhHuongDoiTuong; set => _LapTrinhHuongDoiTuong = value; }
        public int CauTrucDuLieuGiaiThuat { get => _CauTrucDuLieuGiaiThuat; set => _CauTrucDuLieuGiaiThuat = value; }
        public int HeDieuHanh { get => _HeDieuHanh; set => _HeDieuHanh = value; }
        public int PhanTichThietke { get => _PhanTichThietke; set => _PhanTichThietke = value; }
        public int TriTueNhanTao { get => _TriTueNhanTao; set => _TriTueNhanTao = value; }
        public int PhanMemMaNguonMo { get => _PhanMemMaNguonMo; set => _PhanMemMaNguonMo = value; }
        public int BaoTriPhanMem { get => _BaoTriPhanMem; set => _BaoTriPhanMem = value; }
        public int ThuongMaiDienTu { get => _ThuongMaiDienTu; set => _ThuongMaiDienTu = value; }
        public int DoAn1 { get => _DoAn1; set => _DoAn1 = value; }
        public int DoAn2 { get => _DoAn2; set => _DoAn2 = value; }
        public int DoAn3 { get => _DoAn3; set => _DoAn3 = value; }
        public int ChungChiNgoaiNgu { get => _ChungChiNgoaiNgu; set => _ChungChiNgoaiNgu = value; }
        public int HocPhanTuChon { get => _HocPhanTuChon; set => _HocPhanTuChon = value; }

        public SubjectDebtDTO(int idsinhvien, int toanroirac, int giaitich, int xacsuatthongke, int kythuatlaptrinh, 
            int mangmaytinh, int cosodulieu, int kynanggiaotiep, int laptrinhhuongdoituong, int cautrucdulieugiaithuat, int hedieuhanh,
            int phantichthietke, int trituenhantao, int phanmemmanguonmo, int baotriphanmem, int thuongmaidientu, int doan1,
            int doan2, int doan3, int chungchingoaingu, int hocphantuchon)
        {
            this.IDSinhVien = idsinhvien;
            this.ToanRoiRac = toanroirac;
            this.GiaiTich = giaitich;
            this.XacSuatThongKe = xacsuatthongke;
            this.KyThuatLapTrinh = kythuatlaptrinh;
            this.MangMayTinh = mangmaytinh;
            this.CoSoDuLieu = cosodulieu;
            this.KyNangGiaoTiep = kynanggiaotiep;
            this.LapTrinhHuongDoiTuong = laptrinhhuongdoituong;
            this.CauTrucDuLieuGiaiThuat = cautrucdulieugiaithuat;
            this.HeDieuHanh = hedieuhanh;
            this.PhanTichThietke = phantichthietke;
            this.TriTueNhanTao = trituenhantao;
            this.PhanMemMaNguonMo = phanmemmanguonmo;
            this.BaoTriPhanMem = baotriphanmem;
            this.ThuongMaiDienTu = thuongmaidientu;
            this.DoAn1 = doan1;
            this.DoAn2 = doan2;
            this.DoAn3 = doan3;
            this.ChungChiNgoaiNgu = chungchingoaingu;
            this.HocPhanTuChon = hocphantuchon;
        }

        public SubjectDebtDTO(DataRow row)
        {
            this.IDSinhVien = Convert.ToInt32(row["IDSinhVien"]);
            this.ToanRoiRac = Convert.ToInt32(row["ToanRoiRac"]);
            this.GiaiTich = Convert.ToInt32(row["GiaiTich"]);
            this.XacSuatThongKe = Convert.ToInt32(row["XacSuatThongKe"]);
            this.KyThuatLapTrinh = Convert.ToInt32(row["KyThuatLapTrinh"]);
            this.MangMayTinh = Convert.ToInt32(row["MangMayTinh"]);
            this.CoSoDuLieu = Convert.ToInt32(row["CoSoDuLieu"]);
            this.KyNangGiaoTiep = Convert.ToInt32(row["KyNangGiaoTiep"]);
            this.LapTrinhHuongDoiTuong = Convert.ToInt32(row["LapTrinhHuongDoiTuong"]);
            this.CauTrucDuLieuGiaiThuat = Convert.ToInt32(row["CauTrucDuLieuGiaiThuat"]);
            this.HeDieuHanh = Convert.ToInt32(row["HeDieuHanh"]);
            this.PhanTichThietke = Convert.ToInt32(row["PhanTichThietke"]);
            this.TriTueNhanTao = Convert.ToInt32(row["TriTueNhanTao"]);
            this.PhanMemMaNguonMo = Convert.ToInt32(row["PhanMemMaNguonMo"]);
            this.BaoTriPhanMem = Convert.ToInt32(row["BaoTriPhanMem"]);
            this.ThuongMaiDienTu = Convert.ToInt32(row["ThuongMaiDienTu"]);
            this.DoAn1 = Convert.ToInt32(row["DoAn1"]);
            this.DoAn2 = Convert.ToInt32(row["DoAn2"]);
            this.DoAn3 = Convert.ToInt32(row["DoAn3"]);
            this.ChungChiNgoaiNgu = Convert.ToInt32(row["ChungChiNgoaiNgu"]);
            this.HocPhanTuChon = Convert.ToInt32(row["HocPhanTuChon"]);
        }

    }

    public class SubjectDTO
    {
        private int _IDMonHoc;
        private string _HoTen;
        private int _ToanRoiRac;
        private int _GiaiTich;
        private int _XacSuatThongKe;
        private int _KyThuatLapTrinh;
        private int _MangMayTinh;
        private int _CoSoDuLieu;
        private int _KyNangGiaoTiep;
        private int _LapTrinhHuongDoiTuong;
        private int _CauTrucDuLieuGiaiThuat;
        private int _HeDieuHanh;
        private int _PhanTichThietke;
        private int _TriTueNhanTao;
        private int _PhanMemMaNguonMo;
        private int _BaoTriPhanMem;
        private int _ThuongMaiDienTu;
        private int _DoAn1;
        private int _DoAn2;
        private int _DoAn3;
        private int _ChungChiNgoaiNgu;
        private int _HocPhanTuChon;

        public int IDMonHoc { get => _IDMonHoc; set => _IDMonHoc = value; }
        public int ToanRoiRac { get => _ToanRoiRac; set => _ToanRoiRac = value; }
        public int GiaiTich { get => _GiaiTich; set => _GiaiTich = value; }
        public int XacSuatThongKe { get => _XacSuatThongKe; set => _XacSuatThongKe = value; }
        public int KyThuatLapTrinh { get => _KyThuatLapTrinh; set => _KyThuatLapTrinh = value; }
        public int MangMayTinh { get => _MangMayTinh; set => _MangMayTinh = value; }
        public int CoSoDuLieu { get => _CoSoDuLieu; set => _CoSoDuLieu = value; }
        public int KyNangGiaoTiep { get => _KyNangGiaoTiep; set => _KyNangGiaoTiep = value; }
        public int LapTrinhHuongDoiTuong { get => _LapTrinhHuongDoiTuong; set => _LapTrinhHuongDoiTuong = value; }
        public int CauTrucDuLieuGiaiThuat { get => _CauTrucDuLieuGiaiThuat; set => _CauTrucDuLieuGiaiThuat = value; }
        public int HeDieuHanh { get => _HeDieuHanh; set => _HeDieuHanh = value; }
        public int PhanTichThietke { get => _PhanTichThietke; set => _PhanTichThietke = value; }
        public int TriTueNhanTao { get => _TriTueNhanTao; set => _TriTueNhanTao = value; }
        public int PhanMemMaNguonMo { get => _PhanMemMaNguonMo; set => _PhanMemMaNguonMo = value; }
        public int BaoTriPhanMem { get => _BaoTriPhanMem; set => _BaoTriPhanMem = value; }
        public int ThuongMaiDienTu { get => _ThuongMaiDienTu; set => _ThuongMaiDienTu = value; }
        public int DoAn1 { get => _DoAn1; set => _DoAn1 = value; }
        public int DoAn2 { get => _DoAn2; set => _DoAn2 = value; }
        public int DoAn3 { get => _DoAn3; set => _DoAn3 = value; }
        public int ChungChiNgoaiNgu { get => _ChungChiNgoaiNgu; set => _ChungChiNgoaiNgu = value; }
        public int HocPhanTuChon { get => _HocPhanTuChon; set => _HocPhanTuChon = value; }
        public string HoTen { get => _HoTen; set => _HoTen = value; }
    }

}
