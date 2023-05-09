using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SussyKart_Partie1.Models
{
    [Keyless]
    public partial class VwMeilleursChronosParJoueur
    {
        public int Position { get; set; }
        public int Chrono { get; set; }
        public int NbJoueurs { get; set; }
        [Column(TypeName = "datetime")]
        public DateTime DateParticipation { get; set; }
        [StringLength(50)]
        [Unicode(false)]
        public string Nom { get; set; } = null!;
        [StringLength(30)]
        public string Pseudo { get; set; } = null!;
    }
}
