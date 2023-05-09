using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SussyKart_Partie1.Models
{
    [Keyless]
    [Table("NoBancaire", Schema = "Utilisateurs")]
    public partial class NoBancaire
    {
        [Column("NoBancaire")]
        [StringLength(20)]
        [Unicode(false)]
        public string NoBancaire1 { get; set; } = null!;
    }
}
