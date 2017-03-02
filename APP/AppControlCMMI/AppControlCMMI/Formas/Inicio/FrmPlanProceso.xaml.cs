using AppControlCMMI.ControWS;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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

namespace AppControlCMMI.Formas.Inicio
{
    /// <summary>
    /// Lógica de interacción para FrmPlanProceso.xaml
    /// </summary>
    public partial class FrmPlanProceso : Window
    {
        public FrmPlanProceso()
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
            //lblnombre.Content = contex.Nombre;
            //lblsistema.Content = contex.Sistema;
            //lblticket.Content = contex.Ticket;
            lblTicket.Content = contex.idTicket;
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            getGuiaAjuste();
            getDocumentos(contex.idTicket);
            ListaAjuste();
        }
        private void getDocumentos(int Ticket)
        {
            Service1Client cliente = new Service1Client();
            Documentos[] ListadoDoc = cliente.GetDocumentosbyCliente(Ticket, Seguridad.Seguridad.saltkey);
            DataGridComboBoxColumn columncombo = (DataGridComboBoxColumn)dataGrid.Columns[6];
            columncombo.ItemsSource = ListadoDoc;
            columncombo.DisplayMemberPath = "nombre";
            columncombo.SelectedValuePath = "idDocumentos";
            //columncombo.SelectedItemBinding =  "nombre";
        }
        public class Ajuste {
            public int idAjuste { get; set; }
            public string  ajuste { get; set; }
            public Ajuste(int _idAjuste, string _ajuste)
            {
                idAjuste = _idAjuste;
                ajuste = _ajuste;
            }
        }
        private void ListaAjuste()
        {
            ObservableCollection<Ajuste> ListadoAjuste = new ObservableCollection<Ajuste>();
            ListadoAjuste.Add(new Ajuste(1,"Aplica"));
            ListadoAjuste.Add(new Ajuste(2, "No Aplica"));
            ListadoAjuste.Add(new Ajuste(3, "Reemplazo"));
            DataGridComboBoxColumn columncombo = (DataGridComboBoxColumn)dataGrid.Columns[5];
            columncombo.ItemsSource = ListadoAjuste;
            columncombo.DisplayMemberPath = "ajuste";
            columncombo.SelectedValuePath = "idAjuste";

        }
        private void getGuiaAjuste()
        {
            Service1Client cliente = new Service1Client();
            GuiaAjusteRow[] Listado = cliente.GetGuiaAjuste(Seguridad.Seguridad.saltkey);
            dataGrid.ItemsSource = Listado;
         }

        private void Window_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            double intWidth=  e.NewSize.Width;
            double intHeight = e.NewSize.Height;
            if (intHeight > 400)
            {
                dataGrid.Height = intHeight - 200;
                dataGrid.Width = intWidth - 100;
            }
            
            
        }
    }

}
