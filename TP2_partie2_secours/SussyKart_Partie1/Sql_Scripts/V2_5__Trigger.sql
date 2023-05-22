Create trigger TRG_SoftDeleteUtilisateur
on Utilisateurs.Utilisateur
Instead of Delete
AS
Begin 
Delete from Utilisateur.Ami
where Ami_AjoutantID = ANY(select UtilisateurID from deleted) or
Ami_AjouteID= any(select UtilisateurID from deleted)

Delete from Utilisateurs.Avatar
where UtilisateurID= any(select utilisateurID from deleted)

update utilisateurs.Utilisateur
set EstSuppr =1
where UtilisateurID = any(select UtilisateurID from deleted)

end

go