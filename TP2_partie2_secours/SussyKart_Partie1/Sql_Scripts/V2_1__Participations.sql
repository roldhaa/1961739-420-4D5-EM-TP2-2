
	CREATE PROCEDURE Courses.USP_CreerParticipation
		@Position tinyint,
		@Chrono int,
		@NbJoueurs tinyint,
		@NomCourse varchar(50),
		@UtilisateurID int
	AS
	BEGIN
		INSERT INTO Courses.ParticipationCourse (Position, Chrono, NbJoueurs, DateParticipation, CourseID, UtilisateurID)
		VALUES
		(@Position, @Chrono, @NbJoueurs, GETDATE(), 
		(SELECT CourseID FROM Courses.Course WHERE Nom = @NomCourse),
		@UtilisateurID
		);
	END
	GO