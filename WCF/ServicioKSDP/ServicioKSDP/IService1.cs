using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServicioKSDP
{
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        UsuarioSVN ObtenerUsuarioSVN(int idUsuario, string key);
        [OperationContract]
        bool AgregarUsuarioSVN(UsuarioSVN uSVN, string key);
        [OperationContract]
        UsuarioFirmado Acceso(Usuario user, string key);
        [OperationContract]
        List<Menu> Menu(int idPerfil, string key);
        [OperationContract]
        Ticket AgregaTicket(Ticket _Ticket, ref string Mensaje, string key);
        [OperationContract]
        List<ListItem> GetEmpresa(string key);
        [OperationContract]
        List<ListItem> GetTipo(string key);
        [OperationContract]
        List<ListItem> GetSistema(string key);
        [OperationContract]
        List<ListItem> GetSistemaByEmpresa(int idEmpresa, string key);
        [OperationContract]
        List<ListItem> GetLiderKrio(string key);
        [OperationContract]
        List<ListItem> GetPMOKrio(string key);
        [OperationContract]
        List<ListItem> GetEnlace(int idEmpresa, string key);
        [OperationContract]
        List<ListItem> GetDesarrolladorKrio(string key);
        [OperationContract]
        List<ListItem> GetPPQAKrio(string key);
        [OperationContract]
        List<ListItem> GetAdminConfKrio(string key);
        [OperationContract]
        List<ListItem> GetAllUsuariosPuesto(string key);
        [OperationContract]
        List<ListItem> GetAllUsuariosAnexos(string key);
        [OperationContract]
        List<DataRepTicket> Reporte(string Nombre, string Ticket, int Sistema, int idEmpleado, string key);
        [OperationContract]
        void AgregarDireccionSNV(int idTicket,int idUsuario, int idSVN,string Ruta, string URL);
    }
    [DataContract]
    public class UsuarioSVN
    {
        [DataMember]
        public int idUsuario { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Contraseña { get; set; }
        [DataMember]
        public string URL { get; set; }

    }
    [DataContract]
    public class ListItem
    {
        [DataMember]
        public int id { get; set; }
        [DataMember]
        public string item { get; set; }
    }
    [DataContract]
    public class DataRepTicket
    {
        [DataMember]
        public int idTicket { get; set; }
        [DataMember]
        public string Ticket { get; set; }
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string Identificador { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Cliente { get; set; }
        [DataMember]
        public string Sistema { get; set; }
    }
    [DataContract]
    public class Ticket
    {
        [DataMember]
        public int idTicket { get; set; }
        [DataMember]
        public string TicketKSDP { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Identificador { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int idEmpresa { get; set; }
        [DataMember]
        public int idSistema { get; set; }
        [DataMember]
        public int idTipo { get; set; }
        [DataMember]
        public int idPMO { get; set; }
        [DataMember]
        public int idLider { get; set; }
        [DataMember]
        public int idEnlace { get; set; }
        [DataMember]
        public int idEtapa { get; set; }
        [DataMember]
        public int idSubEtapa { get; set; }

    }
    [DataContract]
    public class Menu
    {
        [DataMember]
        public int idMenu { get; set; }
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public int idMenuPadre { get; set; }
        [DataMember]
        public int Ordernar { get; set; }
    }
    [DataContract]
    public class UsuarioFirmado
    {
        [DataMember]
        public int IdEmpleado { get; set; }
        [DataMember]
        public int IdPuesto { get; set; }
        [DataMember]
        public int IdEmpresa { get; set; }
        [DataMember]
        public string Iniciales { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string ApellidoPaterno { get; set; }
        [DataMember]
        public string ApellidoMaterno { get; set; }
        [DataMember]
        public string Usuario { get; set; }
        [DataMember]
        public bool Activo { get; set; }
    }
    [DataContract]
    public class Usuario
    {
        [DataMember]
        public string usuario { get; set; }
        [DataMember]
        public string contraseña { get; set; }
    }
    [DataContract]
    public class Empleado
    {
        [DataMember]
        public string Nombre { get;set; }
        [DataMember]
        public string Correo { get; set; }

    }
}
