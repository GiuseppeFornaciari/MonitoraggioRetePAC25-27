SELECT PasswordHash,* FROM AspNetUsers WHERE Email like '%cicca%'
SELECT * FROM AspNetUserRoles WHERE UserId='c3612854-18cb-4cee-90fd-51d29e4e8349'
SELECT * FROM AspNetRoles

SELECT NUR.*,R.Name
FROM AspNetUsers NU
INNER JOIN AspNetUserRoles NUR ON NU.Id=NUR.UserId
INNER JOIN AspNetRoles R ON NUR.RoleId=R.Id
WHERE Email like '%ferrari%'

UPDATE AspNetUserRoles SET RoleId=2
FROM AspNetUsers NU
INNER JOIN AspNetUserRoles NUR ON NU.Id=NUR.UserId
INNER JOIN AspNetRoles R ON NUR.RoleId=R.Id
WHERE Email like '%ferrari%'


---UPDATE  AspNetUsers SET EmailConfirmed=1  WHERE Email like '%cicca%'


---- 1 REFERENTI MINISTERO
--INSERT INTO [MonitoraggioPAC25-27-27].[dbo].[UtentiRuoli] (IdUtente, IdAspNetRoles)
--SELECT U.idUtente
--,(SELECT id FROM  AspNetRoles WHERE Name='referente ministero')
--FROM [MonitoraggioPAC25-27-27].[dbo].[Utenti] U
--INNER JOIN [MonitoraggioRRN].[dbo].[ReferentiMIPAAF] UOLD ON U.EMail=UOLD.Email

---- 2 RESPONSABILI
--INSERT INTO [MonitoraggioPAC25-27-27].[dbo].[UtentiRuoli] (IdUtente, IdAspNetRoles)
--SELECT U.idUtente
--,(SELECT id FROM  AspNetRoles WHERE Name='responsabile scheda')
--FROM [MonitoraggioPAC25-27-27].[dbo].[Utenti] U
--INNER JOIN [MonitoraggioRRN].[dbo].[ResponsabiliScheda] UOLD ON U.EMail=UOLD.Email

--- SEGRETARIATO








---- cancello UTENTE laura.panicoRM@masaf.gov.it- 00cf32d1-76c9-402b-8255-1e8322f8c8f1
SELECT * FROM [TEST_RRN25-27].[dbo].[Utenti] WHERE Email like '%panico%'
SELECT * FROM [TEST_RRN25-27].[dbo].[UtentiRuoli]
--DELETE UtentiRuoli WHERE IdUtente=40
--DELETE Utenti WHERE idAspNetUser='00cf32d1-76c9-402b-8255-1e8322f8c8f1'
--DELETE AspNetUsers WHERE id='00cf32d1-76c9-402b-8255-1e8322f8c8f1'

----Assegno RUOLO SEGRETARIATO 1
----segretariato@MASAF.gov.it
----segretariato@CREA.it
----segretariato@ISMEA.it
SELECT *
  FROM [TEST_RRN25-27].[dbo].[AspNetUsers]
  WHERE userName like '%segretariato%'






--INSERT INTO AspNetUserRoles(RoleId,UserId) VALUES (1,'3764f462-8dff-4164-95c6-9e608738b5c3')
--INSERT INTO AspNetUserRoles(RoleId,UserId) VALUES (1,'c7cf0262-2f0a-404a-8514-39eb5a907086')
--INSERT INTO AspNetUserRoles(RoleId,UserId) VALUES (1,'e9072a57-ec4e-429b-966b-7a044fac6aa4')

--INSERT INTO Utenti(Utente,Email,idAspNetUser) VALUES ('Segretariato MASAF','segretariato@MASAF.gov.it','e9072a57-ec4e-429b-966b-7a044fac6aa4')
--INSERT INTO Utenti(Utente,Email,idAspNetUser) VALUES ('Segretariato ISMEA','segretariato@ISMEA.it','c7cf0262-2f0a-404a-8514-39eb5a907086')
--INSERT INTO Utenti(Utente,Email,idAspNetUser) VALUES ('Segretariato CREA','segretariato@CREA.it','3764f462-8dff-4164-95c6-9e608738b5c3')


SELECT R.Name,U.id,U.UserName,U.Email,NUR.RoleId
FROM AspNetUsers NU
LEFT JOIN AspNetUserRoles NUR ON NU.Id=NUR.UserId
LEFT JOIN AspNetRoles R ON NUR.RoleId=R.Id
LEFT JOIN AspNetUsers U ON NU.Id=U.Id
WHERE U.Email like '%macri%'
OR U.Email like '%panico%'
OR U.Email like '%ciccarelli%'
OR U.Email like '%segretariato@CREA.it%'
OR U.Email like '%segretariato@MASAF.gov.it%'
OR U.Email like '%segretariato@ISMEA.it%'



--- PER SIMULAZIONE 
---ruolo segretariato
--- segretariato@MASAF.gov.it
--- segretariato@CREA.it
--- segretariato@ISMEA.it

---ruolo ministero
SELECT R.Name,U.id,U.UserName,U.Email,NUR.RoleId
FROM AspNetUsers NU
LEFT JOIN AspNetUserRoles NUR ON NU.Id=NUR.UserId
LEFT JOIN AspNetRoles R ON NUR.RoleId=R.Id
LEFT JOIN AspNetUsers U ON NU.Id=U.Id
WHERE U.Email IN ('c.macri@politicheagricole.it','laura.panico@masaf.gov.it')



--UPDATE aspNetUserRoles SET RoleId=4 WHERE UserId='1c2de1fb-f0bc-495f-b78f-c6673e2b8244'
--UPDATE aspNetUserRoles SET RoleId=4 WHERE UserId='442184e1-5f04-487b-bfae-fc32dbb362e2'



----- 20251125 Aggiunta utenti
---a.ripepi@ismea.it
---DELETE FROM AspNetUsers WHERE username like '%ripepi%'
SELECT * FROM AspNetUsers WHERE username like '%ripepi%'
UPDATE AspNetUsers Set EmailConfirmed=1 WHERE username like '%ripepi%'

