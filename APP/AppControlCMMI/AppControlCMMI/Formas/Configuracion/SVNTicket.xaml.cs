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
            
            // Some operations with this row
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
        private void ConnectSVN(string path,string URL)
        {
            //SvnUpdateResult provides info about what happened during a checkout
            SvnUpdateResult result;

            //we will use this to tell CheckOut() which revision to fetch
            //long revision;

            //SvnCheckoutArgs wraps all of the options for the 'svn checkout' function
            SvnCheckOutArgs args = new SvnCheckOutArgs();


            //if (long.TryParse(tbRevision.Text, out revision))
            //{
            //    //set the revision number if the user entered a valid number
            //    args.Revision = new SvnRevision(revision);
            //}
            //if args.Revision is not set, it defaults to fetch the HEAD revision.
            //else MessageBox.Show("Invalid Revision number, defaulting to HEAD");

            //the using statement is necessary to ensure we are freeing up resources
            using (SvnClient client = new SvnClient())
            {
                try
                {
                    client.Authentication.ForceCredentials("eduardo.jimenez", "P4ssw0rd210");
                    //SvnUriTarget is a wrapper class for SVN repository URIs
                    SvnUriTarget target = new SvnUriTarget(URL);
                   
                    //this is the where 'svn checkout' actually happens.
                    if (client.CheckOut(target, path, args, out result))
                        MessageBox.Show("Successfully checked out revision " + result.Revision + ".");
                }
                catch (SvnException se)
                {
                    MessageBox.Show(se.Message,"svn checkout error");
                }
                catch (UriFormatException ufe)
                {
                    MessageBox.Show(ufe.Message);
                }
            }
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (String.IsNullOrEmpty(txtdireccion.Text))
            {
                MessageBox.Show("Debes ingresar la direccion URL");
                return;
            }
            AppControlCMMI.ControWS.Service1Client Cliente = new Service1Client();
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            int idTicket = int.Parse(lblid.Content.ToString());
            string Ruta = createCarpeta(idTicket);
            ConnectSVN(Ruta, txtdireccion.Text);
        }
    }
}
