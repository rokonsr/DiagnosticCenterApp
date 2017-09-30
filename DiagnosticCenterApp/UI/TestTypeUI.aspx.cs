using System;
using System.Web.UI.WebControls;
using DiagnosticCenterApp.BLL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.UI
{
    public partial class AddTestType : BaseModel
    {
        TestTypeManager testTypeManager = new TestTypeManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            GridViewBindTestType();
        }

        protected void btnAddTestType_OnClick(object sender, EventArgs e)
        {
            TestTypeManager objTestTypeBll = new TestTypeManager();
            TestType objTestType = new TestType();

            objTestType.TestTypeName = txtTestTypeName.Text.Trim();

            MessageBox(objTestTypeBll.CreateTestType(objTestType));

            GridViewBindTestType();

            txtTestTypeName.Text = string.Empty;
        }

        private void GridViewBindTestType()
        {
            gvTestType.DataSource = testTypeManager.GetTestType();
            gvTestType.DataBind();
            gvTestType.ShowHeaderWhenEmpty = true;
            gvTestType.EmptyDataText = "No data found";
        }

        protected void gvTestType_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTestType.PageIndex = e.NewPageIndex;
            GridViewBindTestType();
        }
    }
}