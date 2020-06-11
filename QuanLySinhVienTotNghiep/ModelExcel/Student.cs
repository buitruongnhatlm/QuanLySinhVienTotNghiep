using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLySinhVienTotNghiep.ModelExcel
{
    [Serializable]

    public class Student
    {
        public string HoTen { get; set; }
        public int MaSoSinhVien { get; set; }
        public string GioiTinh { get; set; }
        public DateTime NgaySinh { get; set; }
        public string NoiSinh { get; set; }
        public string DiaChiThuongTru { get; set; }
        public string DanToc { get; set; }
        public string TonGiao { get; set; }
        public int ChungMinhNhanDan { get; set; }
        public DateTime NgayCap { get; set; }
        public DateTime NgayVaoDoan { get; set; }
        public DateTime NgayVaoDang { get; set; }
        public string DienThoai { get; set; }
        public string Email { get; set; }
        public string GhiChu { get; set; }
        public int IDGiaDinh { get; set; }
        public int IDTaiKhoan { get; set; }
        public int IDThongTinTotNghiep { get; set; }

    }
}
