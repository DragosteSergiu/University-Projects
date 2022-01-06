using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ExamenASP.Models
{
    [Table("channels")]
    public class Channels
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Column("owner_id")]
        public int OwnerId { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string Subscribers { get; set; }
    }
}
