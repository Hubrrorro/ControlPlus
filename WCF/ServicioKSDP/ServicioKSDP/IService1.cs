﻿using System;
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
        bool AgregaRutaSVN(UsuarioSVN usuSVN, string key);
        [OperationContract]
        UsuarioSVN GetRuta(int idTicket, int idUsuario, string key);
        [OperationContract]
        SolicitudPPQA GetSolicitudPPQA(int idTicket, string key);
        [OperationContract]
        bool AsignaPersonal(int idTicket, List<int> Personal, string key);
        [OperationContract]
        List<UsuariosInvolucrados> GetInvolucrados(int idTicket, string key);
        [OperationContract]
        List<GuiaAjusteRow> GetGuiaAjuste(string key);
        [OperationContract]
        List<Documentos> GetDocumentosbyCliente(int idTicket, string key);
        //[OperationContract]
        //List<ListItem> GetTemplatePlanProceso(string key);
    }
    [DataContract]
    public class Documentos {
        [DataMember]
        public int idDocumentos { get; set; }
        [DataMember]
        public string nombre { get; set; }
        [DataMember]
        public string codigo { get; set; }
    }
    [DataContract]
    public class GuiaAjusteRow
    {
        [DataMember]
        public int idGuia { get; set; }
        [DataMember]
        public string proceso { get; set; }
        [DataMember]
        public string actividad { get; set; }
        [DataMember]
        public string producto { get; set; }
        [DataMember]
        public string carpeta { get; set; }
    
    }
    [DataContract]
    public class UsuariosInvolucrados
    {
        [DataMember]
        public string Puesto;
        [DataMember]
        public string Funciones;
        [DataMember]
        public string Nombre;
        [DataMember]
        public string Iniciales;
    }
    [DataContract]
    public class SolicitudPPQA
    {
        [DataMember]
        public string cliente { get; set; }
        [DataMember]
        public string app { get; set; }
        [DataMember]
        public string identificador { get; set; }
        [DataMember]
        public string nombrepro { get; set; }
        [DataMember]
        public string descripcion { get; set; }
        [DataMember]
        public string Lider { get; set; }
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
        [DataMember]
        public string RutaLocal { get; set; }
        [DataMember]
        public int idTicket { get; set; }

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
