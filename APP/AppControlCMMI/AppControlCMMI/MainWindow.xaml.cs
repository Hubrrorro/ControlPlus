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
using AppControlCMMI.ControWS;
using AppControlCMMI.Formas;

namespace AppControlCMMI
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtcontraseña.Password))
                {
                    MessageBox.Show("Debes ingresar una contraseña", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (String.IsNullOrEmpty(txtUsuario.Text))
                {
                    MessageBox.Show("Debes ingresar tu usuario", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                ControWS.Service1Client Cliente = new Service1Client();
                Usuario User = new Usuario();
                User.usuario = txtUsuario.Text.ToUpper();
                User.contraseña = txtcontraseña.Password;
                UsuarioFirmado Firmado = Cliente.Acceso(User, Seguridad.Seguridad.saltkey);
                if (!Firmado.Activo)
                {
                    MessageBox.Show("Usuario o contraseña invalida", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                Application.Current.Resources["UserFirmado"] = Firmado;
                FrmMenu frmMenu = new FrmMenu();
                frmMenu.Show();
                this.Hide();
            }
            catch
            {
                MessageBox.Show("Error ne la comunicación", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
        }
    }
}
