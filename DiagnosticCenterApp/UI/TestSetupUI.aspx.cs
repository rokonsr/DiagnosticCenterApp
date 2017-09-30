using System;
using System.Web.UI.WebControls;
using DiagnosticCenterApp.BLL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.UI
{
    public partial class TestSetupUI : BaseModel
    {
        TestSetupManager testSetupManager = new TestSetupManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDown();
            }
            GridViewBindTestSetup();
        }

        private void PopulateDropDown()
        {
            ddlTestType.DataSource = testSetupManager.GetTestTypeForDDL();
            ddlTestType.DataValueField = "TestTypeId";
            ddlTestType.DataTextField = "TestTypeName";
            ddlTestType.DataBind();

            ddlTestType.Items.Insert(0, new ListItem("--Select Test Type--", "0"));
        }

        private void GridViewBindTestSetup()
        {
            gvTestSetup.DataSource = testSetupManager.GetTestSetupForGv();
            gvTestSetup.DataBind();
            gvTestSetup.ShowHeaderWhenEmpty = true;
            gvTestSetup.EmptyDataText = "No data found";
        }

        protected void btnAddTestType_OnClick(object sender, EventArgs e)
        {
            TestSetup testSetup = new TestSetup();

            if (txtTestName.Text != "" && txtTestFee.Text != "" && ddlTestType.SelectedIndex != 0)
            {
                testSetup.TestName = txtTestName.Text.Trim();
                testSetup.TestFee = Convert.ToDecimal(txtTestFee.Text.Trim());
                testSetup.TestTypeId = Convert.ToInt32(ddlTestType.SelectedItem.Value);

                MessageBox(testSetupManager.CreateTestSetup(testSetup));

                GridViewBindTestSetup();

                txtTestName.Text = string.Empty;
                txtTestFee.Text = string.Empty;
                ddlTestType.SelectedIndex = 0;
            }
            else
            {
                MessageBox("All field are required!");
            }
        }
    }
}