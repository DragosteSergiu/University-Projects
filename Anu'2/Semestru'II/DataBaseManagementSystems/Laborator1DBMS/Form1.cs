using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Laborator1DBMS
{
    public partial class Form1 : Form
    {
        SqlConnection dbConn;
        SqlDataAdapter daParent, daTeams;
        DataSet ds;
        BindingSource bsCities, bsTeams;
        SqlCommandBuilder cbTeams;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            daTeams.Update(ds, "Teams");
        }

        private void citiesBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.citiesBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.laborator1DataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dbConn = new SqlConnection();
            dbConn.ConnectionString = "Data Source = DESKTOP-N2KIVA1\\SQLEXPRESS; Initial Catalog = Laborator1; " +
    " Integrated Security = SSPI";
            ds = new DataSet();
            daTeams = new SqlDataAdapter("SELECT * FROM Teams", dbConn);
            daParent = new SqlDataAdapter("SELECT * FROM Cities", dbConn);
            cbTeams = new SqlCommandBuilder(daTeams);
            daTeams.Fill(ds, "Teams");
            daParent.Fill(ds, "Cities");

            DataRelation dr = new DataRelation("FK_Cities_Teams", ds.Tables["Cities"].Columns["ID"],
                ds.Tables["Teams"].Columns["CityID"]);
            ds.Relations.Add(dr);

            bsCities = new BindingSource();
            bsCities.DataSource = ds;
            bsCities.DataMember = "Cities";

            bsTeams = new BindingSource();
            bsTeams.DataSource = bsCities;
            bsTeams.DataMember = "FK_Cities_Teams";

            citiesDataGridView.DataSource = bsCities;
            teamsDataGridView.DataSource = bsTeams;
        }
    }
}
