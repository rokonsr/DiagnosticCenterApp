<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestRequestUI.aspx.cs" Inherits="DiagnosticCenterApp.UI.TestRequestUI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $("#txtDateofBirth").datepicker({ dateFormat: 'dd/mm/yy', type: Text });
                });
        });
    </script>
    

    <style>
        .rightalign {
            float: right;
            font-weight: bolder;
        }

        table tr td {
            padding: 5px;
        }

        .auto-style1 {
           ;
        }

    </style>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Test Request Entry</legend>
        
        <div class="box">
            <div class="form-group">
                <table>
                    <tr>
                        <td>
                            <label for="patientname" style="width: 120px;">Patient Name</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPatientName" CssClass="form-control" runat="server" Width="250"></asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Patient name is required!" ControlToValidate="txtPatientName" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtPatientName" ForeColor="red" ValidationExpression="^[a-zA-Z . \- ]*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="dateofbirth">Date of Birth</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateofBirth" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Date of birth is required!" ControlToValidate="txtDateofBirth" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtDateofBirth" ForeColor="red" ValidationExpression="^[0-9 \/ ]*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="mobilenumber">Mobile Number</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobileNumber" CssClass="form-control" runat="server"></asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="Mobile no is required!" ControlToValidate="txtMobileNumber" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtMobileNumber" ForeColor="red" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="testname">Select Test</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTestName" CssClass="form-control" AutoPostBack="True" runat="server" OnSelectedIndexChanged="ddlTestName_OnSelectedIndexChanged"></asp:DropDownList>
                            
                            <asp:Label ID="lblDDLErrorMessage" runat="server" Text="" ForeColor="red"></asp:Label>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server" ErrorMessage="Please select test name" InitialValue="0" ForeColor="red" ControlToValidate="ddlTestName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <table style="float: right;">
                                <tr>
                                    <td style="padding: 10px; text-align: right; width: 220px"><label for="testfee">FEE</label></td>
                                    <td>
                                        <asp:TextBox ID="txtTestFee" CssClass="form-control" runat="server" style="width: 60px;"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: right;">
                            <asp:Button ID="btnAddTestType" CssClass="btn btn-default" runat="server" Text="Add" OnClick="btnAddTestType_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <br />
        <asp:Panel ID="pnlTestRequest" Visible="False" runat="server">
            <asp:GridView ID="gvTestRequest" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False" Width="100%">
            <HeaderStyle CssClass="gvheaderstyle" />
            <%--<RowStyle CssClass="gvrowstyle" />--%>
            <Columns>
                <asp:TemplateField HeaderText="Sl No.">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Test">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestName" Text='<%# Eval("TestName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fee">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestFee" Text='<%# Eval("TestFee") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
            <PagerStyle BackColor="lightblue" BorderColor="Blue" BorderWidth="1" Font-Underline="true" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" CssClass="pagerStyle" />
            </asp:GridView>
            <br />
            
            <asp:TextBox ID="txtTotalAmount" CssClass="rightalign form-control" style="width: 120px;" runat="server"></asp:TextBox>
            <label for="totalAmount" class="rightalign" style="padding-top: 5px;">Total Amount : &nbsp;</label>
            <br />
            <br />
            <asp:Button ID="btnSave" runat="server" class="rightalign btn btn-default" style="padding-top: 5px; width: 120px;" Text="Save" OnClick="btnSave_Click" CausesValidation="False" />
        </asp:Panel>
        <asp:Panel ID="pnlPrintBill" runat="server">
            <asp:GridView ID="gvPrintBill" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False" Width="100%">
            <HeaderStyle CssClass="gvheaderstyle" />
            <%--<RowStyle CssClass="gvrowstyle" />--%>
            <Columns>
                <asp:TemplateField HeaderText="Sl No.">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Test">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestName" Text='<%# Eval("TestName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fee">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestFee" Text='<%# Eval("TestFee") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
            <PagerStyle BackColor="lightblue" BorderColor="Blue" BorderWidth="1" Font-Underline="true" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" CssClass="pagerStyle" />
            </asp:GridView>
            <br />
        </asp:Panel>

    </fieldset>

</asp:Content>
