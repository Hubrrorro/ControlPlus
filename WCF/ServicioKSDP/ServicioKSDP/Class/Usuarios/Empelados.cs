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
        public UsuarioSVN GetUsuSVN(int IdUsuario)
        {
            Conexion Conex = new Conexion();
            UsuarioSVN OEmpleado = new UsuarioSVN();
            try
            {
                SqlConnection SqlCon = Conex.CreaConex();
                using (SqlCon)
                {
                    using (SqlCommand Comm = new SqlCommand("select * from Cat_SVN where idusuario = @idUsuario;", SqlCon))
                    {
                        Comm.Parameters.Add(new SqlParameter("@idUsuario", IdUsuario));
                        Comm.CommandType = System.Data.CommandType.Text;
                        SqlCon.Open();
                        SqlDataReader reader = Comm.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                OEmpleado.idUsuario = reader.GetInt32(1);
                                OEmpleado.URL = reader.GetString(2);
                                OEmpleado.Nombre = reader.GetString(3);
                                OEmpleado.Contraseña = reader.GetString(4);
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
                        Comm.Parameters.Add(new SqlParameter("@Ruta", uSVN.URL));
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