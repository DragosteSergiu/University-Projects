using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ExamenASP.Models;

namespace ExamenASP.Data
{
    public class PersonsContext : DbContext
    {
        public DbSet<Persons> Persons { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Persons>()
                .HasKey(e => e.Id);
            modelBuilder.Entity<Persons>()
                .Property(f => f.Id)
                .ValueGeneratedOnAdd();
        }

        public PersonsContext(DbContextOptions<PersonsContext> options) : base(options)
        {

        }
    }

    public class ChannelsContext : DbContext
    {
        public DbSet<Channels> Channels { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Channels>()
                .HasKey(e => e.Id);
            modelBuilder.Entity<Channels>()
                .Property(f => f.Id)
                .ValueGeneratedOnAdd();
        }

        public ChannelsContext(DbContextOptions<ChannelsContext> options) : base(options)
        {

        }
    }

}
