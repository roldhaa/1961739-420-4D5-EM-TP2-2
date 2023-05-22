create table Utilisateurs.Avatar(
AvatarID int IDENTITY
Identifiant uniqueidentifier NOT NULL rowGUIDCOL,
CONSTAINT PK_Avatar_AvatarID PRIMARY KEY(AvatarID),
UtilisateurID int not null
);
go


alter table Utilisateurs.Avatar add constraint UC_Avatar_Identifiant
unique (Identifiant);
go

Alter table Uitlisateurs.Avatar add constraint DF_Image_identifiant
default newid () For Identifant;
go

Alter table Uitlisateurs.Avatar add 
FichierAvatar varbinary (max) Filestream null;
go

Alter table Uitlisateurs.Avatar add constraint FK_Image_utilisateurID
foreign key(UtilisateurID) references Utilisateurs.Utilisateur(UtilisateurID);
go

