using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Laborator2DBMS
{
    public partial class Form1 : Form
    {
        public const int CHOICE = 1;
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["connection" + CHOICE.ToString()].ConnectionString);
        SqlDataAdapter parentsDataAdapter = new SqlDataAdapter();
        DataSet parentsDataSet = new DataSet();
        SqlDataAdapter childrenDataAdapter = new SqlDataAdapter();
        DataSet childrenDataSet = new DataSet();


        public Form1()
        {
            ChooseScenario(CHOICE);
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void ChooseScenario(int scenario)
        {
            if (scenario == 1)
            {
                ConfigurationSettings.AppSettings["parentTable"] = "Cities";
                ConfigurationSettings.AppSettings["parentPrimaryKey"] = "CityID";
                ConfigurationSettings.AppSettings["childTable"] = "Teams";
                ConfigurationSettings.AppSettings["childNumberOfColumns"] = "5";
                ConfigurationSettings.AppSettings["childColumnNames"] = "TeamID,TeamName,CityID,Founded,Nickname";
            }
            else
            {
                if (scenario == 2)
                {
                    ConfigurationSettings.AppSettings["parentTable"] = "Producer";
                    ConfigurationSettings.AppSettings["parentPrimaryKey"] = "ProducerID";
                    ConfigurationSettings.AppSettings["childTable"] = "Model";
                    ConfigurationSettings.AppSettings["childNumberOfColumns"] = "3";
                    ConfigurationSettings.AppSettings["childColumnNames"] = "ModelID,Name,ProducerID";
                }
            }
        }

        private void connectButton_Click(object sender, EventArgs e)
        {
            string parentTableName = ConfigurationSettings.AppSettings["parentTable"];
            string cmd = "Select * from " + parentTableName;
            parentsDataAdapter.SelectCommand = new SqlCommand(cmd, connection);
            parentsDataSet.Clear();
            parentsDataAdapter.Fill(parentsDataSet);
            parentsDataGridView.DataSource = parentsDataSet.Tables[0];
        }

        private void parentsDataGridView_SelectionChanged(object sender, EventArgs e)
        {

            DataGridViewRow dataGridViewRow = parentsDataGridView.CurrentRow;
            int key = Int32.Parse(dataGridViewRow.Cells[0].Value.ToString());

            string childTableName = ConfigurationSettings.AppSettings["childTable"];
            string selectAllFromChildrenCmd = "Select * from " + childTableName;
            string parentPrimaryKeyName = ConfigurationSettings.AppSettings["parentPrimaryKey"];
            childrenDataAdapter.SelectCommand = new SqlCommand(selectAllFromChildrenCmd + " WHERE " + "[" + parentPrimaryKeyName + "]=@" + parentPrimaryKeyName, connection);

            childrenDataAdapter.SelectCommand.Parameters.AddWithValue("@" + parentPrimaryKeyName, key);
            childrenDataSet.Clear();
            childrenDataAdapter.Fill(childrenDataSet);
            childrenDataGridView.DataSource = childrenDataSet.Tables[0];
            
        }

        private void childrenDataGridView_SelectionChanged(object sender, EventArgs e)
        {
            int numberOfSelectedRows = childrenDataGridView.SelectedRows.Count;
            if (numberOfSelectedRows > 0)
            {
                DataGridViewRow dataGridViewRow = childrenDataGridView.CurrentRow;
                List<string> childColumnNamesList = new List<string>(ConfigurationSettings.AppSettings["childColumnNames"].Split(','));
                int i = 0;
                foreach (string column in childColumnNamesList)
                {
                    TextBox textBox = (TextBox)fieldsPanel.Controls[column];
                    textBox.Text = dataGridViewRow.Cells[i].Value.ToString();
                    i++;
                }
            }
        }

        private void showPanelButton_Click(object sender, EventArgs e)
        {
            
            List<string> childColumnNamesList = new List<string>(ConfigurationSettings.AppSettings["childColumnNames"].Split(','));
            int x = 50;
            int y = 30;
            fieldsPanel.Controls.Clear();
            foreach (string column in childColumnNamesList)
            {
                TextBox textBox = new TextBox();
                textBox.Text = column;
                textBox.Name = column;
                textBox.Location = new Point(x, y);
                textBox.Visible = true;
                textBox.Parent = fieldsPanel;
                fieldsPanel.Show();
                y += 35;
            }
            
        }

        private void addButton_Click(object sender, EventArgs e)
        {
            try
            {
                string childTableName = ConfigurationSettings.AppSettings["childTable"];
                List<string> childColumnNamesList = new List<string>(ConfigurationSettings.AppSettings["childColumnNames"].Split(','));
                string insertChildCommand = "INSERT INTO " + childTableName + " VALUES (";
                for (int j = 1; j < childColumnNamesList.Count - 1; j++)
                {
                    insertChildCommand += "@" + childColumnNamesList[j] + ",";
                }
                insertChildCommand += "@" + childColumnNamesList[childColumnNamesList.Count - 1] + ")";

                childrenDataAdapter.InsertCommand = new SqlCommand(insertChildCommand, connection);
                for (int i = 1; i < childColumnNamesList.Count; i++)
                {
                    TextBox textBox = (TextBox)fieldsPanel.Controls[childColumnNamesList[i]];
                    childrenDataAdapter.InsertCommand.Parameters.AddWithValue("@" + childColumnNamesList[i], textBox.Text);
                }
                connection.Open();
                
                childrenDataAdapter.InsertCommand.ExecuteNonQuery();
                MessageBox.Show("The insert operation succeeded");
                connection.Close();
                childrenDataSet.Clear();
                childrenDataAdapter.Fill(childrenDataSet);
                childrenDataGridView.DataSource = childrenDataSet.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                connection.Close();
            }
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            try
            {
                string childTableName = ConfigurationSettings.AppSettings["childTable"];
                List<string> childColumnNamesList = new List<string>(ConfigurationSettings.AppSettings["childColumnNames"].Split(','));
                string updateChildCommand = "UPDATE " + childTableName + " SET ";
                for (int i = 1; i < childColumnNamesList.Count - 1; i++)
                {
                    updateChildCommand += childColumnNamesList[i] + "=@" + childColumnNamesList[i] + ",";
                }
                updateChildCommand += childColumnNamesList[childColumnNamesList.Count - 1] + "=@" + childColumnNamesList[childColumnNamesList.Count - 1] + " ";
                updateChildCommand += "WHERE [" + childColumnNamesList[0] + "]=@" + childColumnNamesList[0];

                childrenDataAdapter.UpdateCommand = new SqlCommand(updateChildCommand, connection);
                for (int i = 1; i < childColumnNamesList.Count; i++)
                {
                    TextBox textBox = (TextBox)fieldsPanel.Controls[childColumnNamesList[i]];
                    childrenDataAdapter.UpdateCommand.Parameters.AddWithValue("@" + childColumnNamesList[i], textBox.Text);
                }

                TextBox textBox1 = (TextBox)fieldsPanel.Controls[childColumnNamesList[0]];
                childrenDataAdapter.UpdateCommand.Parameters.AddWithValue("@" + childColumnNamesList[0], textBox1.Text);
                connection.Open();
            
                childrenDataAdapter.UpdateCommand.ExecuteNonQuery();
                MessageBox.Show("The update operation succeeded");
                connection.Close();
                childrenDataSet.Clear();
                childrenDataAdapter.Fill(childrenDataSet);
                childrenDataGridView.DataSource = childrenDataSet.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                connection.Close();
            }
        }

        private void deleteButton_Click(object sender, EventArgs e)
        {
            try
            {
                string childTableName = ConfigurationSettings.AppSettings["childTable"];
                List<string> childColumnNamesList = new List<string>(ConfigurationSettings.AppSettings["childColumnNames"].Split(','));

                string deleteChildCommand = "DELETE FROM " + childTableName + " WHERE [" + childColumnNamesList[0] + "]=@" + childColumnNamesList[0];

                childrenDataAdapter.DeleteCommand = new SqlCommand(deleteChildCommand, connection);
                TextBox textBox = (TextBox)fieldsPanel.Controls[childColumnNamesList[0]];
                childrenDataAdapter.DeleteCommand.Parameters.AddWithValue("@" + childColumnNamesList[0], textBox.Text);

                connection.Open();
                childrenDataAdapter.DeleteCommand.ExecuteNonQuery();
                MessageBox.Show("The delete operation succeeded");
                connection.Close();
                childrenDataSet.Clear();
                childrenDataAdapter.Fill(childrenDataSet);
                childrenDataGridView.DataSource = childrenDataSet.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                connection.Close();
            }
        }

    }
}
