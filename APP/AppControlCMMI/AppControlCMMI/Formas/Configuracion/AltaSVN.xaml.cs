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
using System.Windows.Shapes;
using AppControlCMMI.ControWS;
namespace AppControlCMMI.Formas.Configuracion
{
    /// <summary>
    /// Lógica de interacción para AltaSVN.xaml
    /// </summary>
    public partial class AltaSVN : Window
    {
        public AltaSVN()
        {
            InitializeComponent();
            GetSVN();
        }
        protected void GetSVN()
        {
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            Service1Client Cliente = new Service1Client();
            UsuarioSVN uSVN = Cliente.ObtenerUsuarioSVN(UsuFirmado.IdEmpleado,Seguridad.Seguridad.saltkey);
            if (!String.IsNullOrEmpty(uSVN.Contraseña))
            {
                txtcontra.Text = uSVN.Contraseña;
                txtUsuario.Text = uSVN.Nombre;
                txtURL.Text = uSVN.URL;
            }
        }
        private void button_Click(object sender, RoutedEventArgs e)
        {
            if ((String.IsNullOrEmpty(txtcontra.Text)) || (String.IsNullOrEmpty(txtURL.Text)) || (String.IsNullOrEmpty(txtUsuario.Text)))
            {
                MessageBox.Show("Falta llenar campos", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            UsuarioSVN uSVN = new UsuarioSVN();
            uSVN.idUsuario = UsuFirmado.IdEmpleado;
            uSVN.Nombre = txtUsuario.Text;
            uSVN.URL = txtURL.Text;
            uSVN.Contraseña = txtcontra.Text;
            Service1Client Cliente = new Service1Client();
            bool Respuesta = Cliente.AgregarUsuarioSVN(uSVN, Seguridad.Seguridad.saltkey);
            if (Respuesta)
                MessageBox.Show("Se guardo correctamente la información", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
            else
                MessageBox.Show("Error al guardar los datos", "Error", MessageBoxButton.OK, MessageBoxImage.Error);


        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
