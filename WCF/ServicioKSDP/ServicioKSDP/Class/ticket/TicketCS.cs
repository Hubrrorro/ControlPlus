using ServicioKSDP.BD;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace ServicioKSDP.Class.ticket
{
    public class TicketCS
    {
        public void ActualizaSubEtapa(int idSubEtapa, int IdTicket)
        {
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    string qry = "update TblTicket set idSubEtapa = @SubEtapa ";
                    qry += "where IDTicket = @Ticket";
                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@SubEtapa", idSubEtapa));
                        Comm.Parameters.Add(new SqlParameter("@Ticket", IdTicket));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        Comm.ExecuteNonQuery();
                    }
                }
            }
            catch
            {

            }
        }
        public void AgregaPersonal(int IdUsuario, int IdTicket)
        {
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    string qry = "insert into CatTicketEmpleado(idEmpleado,IDTicket) ";
                    qry += "values (@Usu,@idTicket)";
                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@Usu", IdUsuario));
                        Comm.Parameters.Add(new SqlParameter("@idTicket", IdTicket));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        Comm.ExecuteNonQuery();
                    }
                }

            }
            catch
            {

            }
        }
        public DataRepTicket RerportRow(int IdTicket)
        {
            DataRepTicket Reporte = new DataRepTicket();
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    string qry = "select t.IDTicket,Ticket,convert(nvarchar(10),FechaAlta,103) FchAlta,upper(Identificador) Identificador,upper(Nombre) Nombre,Cliente,c.Sistema ";
                    qry += " from TblTicket t inner join CatSistema c on c.idSistema = t.idSistema inner join Cat_Cliente cli on cli.idCliente = c.idCliente";
                    qry += " where t.IDTicket=@IdTicket;";
                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@IdTicket", IdTicket));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Reporte.idTicket = reader.GetInt32(0);
                                Reporte.Ticket = reader.GetString(1);
                                Reporte.Fecha = reader.GetString(2);
                                Reporte.Identificador = reader.GetString(3);
                                Reporte.Nombre = reader.GetString(4);
                                Reporte.Cliente = reader.GetString(5);
                                Reporte.Sistema = reader.GetString(6);
                            }
                        }
                    }
                }

            }
            catch
            {

            }
            return Reporte;
        }
        public List<DataRepTicket> Rerport(string Nombre, string Ticket, int Sistema, int idEmpleado)
        {
            List<DataRepTicket> Reporte = new List<DataRepTicket>();
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    string qry = "select t.IDTicket,Ticket,convert(nvarchar(10),FechaAlta,103) FchAlta,upper(Identificador) Identificador,upper(Nombre) Nombre,Cliente,c.Sistema ";
                    qry += " from TblTicket t inner join CatSistema c on c.idSistema = t.idSistema inner join Cat_Cliente cli on cli.idCliente = c.idCliente";
                    qry += " inner join CatTicketEmpleado em on em.IDTicket = t.IDTicket where id_Estatus=1 and em.idEmpleado=" + idEmpleado.ToString();
                    if (!String.IsNullOrEmpty(Nombre.Trim()))
                        qry += " and Nombre like '%" + Nombre + "%'";
                    if (!String.IsNullOrEmpty(Ticket.Trim()))
                        qry += " and Ticket = '" + Ticket.ToUpper() + "'";
                    if (!Sistema.Equals(0))
                        qry += " and t.idSistema = " + Sistema.ToString();

                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                DataRepTicket RowReporte = new DataRepTicket();
                                RowReporte.idTicket = reader.GetInt32(0);
                                RowReporte.Ticket = reader.GetString(1);
                                RowReporte.Fecha = reader.GetString(2);
                                RowReporte.Identificador = reader.GetString(3);
                                RowReporte.Nombre = reader.GetString(4);
                                RowReporte.Cliente = reader.GetString(5);
                                RowReporte.Sistema = reader.GetString(6);
                                Reporte.Add(RowReporte);
                            }
                        }
                    }
                }

            }
            catch
            {

            }
            return Reporte;
        }
        public List<DataRepTicket> Rerport(int idEmpleado)
        {
            List<DataRepTicket> Reporte = new List<DataRepTicket>();
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    string qry = "select t.IDTicket,Ticket,convert(nvarchar(10),FechaAlta,103) FchAlta,upper(Identificador) Identificador,upper(Nombre) Nombre,Cliente,c.Sistema ";
                    qry += " from TblTicket t inner join CatSistema c on c.idSistema = t.idSistema inner join Cat_Cliente cli on cli.idCliente = c.idCliente";
                    qry += " inner join CatTicketEmpleado em on em.IDTicket = t.IDTicket where id_Etapa=1 and idSubEtapa=1 and id_Estatus=1 and em.idEmpleado=@idEmpleado;";
                    using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idEmpleado", idEmpleado));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                DataRepTicket RowReporte = new DataRepTicket();
                                RowReporte.idTicket = reader.GetInt32(0);
                                RowReporte.Ticket = reader.GetString(1);
                                RowReporte.Fecha = reader.GetString(2);
                                RowReporte.Identificador = reader.GetString(3);
                                RowReporte.Nombre = reader.GetString(4);
                                RowReporte.Cliente = reader.GetString(5);
                                RowReporte.Sistema = reader.GetString(6);
                                Reporte.Add(RowReporte);
                            }
                        }
                    }
                }

            }
            catch
            {

            }
            return Reporte;
        }
        private void CorreoAsignaTicketLider(Ticket _Ticket)
        {
            Class.Usuarios.Empelados CEmpleados = new Class.Usuarios.Empelados();
            Empleado Lider = CEmpleados.GetEmpleadoByID(_Ticket.idLider);
            Empleado PMO = CEmpleados.GetEmpleadoByID(_Ticket.idPMO);
            Empleado Enlace = CEmpleados.GetEmpleadoByID(_Ticket.idEnlace);
            catalogos.Catalogos Cat = new catalogos.Catalogos();
            ListItem Sistema = Cat.GetSistemaByID(_Ticket.idSistema);
            ListItem Cliente = Cat.GetClienteByID(_Ticket.idSistema);
            List<string> Correos = new List<string>();
            Correos.Add(Lider.Correo);
            Correos.Add(PMO.Correo);
            StringBuilder SB_Cuerpo = new StringBuilder();
            SB_Cuerpo.Append("<h2>Asignación de proyecto</h2>");
            SB_Cuerpo.Append("</br>");
            SB_Cuerpo.Append("<p>Estimado : "+ Lider.Nombre +"</p>");
            SB_Cuerpo.Append("</br>");
            SB_Cuerpo.Append("<p>Por medio del presente correo se informa que se te ha asignado el siguiente proyecto para realizar el proceso de gestión, desarrollo, pruebas y liberación</p>");
            SB_Cuerpo.Append("</br>");
            SB_Cuerpo.Append("Datos :");
            SB_Cuerpo.Append("</br>");
            SB_Cuerpo.Append("<ul>");
            SB_Cuerpo.Append("<li> Cliente : "+ Cliente.item  +"</li>");
            SB_Cuerpo.Append("<li> Sistema : " + Sistema.item + "</li>");
            SB_Cuerpo.Append("<li> Identificador/WO : " + _Ticket.Identificador + "</li>");
            SB_Cuerpo.Append("<li> Enlace : " + Enlace.Nombre + "</li>");
            SB_Cuerpo.Append("</ul>");
            EnvioCorreo EnvioCo = new EnvioCorreo();
            EnvioCo.Enviar("Asignación de proyecto", SB_Cuerpo, Correos);
        }
        public Ticket Create(Ticket _Ticket)
        {
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("SP_AddTicket", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idSistema", _Ticket.idSistema));
                        Comm.Parameters.Add(new SqlParameter("@idTipo", _Ticket.idTipo));
                        Comm.Parameters.Add(new SqlParameter("@idEtapa", _Ticket.idEtapa));
                        Comm.Parameters.Add(new SqlParameter("@Identificador", _Ticket.Identificador));
                        Comm.Parameters.Add(new SqlParameter("@Nombre", _Ticket.Nombre));
                        Comm.Parameters.Add(new SqlParameter("@Descrip", _Ticket.Descripcion));
                        Comm.Parameters.Add(new SqlParameter("@idSubEtapa", _Ticket.idSubEtapa));
                        Comm.Parameters.Add(new SqlParameter("@PMO", _Ticket.idPMO));
                        Comm.Parameters.Add(new SqlParameter("@Enlace", _Ticket.idEnlace));
                        Comm.Parameters.Add(new SqlParameter("@Lider", _Ticket.idLider));
                        Comm.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                _Ticket.idTicket = reader.GetInt32(0);
                                _Ticket.TicketKSDP = reader.GetString(1);
                            }
                            CorreoAsignaTicketLider(_Ticket);
                        }
                    }
                }

            }
            catch
            {

            }
            return _Ticket;
        }
        public bool ExisteBD(Ticket _Ticket)
        {
            bool Existe = true;
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("SP_BuscaTicket", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@Identificador", _Ticket.Identificador));
                        Comm.Parameters.Add(new SqlParameter("@Nombre", _Ticket.Nombre));
                        Comm.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int Suma = reader.GetInt32(0);
                                if (Suma == 0)
                                    Existe = false;
                                break;

                            }
                        }
                    }
                }

            }
            catch
            {
            }
            return Existe;
        }
    }
}