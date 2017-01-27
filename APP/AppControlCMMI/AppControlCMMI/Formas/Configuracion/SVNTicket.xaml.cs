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
using System.IO;
using SharpSvn;
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
            AddEvent();
        }
        private void GetSistemas()
        {
            Service1Client Cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> Sistemas = Cliente.GetSistema(Seguridad.Seguridad.saltkey).ToList();
            ddlSistema.ItemsSource = Sistemas;
            ddlSistema.DisplayMemberPath = "item";
            ddlSistema.SelectedValuePath = "id";

        }
        protected void AddEvent()
        {
            Style rowStyle = new Style(typeof(DataGridRow));
            rowStyle.Setters.Add(new EventSetter(DataGridRow.MouseDoubleClickEvent,
                                     new MouseButtonEventHandler(Row_DoubleClick)));
            dgTicket.RowStyle = rowStyle;
        }
        private void btnbuscar_Click(object sender, RoutedEventArgs e)
        {
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            Service1Client Cliente = new Service1Client();
            List<DataRepTicket> Report = Cliente.Reporte(txtnombre.Text, txtticket.Text, int.Parse(ddlSistema.SelectedValue.ToString()), UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey).ToList();
            dgTicket.ItemsSource = Report;
        }
        private void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = sender as DataGridRow;
            DataRepTicket contex = (DataRepTicket)row.DataContext;
            BusquedaGrid.Visibility = System.Windows.Visibility.Hidden;
            AsignaGrid.Visibility = System.Windows.Visibility.Visible;
            lblnombre.Content = contex.Nombre;
            lblsistema.Content = contex.Sistema;
            lblticket.Content = contex.Ticket;
            lblid.Content = contex.idTicket;
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            BuscarInformacion(contex.idTicket, UsuFirmado.IdEmpleado);
            // Some operations with this row
        }
        protected void BuscarInformacion(int idTicket, int idUsuario)
        {
            Service1Client Cliente = new Service1Client();
            UsuarioSVN usuSVN= Cliente.GetRuta(idTicket, idUsuario, Seguridad.Seguridad.saltkey);
            txtdireccion.Text = usuSVN.URL;
            lblrutaLocal.Content = usuSVN.RutaLocal;
        }
        private void dgTicket_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
        private string createCarpeta(int idTicket)
        {
            string Ruta = System.AppDomain.CurrentDomain.BaseDirectory;
            Ruta += idTicket.ToString();
            if (!Directory.Exists(Ruta))
            {
                Directory.CreateDirectory(Ruta );
            }
            return Ruta;
        }
        private void ConnectSVN(UsuarioSVN usuSVN) 
        {
            AppControlCMMI.ControWS.Service1Client Cliente = new Service1Client();
            UsuarioSVN usuSVN2 = usuSVN;
            if (usuSVN.RutaLocal == null)
            {
                usuSVN = Cliente.ObtenerUsuarioSVN(usuSVN.idUsuario, Seguridad.Seguridad.saltkey);
                usuSVN.URL = usuSVN2.URL;
                usuSVN.RutaLocal = usuSVN2.RutaLocal;
            }
            AppControlCMMI.SVN.CSVN _svn = new SVN.CSVN();
            bool correcto = _svn.checkedOut(usuSVN);
            if (!correcto)
                MessageBox.Show("Error al realizar enlace con SVN");
            else
                MessageBox.Show("Asignación correcta");
        }
        
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (String.IsNullOrEmpty(txtdireccion.Text))
            {
                MessageBox.Show("Debes ingresar la direccion URL");
                return;
            }
            if (String.IsNullOrEmpty(lblrutaLocal.Content.ToString()))
            {
                MessageBox.Show("Debes seleccionar donde se guardara la información");
                return;
            }
            AppControlCMMI.ControWS.Service1Client Cliente = new Service1Client();
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            int idTicket = int.Parse(lblid.Content.ToString());
            UsuarioSVN usuSVN = new UsuarioSVN();
            usuSVN.idTicket = idTicket;
            usuSVN.idUsuario = UsuFirmado.IdEmpleado;
            usuSVN.URL = txtdireccion.Text;
            usuSVN.RutaLocal = lblrutaLocal.Content.ToString();
            bool correcto = Cliente.AgregaRutaSVN(usuSVN, Seguridad.Seguridad.saltkey);
            if (correcto)
            {
                ConnectSVN(usuSVN);
            }
        }
       

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            var dlg = new System.Windows.Forms.FolderBrowserDialog();
            System.Windows.Forms.DialogResult result = dlg.ShowDialog(this.GetIWin32Window());
            lblrutaLocal.Content = dlg.SelectedPath;
        }
    }
}
