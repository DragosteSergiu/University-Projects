using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Seminar2
{
    public partial class Form1 : Form
    {
        SqlConnection dbConn;
        SqlDataAdapter daTeams, daCities;
        DataSet ds;
        BindingSource bsTeams, bsCities;
        private void Form1_Load(object sender, EventArgs e)
        {
            dbConn = new SqlConnection();
            dbConn.ConnectionString = "Data Source = DESKTOP-N2KIVA1\\SQLEXPRESS; Initial Catalog = EnglishTeamsDB; " +
    " Integrated Security = SSPI";
            ds = new DataSet();
            daTeams = new SqlDataAdapter("SELECT * FROM Teams", dbConn);
            daCities = new SqlDataAdapter("SELECT * FROM Cities", dbConn);
            daTeams.Fill(ds, "Teams");
            daCities.Fill(ds, "Cities");

            DataRelation dr = new DataRelation("FK_Teams_Cities", ds.Tables["Teams"].Columns["TeamID"],
                ds.Tables["Cities"].Columns["CityID"]);
            ds.Relations.Add(dr);

            bsTeams = new BindingSource();
            bsTeams.DataSource = ds;
            bsTeams.DataMember = "Teams";

            bsCities = new BindingSource();
            bsCities.DataSource = bsTeams;
            bsCities.DataMember = "FK_Teams_Cities";
        }

        public Form1()
        {

        }
    }

    public class Form
    {
    }
}
