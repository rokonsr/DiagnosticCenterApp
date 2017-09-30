using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using DiagnosticCenterApp.DAL;
using DiagnosticCenterApp.Model;

namespace DiagnosticCenterApp.Gateway
{
    public class TestTypeGateway
    {
        ServerConnection server = new ServerConnection();

        public int CreateTestType(TestType testType)
        {
            int count = 0;

            SqlCommand command = new SqlCommand("uspCreateTestType", server.SqlConnection());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("TestType", testType.TestTypeName);

            return count = command.ExecuteNonQuery();
        }

        public bool IsExistTestType(TestType testType)
        {
            string query = "SELECT * FROM TestType WHERE TestTypeName = '" + testType.TestTypeName + "'";

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

        public List<TestType> GetTestType()
        {
            List<TestType> testTypes = new List<TestType>();
            
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
                        testTypes.Add(testType);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }

            return testTypes;
        }

        public List<TestType> GetTypewiseReport(DateTime fromDate, DateTime toDate)
        {
            List<TestType> testTypes = new List<TestType>();

            try
            {
                SqlCommand command = new SqlCommand("uspGettypewiseReport", server.SqlConnection());
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("FromDate", fromDate);
                command.Parameters.AddWithValue("ToDate", toDate);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestType testyType = new TestType();
                        testyType.TestTypeName = reader["TestTypeName"].ToString();
                        testyType.TotalTest = Convert.ToInt32(reader["TotalTest"]);
                        testyType.TestFee = Convert.ToInt32(reader["TestFee"]);

                        testTypes.Add(testyType);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }

            return testTypes;
        }
    }
}