using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiagnosticCenterApp.Model
{
    public class BillGenerateViewModel
    {
        public string PatientName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string MobileNumber { get; set; }

        public string TestName { get; set; }
        public decimal TestFee { get; set; }
    }
}