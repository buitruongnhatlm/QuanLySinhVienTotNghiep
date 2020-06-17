using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class ProfessionDTO
    {
        private string _TenNganh;
        private string _GhiChu;

        public string TenNganh { get => _TenNganh; set => _TenNganh = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }

        public ProfessionDTO(string tennganh, string ghichu)
        {
            this.TenNganh = tennganh;
            this.GhiChu = ghichu;
        }

        public ProfessionDTO(DataRow row)
        {
            this.TenNganh = row["TenNganh"].ToString();

            if(row["GhiChu"]!=null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
        }
    }
}
