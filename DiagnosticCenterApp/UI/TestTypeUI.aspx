<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestTypeUI.aspx.cs" Inherits="DiagnosticCenterApp.UI.AddTestType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table tr td {
            padding: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Test Type Setup</legend>
        
        <div class="box">
            <div class="form-group">
                <table>
                    <tr>
                        <td>
                            <label for="testtypename" style="width: 120px;">Type Name</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTestTypeName" CssClass="form-control" runat="server" Width="250"></asp:TextBox>
                            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Type name is required!" ControlToValidate="txtTestTypeName" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtTestTypeName" ForeColor="red" ValidationExpression="^[a-zA-Z0-9 _.-]*$"></asp:RegularExpressionValidator>
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
            <asp:GridView ID="gvTestType" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False"  OnPageIndexChanging="gvTestType_OnPageIndexChanging" Width="100%">
            <HeaderStyle CssClass="gvheaderstyle" />
            <RowStyle CssClass="gvrowstyle" />
            <Columns>
                <asp:TemplateField HeaderText="Sl No">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# Eval("TestTypeName")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
            <PagerStyle BackColor="lightblue" BorderColor="Blue" BorderWidth="1" Font-Underline="true" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" CssClass="pagerStyle" />
            </asp:GridView>
        </asp:Panel>

    </fieldset>

</asp:Content>
