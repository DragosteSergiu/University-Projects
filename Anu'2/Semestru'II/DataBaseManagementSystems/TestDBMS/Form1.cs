using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TestDBMS
{
    public partial class Form1 : Form
    {
        SqlConnection dbConn;
        SqlDataAdapter daCategoties, daMovies;
        DataSet ds;
        BindingSource bsCategories, bsMovies;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            daMovies.Update(ds, "Movie"); //sends the changes back to the database
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            dbConn = new SqlConnection();
            dbConn.ConnectionString = "Data Source = DESKTOP-N2KIVA1\\SQLEXPRESS; Initial Catalog = TestDBMS1; " +
    " Integrated Security = SSPI"; // connects to the database;
            ds = new DataSet();
            daMovies = new SqlDataAdapter("SELECT * FROM Movie", dbConn);
            daCategoties = new SqlDataAdapter("SELECT * FROM MovieCategory", dbConn);
            daMovies.Fill(ds, "Movie");
            daCategoties.Fill(ds, "Category");

            DataRelation dr = new DataRelation("FK_Movie_category", ds.Tables["MovieCategory"].Columns["id"],
                ds.Tables["Movie"].Columns["category_id"]);
            ds.Relations.Add(dr);

            bsCategories = new BindingSource(); //fetches data into the application;
            bsCategories.DataSource = ds;
            bsCategories.DataMember = "MovieCategory";

            bsMovies = new BindingSource();
            bsMovies.DataSource = bsCategories;
            bsMovies.DataMember = "FK_Movie_category";

            dgvCategories.DataSource = bsCategories; //binds the DataGridView
            dgvMovies.DataSource = bsMovies;
        }
    }
}
