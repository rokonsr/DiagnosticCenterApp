using System;
using System.Collections.Generic;
using DiagnosticCenterApp.Gateway;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.BLL
{
    public class TestRequestManager
    {
        TestRequestGateway testRequestGateway = new TestRequestGateway();
        public List<TestSetup> GetTestSetupForDDL()
        {
            List<TestSetup> testSetups = testRequestGateway.GetTestSetupForDDL();

            return testSetups;
        }

        public TestSetup GetTestFee(string TestSetupId)
        {
            TestSetup testSetup = testRequestGateway.GetTestFee(TestSetupId);

            return testSetup;
        }

        public void SaveTestRequest(Patient patient)
        {
            testRequestGateway.SaveTestRequest(patient);
        }

        public List<Patient> GetReportForUnpaidBill(DateTime fromDate, DateTime toDate)
        {
            return testRequestGateway.GetReportForUnpaidBill(fromDate, toDate);
        }

        //public  object GenerateBill()
        //{
        //    throw new NotImplementedException();
        //}

        public int GetLastBillNumber()
        {
            return testRequestGateway.GetLastBillNumber();
        }
    }
}
