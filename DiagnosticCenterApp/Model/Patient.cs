using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiagnosticCenterApp.Model
{
    [Serializable]
    public class Patient
    {
        public int PatientId { get; set; }
        public string PatientName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string MobileNumber { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal PaidAmount { get; set; }
        public decimal DueAmount 
        { 
            get { return TotalAmount - PaidAmount; } 
        }
        public DateTime CreatedDate { get; set; }

        public int TestSetupId { get; set; }
        public List<TestSetup> TestSetups { get; set; }
    }
}