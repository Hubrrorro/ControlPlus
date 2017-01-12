using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ServicioKSDP.Class
{
    public static class Seguridad
    {
        private static  string saltkey
        { get {
                string strKey = DateTime.Now.ToShortDateString();
                strKey = strKey.Replace("/", "");
                strKey = strKey + "_KSDP123";
                    return strKey;
            } }
        private const string saltpass = "_M3nt3";
         
        public static bool keyCorrecta(string Key)
        {
            string _key = sha256(saltkey);
            return _key.Equals(Key);
        }
        private static string sha256(string password)
        {
            SHA256Managed crypt = new SHA256Managed();
            string hash = String.Empty;
            byte[] crypto = crypt.ComputeHash(Encoding.ASCII.GetBytes(password), 0, Encoding.ASCII.GetByteCount(password));
            foreach (byte theByte in crypto)
            {
                hash += theByte.ToString("x2");
            }
            return hash;
        }
    }
}