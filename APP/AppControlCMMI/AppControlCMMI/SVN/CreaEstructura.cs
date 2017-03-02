using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace AppControlCMMI.SVN
{
    public class CreaEstructura
    {
        public string Inicio(string path)
        {
            string Ruta = path + "/1.Inicio";
            return CreaFolder(Ruta);
        }
        private string CreaFolder(string Ruta)
        {
            if (!Directory.Exists(Ruta))
            {
                Directory.CreateDirectory(Ruta);
            }
            return Ruta;
        }
    }
}
