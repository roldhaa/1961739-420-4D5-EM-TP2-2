
	ALTER TABLE Utilisateurs.Utilisateur
	ADD MotDePasseHache varbinary(32) NULL,
	MdpSel varbinary(16) NULL;
	GO
	
	-- Procédure pour créer un utilisateur
	ALTER PROCEDURE Utilisateurs.USP_CreerUtilisateur
		@Pseudo nvarchar(30),
		@Courriel nvarchar(320),
		@MotDePasse nvarchar(50)
	AS
	BEGIN
		-- Sels aléatoires
		DECLARE @MdpSel varbinary(16) = CRYPT_GEN_RANDOM(16);
		
		-- Concaténation de données et sel
		DECLARE @MdpEtSel nvarchar(116) = CONCAT(@MotDePasse, @MdpSel);
		
		-- Hachage du mot de passe
		DECLARE @MdpHachage varbinary(32) = HASHBYTES('SHA2_256', @MdpEtSel);
		
		-- Insertion
		INSERT INTO Utilisateurs.Utilisateur (Pseudo, MotDePasseHache, MdpSel, Courriel, DateInscription)
		VALUES
		(@Pseudo, @MdpHachage, @MdpSel, @Courriel, GETDATE());
		
	END
	GO
	
	-- Procédure d'authentification
	CREATE PROCEDURE Utilisateurs.USP_AuthUtilisateur
		@Pseudo nvarchar(50),
		@MotDePasse nvarchar(100)
	AS
	BEGIN
		DECLARE @Sel varbinary(16);
		DECLARE @MdpHache varbinary(32);
		SELECT @Sel = MdpSel, @MdpHache = MotDePasseHache 
		FROM Utilisateurs.Utilisateur
		WHERE Pseudo = @Pseudo; -- Si les pseudos sont uniques !
		
		IF HASHBYTES('SHA2_256', CONCAT(@MotDePasse, @Sel)) = @MdpHache
		BEGIN
			-- On retourne l'utilisateur si le mot de passe est valide
			SELECT * FROM Utilisateurs.Utilisateur WHERE Pseudo = @Pseudo;
		END
		ELSE
		BEGIN
			SELECT TOP 0 * FROM Utilisateurs.Utilisateur; -- On retourne rien si mot de passe invalide
		END
	END
	GO

	-- Remplir les mots de passe et les numéros de compte bancaire des utilisateurs déjà présents :
	UPDATE Utilisateurs.Utilisateur
	SET MdpSel = CRYPT_GEN_RANDOM(16);
	GO
	
	UPDATE Utilisateurs.Utilisateur
	SET MotDePasseHache = HASHBYTES('SHA2_256', CONCAT(N'patate', MdpSel));
	GO