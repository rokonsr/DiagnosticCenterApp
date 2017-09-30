using System;
using System.Collections.Generic;
using DiagnosticCenterApp.Gateway;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.BLL
{
    public class TestSetupManager
    {
        TestSetupGateway testSetupGateway = new TestSetupGateway();

        public List<TestType> GetTestTypeForDDL()
        {
            return testSetupGateway.GetTestTypeForDDL();
        }

        public List<TestSetup> GetTestSetupForGv()
        {
            return testSetupGateway.GetTestSetupForGv();
        }

        public string CreateTestSetup(TestSetup testSetup)
        {
            if (testSetup.TestName == "")
            {
                return "Test name is required!";
            }
            if (testSetup.TestName.Length < 3 || testSetup.TestName.Length > 95)
            {
                return "Test type should between 3 to 90";
            }
            if (string.IsNullOrEmpty(testSetup.TestFee.ToString()))
            {
                return "Test fee is required!";
            }
            if (testSetupGateway.IsExistTestSetup(testSetup))
            {
                return "Test name =" + testSetup.TestName + "= already exist!";
            }
            if (testSetupGateway.CreateTest(testSetup) > 0)
            {
                return "Save Sucessfully";
            }
            return "Save Failed";
        }

        public List<TestSetup> GetTestwiseReport(DateTime fromDate, DateTime toDate)
        {
            return testSetupGateway.GetTestwiseReport(fromDate, toDate);
        }
    }
}
