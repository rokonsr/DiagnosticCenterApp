<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestSetupUI.aspx.cs" Inherits="DiagnosticCenterApp.UI.TestSetupUI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        table tr td {
            padding: 5px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Test Setup</legend>
        
        <div class="box">
            <div class="form-group">
                <table>
                    <tr>
                        <td>
                            <label for="testsetup" style="width: 120px;">Test Name</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTestName" CssClass="form-control" runat="server" Width="250"></asp:TextBox>
                            <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Type name is required!" ControlToValidate="txtTestName" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtTestName" ForeColor="red" ValidationExpression="^[a-zA-Z0-9 _.-]*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="testfee">Fee</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTestFee" CssClass="form-control" runat="server"></asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Type name is required!" ControlToValidate="txtTestFee" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtTestFee" ForeColor="red" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                        </td>
                        <td style="width: 120px; text-align: center;">BDT</td>
                    </tr>
                    <tr>
                        <td>
                            <label for="testtype">Test Type</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTestType" CssClass="form-control" runat="server"></asp:DropDownList>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server" ErrorMessage="Please select test type" InitialValue="0" ForeColor="red" ControlToValidate="ddlTestType"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: right;">
                            <asp:Button ID="btnAddTestType" CssClass="btn btn-default" runat="server" Text="Save" OnClick="btnAddTestType_OnClick" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <br />
        <asp:Panel ID="pnlTestType" runat="server">
            <asp:GridView ID="gvTestSetup" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False" Width="100%">
            <HeaderStyle CssClass="gvheaderstyle" />
            <RowStyle CssClass="gvrowstyle" />
            <Columns>
                <asp:TemplateField HeaderText="Sl No">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Test Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestName" Text='<%# Eval("TestName")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fee">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestFee" Text='<%# Eval("TestFee")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TestType" Text='<%# Eval("TestTypeName")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
            <PagerStyle BackColor="lightblue" BorderColor="Blue" BorderWidth="1" Font-Underline="true" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" CssClass="pagerStyle" />
            </asp:GridView>
        </asp:Panel>

    </fieldset>

</asp:Content>
