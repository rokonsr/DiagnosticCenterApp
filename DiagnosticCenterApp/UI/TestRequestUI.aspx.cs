using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using DiagnosticCenterApp.BLL;
using DiagnosticCenterApp.Model;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using ListItem = System.Web.UI.WebControls.ListItem;

namespace DiagnosticCenterApp.UI
{
    public partial class TestRequestUI : BaseModel
    {
        TestRequestManager testRequestManager = new TestRequestManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDown();
            }
        }

        private void PopulateDropDown()
        {
            List<TestSetup> objTestTypeList = new List<TestSetup>();
            TestRequestManager objTestRequestBll = new TestRequestManager();
            objTestTypeList = objTestRequestBll.GetTestSetupForDDL();
            ddlTestName.DataSource = objTestTypeList;
            ddlTestName.DataValueField = "TestSetupId";
            ddlTestName.DataTextField = "TestName";
            ddlTestName.DataBind();

            ddlTestName.Items.Insert(0, new ListItem("--Select Test--", "0"));
        }

        protected void ddlTestName_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            TestSetup objTestSetup = new TestSetup();
            TestRequestManager objTestRequestBll = new TestRequestManager();

            if (ddlTestName.SelectedIndex != 0)
            {
                objTestSetup = objTestRequestBll.GetTestFee(ddlTestName.SelectedItem.Value);

                txtTestFee.Text = objTestSetup.TestFee.ToString();

                lblDDLErrorMessage.Text = "";
            }
            else
            {
                lblDDLErrorMessage.Text = "Please select test name";
            }
            
        }

        protected void btnAddTestType_Click(object sender, EventArgs e)
        {
            pnlTestRequest.Visible = true;

            if (ddlTestName.SelectedIndex != 0)
            {
                Patient aPatient = new Patient();
                
                if (ViewState["TestRequest"] == null)
                {
                    List<TestSetup> testSetups = new List<TestSetup>();

                    TestSetup testSetup = new TestSetup();
                    testSetup.TestSetupId = Convert.ToInt32(ddlTestName.SelectedItem.Value);
                    testSetup.TestName = ddlTestName.SelectedItem.Text;
                    testSetup.TestFee = Convert.ToDecimal(txtTestFee.Text);
                    
                    testSetups.Add(testSetup);
                    aPatient.TestSetups = testSetups;

                    ViewState["TestRequest"] = testSetups;
                }
                else
                {
                    List<TestSetup> testSetups = (List<TestSetup>)ViewState["TestRequest"];

                    bool status = false;

                    foreach (TestSetup item in testSetups)
                    {
                        if (item.TestSetupId == Convert.ToInt32(ddlTestName.SelectedItem.Value))
                        {
                            status = true;
                        }
                    }

                    if (!status)
                    {
                        TestSetup testSetup = new TestSetup();
                        testSetup.TestSetupId = Convert.ToInt32(ddlTestName.SelectedItem.Value);
                        testSetup.TestName = ddlTestName.SelectedItem.Text;
                        testSetup.TestFee = Convert.ToDecimal(txtTestFee.Text);
                        
                        testSetups.Add(testSetup);
                        
                        ViewState["TestRequest"] = testSetups;
                    }
                }

                if (ViewState["TestRequest"] != null)
                {
                    aPatient.TestSetups = (List<TestSetup>)ViewState["TestRequest"];

                    decimal totalAmount = 0;
                    gvTestRequest.DataSource = (List<TestSetup>)ViewState["TestRequest"];
                    gvTestRequest.DataBind();

                    foreach (TestSetup item in (List<TestSetup>)ViewState["TestRequest"])
                    {
                        totalAmount += (decimal)item.TestFee;
                    }
                    txtTotalAmount.Text = totalAmount.ToString("N2");
                }
                Session["Patient"] = aPatient;
                ddlTestName.SelectedIndex = 0;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Patient aPatient = (Patient)Session["Patient"];

            if (Session["Patient"] != null)
            {
                aPatient.PatientName = txtPatientName.Text;
                aPatient.DateOfBirth = Convert.ToDateTime(txtDateofBirth.Text);
                aPatient.MobileNumber = txtMobileNumber.Text;

                aPatient.TotalAmount = Convert.ToDecimal(txtTotalAmount.Text);

                foreach (TestSetup item in aPatient.TestSetups)
                {
                    aPatient.TestSetupId = item.TestSetupId;

                    testRequestManager.SaveTestRequest(aPatient);

                    aPatient.MobileNumber = "Reset";
                }
                Session.Remove("Patient");
                aPatient = new Patient();
            }

            int billNumber = testRequestManager.GetLastBillNumber();
            GeneratePdf(txtPatientName.Text, txtTotalAmount.Text, billNumber);
        }

        private void GeneratePdf(string patientName, string totalAmount, int billNumber)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=BillDetails.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvTestRequest.RenderControl(hw);
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

            PdfPCell cell1 = new PdfPCell(new Phrase("Bill Details", new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 20)));
            cell1.Colspan = 3;
            cell1.HorizontalAlignment = Element.ALIGN_CENTER;
            cell1.Border = 0;
            cell1.BorderColorBottom = new BaseColor(System.Drawing.Color.Black);
            cell1.BorderWidthBottom = 1f;
            table.AddCell(cell1);

            table.AddCell("Bill No. " + billNumber);
            cell = new PdfPCell(new Phrase(DateTime.Now.ToShortDateString()));
            cell.Colspan = 2;
            cell.Border = 0;
            cell.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell);

            table.AddCell("");
            table.AddCell("");
            table.AddCell("");

            table.AddCell("Patient Name : " + patientName);
            table.AddCell("");
            table.AddCell("Total Amount " + totalAmount);


            pdfDoc.Add(table);

            pdfDoc.Add(new Paragraph(" \n"));

            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
            gvTestRequest.AllowPaging = true;
            gvTestRequest.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            return;
        }
    }
}