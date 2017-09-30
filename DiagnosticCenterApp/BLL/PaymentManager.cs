using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DiagnosticCenterApp.Gateway;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.BLL
{
    public class PaymentManager
    {
        PaymentGateway paymentGateway = new PaymentGateway();
        public List<TestSetup> GetBillDetailsForGv(int billNumber)
        {
            return paymentGateway.GetBillDetailsForGv(billNumber);
        }

        public Patient GetBillSummary(int billNumber)
        {
            return paymentGateway.GetBillSummary(billNumber);
        }

        public string GetPayment(double paidAmount, int billNumber)
        {
            if (paymentGateway.GetPaymentAmount(paidAmount, billNumber) > 0)
            {
                return "Payment received";
            }
            return "Payment updated failed!";
        }
    }
}