using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
   public class SubjectDebtDAL
   {
        private static SubjectDebtDAL _instance;

        public static SubjectDebtDAL Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new SubjectDebtDAL();
                }
                return _instance;
            }

            private set => _instance = value;
        }

        private SubjectDebtDAL() { }

        public DataTable GetListSubjectDebt()
        {
            return DataProvider.Instance.ExcuteQuery(" EXECUTE dbo.pro_GetListSubjectDebt ");
        }

        public bool InsertSubjectDebt(int idsinhvien, int toanroirac, int giaitich, int xacsuatthongke, int kythuatlaptrinh,
            int mangmaytinh, int cosodulieu, int kynanggiaotiep, int laptrinhhuongdoituong, int cautrucdulieugiaithuat, int hedieuhanh,
            int phantichthietke, int trituenhantao, int phanmemmanguonmo, int baotriphanmem, int thuongmaidientu, int doan1,
            int doan2, int doan3, int chungchingoaingu, int hocphantuchon)
        {
            string _query = string.Format(" INSERT INTO dbo.MonHoc ( IDSinhVien , ToanRoiRac , GiaiTich , XacSuatThongKe , KyThuatLapTrinh , MangMayTinh , CoSoDuLieu , KyNangGiaoTiep, LapTrinhHuongDoiTuong, CauTrucDuLieuGiaiThuat, HeDieuHanh, PhanTichThietKe, TriTueNhanTao, PhanMemMaNguonMo, BaoTriPhanMem, ThuongMaiDienTu, DoAn1, DoAn2, DoAn3, ChungChiNgoaiNgu, HocPhanTuChon) VALUES ({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}, {17}, {18}, {19}, {20}) ",
            idsinhvien,toanroirac,giaitich,xacsuatthongke,kythuatlaptrinh,mangmaytinh,cosodulieu,kynanggiaotiep,laptrinhhuongdoituong,cautrucdulieugiaithuat,hedieuhanh,
            phantichthietke,trituenhantao,phanmemmanguonmo,baotriphanmem,thuongmaidientu,doan1,doan2,doan3,chungchingoaingu,hocphantuchon);

            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool UpdateSubjectDebt(int idmonhoc, int toanroirac, int giaitich, int xacsuatthongke, int kythuatlaptrinh,
            int mangmaytinh, int cosodulieu, int kynanggiaotiep, int laptrinhhuongdoituong, int cautrucdulieugiaithuat, int hedieuhanh,
            int phantichthietke, int trituenhantao, int phanmemmanguonmo, int baotriphanmem, int thuongmaidientu, int doan1,
            int doan2, int doan3, int chungchingoaingu, int hocphantuchon)
        {

            string _query = string.Format(" UPDATE dbo.MonHoc SET ToanRoiRac ={1} , GiaiTich ={2}, XacSuatThongKe ={3}, KyThuatLapTrinh ={4}, MangMayTinh ={5}, CoSoDuLieu ={6}, KyNangGiaoTiep = {7}, LapTrinhHuongDoiTuong = {8}, CauTrucDuLieuGiaiThuat = {9}, HeDieuHanh = {10}, PhanTichThietKe = {11}, TriTueNhanTao = {12}, PhanMemMaNguonMo = {13}, BaoTriPhanMem = {14}, ThuongMaiDienTu = {15}, DoAn1 = {16}, DoAn2 = {17}, DoAn3 = {18}, ChungChiNgoaiNgu = {19}, HocPhanTuChon = {20} WHERE IDMonHoc = {0} ",
                idmonhoc, toanroirac, giaitich, xacsuatthongke, kythuatlaptrinh, mangmaytinh, cosodulieu, kynanggiaotiep, laptrinhhuongdoituong, cautrucdulieugiaithuat, hedieuhanh,
                phantichthietke, trituenhantao, phanmemmanguonmo, baotriphanmem, thuongmaidientu, doan1, doan2, doan3, chungchingoaingu, hocphantuchon);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

        public bool DeleteSubjectDebt(int idmonhoc)
        {
            string _query = string.Format(" DELETE dbo.MonHoc WHERE IDMonHoc={0} ", idmonhoc);
            int _result = DataProvider.Instance.ExcuteNonQuery(_query);
            return _result > 0;
        }

    }
}
