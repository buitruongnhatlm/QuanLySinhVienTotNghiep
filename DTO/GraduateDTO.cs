using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class GraduateDTO
    {
        private DateTime? _NgayVaoTruong;
        private DateTime? _NgayTotNghiep;
        private DateTime? _NgayCapBang;
        private float _Diem10;
        private float _Diem4;
        private string _GhiChu;
        private int _IDLoaiTotNghiep;
        private int _IDHeDaoTao;
        private int _IDNghanh;
        private string _IDLop;
        private int _IDDiemChu;

        public DateTime? NgayVaoTruong { get => _NgayVaoTruong; set => _NgayVaoTruong = value; }
        public DateTime? NgayTotNghiep { get => _NgayTotNghiep; set => _NgayTotNghiep = value; }
        public DateTime? NgayCapBang { get => _NgayCapBang; set => _NgayCapBang = value; }
        public float Diem10 { get => _Diem10; set => _Diem10 = value; }
        public float Diem4 { get => _Diem4; set => _Diem4 = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDLoaiTotNghiep { get => _IDLoaiTotNghiep; set => _IDLoaiTotNghiep = value; }
        public int IDHeDaoTao { get => _IDHeDaoTao; set => _IDHeDaoTao = value; }
        public int IDNganh { get => _IDNghanh; set => _IDNghanh = value; }
        public string IDLop { get => _IDLop; set => _IDLop = value; }
        public int IDDiemChu { get => _IDDiemChu; set => _IDDiemChu = value; }

        public GraduateDTO(DateTime? ngayvaotruong, DateTime? ngaytotnghiep, DateTime? ngaycapbang, int diem10, int diem4, 
                           int idloaitotnghiep, int idhedaotao, int idnganh, string idlop, int iddiemchu, string ghichu)
        {
            this.NgayVaoTruong = ngayvaotruong;
            this.NgayTotNghiep = ngaytotnghiep;
            this.NgayCapBang = ngaycapbang;
            this.Diem10 = diem10;
            this.Diem4 = diem4;
            this.GhiChu = ghichu;
            this.IDLoaiTotNghiep = idloaitotnghiep;
            this.IDHeDaoTao = idhedaotao;
            this.IDNganh = idnganh;
            this.IDLop = idlop;
            this.IDDiemChu = iddiemchu;
        }

        public GraduateDTO(DataRow row)
        {
            this.NgayVaoTruong = Convert.ToDateTime(row["NgayVaoTruong"]);
            this.NgayTotNghiep = Convert.ToDateTime(row["NgayTotNghiep"]);
            this.NgayCapBang = Convert.ToDateTime(row["NgayCapBang"]);
            this.Diem10 = (float)(row["Diem10"]);
            this.Diem4 = (float)(row["Diem4"]);
            this.IDLoaiTotNghiep = Convert.ToInt32(row["IDLoaiTotNghiep"]);
            this.IDHeDaoTao = Convert.ToInt32(row["IDHeDaoTao"]);
            this.IDNganh = Convert.ToInt32(row["IDNganh"]);
            this.IDLop = row["IDLop"].ToString();
            this.IDDiemChu = Convert.ToInt32(row["IDDiemChu"]);

            if (row["GhiChu"]!=null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
            
        }

    }
}
