using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class ClassDTO
    {
        private string _MaLop;
        private string _TenLop;
        private int _SoLuongSinhVien;
        private string _CoVan;
        private string _GhiChu;
        private int _IDKhoa;

        public string MaLop { get => _MaLop; set => _MaLop = value; }
        public string TenLop { get => _TenLop; set => _TenLop = value; }
        public int SoLuongSinhVien { get => _SoLuongSinhVien; set => _SoLuongSinhVien = value; }
        public string CoVan { get => _CoVan; set => _CoVan = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDKhoa { get => _IDKhoa; set => _IDKhoa = value; }

        public ClassDTO(string malop, string tenlop, int soluongsinhvien, string covan, int idkhoa, string ghichu)
        {
            this.MaLop = malop;
            this.TenLop = tenlop;
            this.SoLuongSinhVien = soluongsinhvien;
            this.CoVan = covan;
            this.IDKhoa = idkhoa;
            this.GhiChu = ghichu;
        }

        public ClassDTO(DataRow row)
        {
            this.MaLop = row["MaLop"].ToString();
            this.TenLop = row["TenLop"].ToString();
            this.SoLuongSinhVien = Convert.ToInt32(row["SoLuongSinhVien"]);
            this.CoVan = row["CoVan"].ToString();
            this.IDKhoa = Convert.ToInt32(row["IDKhoa"]);

            if(row["GhiChu"]!=null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
        }
    }
}
