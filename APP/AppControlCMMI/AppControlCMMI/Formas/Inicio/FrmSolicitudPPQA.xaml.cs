using AppControlCMMI.ControWS;
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
using Novacode;
using AppControlCMMI.SVN;

namespace AppControlCMMI.Formas.Inicio
{
    /// <summary>
    /// Lógica de interacción para FrmSolicitudPPQA.xaml
    /// </summary>
    public partial class FrmSolicitudPPQA : Window
    {
        public FrmSolicitudPPQA()
        {
            InitializeComponent();
            GetSistemas();
            AddEvent();
        }

        private void btnEnvio_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string NombreDocumento = "KSDP_PP_F05_SolicitudAuditorAseguramientoCalidad.docx";
                Service1Client Cliente = new Service1Client();
                UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
                string Ruta = System.AppDomain.CurrentDomain.BaseDirectory;
                Ruta += "Documentos/" + NombreDocumento;
                CreaEstructura CCrea = new CreaEstructura();
                int idTicket = int.Parse(lblticket.Content.ToString());
                UsuarioSVN usuSVNRuta = Cliente.GetRuta(idTicket, UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey);
                UsuarioSVN usuSVNContra = Cliente.ObtenerUsuarioSVN(UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey);
                string RutaSVN = CCrea.Inicio(usuSVNRuta.RutaLocal);
                SolicitudPPQA Solicitud = Cliente.GetSolicitudPPQA(idTicket, Seguridad.Seguridad.saltkey);
                using (var documento = DocX.Load(Ruta))
                {
                    documento.ReplaceText("//cliente", Solicitud.cliente);
                    documento.ReplaceText("@app", Solicitud.app);
                    documento.ReplaceText("@identificador", Solicitud.identificador);
                    documento.ReplaceText("@fecha", DateTime.Now.ToShortDateString());
                    documento.ReplaceText("@nombrepro", Solicitud.nombrepro);
                    documento.ReplaceText("@descpro", Solicitud.descripcion);
                    documento.SaveAs(RutaSVN + "/" + NombreDocumento);
                }
                MessageBox.Show("Se agrego correctamente el documento");
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
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
            Envio.Visibility = System.Windows.Visibility.Visible;
            //lblnombre.Content = contex.Nombre;
            //lblsistema.Content = contex.Sistema;
            lblticket.Content = contex.idTicket;
            //lblid.Content = 

            //BuscarInformacion(contex.idTicket, UsuFirmado.IdEmpleado);
            //// Some operations with this row
        }
    }
}
