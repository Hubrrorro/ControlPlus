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
    /// Lógica de interacción para SVNTicket.xaml
    /// </summary>
    public partial class SVNTicket : Window
    {
        public SVNTicket()
        {
            InitializeComponent();
            GetSistemas();
        }
        private void GetSistemas()
        {
            Service1Client Cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> Sistemas = Cliente.GetSistema(Seguridad.Seguridad.saltkey).ToList();
            ddlSistema.ItemsSource = Sistemas;
            ddlSistema.DisplayMemberPath = "item";
            ddlSistema.SelectedValuePath = "id";

        }
        private void btnbuscar_Click(object sender, RoutedEventArgs e)
        {
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            Service1Client Cliente = new Service1Client();
            List<DataRepTicket> Report = Cliente.Reporte(txtnombre.Text, txtticket.Text, int.Parse(ddlSistema.SelectedValue.ToString()), UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey).ToList();
            dgTicket.ItemsSource = Report;
        }
    }
}
