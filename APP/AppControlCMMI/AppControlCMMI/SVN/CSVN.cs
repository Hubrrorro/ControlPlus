using AppControlCMMI.ControWS;
using SharpSvn;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppControlCMMI.SVN
{
    class CSVN
    {
        public bool commit(UsuarioSVN usuSVN, string Mensaje)
        {
            bool EsCorrecto = true;
            SvnUpdateResult result;
            SvnCommitArgs ca = new SvnCommitArgs();
            using (SvnClient client = new SvnClient())
            {
                try
                {
                    client.Authentication.ForceCredentials(usuSVN.Nombre, usuSVN.Contraseña);
                    //SvnUriTarget is a wrapper class for SVN repository URIs
                    SvnUriTarget target = new SvnUriTarget(usuSVN.URL);
                    client.Authentication.SslServerTrustHandlers += new EventHandler<SharpSvn.Security.SvnSslServerTrustEventArgs>(Authentication_SslServerTrustHandlers);

                    // Checkout the code to the specified directory
                    client.CheckOut(target, usuSVN.RutaLocal);

                    // Update the specified working copy path to the head revision
                    //client.Update("c:\\sharpsvn");
                    
                    client.Update(usuSVN.RutaLocal, out result);

                    
                    
                    ca.LogMessage = "Mensaje";
                    client.Commit(usuSVN.RutaLocal, ca);
                }
                catch
                {
                    EsCorrecto = false;
                }
                return EsCorrecto;
            }
        }
        public bool checkedOut(UsuarioSVN usuSVN)
        {
            SvnUpdateResult result;

            SvnCheckOutArgs args = new SvnCheckOutArgs();

            using (SvnClient client = new SvnClient())
            {
                try
                {
                    client.Authentication.ForceCredentials(usuSVN.Nombre, usuSVN.Contraseña);
                    //SvnUriTarget is a wrapper class for SVN repository URIs
                    SvnUriTarget target = new SvnUriTarget(usuSVN.URL);
                    client.Authentication.SslServerTrustHandlers += new EventHandler<SharpSvn.Security.SvnSslServerTrustEventArgs>(Authentication_SslServerTrustHandlers);


                    if (client.CheckOut(target, usuSVN.RutaLocal, args, out result))
                        return true;
                }
                catch (SvnException se)
                {
                    return false;
                }
                catch (UriFormatException ufe)
                {
                    return false;
                }
            }
            return true;

        }
        void Authentication_SslServerTrustHandlers(object sender, SharpSvn.Security.SvnSslServerTrustEventArgs e)
        {
            // Look at the rest of the arguments of E, whether you wish to accept

            // If accept:
            e.AcceptedFailures = e.Failures;
            e.Save = true; // Save acceptance to authentication store
        }
    }
}
