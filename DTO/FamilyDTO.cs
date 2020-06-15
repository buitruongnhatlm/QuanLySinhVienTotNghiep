using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class FamilyDTO
    {
        private string _HoTenCha;
        private DateTime _NamSinhCha;
        private int _DienThoaiCha;
        private string _HoTenMe;
        private DateTime _NamSinhMe;
        private int _DienThoaiMe;
        private string _DiaChi;
        private string _GhiChu;

        public string HoTenCha { get => _HoTenCha; set => _HoTenCha = value; }
        public int DienThoaiCha { get => _DienThoaiCha; set => _DienThoaiCha = value; }
        public string HoTenMe { get => _HoTenMe; set => _HoTenMe = value; }
        public DateTime NamSinhMe { get => _NamSinhMe; set => _NamSinhMe = value; }
        public int DienThoaiMe { get => _DienThoaiMe; set => _DienThoaiMe = value; }
        public string DiaChi { get => _DiaChi; set => _DiaChi = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public DateTime NamSinhCha { get => _NamSinhCha; set => _NamSinhCha = value; }

        public FamilyDTO(string hotencha, DateTime namsinhcha, int dienthoaicha, string hotenme, DateTime namsinhme , int dienthoaime, string diachi, string ghichu)
        {
            this.HoTenCha = hotencha;
            this.NamSinhCha = namsinhcha;
            this.DienThoaiCha = dienthoaicha;
            this.HoTenMe = hotenme;
            this.NamSinhMe = namsinhme;
            this.DienThoaiMe = dienthoaime;
            this.DiaChi = diachi;
            this.GhiChu = ghichu;
        }

        public FamilyDTO(DataRow row)
        {
            this.HoTenCha = row["HoTenCha"].ToString();
            this.NamSinhCha = Convert.ToDateTime(row["NamSinhCha"]);

            if(!string.IsNullOrEmpty(row["DienThoaiCha"].ToString()))
            {
                this.DienThoaiCha = Convert.ToInt32(row["DienThoaiCha"]);
            }
            
            this.HoTenMe = row["HoTenMe"].ToString();
            this.NamSinhMe = Convert.ToDateTime(row["NamSinhMe"]);

            if(!string.IsNullOrEmpty(row["DienThoaiMe"].ToString()))
            {
                this.DienThoaiMe = Convert.ToInt32(row["DienThoaiMe"]);
            }
            
            this.DiaChi = row["DiaChi"].ToString();

            if(!string.IsNullOrEmpty(row["GhiChu"].ToString()))
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
            
        }

    }
}
