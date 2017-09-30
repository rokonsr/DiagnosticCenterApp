using System;

namespace DiagnosticCenterApp.Model
{
    [Serializable]
    public class TestSetup
    {
        public int TestSetupId { get; set; }
        public string TestName { get; set; }
        public decimal TestFee { get; set; }

        public int TotalTest { get; set; }
        public int TestTypeId { get; set; }
        public string TestTypeName { get; set; }
    }
}
