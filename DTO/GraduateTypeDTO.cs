using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    class GraduateTypeDTO
    {
        private string _TenLoaiTotNghiep;
        private string _GhiChu;

        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public string TenLoaiTotNghiep { get => _TenLoaiTotNghiep; set => _TenLoaiTotNghiep = value; }

        public GraduateTypeDTO(string tenloaitotnghiep, string ghichu)
        {
            this.TenLoaiTotNghiep = tenloaitotnghiep;
            this.GhiChu = ghichu;
        }

        public GraduateTypeDTO(DataRow row)
        {
            this.TenLoaiTotNghiep = row["TenLoaiTotNghiep"].ToString();

            if(row["GhiChu"]!=null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
        }

    }
}
