using System.Configuration;
using System.Data.SqlClient;

namespace DiagnosticCenterApp.DAL
{
    public class ServerConnection
    {
        public SqlConnection SqlConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            return con;
        }
    }
}
