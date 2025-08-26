using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;

namespace MetroCityDemo
{
    public partial class Cities : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public class CityInfo
        {
            public string City { get; set; }
            public bool IsMetro { get; set; }
        }

        [WebMethod]
        public static List<CityInfo> GetCities()
        {
            var cities = new List<CityInfo>();
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT city, ismetro FROM CityMetro", conn))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        cities.Add(new CityInfo
                        {
                            City = reader.GetString(0),
                            IsMetro = reader.GetBoolean(1)
                        });
                    }
                }
            }
            return cities;
        }

        [WebMethod]
        public static bool UpdateMetroStatus(string city, bool isMetro)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string query = @"
                    IF EXISTS (SELECT 1 FROM CityMetro WHERE city = @city)
                        UPDATE CityMetro SET ismetro = @ismetro WHERE city = @city
                    ELSE
                        INSERT INTO CityMetro(city, ismetro) VALUES(@city, @ismetro)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@city", System.Data.SqlDbType.VarChar, 100).Value = city;
                    cmd.Parameters.Add("@ismetro", System.Data.SqlDbType.Bit).Value = isMetro;
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }
    }
}
