using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Forms;
using DTO;
using DAL;
using MessageBox = System.Windows.Forms.MessageBox;
using Panel = System.Windows.Forms.Panel;
using System.Security.Cryptography;
using System.Drawing;
using Color = System.Drawing.Color;
using System.Drawing.Drawing2D;
using Pen = System.Drawing.Pen;
using Brushes = System.Drawing.Brushes;

namespace QuanLySinhVienTotNghiep.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();
            //CreateCaptcha();
            captcha();
        }

        private void btnDangNhap_Click(object sender, RoutedEventArgs e)
        {
            string _taiKhoan = txtTaiKhoan.Text;
            string _matKhau = txtMatKhau.Password;
            if (CheckLogin(_taiKhoan,_matKhau))
            {
                if (!string.IsNullOrEmpty(txtRecaptcha.Text))
                {
                    if (lblCaptcha.Content==txtRecaptcha.Text)
                    {
                        Home _page = new Home();
                        _page.Show();
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("Mã xác nhận không chính xác");
                    }
                }
                else
                {
                    MessageBox.Show("Bạn chưa nhập mã xác nhận");
                }
                
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu", "THÔNG BÁO");
            }

        }

        private bool CheckLogin(string taiKhoan, string matKhau)
        {
            return AccountDAL.Instance.Login(taiKhoan,matKhau);
        }

        #region Recaptcha

        //private string _captchaText;

        //#region hàm random chuỗi ngẫu nhiên
        //public String RandomString()
        //{
        //    Random _random = new Random();
        //    int _number = _random.Next(10000, 99999);

        //    // chuyển dãy số vừa random thành chuỗi bằng ToString()
        //    // đưa chuỗi vừa chuyển vào hàm mã hóa md5
        //    // cắt 6 kí tự để lấy recaptcha và in hoa lên.
        //    string _text = md5(_number.ToString());
        //    _text = _text.ToUpper();
        //    _text = _text.Substring(0, 6);

        //    return _text;

        //}
        //#endregion

        //#region hàm mã hóa MD5
        //public static byte[] EncryptData(string data)
        //{
        //    // tạo đối tượng MD5
        //    MD5CryptoServiceProvider _md5Hasher = new MD5CryptoServiceProvider();

        //    // tạo mảng byte lưu trữ kết quả
        //    byte[] _hashedByte;

        //    UTF8Encoding _encoder = new UTF8Encoding();

        //    // chuyển chuỗi data thành mảng byte
        //    // chuyển thành kí tự utf8
        //    // đưa vào hàm băm của lớp md5 
        //    // gán giá trị cho mảng byte lúc đầu

        //    _hashedByte = _md5Hasher.ComputeHash(_encoder.GetBytes(data));

        //    return _hashedByte;
        //}

        //// hàm chuyển lại mảng byte thành chuỗi
        //public static string md5(string data)
        //{
        //    // hàm BitConverter.ToString() sẽ chuyển 1 mảng byte thành chuỗi kèm theo "-"
        //    // do hàm BitConverter.ToString() sẽ trả ra 1 chuỗi byte dạng "-" nên cần thay thế "-" thành ""
        //    return BitConverter.ToString(EncryptData(data)).Replace("-", "").ToLower();
        //}

        //#endregion

        //#region hàm chuyển chuỗi thành hình ảnh recaptcha
        //private Bitmap drawImageCaptcha(string text, int width, int heigh)
        //{
        //    Random _random = new Random();

        //    // tạo 1 bitmap để vẽ lên
        //    Bitmap _bitmap = new Bitmap(width, heigh);

        //    // tạo 1 đối tượng graphic 
        //    Graphics _graphic = Graphics.FromImage(_bitmap);

        //    // tạo brush để vẽ
        //    SolidBrush _solidbrush = new SolidBrush(Color.White);

        //    // vẽ hình chữ nhật
        //    _graphic.FillRectangle(_solidbrush, 0, 0, _bitmap.Width, _bitmap.Height);

        //    // tăng độ nét kí tự nét vẽ
        //    _graphic.SmoothingMode = SmoothingMode.HighQuality;

        //    // chiều rộng mỗi kí tự
        //    int _characterWidth = 20;

        //    for (int i = 0; i < text.Length; i++)
        //    {
        //        float _fontSize = _random.Next(10, 30);
        //        System.Drawing.Font _font = new System.Drawing.Font("Tahoma", _fontSize);
        //        DrawCharacter(text.Substring(i, 1), _graphic, _font, i * _characterWidth, _characterWidth, width, heigh);
        //    }

        //    //// tạo hiệu ứng cho captcha

        //    // vẽ dấu chấm
        //    int _count = 0;
        //    while (_count < 1000)
        //    {
        //        _solidbrush = new SolidBrush(Color.Blue);
        //        _graphic.FillEllipse(_solidbrush, _random.Next(0, _bitmap.Width), _random.Next(0, _bitmap.Height), 4, 2);
        //        _count++;
        //    }

        //    // vẽ dấu gạch ngang
        //    _count = 0;
        //    while (_count < 25)
        //    {
        //        _graphic.DrawLine(new Pen(Color.DeepPink), _random.Next(0, _bitmap.Width), _random.Next(0, _bitmap.Height), _random.Next(0, _bitmap.Width), _random.Next(0, _bitmap.Height));
        //        _graphic.DrawLine(new Pen(Color.White), _random.Next(0, _bitmap.Width), _random.Next(0, _bitmap.Height), _random.Next(0, _bitmap.Width), _random.Next(0, _bitmap.Height));
        //        _count++;
        //    }

        //    return _bitmap;

        //}

        //#endregion

        //#region Hàm tạo captcha
        //public void CreateCaptcha()
        //{
        //    // tạo captcha gán vào biến local
        //    _captchaText = this.RandomString();
        //    txtRecaptcha.Text = "";

        //    Panel panel = new Panel();
        //    panel.Width = 230;
        //    panel.Height = 300;
        //    frameRecaptcha.Content = panel;

        //    // vẽ captcha lên panel
        //    panel.BackgroundImage = drawImageCaptcha(_captchaText, panel.Width, panel.Height);
        //}
        //#endregion

        //#region hàm vẽ từng kí tự và in nghiêng

        //private int _preAngle = 0;
        //public void DrawCharacter(string txt, Graphics grs, Font font, int x, int characterWidth, int width, int heigh)
        //{
        //    Random _random = new Random();

        //    // định dạng chữ căn giữa
        //    StringFormat _stringFormat = new StringFormat();
        //    _stringFormat.Alignment = StringAlignment.Center;
        //    _stringFormat.LineAlignment = StringAlignment.Center;

        //    // tạo hình chữ nhật, chứa điểm chuỗi bắt đầu
        //    RectangleF _rectangleF = new RectangleF(x, 0, characterWidth, heigh);

        //    // tạo 1 đối tượng graphicPath để vẽ
        //    GraphicsPath _graphicPath = new GraphicsPath();

        //    // thêm chuỗi nội dung vào để vẽ
        //    _graphicPath.AddString(txt, font.FontFamily, (int)font.Style, font.Size, _rectangleF, _stringFormat);

        //    // xét vị trí x,y bắt đầu vẽ
        //    float _dx = (float)(x + characterWidth / 2);
        //    float _dy = (float)(heigh / 2);
        //    grs.TranslateTransform(-_dx, -_dy, MatrixOrder.Append);

        //    // tạo góc nghiêng cho chữ
        //    int _angle = _preAngle;
        //    do
        //    {
        //        _angle = _random.Next(-30, 30);
        //    } while (Math.Abs(_angle - _preAngle) < 20);

        //    _preAngle = _angle;

        //    grs.RotateTransform(_angle, MatrixOrder.Append);
        //    grs.TranslateTransform(_dx, _dy, MatrixOrder.Append);

        //    // vẽ
        //    grs.FillPath(Brushes.Blue, _graphicPath);
        //    grs.ResetTransform();

        //}

        //#endregion

        #endregion

        private void BtnRefesh_Click(object sender, RoutedEventArgs e)
        {
            captcha();
        }

        void captcha()
        {
            Random _random = new Random();
            int num = _random.Next(6, 8);
            string captcha = "";
            int totl = 0;
            do
            {
                int chr = _random.Next(48, 123);
                if ((chr >= 48 && chr <= 57) || (chr >= 65 && chr <= 90) || (chr >= 97 && chr <= 122))
                {
                    captcha = captcha + (char)chr;
                    totl++;
                    if (totl == num)
                    {
                        break;
                    }
                }
            } while (true);
            lblCaptcha.Content = captcha;
        }

    }
}
