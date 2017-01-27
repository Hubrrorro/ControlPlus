using ServicioKSDP.BD;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ServicioKSDP.Class.Usuarios
{
    public class Empelados
    {
        public UsuarioSVN GetRutaSVN(int idUsuario, int idTicket)
        {
            Conexion Conex = new Conexion();
            UsuarioSVN OEmpleado = new UsuarioSVN();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("select RutaSVN, RutaLocal from Cat_SVNLocal where idUsuario = @idUsuario and idTicket = @idTicket;", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idUsuario", idUsuario));
                        Comm.Parameters.Add(new SqlParameter("@idTicket", idTicket));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                OEmpleado.idUsuario = idUsuario;
                                OEmpleado.idTicket = idTicket;
                                OEmpleado.URL = reader.GetString(0);
                                OEmpleado.RutaLocal = reader.GetString(1);
                            }
                        }
                    }
                }
            }
            catch
            {
            }
            return OEmpleado;
        }
        public bool AddlRutas(UsuarioSVN Usuariosvn)
        {
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("SP_AddRutaSVN", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idTicket", Usuariosvn.idTicket));
                        Comm.Parameters.Add(new SqlParameter("@idUsuario", Usuariosvn.idUsuario));
                        Comm.Parameters.Add(new SqlParameter("@RutaLocal", Usuariosvn.RutaLocal));
                        Comm.Parameters.Add(new SqlParameter("@RutaSVN", Usuariosvn.URL));
                        Comm.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlCon.Open();
                        Comm.ExecuteNonQuery();
                        
                    }
                }
            }
            catch
            {
                return false;
            }
            return true;
        }
        public UsuarioSVN GetUsuSVN(int IdUsuario)
        {
            Conexion Conex = new Conexion();
            UsuarioSVN OEmpleado = new UsuarioSVN();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("select USUSVN,PassSVN from  tblEmpleado where idEmpleado = @idUsuario;", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idUsuario", IdUsuario));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                OEmpleado.idUsuario = IdUsuario;
                                OEmpleado.Nombre = reader.GetString(0);
                                OEmpleado.Contraseña = reader.GetString(1);
                            }
                        }
                    }
                }
            }
            catch
            {
            }
            return OEmpleado;
        }
        public bool AddSVN(UsuarioSVN uSVN)
        {
            Conexion Conex = new Conexion();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("SP_UsuarioSVN", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idUsuario", uSVN.idUsuario));
                        Comm.Parameters.Add(new SqlParameter("@Usuario", uSVN.Nombre));
                        Comm.Parameters.Add(new SqlParameter("@Pass", uSVN.Contraseña));
                        Comm.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlCon.Open();
                        Comm.ExecuteNonQuery();
                        
                    }
                }
            }
            catch
            {
                return false;
            }
            return true;
        }
        public Empleado GetEmpleadoByID(int idEmpleado)
        {
            Conexion Conex = new Conexion();
            Empleado OEmpleado = new Empleado();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("select Nombre + ' ' + ApellidoPat + ' '+ ApellidoMat Nombre,Correo from TblEmpleado where idEmpleado =@idEmpleado;", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idEmpleado", idEmpleado));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                OEmpleado.Nombre = reader.GetString(0);
                                OEmpleado.Correo = reader.GetString(1);
                            }
                        }
                    }
                }
            }
            catch
            { }
            return OEmpleado;
        }
    }
}