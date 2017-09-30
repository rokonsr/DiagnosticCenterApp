using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using DiagnosticCenterApp.BLL;
using DiagnosticCenterApp.Model;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using Font = System.Drawing.Font;

namespace DiagnosticCenterApp.UI
{
    public partial class TestwiseReportUI : System.Web.UI.Page
    {
        TestSetupManager testSetupManager = new TestSetupManager();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnShow_OnClick(object sender, EventArgs e)
        {
            List<TestSetup> testSetups = testSetupManager.GetTestwiseReport(Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text));

            gvReportDetails.DataSource = testSetups;

            gvReportDetails.ShowHeaderWhenEmpty = true;
            gvReportDetails.EmptyDataText = "No data found";
            gvReportDetails.DataBind();

            pnlReportDetails.Visible = true;

            decimal totalAmount = 0;

            foreach (TestSetup testSetup in testSetups)
            {
                totalAmount += testSetup.TestFee;
            }

            txtTotalAmount.Text = totalAmount.ToString("N2");
        }

        protected void btnGeneratePdf_OnClick(object sender, EventArgs e)
        {
            GeneratePdf();
        }

        private void GeneratePdf()
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=TestwiseReport.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvReportDetails.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 50f, 50f, 20f, 50f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

            pdfDoc.Open();

            PdfPTable table = new PdfPTable(3);
            table.WidthPercentage = 100;
            table.DefaultCell.Border = 0;

            PdfPCell cell =
                new PdfPCell(new Phrase("BD Diagnostic Center", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 26)));
            cell.Colspan = 3;
            cell.HorizontalAlignment = Element.ALIGN_CENTER;
            cell.Border = 0;
            table.AddCell(cell);

            PdfPCell cell1 = new PdfPCell(new Phrase("Test wise Report", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 20)));
            cell1.Colspan = 3;
            cell1.HorizontalAlignment = Element.ALIGN_CENTER;
            cell1.Border = 0;
            cell1.BorderColorBottom = new BaseColor(System.Drawing.Color.Black);
            cell1.BorderWidthBottom = 1f;
            table.AddCell(cell1);

            table.AddCell("");
            cell = new PdfPCell(new Phrase(DateTime.Now.ToShortDateString()));
            cell.Colspan = 2;
            cell.Border = 0;
            cell.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell);

            pdfDoc.Add(table);

            pdfDoc.Add(new Paragraph(" \n"));

            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
            gvReportDetails.AllowPaging = true;
            gvReportDetails.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            return;
        }
    }
}