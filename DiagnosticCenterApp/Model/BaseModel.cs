using System;
using System.IO;
using System.Web;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using Font = System.Drawing.Font;


namespace DiagnosticCenterApp.Model
{
    public class BaseModel : System.Web.UI.Page
    {
        public void MessageBox(String message)
        {
            System.Web.UI.WebControls.Label lblMessageBoxForAlert = new System.Web.UI.WebControls.Label();
            lblMessageBoxForAlert.ID = "testjavascriptlabelid";
            lblMessageBoxForAlert.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert(" + "'" + message + "'" + ");</script>";
            Page.Controls.Add(lblMessageBoxForAlert);
        }
    }
}
