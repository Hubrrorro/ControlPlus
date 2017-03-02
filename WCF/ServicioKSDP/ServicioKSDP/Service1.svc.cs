using ServicioKSDP.BD;
using ServicioKSDP.Class.catalogos;
using ServicioKSDP.Class.ticket;
using ServicioKSDP.Class.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServicioKSDP
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    // NOTE: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione Service1.svc o Service1.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class Service1 : IService1
    {
        public List<UsuariosInvolucrados> GetInvolucrados(int idTicket, string key)
        {
            List<UsuariosInvolucrados> Listado = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Listado;
            TicketCS cTicket = new TicketCS();
            return cTicket.GetInvolucrados(idTicket);
        }
        public SolicitudPPQA GetSolicitudPPQA(int idTicket, string key)
        {
            SolicitudPPQA Solicitud= null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Solicitud;
            TicketCS cTicket = new TicketCS();
            return cTicket.GetDatos(idTicket);
        }
        public bool AsignaPersonal(int idTicket, List<int> Personal, string key)
        {
            if (!Class.Seguridad.keyCorrecta(key))
                return false;
            Empelados Emp = new Empelados();
            Emp.BorraPersonal(idTicket);
            return  Emp.AsignaTicketUsuario(idTicket, Personal);
        }
        public bool AgregaRutaSVN(UsuarioSVN usuSVN, string key)
        {
            if (!Class.Seguridad.keyCorrecta(key))
                return false;
            Empelados emp = new Empelados();
            return  emp.AddlRutas(usuSVN);
        }
        
        public List<DataRepTicket> Reporte(string Nombre, string Ticket, int Sistema, int idEmpleado, string key)
        {
            List<DataRepTicket> listado;
            if (!Class.Seguridad.keyCorrecta(key))
            {
                listado = new List<DataRepTicket>();
                return listado;
            }
            TicketCS CsTicket = new TicketCS();
            return CsTicket.Rerport(Nombre, Ticket, Sistema, idEmpleado);

        }
        public UsuarioSVN ObtenerUsuarioSVN(int idUsuario, string key)
        {
            UsuarioSVN uSVN;
            if (!Class.Seguridad.keyCorrecta(key))
            {
                uSVN = new UsuarioSVN();
                return uSVN;
            }
            Empelados Emp = new Empelados();
            return Emp.GetUsuSVN(idUsuario);
        }
        public bool AgregarUsuarioSVN(UsuarioSVN uSVN, string key)
        {
            if (!Class.Seguridad.keyCorrecta(key))
            {
                return false;
            }
            Empelados Emp = new Empelados();
            return Emp.AddSVN(uSVN);
            
        }
        public UsuarioFirmado Acceso(Usuario user, string key)
        {
            UsuarioFirmado UserFirmado;
            if (!Class.Seguridad.keyCorrecta(key))
            {
                UserFirmado = new UsuarioFirmado();
                UserFirmado.Activo = false;
                return UserFirmado;
            }
            AccesoSistema Acc = new AccesoSistema();
            UserFirmado = Acc.IsAcceso(user);
            return UserFirmado;
        }
        public List<Menu> Menu(int idPerfil, string key)
        {
            List<Menu> Listado;
            if (!Class.Seguridad.keyCorrecta(key))
            {
                Listado = new List<Menu>();
                return Listado;
            }
            AccesoSistema Acc = new AccesoSistema();
            Listado = Acc.GetMenu(idPerfil);
            return Listado;

        }
        public Ticket AgregaTicket(Ticket _Ticket, ref string Mensaje, string key)
        {
            if (!Class.Seguridad.keyCorrecta(key))
            {
                Mensaje = "Error";
                return _Ticket;
            }
            Class.ticket.TicketCS CsTicket = new Class.ticket.TicketCS();
            bool Existe = CsTicket.ExisteBD(_Ticket);
            if (Existe)
                Mensaje = "Ya se encuentra en la base de datos";
            else
                _Ticket = CsTicket.Create(_Ticket);
            return _Ticket;
        }
        public List<ListItem> GetEmpresa(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            Empresas = Cat.GetEmpresa();
            return Empresas;
        }
        public List<ListItem> GetTipo(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            List<ListItem> Tipo = Cat.GetTipo();
            return Tipo;
        }
        public List<ListItem> GetSistema(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            List<ListItem> Sistema = Cat.GetSistema();
            return Sistema;
        }
        public List<ListItem> GetSistemaByEmpresa(int idEmpresa, string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            List<ListItem> Sistema = Cat.GetSistema(idEmpresa);
            return Sistema;
        }
        public List<ListItem> GetLiderKrio(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            List<ListItem> Lider = Cat.GetLiderKrio();
            return Lider;
        }
        public List<ListItem> GetPMOKrio(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetLiderKrio();
        }
        public List<ListItem> GetEnlace(int idEmpresa, string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetEnlace(idEmpresa);
        }
        public List<ListItem> GetDesarrolladorKrio(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetDesarrolladorKrio();
        }
        public List<ListItem> GetPPQAKrio(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetPPQAKrio();
        }
        public List<ListItem> GetAdminConfKrio(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetAdminConfKrio();
        }
        public List<ListItem> GetAllUsuariosPuesto(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetAllUsuariosPuesto();
        }
        public List<ListItem> GetAllUsuariosAnexos(string key)
        {
            List<ListItem> Empresas = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Empresas;
            Class.catalogos.Catalogos Cat = new Class.catalogos.Catalogos();
            return Cat.GetAllUsuariosAnexos();
        }
        public UsuarioSVN GetRuta(int idTicket, int idUsuario, string key)
        {
            UsuarioSVN usu = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return usu;
            Empelados emp = new Empelados();
            return emp.GetRutaSVN(idUsuario, idTicket);
        }
        public List<GuiaAjusteRow> GetGuiaAjuste(string key)
        {
            List<GuiaAjusteRow> Listado = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Listado;
            Catalogos cat = new Catalogos();
            return cat.GetGuiaAjuste();
        }
        public List<Documentos> GetDocumentosbyCliente(int idTicket, string key)
        {
            List<Documentos> Listado = null;
            if (!Class.Seguridad.keyCorrecta(key))
                return Listado;
            Catalogos cat = new Catalogos();
            return cat.GetDocumentosbyCliente(idTicket);
        }
        //public List<ListItem> GetTemplatePlanProceso(string key)
        //{
        //    List<ListItem> Listado = null;
        //    if (!Class.Seguridad.keyCorrecta(key))
        //        return Listado;
        //    Catalogos cat = new Catalogos();
        //    return cat.(idTicket);
        //}
    }
}
