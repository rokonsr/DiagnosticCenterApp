using System;
using System.Collections.Generic;
using DiagnosticCenterApp.Gateway;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.BLL
{
    public class TestTypeManager
    {
        TestTypeGateway testTypeGateway = new TestTypeGateway();

        public string CreateTestType(TestType testType)
        {
            if (testType.TestTypeName == "")
            {
                return "Test type is required!";
            }
            if (testType.TestTypeName.Length < 3 || testType.TestTypeName.Length > 95)
            {
                return "Test type should between 3 to 90";
            }
            if (testTypeGateway.IsExistTestType(testType))
            {
                return "TestType ="+ testType.TestTypeName +"= already exist!";
            }
            if (testTypeGateway.CreateTestType(testType) > 0)
            {
                return "Save Sucessfully";
            }
            return "Save Failed";
        }

        public List<TestType> GetTestType()
        {
            return testTypeGateway.GetTestType();
        }

        public List<TestType> GetTypewiseReport(DateTime fromDate, DateTime toDate)
        {
            return testTypeGateway.GetTypewiseReport(fromDate, toDate);
        }
    }
}
