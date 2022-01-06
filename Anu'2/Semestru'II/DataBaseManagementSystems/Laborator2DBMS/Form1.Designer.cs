namespace Laborator2DBMS
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.parentsDataGridView = new System.Windows.Forms.DataGridView();
            this.childrenDataGridView = new System.Windows.Forms.DataGridView();
            this.parentLabel = new System.Windows.Forms.Label();
            this.childLabel = new System.Windows.Forms.Label();
            this.connectButton = new System.Windows.Forms.Button();
            this.addButton = new System.Windows.Forms.Button();
            this.updateButton = new System.Windows.Forms.Button();
            this.deleteButton = new System.Windows.Forms.Button();
            this.showPanelButton = new System.Windows.Forms.Button();
            this.fieldsPanel = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.parentsDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.childrenDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // parentsDataGridView
            // 
            this.parentsDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.parentsDataGridView.Location = new System.Drawing.Point(51, 46);
            this.parentsDataGridView.Name = "parentsDataGridView";
            this.parentsDataGridView.RowHeadersWidth = 51;
            this.parentsDataGridView.RowTemplate.Height = 24;
            this.parentsDataGridView.Size = new System.Drawing.Size(487, 293);
            this.parentsDataGridView.TabIndex = 0;
            this.parentsDataGridView.SelectionChanged += new System.EventHandler(this.parentsDataGridView_SelectionChanged);
            // 
            // childrenDataGridView
            // 
            this.childrenDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.childrenDataGridView.Location = new System.Drawing.Point(891, 46);
            this.childrenDataGridView.Name = "childrenDataGridView";
            this.childrenDataGridView.RowHeadersWidth = 51;
            this.childrenDataGridView.RowTemplate.Height = 24;
            this.childrenDataGridView.Size = new System.Drawing.Size(450, 293);
            this.childrenDataGridView.TabIndex = 1;
            this.childrenDataGridView.SelectionChanged += new System.EventHandler(this.childrenDataGridView_SelectionChanged);
            // 
            // parentLabel
            // 
            this.parentLabel.AutoSize = true;
            this.parentLabel.Location = new System.Drawing.Point(250, 13);
            this.parentLabel.Name = "parentLabel";
            this.parentLabel.Size = new System.Drawing.Size(50, 17);
            this.parentLabel.TabIndex = 2;
            this.parentLabel.Text = "Parent";
            // 
            // childLabel
            // 
            this.childLabel.AutoSize = true;
            this.childLabel.Location = new System.Drawing.Point(1097, 13);
            this.childLabel.Name = "childLabel";
            this.childLabel.Size = new System.Drawing.Size(39, 17);
            this.childLabel.TabIndex = 3;
            this.childLabel.Text = "Child";
            // 
            // connectButton
            // 
            this.connectButton.Location = new System.Drawing.Point(736, 416);
            this.connectButton.Name = "connectButton";
            this.connectButton.Size = new System.Drawing.Size(135, 44);
            this.connectButton.TabIndex = 4;
            this.connectButton.Text = "Connect";
            this.connectButton.UseVisualStyleBackColor = true;
            this.connectButton.Click += new System.EventHandler(this.connectButton_Click);
            // 
            // addButton
            // 
            this.addButton.Location = new System.Drawing.Point(550, 355);
            this.addButton.Name = "addButton";
            this.addButton.Size = new System.Drawing.Size(92, 38);
            this.addButton.TabIndex = 5;
            this.addButton.Text = "Add";
            this.addButton.UseVisualStyleBackColor = true;
            this.addButton.Click += new System.EventHandler(this.addButton_Click);
            // 
            // updateButton
            // 
            this.updateButton.Location = new System.Drawing.Point(669, 355);
            this.updateButton.Name = "updateButton";
            this.updateButton.Size = new System.Drawing.Size(92, 38);
            this.updateButton.TabIndex = 6;
            this.updateButton.Text = "Update";
            this.updateButton.UseVisualStyleBackColor = true;
            this.updateButton.Click += new System.EventHandler(this.updateButton_Click);
            // 
            // deleteButton
            // 
            this.deleteButton.Location = new System.Drawing.Point(780, 355);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(91, 38);
            this.deleteButton.TabIndex = 7;
            this.deleteButton.Text = "Delete";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.deleteButton_Click);
            // 
            // showPanelButton
            // 
            this.showPanelButton.Location = new System.Drawing.Point(550, 416);
            this.showPanelButton.Name = "showPanelButton";
            this.showPanelButton.Size = new System.Drawing.Size(135, 44);
            this.showPanelButton.TabIndex = 8;
            this.showPanelButton.Text = "Show Panel";
            this.showPanelButton.UseVisualStyleBackColor = true;
            this.showPanelButton.Click += new System.EventHandler(this.showPanelButton_Click);
            // 
            // fieldsPanel
            // 
            this.fieldsPanel.Location = new System.Drawing.Point(591, 46);
            this.fieldsPanel.Name = "fieldsPanel";
            this.fieldsPanel.Size = new System.Drawing.Size(248, 293);
            this.fieldsPanel.TabIndex = 9;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1404, 489);
            this.Controls.Add(this.fieldsPanel);
            this.Controls.Add(this.showPanelButton);
            this.Controls.Add(this.deleteButton);
            this.Controls.Add(this.updateButton);
            this.Controls.Add(this.addButton);
            this.Controls.Add(this.connectButton);
            this.Controls.Add(this.childLabel);
            this.Controls.Add(this.parentLabel);
            this.Controls.Add(this.childrenDataGridView);
            this.Controls.Add(this.parentsDataGridView);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.parentsDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.childrenDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView parentsDataGridView;
        private System.Windows.Forms.DataGridView childrenDataGridView;
        private System.Windows.Forms.Label parentLabel;
        private System.Windows.Forms.Label childLabel;
        private System.Windows.Forms.Button connectButton;
        private System.Windows.Forms.Button addButton;
        private System.Windows.Forms.Button updateButton;
        private System.Windows.Forms.Button deleteButton;
        private System.Windows.Forms.Button showPanelButton;
        private System.Windows.Forms.Panel fieldsPanel;
    }
}

