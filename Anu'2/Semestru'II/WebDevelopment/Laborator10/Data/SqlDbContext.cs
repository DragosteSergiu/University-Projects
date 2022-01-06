using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MySql.Data.EntityFrameworkCore;
using Laborator10.Models;

namespace Laborator10.Data
{
    public class SqlDbContext : DbContext
    {
   
        public SqlDbContext(DbContextOptions options) : base(options) { }
        public DbSet<User> Users { get; set; }
    }
}
