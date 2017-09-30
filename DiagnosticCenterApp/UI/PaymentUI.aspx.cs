using System;
using DiagnosticCenterApp.BLL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.UI
{
    public partial class Payment : BaseModel
    {
        PaymentManager paymentManager = new PaymentManager();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearchBillNumber_OnClick(object sender, EventArgs e)
        {
            gvBillDetails.DataSource = paymentManager.GetBillDetailsForGv(Convert.ToInt32(txtBillNumber.Text.Trim()));

            gvBillDetails.ShowHeaderWhenEmpty = true;
            gvBillDetails.EmptyDataText = "No data found";
            gvBillDetails.DataBind();

            AmountDetails();
        }

        protected void btnPaid_OnClick(object sender, EventArgs e)
        {
            MessageBox(paymentManager.GetPayment(Convert.ToInt32(txtAmountToBePaid.Text.Trim()), Convert.ToInt32(txtBillNumber.Text.Trim())));

            AmountDetails();
        }

        private void AmountDetails()
        {
            Patient patient = new Patient();
            patient = paymentManager.GetBillSummary(Convert.ToInt32(txtBillNumber.Text.Trim()));

            lblBillDate.Text = patient.CreatedDate.ToString("d MMM yyyy");
            lblTotalFee.Text = patient.TotalAmount.ToString("N2");
            lblPaidAmount.Text = patient.PaidAmount.ToString("N2");
            lblDueAmount.Text = patient.DueAmount.ToString("N2");

            pnlSearchBill.Visible = true;
        }
    }
}