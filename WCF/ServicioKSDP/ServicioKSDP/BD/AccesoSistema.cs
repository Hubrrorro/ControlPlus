using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ServicioKSDP.BD
{
    public class AccesoSistema
    {
        Conexion Conex = new Conexion();
        public List<Menu> GetMenu(int idPuesto)
        {
            List<Menu> Listado = new List<Menu>();
            SqlConnection SqlCon = Conex.CreaConex();
            using (SqlCon)
            {
                string qry = "select m.idMenu,m.idPadre,m.Ordenar,m.Titulo from cat_menu m inner join cat_menupuesto p on m.idMenu = p.idMenu where p.idPuesto= @idPuesto and m.idWebAPP=0;";
                using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                {
                    Comm.CommandType = System.Data.CommandType.Text;
                    Comm.Parameters.Add(new SqlParameter("@idPuesto", idPuesto));
                    SqlCon.Open();
                    SqlDataReader reader = Comm.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Menu _menu = new Menu();
                            _menu.idMenu= reader.GetInt32(0);
                            _menu.idMenuPadre= reader.GetInt32(1);
                            _menu.Ordernar = reader.GetInt32(2);
                            _menu.Titulo = reader.GetString(3);
                            Listado.Add(_menu);       
                        }
                    }
                }
            }
            return Listado;
        }
        public UsuarioFirmado IsAcceso(Usuario User)
        {
            string _pass = String.Empty;
            UsuarioFirmado UserFirmado = new UsuarioFirmado();
            SqlConnection SqlCon = Conex.CreaConex();
            using (SqlCon)
            {
                string qry = "select idEmpleado,idPuesto,idEmpresa,Iniciales,Nombre, ApellidoPat,ApellidoMat,Usuario,Pass from TblEmpleado where activo =1 and usuario = @USUARIO;";
                using (SqlCommand Comm = new SqlCommand(qry, SqlCon))
                {
                    Comm.CommandType = System.Data.CommandType.Text;
                    Comm.Parameters.Add(new SqlParameter("@USUARIO", User.usuario.ToUpper()));
                    SqlCon.Open();
                    SqlDataReader reader = Comm.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            _pass = reader.GetString(8);
                            if (_pass.Equals(User.contraseña))
                            {
                                UserFirmado.IdEmpleado = reader.GetInt32(0);
                                UserFirmado.IdPuesto = reader.GetInt32(1);
                                UserFirmado.IdEmpresa = reader.GetInt32(2);
                                UserFirmado.Iniciales = reader.GetString(3);
                                UserFirmado.Nombre = reader.GetString(4);
                                UserFirmado.ApellidoPaterno = reader.GetString(5);
                                UserFirmado.ApellidoMaterno = reader.GetString(6);
                                UserFirmado.Usuario = reader.GetString(7);
                                UserFirmado.Activo = true;
                            }
                            else
                                UserFirmado.Activo = false;
                        }
                    }
                    else
                        UserFirmado.Activo = false;
                }
            }
            return UserFirmado;
        }
    }
}