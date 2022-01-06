using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ExamenASP.Models
{
    [Table("user")]
    public class Persons
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public int Group_id { get; set; }

    }
}
