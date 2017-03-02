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
using System.Collections.ObjectModel;
using AppControlCMMI.SVN;
using Novacode;

namespace AppControlCMMI.Formas.Inicio
{
    /// <summary>
    /// Lógica de interacción para FrmAsignaPPQDEV.xaml
    /// </summary>
    public partial class FrmAsignaPPQDEV : Window
    {
        public FrmAsignaPPQDEV()
        {
            InitializeComponent();
            GetSistemas();
            AddEvent();
            GetPPQA();
            GetEstadistica();
            GetCM();
            GetDev();
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
            
            
        }
        protected void GetEstadistica()
        {
            estadisticaList = new ObservableCollection<Contenido>();
            estadisticaList.Add(new Contenido { id = -1, Value = "ROBERTO GARZA" });
            lstEstadistica.ItemsSource = estadisticaList;
            this.DataContext = this;
        }
        protected void GetCM()
        {
            Service1Client cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> cmList_ = cliente.GetAdminConfKrio(Seguridad.Seguridad.saltkey).ToList();
            cmList = Transform(cmList_);
            lstCM.ItemsSource = cmList;
            this.DataContext = this;
        }
        protected void GetDev()
        {
            Service1Client cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> devList_ = cliente.GetDesarrolladorKrio(Seguridad.Seguridad.saltkey).ToList();
            devList = Transform(devList_);
            lstDev.ItemsSource = devList;
            this.DataContext = this;
        }
        public class Contenido
        {
            public int id { get; set; }
            public string Value { get; set; }
            public bool isCheked { get; set; }
        }
        public ObservableCollection<Contenido> ppqaList { get; set; }
        public ObservableCollection<Contenido> devList { get; set; }
        public ObservableCollection<Contenido> cmList { get; set; }
        public ObservableCollection<Contenido> estadisticaList { get; set; }
        protected ObservableCollection<Contenido> Transform(List<AppControlCMMI.ControWS.ListItem> Listado)
        {
            ObservableCollection<Contenido> _Contenido = new ObservableCollection<Contenido>();
            foreach (AppControlCMMI.ControWS.ListItem item in Listado)
            {
                Contenido cont = new Contenido();
                cont.id = item.id;
                cont.Value = item.item;
                _Contenido.Add(cont);
            }
            return  _Contenido;
        }
        protected void GetPPQA()
        {
            Service1Client cliente = new Service1Client();
            List<AppControlCMMI.ControWS.ListItem> ppqaList_ = cliente.GetPPQAKrio(Seguridad.Seguridad.saltkey).ToList();
            ppqaList = Transform(ppqaList_) ;
            lstPPQA.ItemsSource = ppqaList;
            this.DataContext = this;
        }
        private void btnAsinar_Click(object sender, RoutedEventArgs e)
        {
            List<int> Seleccionados = new List<int>();
            bool revCM = false, revDev = false, revPPQA = false;
            foreach (Contenido item in lstCM.Items)
            {
                if (item.isCheked)
                {
                    Seleccionados.Add(item.id);
                    revCM = true;
                }
            }
            foreach (Contenido item in lstDev.Items)
            {
                if (item.isCheked)
                {
                    Seleccionados.Add(item.id);
                    revDev = true;
                }
            }
            foreach (Contenido item in lstPPQA.Items)
            {
                if (item.isCheked)
                {
                    Seleccionados.Add(item.id);
                    revPPQA = true;
                }
            }
            if (!revCM)
            {
                MessageBox.Show("Debes seleccionar un CM");
                return;
            }
            if (!revDev)
            {
                MessageBox.Show("Debes seleccionar un Desarrollador");
                return;
            }
            if (!revPPQA)
            {
                MessageBox.Show("Debes seleccionar un PPQA");
                return;
            }
            Service1Client cliente = new Service1Client();
            int idTicket = int.Parse(lblTicket.Content.ToString());
            bool correcto =  cliente.AsignaPersonal(idTicket, Seleccionados.ToArray(), Seguridad.Seguridad.saltkey);
            if (!correcto)
            {
                MessageBox.Show("Error al guardar información");
                return;
            }
            UsuarioFirmado UsuFirmado = (UsuarioFirmado)Application.Current.Resources["UserFirmado"];
            SolicitudPPQA Solicitud = cliente.GetSolicitudPPQA(idTicket, Seguridad.Seguridad.saltkey);
            UsuariosInvolucrados[] Usuarios = cliente.GetInvolucrados(idTicket, Seguridad.Seguridad.saltkey);
            string NombreDocumento = "KSDP_PPQA_F04_AsignaciónRecursos.docx";
            string Ruta = System.AppDomain.CurrentDomain.BaseDirectory;
            Ruta += "Documentos/" + NombreDocumento;
            CreaEstructura CCrea = new CreaEstructura();
            UsuarioSVN usuSVNRuta = cliente.GetRuta(idTicket, UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey);
            UsuarioSVN usuSVNContra = cliente.ObtenerUsuarioSVN(UsuFirmado.IdEmpleado, Seguridad.Seguridad.saltkey);
            string RutaSVN = CCrea.Inicio(usuSVNRuta.RutaLocal);
            using (var documento = DocX.Load(Ruta))
            {
                documento.ReplaceText("@cliente", Solicitud.cliente);
                documento.ReplaceText("@app", Solicitud.app);
                documento.ReplaceText("@identificador", Solicitud.identificador);
                documento.ReplaceText("@fecha", DateTime.Now.ToShortDateString());
                documento.ReplaceText("@nombrepro", Solicitud.nombrepro);
                documento.ReplaceText("@descpro", Solicitud.descripcion);
                documento.ReplaceText("@lider", Solicitud.Lider);
                Novacode.Table myTable = documento.Tables[0];
                foreach (UsuariosInvolucrados usu in Usuarios)
                {
                    Row myRow = myTable.InsertRow();
                    myRow.Cells[0].Paragraphs.First().Append(usu.Nombre);
                    myRow.Cells[1].Paragraphs.First().Append(usu.Puesto);
                    myRow.Cells[2].Paragraphs.First().Append(usu.Iniciales);
                    myRow.Cells[3].Paragraphs.First().Append(usu.Funciones);
                    myTable.Rows.Add(myRow);
                }
                documento.SaveAs(RutaSVN + "/" + NombreDocumento);
            }
            MessageBox.Show("Se agrego correctamente el documento");

        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
