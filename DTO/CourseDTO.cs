using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
   public class CourseDTO
    {
        private int _MaKhoa;
        private string _TenKhoa;
        private string _GhiChu;

        public int MaKhoa { get => _MaKhoa; set => _MaKhoa = value; }
        public string TenKhoa { get => _TenKhoa; set => _TenKhoa = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }

        public CourseDTO(int makhoa, string tenkhoa, string ghichu)
        {
            this.MaKhoa = makhoa;
            this.TenKhoa = tenkhoa;
            this.GhiChu = ghichu;
        }

        public CourseDTO(DataRow row)
        {

            this.MaKhoa = Convert.ToInt32(row["MaKhoa"]);
            this.TenKhoa = row["TenKhoa"].ToString();

            if (row["GhiChu"] != null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
        }

    }
}
