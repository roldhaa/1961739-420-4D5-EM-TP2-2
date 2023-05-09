using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SussyKart_Partie1.Data;
using SussyKart_Partie1.Models;
using SussyKart_Partie1.ViewModels;

namespace SussyKart_Partie1.Controllers
{
    public class StatsController : Controller
    {
       
        private readonly TP2_SussyKartContext _context;
        
        public StatsController(TP2_SussyKartContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }
        
        // Section 1 : Compléter ToutesParticipations (Obligatoire)
        public async Task<IActionResult> ToutesParticipations()
        {
            // Obtenir les participations grâce à une vue SQL
            List<VwDetailsParticipation> participations = await _context.VwDetailsParticipation.Take(30).ToListAsync();

            return View(new FiltreParticipationVM() { Participations = participations });
        }

        public async Task<IActionResult> ToutesParticipationsFiltre(FiltreParticipationVM fpvm)
        {
            // Obtenir les participations grâce à une vue SQL
            List<VwDetailsParticipation> participations = await _context.VwDetailsParticipation.ToListAsync();

            if (fpvm.Pseudo != null)
            {
                participations = participations.Where(x => x.Pseudo == fpvm.Pseudo).ToList();
            }

            if(fpvm.Course != "Toutes")
            {
                participations = participations.Where(x => x.Nom == fpvm.Course).ToList();
            }

            // Trier soit par date, soit par chrono (fpvm.Ordre) de manière croissante ou décroissante (fpvm.TypeOrdre)
            if(fpvm.TypeOrdre == "DESC")
            {
                if(fpvm.Ordre == "Date")
                {
                    participations = participations.OrderByDescending(x => x.DateParticipation).ToList();
                }
                else
                {
                    participations = participations.OrderByDescending(x => x.Chrono).ToList();
                }
            }
            else
            {
                if (fpvm.Ordre == "Date")
                {
                    participations = participations.OrderBy(x => x.DateParticipation).ToList();
                }
                else
                {
                    participations = participations.OrderBy(x => x.Chrono).ToList();
                }
            }

            // Sauter des paquets de 30 participations si la page est supérieure à 1
            participations = participations.Skip((fpvm.Page - 1) * 30).Take(30).ToList();

            fpvm.Participations = participations;

            return View("ToutesParticipations", fpvm);
        }
    }
}
