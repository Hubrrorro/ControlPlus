using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace AppControlCMMI.Seguridad
{
    public static class Seguridad
    {
        public static string saltkey
        {
            get
            {
                string strKey = DateTime.Now.ToShortDateString();
                strKey = strKey.Replace("/", "");
                strKey = strKey + "_KSDP123";
                return sha256(strKey);
            }
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

