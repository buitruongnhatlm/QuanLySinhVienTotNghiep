using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class DataProvider
    {
        private string _connectionString = @"Data Source=(local);Initial Catalog=QuanLySinhVienTotNghiep;Integrated Security=True";

        private static DataProvider _instance;

        public static DataProvider Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new DataProvider();
                }
                return DataProvider._instance;
            }
            private set => _instance = value;

        }

        private DataProvider() { }


        #region ExcuteQuery (hàm thực thi truy vấn trả về kết quả dạng table)

        // truyền vào câu truy vấn và mảng parameter để đáp ứng cho việc nhập, truy vấn nhiều tên
        public DataTable ExcuteQuery(string _query, object[] _arrayParameter = null)
        {
            DataTable _table = new DataTable();

            /* sử dụng using để giải phóng bộ nhớ sau khi kết thúc khối lệnh 
                đảm bảo khi có lỗi bên trong khối lệnh hàm vẫn sẽ được giải phóng */

            using (SqlConnection _connect = new SqlConnection(_connectionString))
            {
                _connect.Open();

                SqlCommand _cmd = new SqlCommand(_query, _connect);

                if (_arrayParameter != null)
                {
                    string[] _listParameter = _query.Split(' ');

                    int i = 0;

                    foreach (string item in _listParameter)
                    {
                        if (item.Contains("@"))
                        {
                            _cmd.Parameters.AddWithValue(item, _arrayParameter[i]);
                            i++;
                        }
                    }

                }

                SqlDataAdapter _adapter = new SqlDataAdapter(_cmd);

                _adapter.Fill(_table);

                _connect.Close();

            }

            return _table;
        }

        #endregion

        #region ExcuteNonQuery (hàm thực thi truy vấn trả về kết quả là số dòng thực hiện truy vấn thành công)

        // truyền vào câu truy vấn và mảng parameter để đáp ứng cho việc nhập, truy vấn nhiều tên
        public int ExcuteNonQuery(string _query, object[] _arrayParameter = null)
        {
            /* sử dụng using để giải phóng bộ nhớ sau khi kết thúc khối lệnh 
                đảm bảo khi có lỗi bên trong khối lệnh hàm vẫn sẽ được giải phóng */

            int _countSuccess = 0;

            using (SqlConnection _connect = new SqlConnection(_connectionString))
            {
                _connect.Open();

                SqlCommand _cmd = new SqlCommand(_query, _connect);

                if (_arrayParameter != null)
                {
                    string[] _listParameter = _query.Split(' ');

                    int i = 0;

                    foreach (string item in _listParameter)
                    {
                        if (item.Contains("@"))
                        {
                            _cmd.Parameters.AddWithValue(item, _arrayParameter[i]);
                            i++;
                        }
                    }

                }

                _countSuccess = _cmd.ExecuteNonQuery();

                _connect.Close();

            }

            return _countSuccess;
        }

        #endregion

        #region ExcuteSalar (hàm thực thi truy vấn trả về dòng và cột đầu tiên trong kết quả)
        // truyền vào câu truy vấn và mảng parameter để đáp ứng cho việc nhập, truy vấn nhiều tên
        public object ExcuteSalar(string _query, object[] _arrayParameter = null)
        {
            /* sử dụng using để giải phóng bộ nhớ sau khi kết thúc khối lệnh 
                đảm bảo khi có lỗi bên trong khối lệnh hàm vẫn sẽ được giải phóng */

            object _FirstResult = 0;

            using (SqlConnection _connect = new SqlConnection(_connectionString))
            {
                _connect.Open();

                SqlCommand _cmd = new SqlCommand(_query, _connect);

                if (_arrayParameter != null)
                {
                    string[] _listParameter = _query.Split(' ');

                    int i = 0;

                    foreach (string item in _listParameter)
                    {
                        if (item.Contains("@"))
                        {
                            _cmd.Parameters.AddWithValue(item, _arrayParameter[i]);
                            i++;
                        }
                    }

                }

                _FirstResult = _cmd.ExecuteScalar();

                _connect.Close();

            }

            return _FirstResult;
        }

        #endregion

    }
}
