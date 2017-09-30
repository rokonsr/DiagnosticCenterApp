using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using DiagnosticCenterApp.DAL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.Gateway
{
    public class PaymentGateway
    {
        ServerConnection server = new ServerConnection();
        public List<TestSetup> GetBillDetailsForGv(int billNumber)
        {
            List<TestSetup> testSetups = new List<TestSetup>();

            try
            {
                SqlCommand command = new SqlCommand("uspGetTestDetailsForBill", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("BillNumber", billNumber);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestSetup testSetup = new TestSetup();
                        testSetup.TestName = reader["TestName"].ToString();
                        testSetup.TestFee = Convert.ToInt32(reader["TestFee"]);

                        testSetups.Add(testSetup);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }

            return testSetups;
        }

        public Patient GetBillSummary(int billNumber)
        {
            Patient patient = new Patient();

            try
            {
                SqlCommand command = new SqlCommand("uspGetBillSummary", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("BillNumber", billNumber);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        patient.CreatedDate = (DateTime)reader["CreatedDate"];
                        patient.TotalAmount = (decimal) reader["TotalAmount"];
                        patient.PaidAmount = (decimal) reader["PaidAmount"];
                        //patient.DueAmount = (decimal) reader["DueAmount"];
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return patient;
        }

        public int GetPaymentAmount(double paidAmount, int billNumber)
        {
            int count = 0;

            SqlCommand command = new SqlCommand("uspGetPaidAmount", server.SqlConnection());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("PaidAmount", paidAmount);
            command.Parameters.AddWithValue("BillNumber", billNumber);

            return count = command.ExecuteNonQuery();
        }
    }
}