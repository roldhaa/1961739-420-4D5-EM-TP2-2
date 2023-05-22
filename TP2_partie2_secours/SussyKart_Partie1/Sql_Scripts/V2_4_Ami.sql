create table Utilisateurs.Ami(
AmiID int identity(1,1),
Ami_AjoutantID int not null,
Ami_AjouteID int Not null,
constraint PK_Ami primary key (AmiID),
constraint FK_Ami_AjoutantID foreign key (Ami_AjoutantID) references Utilisateurs.Utilisateur(UtilisateurID),
constraint FK_Ami_AjouteID foreign key (Ami_AjouteID) references Utilisateurs.Utilisateur(UtilisateurID),
constraint CHK_Ami check (Ami_AjoutantID <> Ami_AjouteID)
);
go

Alter Table Utilisateurs.Ami Add Constraint UQ_Amities unique (Ami_AjoutantID, Ami_AjouteID);
go


Drop Trigger Utilisateurs.TRd_Utilisateur_Utilisateur;
go


