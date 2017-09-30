using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using DiagnosticCenterApp.DAL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.Gateway
{
    public class TestRequestGateway
    {
        ServerConnection server = new ServerConnection();

        public List<TestSetup> GetTestSetupForDDL()
        {
            List<TestSetup> objTestNameList = new List<TestSetup>();

            DbDataReader objDbDataReader = null;
            TestSetup objTestSetup;

            try
            {
                SqlCommand command = new SqlCommand("uspGetTestSetupForGv", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;

                objDbDataReader = command.ExecuteReader();

                if (objDbDataReader.HasRows)
                {
                    while (objDbDataReader.Read())
                    {
                        objTestSetup = new TestSetup();
                        objTestSetup.TestSetupId = Convert.ToInt32(objDbDataReader["TestSetupId"]);
                        objTestSetup.TestName = objDbDataReader["TestName"].ToString();
                        objTestNameList.Add(objTestSetup);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return objTestNameList;
        }

        public TestSetup GetTestFee(string TestSetupId)
        {
            DbDataReader objDbDataReader = null;

            TestSetup objSetup = new TestSetup();
            double testFee = 0;

            try
            {
                SqlCommand command = new SqlCommand("uspGetTestFee", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("TestTypeId", TestSetupId);

                objDbDataReader = command.ExecuteReader();

                if (objDbDataReader.HasRows)
                {
                    while (objDbDataReader.Read())
                    {
                        TestSetup objTestSetup = new TestSetup();
                        objTestSetup.TestFee = Convert.ToDecimal(objDbDataReader["TestFee"]);

                        objSetup = objTestSetup;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return objSetup;
        }

        public int SaveTestRequest(Patient patient)
        {
            int count = 0;

            SqlCommand command = new SqlCommand("uspCreateTestRequest", server.SqlConnection());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("PatientName", patient.PatientName);
            command.Parameters.AddWithValue("DateOfBirth", patient.DateOfBirth);
            command.Parameters.AddWithValue("MobileNumber", patient.MobileNumber);
            command.Parameters.AddWithValue("TestId", patient.TestSetupId);
            command.Parameters.AddWithValue("TotalAmount", patient.TotalAmount);

            return count = command.ExecuteNonQuery();
        }

        public List<Patient> GetReportForUnpaidBill(DateTime fromDate, DateTime toDate)
        {
            List<Patient> patients = new List<Patient>();

            try
            {
                SqlCommand command = new SqlCommand("uspGetUnpaidBillwiseReport", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("FromDate", fromDate);
                command.Parameters.AddWithValue("ToDate", toDate);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Patient patient = new Patient();
                        patient.PatientId = Convert.ToInt32(reader["PatientId"]);
                        patient.PatientName = reader["PatientName"].ToString();
                        patient.MobileNumber = reader["MobileNumber"].ToString();
                        patient.TotalAmount = Convert.ToInt32(reader["TotalAmount"]);
                        patient.PaidAmount = Convert.ToInt32(reader["PaidAmount"]);

                        patients.Add(patient);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return patients;
        }

        public int GetLastBillNumber()
        {
            int billNumber = 0;

            string query = "SELECT TOP 1 PatientId FROM PatientInfo ORDER BY PatientId DESC";

            SqlCommand command = new SqlCommand(query, server.SqlConnection());

            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    billNumber = Convert.ToInt32(reader["PatientId"]);
                }
            }
            return billNumber;
        }
    }
}