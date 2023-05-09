
	-- Vue pour toutes les participations
	CREATE VIEW Courses.VW_DetailsParticipation
	AS
		SELECT U.UtilisateurID, U.Pseudo, C.CourseID, C.Nom, P.NbJoueurs, P.Position, P.Chrono, P.DateParticipation
		FROM Courses.ParticipationCourse P
		INNER JOIN Utilisateurs.Utilisateur U
		ON P.UtilisateurID = U.UtilisateurID
		INNER JOIN Courses.Course C
		ON P.CourseID = C.CourseID
	GO