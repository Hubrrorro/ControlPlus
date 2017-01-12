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

namespace AppControlCMMI.Formas
{
    /// <summary>
    /// Lógica de interacción para Menu.xaml
    /// </summary>
    public partial class FrmMenu : Window
    {
        public FrmMenu()
        {
            InitializeComponent();
        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            Inicio.AltaTicket Alta = new Inicio.AltaTicket();
            Alta.ShowDialog();
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void AltaSVN_Click(object sender, RoutedEventArgs e)
        {
            Configuracion.AltaSVN Alta = new Configuracion.AltaSVN();
            Alta.ShowDialog();
        }

        private void MenuItem_Click_1(object sender, RoutedEventArgs e)
        {

        }

        private void SVNTicket_Click(object sender, RoutedEventArgs e)
        {
            Configuracion.SVNTicket svnTic = new Configuracion.SVNTicket();
            svnTic.ShowDialog();
        }
    }
}
