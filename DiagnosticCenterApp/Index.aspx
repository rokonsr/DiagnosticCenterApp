<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="DiagnosticCenterApp.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        table tr td {
            padding: 5px;
        }
         
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Project Details</legend>
        <span style="font-size: 30px;">Team Name : Reverb</span>
        <br />
        <br />
        <table>
            <tr>
                <th colspan="2" style="text-decoration: underline">Member Details</th>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td><b>Name</b></td>
                <td><b>SEIP Id</b></td>
            </tr>
            <tr>
                <td>Md. Roknuzzaman</td>
                <td>147969</td>
            </tr>
            <tr>
                <td>AM Monir Hossain</td>
                <td>165029</td>
            </tr>
            <tr>
                <td>Md. Abdullah-Al-Faisal</td>
                <td>166802</td>
            </tr>
            <tr>
                <td>Md. Aftab Uddin</td>
                <td>160561</td>
            </tr>
        </table>

    </fieldset>

</asp:Content>
