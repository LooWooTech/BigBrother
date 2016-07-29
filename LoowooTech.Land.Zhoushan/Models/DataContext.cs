using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public class DataContext : DbContext
    {
        public DataContext() : base("name=DbConnectionString") { }

        public DbSet<User> Users { get; set; }

        public DbSet<Form> Forms { get; set; }

        public DbSet<Node> Nodes { get; set; }

        public DbSet<NodeValue> NodeValues { get; set; }

        public DbSet<Area> Areas { get; set; }

        public DbSet<NodeValueType> NodeValueTypes { get; set; }
        public DbSet<Dossier> Dossiers { get; set; }
        public DbSet<DossierFile> DossierFiles { get; set; }
    }
}
