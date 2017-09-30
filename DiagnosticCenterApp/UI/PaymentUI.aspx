<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaymentUI.aspx.cs" Inherits="DiagnosticCenterApp.UI.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*table {
            margin: 0 auto;
        }*/

        table tr td {
            padding: 5px;
            text-align: left;
        }

        /*.surroundingborder {
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            width: 400px;
            height: 75px;
            margin: 0 auto;
        }

        .panel-border-style {
            width: 80%;
            margin: 0 auto;
            padding: 5px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Pay Bill</legend>

        <div class="box">
            <table>
            <tr>
                <td>
                    <label for="billnumber" style="width: 120px;">Bill No</label>
                </td>
                <td>
                    <asp:TextBox ID="txtBillNumber" CssClass="form-control" runat="server" Width="150"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="Bill no is required!" ControlToValidate="txtBillNumber" ForeColor="red"></asp:RequiredFieldValidator>
                            
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtBillNumber" ForeColor="red" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                </td>
                <td style="text-align: right;">
                    <asp:Button ID="btnSearchBillNumber" CssClass="btn btn-default" runat="server" Text="Search" OnClick="btnSearchBillNumber_OnClick" />
                </td>
            </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
        </table>
        </div>
        

        <br />
        <asp:Panel ID="pnlSearchBill" runat="server" CssClass="panel-border-style" Visible="False">
            <asp:GridView ID="gvBillDetails" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False" Width="100%">
                <HeaderStyle CssClass="gvheaderstyle" />
                <RowStyle CssClass="gvrowstyle" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sl No">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="SlNo" CssClass="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
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
            <table>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">Bill Date</td>
                    <td>
                        <asp:Label ID="lblBillDate" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">Total Fee</td>
                    <td>
                        <asp:Label ID="lblTotalFee" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">Paid Amount</td>
                    <td>
                        <asp:Label ID="lblPaidAmount" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">Due Amount</td>
                    <td>
                        <asp:Label ID="lblDueAmount" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">Amount</td>
                    <td>
                        <asp:TextBox ID="txtAmountToBePaid" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Amount is required!" ControlToValidate="txtAmountToBePaid" ForeColor="red"></asp:RequiredFieldValidator>
                            
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtAmountToBePaid" ForeColor="red" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnPaid" runat="server" Text="Pay" CssClass="btn btn-default" OnClick="btnPaid_OnClick" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        

    </fieldset>

</asp:Content>
