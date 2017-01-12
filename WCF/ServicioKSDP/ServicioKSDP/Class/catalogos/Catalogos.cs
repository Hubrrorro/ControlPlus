using ServicioKSDP.BD;
using ServicioKSDP;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ServicioKSDP.Class.catalogos
{
    public class Catalogos
    {
        private List<ListItem> GetCatalogos(string qry)
        {
            //ListItem
            List<ListItem> Catalogo = new List<ListItem>();
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                ListItem Fila = new ListItem();
                                Fila.id = reader.GetInt32(0);
                                Fila.item = reader.GetString(1);
                                Catalogo.Add(Fila);
                            }
                        }
                    }
                }

            }
            catch
            {

            }
            return Catalogo;
        }
        public List<ListItem> GetEmpresa()
        {
            List<ListItem> Empresas = GetCatalogos("select idCliente,Cliente from dbo.Cat_Cliente;");
            return Empresas;
        }
        public List<ListItem> GetTipo()
        {
            List<ListItem> Tipo = GetCatalogos("select id_Tipo,Tipo from Cat_Tipo;");
            return Tipo;
        }
        public List<ListItem> GetSistema()
        {
            List<ListItem> Sistema = GetCatalogos("select idSistema,Sistema from CatSistema ;");
            return Sistema;
        }
        public List<ListItem> GetSistema(int idEmpresa)
        {
            List<ListItem> Sistema = GetCatalogos("select idSistema,Sistema from CatSistema where idCliente=" + idEmpresa.ToString() + ";");
            return Sistema;
        }
        public ListItem GetSistemaByID(int idSistema)
        {
            ListItem Sistema = GetCatalogos("select idSistema,Sistema from CatSistema where idSistema=" + idSistema.ToString() + ";").First();
            return Sistema;
        }
         public ListItem GetClienteByID(int idSistema)
        {
            ListItem Sistema = GetCatalogos("select c.idCliente,c.Cliente from CatSistema s inner join Cat_Cliente c on s.idCliente  = c.idCliente where s.idSistema =" + idSistema.ToString() + ";").First();
            return Sistema;
        }
        
        public List<ListItem> GetLiderKrio()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= 0 and Activo=1 and idPuesto=2");
        }
        public List<ListItem> GetPMOKrio()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= 0 and Activo=1 and idPuesto=3");
        }
        public List<ListItem> GetEnlace(int idEmpresa)
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= " + idEmpresa.ToString() + " and Activo=1 and idPuesto=4");
        }
        public List<ListItem> GetDesarrolladorKrio()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= 0 and Activo=1 and idPuesto=5");
        }
        public List<ListItem> GetPPQAKrio()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= 0 and Activo=1 and idPuesto=6");
        }
        public List<ListItem> GetAdminConfKrio()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre  from TblEmpleado  where idEmpresa= 0 and Activo=1 and idPuesto=7");
        }
        public List<ListItem> GetAllUsuariosPuesto()
        {
            return GetCatalogos("select idEmpleado,Nombre + ' ' + ApellidoPat + ' ' + ApellidoPat + '(' + p.Puesto + ')' from TblEmpleado e inner join Cat_Puesto p on p.idPuesto = e.idPuesto");
        }
        public List<ListItem> GetAllUsuariosAnexos()
        {
            return GetCatalogos("select idParticipante,Participante from TblParticipante;");
        }

    }
}