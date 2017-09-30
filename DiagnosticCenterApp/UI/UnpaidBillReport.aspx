<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UnpaidBillReport.aspx.cs" Inherits="DiagnosticCenterApp.UI.UnpaidBill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $("#txtFromDate").datepicker({ dateFormat: 'dd/mm/yy', type: Text });
                $("#txtToDate").datepicker({ dateFormat: 'dd/mm/yy', type: Text });
            });
        });
    </script>
    
    <style>
        
        table tr td {
            padding: 5px;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Unpaid Bill Report</legend>
            <div class="box">
                
                <table>
                <tr>
                    <td>
                        <label for="fromdate" style="width: 120px;">From Date</label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFromDate" CssClass="form-control" runat="server" ClientIDMode="Static" Placeholder="dd/mm/yy" Width="250"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Date is required!" ControlToValidate="txtFromDate" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtFromDate" ForeColor="red" ValidationExpression="^[0-9 \/ ]*$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="todate">To Date</label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtToDate" CssClass="form-control" runat="server" ClientIDMode="Static" Placeholder="dd/mm/yy"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Date is required!" ControlToValidate="txtToDate" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please input correct format" ControlToValidate="txtToDate" ForeColor="red" ValidationExpression="^[0-9 \/ ]*$"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Button ID="btnShow" CssClass="btn btn-default" runat="server" Text="Show" OnClick="btnShow_OnClick" />
                    </td>
                </tr>
            </table>
        <br />

            </div>
        <asp:Panel ID="pnlReportDetails" runat="server" Visible="False">
            <asp:GridView ID="gvReportDetails" runat="server" AllowPaging="True" PageSize="10" AutoGenerateColumns="False" Width="100%">
            <HeaderStyle CssClass="gvheaderstyle" />
            <Columns>
                <asp:TemplateField HeaderText="Sl No">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SlNo" Text='<%# ((GridViewRow)Container).RowIndex + 1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Number">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="PatientId" Text='<%# Eval("PatientId") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contact Number">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="MobileNumber" Text='<%# Eval("MobileNumber") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="PatientName" Text='<%# Eval("PatientName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Amount">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="TotalAmount" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Paid Amount">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="PaidAmount" Text='<%# Eval("PaidAmount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Due Amount">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="DueAmount" Text='<%# Eval("DueAmount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
            <PagerStyle BackColor="lightblue" BorderColor="Blue" BorderWidth="1" Font-Underline="true" ForeColor="White" Font-Bold="true" HorizontalAlign="Center" CssClass="pagerStyle" />
            </asp:GridView>
            <br />
            <table>
                <tr>
                    <td style="width: 25%;"></td>
                    <td style="width: 25%;"><asp:Button ID="btnGeneratePdf" runat="server" Text="PDF" OnClick="btnGeneratePdf_OnClick" CssClass="btn btn-default" /></td>
                    <td style="width: 25%; text-align: right;">Total</td>
                    <td style="width: 25%;">
                        <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
            </table>
            
        </asp:Panel>
    </fieldset>

</asp:Content>
