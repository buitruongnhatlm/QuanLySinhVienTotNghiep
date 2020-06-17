using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class MarkDTO
    {
        private int _IDDiemChu;
        private string _TenDiem;
        private string _GhiChu;

        public string TenDiem { get => _TenDiem; set => _TenDiem = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }
        public int IDDiemChu { get => _IDDiemChu; set => _IDDiemChu = value; }

        public MarkDTO(int iddiemchu, string tendiem, string ghichu)
        {
            this.IDDiemChu = iddiemchu;
            this.TenDiem = tendiem;
            this.GhiChu = ghichu;
        }

        public MarkDTO(DataRow row)
        {
            this.IDDiemChu = Convert.ToInt32(row["IDDiemChu"].ToString());

            this.TenDiem = row["TenDiem"].ToString();

            if (row["GhiChu"] != null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
        }

    }
}
