using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ServicioKSDP.BD
{
    public class Conexion
    {
        internal SqlConnection CreaConex()
        {
            string StrConex = ConfigurationManager.ConnectionStrings["dbEvaluacion"].ConnectionString;
            SqlConnection SqlConn = new SqlConnection(StrConex);
            return SqlConn;
        }
    }
}