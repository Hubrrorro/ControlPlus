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
namespace AppControlCMMI.Formas.Inicio
{
    /// <summary>
    /// Lógica de interacción para AltaTicket.xaml
    /// </summary>
    public partial class AltaTicket : Window
    {
        public AltaTicket()
        {
            InitializeComponent();
            GetCombos();
        }
        public void AgregarItem(List<AppControlCMMI.ControWS.ListItem> Listado, ComboBox CB)
        {
            CB.ItemsSource = Listado;
            CB.DisplayMemberPath = "item";
            CB.SelectedValuePath = "id";
        }
        public void GetCombos()
        {
            Service1Client Cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> Empresas = Cliente.GetEmpresa(Seguridad.Seguridad.saltkey).ToList();
            List<AppControlCMMI.ControWS.ListItem> Tipo = Cliente.GetTipo(Seguridad.Seguridad.saltkey).ToList();

            List<AppControlCMMI.ControWS.ListItem> Lider = Cliente.GetLiderKrio(Seguridad.Seguridad.saltkey).ToList();
            List<AppControlCMMI.ControWS.ListItem> PMO = Cliente.GetPMOKrio(Seguridad.Seguridad.saltkey).ToList();

            AgregarItem(Empresas, ddlEmpresa);
            AgregarItem(Tipo, ddlTipo);

            AgregarItem(Lider, ddlLider);
            AgregarItem(PMO, ddlPMO);

            int IdEmpresa = Empresas.Select(x => x.id).First();
            CombosDependientes(IdEmpresa);

        }
        public void CombosDependientes(int IdEmpresa)
        {
            Service1Client Cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> Sistema = Cliente.GetSistemaByEmpresa(IdEmpresa, Seguridad.Seguridad.saltkey).ToList();
            List<AppControlCMMI.ControWS.ListItem> Enlace = Cliente.GetEnlace(IdEmpresa, Seguridad.Seguridad.saltkey).ToList();
            AgregarItem(Sistema, ddlSistema);
            AgregarItem(Enlace, ddlEnlace);
        }
        public void getSistema()
        {
            Service1Client Cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> Sistema = Cliente.GetEmpresa(Seguridad.Seguridad.saltkey).ToList();
            ddlSistema.DataContext = Sistema;
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            if ((String.IsNullOrEmpty(txtdescripcion.Text)) || (String.IsNullOrEmpty(txtIdentificador.Text)) || (String.IsNullOrEmpty(txtNombre.Text)) ||
                    (String.IsNullOrEmpty(ddlSistema.SelectedValue.ToString())) || (String.IsNullOrEmpty(ddlEmpresa.SelectedValue.ToString()))
                || (String.IsNullOrEmpty(ddlEnlace.SelectedValue.ToString())) || (String.IsNullOrEmpty(ddlLider.SelectedValue.ToString())) || (String.IsNullOrEmpty(ddlPMO.SelectedValue.ToString()))
                || (String.IsNullOrEmpty(ddlTipo.SelectedValue.ToString())))
            {
                MessageBox.Show("Falta llenar campos", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            AppControlCMMI.ControWS.Ticket _Ticket = new AppControlCMMI.ControWS.Ticket();
            _Ticket.idEmpresa = int.Parse(ddlEmpresa.SelectedValue.ToString());
            _Ticket.Descripcion = txtdescripcion.Text;
            _Ticket.idEnlace = int.Parse(ddlEnlace.SelectedValue.ToString());
            _Ticket.Identificador = txtIdentificador.Text;
            _Ticket.idLider = int.Parse(ddlLider.SelectedValue.ToString());
            _Ticket.idPMO = int.Parse(ddlPMO.SelectedValue.ToString());
            _Ticket.idSistema = int.Parse(ddlSistema.SelectedValue.ToString());
            _Ticket.idTipo = int.Parse(ddlTipo.SelectedValue.ToString());
            _Ticket.Nombre = txtNombre.Text;
            _Ticket.idEtapa = 1;
            _Ticket.idSubEtapa = 1;
            Service1Client Cliente = new Service1Client();
            string Respuesta = String.Empty;
            _Ticket = Cliente.AgregaTicket(_Ticket,ref Respuesta, Seguridad.Seguridad.saltkey);
            if (!String.IsNullOrEmpty(Respuesta))
                MessageBox.Show(Respuesta, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                MessageBox.Show("Se agrego correctamente con el folio "+ _Ticket.TicketKSDP, "Mensaje Control CMMI", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ddlEmpresa_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ddlEmpresa.SelectedValue != null)
            {
                int IdEmpresa = int.Parse(ddlEmpresa.SelectedValue.ToString());
                CombosDependientes(IdEmpresa);
            }
        }
    }
}
