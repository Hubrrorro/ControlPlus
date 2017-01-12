using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
namespace ServicioKSDP.Class
{
    public class EnvioCorreo
    {
        public bool Enviar(string Titulo, StringBuilder Cuerpo, List<string> Correos)
        {
            try
            {
                SmtpClient Cliente = new SmtpClient("mail.codeplus.com.mx", 25);
                MailAddress CorreoDesde = new MailAddress("envio@codeplus.com.mx", "Envio Control Proyect");
                MailMessage Mensaje = new MailMessage();
                Mensaje.From = CorreoDesde;
                foreach (string Correo in Correos)
                {
                    Mensaje.To.Add(new MailAddress(Correo));
                }
                Mensaje.Body = Cuerpo.ToString();
                Mensaje.BodyEncoding = Encoding.UTF8;
                Mensaje.IsBodyHtml = true;
                Mensaje.Subject = Titulo;
                NetworkCredential credentials = new NetworkCredential("envio@codeplus.com.mx", "Lalo1981", "");
                Cliente.Credentials = credentials;
                Cliente.Send(Mensaje);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}