using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class TrainingDTO
    {
        private string _TenHeDaoTao;
        private int _ThoiGianDaoTao;
        private string _GhiChu;

        public string TenHeDaoTao { get => _TenHeDaoTao; set => _TenHeDaoTao = value; }
        public int ThoiGianDaoTao { get => _ThoiGianDaoTao; set => _ThoiGianDaoTao = value; }
        public string GhiChu { get => _GhiChu; set => _GhiChu = value; }

        public TrainingDTO(string tenhedaotao, int thoigiandaotao, string ghichu)
        {
            this.TenHeDaoTao = tenhedaotao;
            this.ThoiGianDaoTao = thoigiandaotao;
            this.GhiChu = ghichu;
        }

        public TrainingDTO(DataRow row)
        {
            this.TenHeDaoTao = row["TenHeDaoTao"].ToString();
            this.ThoiGianDaoTao = Convert.ToInt32(row["ThoiGianDaoTao"].ToString());

            if(row["GhiChu"]!=null)
            {
                this.GhiChu = row["GhiChu"].ToString();
            }
            
        }

    }
}
