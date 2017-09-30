using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using DiagnosticCenterApp.DAL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.Gateway
{
    public class TestSetupGateway
    {
        ServerConnection server = new ServerConnection();

        public List<TestType> GetTestTypeForDDL()
        {
            List<TestType> objTestTypeList = new List<TestType>();

            try
            {
                SqlCommand command = new SqlCommand("uspGetTestTypeList", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestType testType = new TestType();
                        testType.TestTypeId = Convert.ToInt32(reader["TestTypeId"]);
                        testType.TestTypeName = reader["TestTypeName"].ToString();
                        objTestTypeList.Add(testType);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return objTestTypeList;
        }

        public int CreateTest(TestSetup testSetup)
        {
            int count = 0;

            SqlCommand command = new SqlCommand("uspCreateTest", server.SqlConnection());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("TestName", testSetup.TestName);
            command.Parameters.AddWithValue("TestFee", testSetup.TestFee);
            command.Parameters.AddWithValue("TestType", testSetup.TestTypeId);

            return count = command.ExecuteNonQuery();
        }

        public bool IsExistTestSetup(TestSetup testSetup)
        {
            string query = "SELECT * FROM TestSetup WHERE TestName = '" + testSetup.TestName + "' AND TestTypeId = '" + testSetup.TestTypeId + "'";

            try
            {
                SqlCommand command = new SqlCommand(query, server.SqlConnection());

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
            return false;
        }

        public List<TestSetup> GetTestSetupForGv()
        {
            List<TestSetup> testSetups = new List<TestSetup>();
            
            try
            {
                SqlCommand command = new SqlCommand("uspGetTestSetupForGv", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestSetup testSetup = new TestSetup();
                        testSetup.TestTypeName = reader["TestTypeName"].ToString();
                        testSetup.TestName = reader["TestName"].ToString();
                        testSetup.TestSetupId = Convert.ToInt32(reader["TestSetupId"]);
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

        public List<TestSetup> GetTestwiseReport(DateTime fromDate, DateTime toDate)
        {
            List<TestSetup> testSetups = new List<TestSetup>();

            try
            {
                SqlCommand command = new SqlCommand("uspGetTestwiseReport", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("FromDate", fromDate);
                command.Parameters.AddWithValue("ToDate", toDate);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestSetup testSetup = new TestSetup();
                        testSetup.TestName = reader["TestName"].ToString();
                        testSetup.TotalTest = Convert.ToInt32(reader["TotalTest"]);
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
    }
}