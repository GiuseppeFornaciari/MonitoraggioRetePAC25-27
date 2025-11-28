-------------------------
--- 1 Copia di backup
-------------------------
--SELECT *
--INTO UtentiBK20251031
--FROM [MonitoraggioPAC25-27-27].[dbo].[Utenti]
--SELECT *
--INTO UtentiProgettoEnteBK20251031
--FROM [MonitoraggioPAC25-27-27].[dbo].[UtentiProgettoEnte]
--SELECT *
--INTO UtentiProgettoMinisteroBK20251031
--FROM [MonitoraggioPAC25-27-27].[dbo].[UtentiProgettoMinistero]
--SELECT *
--INTO UtentiRuoliBK20251031
--FROM [MonitoraggioPAC25-27-27].[dbo].[UtentiRuoli]
--SELECT *
--INTO UtentiSchedaEnteBK20251031
--FROM [MonitoraggioPAC25-27-27].[dbo].[UtentiSchedaEnte]

-------------------------
--- 2 Cancellazione tabelle e reseed indici
-------------------------
--DELETE FROM [MonitoraggioPAC25-27].[dbo].[UtentiSchedaEnte]
--DELETE FROM [MonitoraggioPAC25-27].[dbo].[UtentiRuoli]
--DELETE FROM [MonitoraggioPAC25-27].[dbo].UtentiProgettoMinistero
--DELETE FROM [MonitoraggioPAC25-27].[dbo].UtentiProgettoEnte
--DELETE FROM [MonitoraggioPAC25-27].[dbo].[Utenti] 


--SELECT *
--INTO AspNetUserRolesBK20251031
--FROM [MonitoraggioPAC25-27].[dbo].[AspNetUserRoles]

-------------------------
--- 2.1 MANTENGO ACCOUNT necessari NON IN ELENCO 
-------------------------
--DELETE FROM  [MonitoraggioPAC25-27].[dbo].[AspNetUserRoles]
--FROM [MonitoraggioPAC25-27].[dbo].[AspNetUserRoles] UR INNER JOIN [MonitoraggioPAC25-27].[dbo].[AspNetUsers] U ON UR.UserId=U.Id
--WHERE userName NOT IN
--(
-- 'segretariato@CREA.it'
--,'segretariato@ISMEA.it'
--,'SEGRETARIATO@MASAF.GOV.IT'
--,'giuseppe.fornaciari@gmail.com'
--,'??@??'
--)

--SELECT *
--INTO AspNetUsersBK20251031
--FROM [MonitoraggioPAC25-27].[dbo].[AspNetUsers]

--DELETE [MonitoraggioPAC25-27].[dbo].[AspNetUsers]
--WHERE userName NOT IN
--(
-- 'segretariato@CREA.it'
--,'segretariato@ISMEA.it'
--,'SEGRETARIATO@MASAF.GOV.IT'
--,'giuseppe.fornaciari@gmail.com'
--,'??@??'
--)


--DBCC CHECKIDENT ('dbo.UtentiSchedaEnte', RESEED, 0);
--DBCC CHECKIDENT ('dbo.UtentiRuoli', RESEED, 0)
--DBCC CHECKIDENT ('dbo.UtentiProgettoMinistero', RESEED, 0)
--DBCC CHECKIDENT ('dbo.UtentiProgettoEnte', RESEED, 0)
--DBCC CHECKIDENT ('dbo.Utenti', RESEED, 0)

-------------------------
--- 3 inserimento elenco definitivo utenti con password assegnate da visual studio  
-------------------------
---UPDATE [AspNetUsers] SET Email=UserName, NormalizedEmail=NormalizedUserName

----4 Assegno ruolo RESPONSABILI DI progetto (3)
--INSERT INTO AspNetUserRoles
--SELECT id,3 FROM [MonitoraggioPAC25-27].[dbo].[AspNetUsers]
--WHERE id NOT IN --- GIA ASSEGNATI
--(
-- '65aae332-0a9e-48d8-9d69-8061868a6428' ---	1
--,'72e0ce18-c809-4c7f-8dbe-1fb8beb89612' ---	1
--,'e162fde4-5807-4453-a13d-9d1f9c8f8ac3' ---	1
--,'9999999999' ---	4
--,'f632d0f3-9a5a-4e04-928c-6f63404f3bd3' ---	5
--)
--AND UserName IN
--(
--'f.ciccarelli@ismea.it'----Franca Ciccarelli
--,'m.nucera@ismea.it'----Maria Antonia Nucera 
--,'g.ferrari@ismea.it'----Giovanna Maria Ferrari
--,'m.federico@ismea.it'----Margherita Federico
--,'f.daprile@ismea.it' ----Federica D'Aprile
--)

----5 Assegno ruolo RESPONSABILI DI scheda (2)
--INSERT INTO AspNetUserRoles
--SELECT id,2 FROM [MonitoraggioPAC25-27].[dbo].[AspNetUsers]
--WHERE id NOT IN --- GIA ASSEGNATI
--(
-- '65aae332-0a9e-48d8-9d69-8061868a6428' ---	1
--,'72e0ce18-c809-4c7f-8dbe-1fb8beb89612' ---	1
--,'e162fde4-5807-4453-a13d-9d1f9c8f8ac3' ---	1
--,'9999999999' ---	4
--,'f632d0f3-9a5a-4e04-928c-6f63404f3bd3' ---	5
--)
--AND UserName IN
--(
-- 'a.denaro@ismea.it'
-----,'f.daprile@ismea.it'
-----,'f.ciccarelli@ismea.it'
--,'g.giorgi@ismea.it'
-----,'g.ferrari@ismea.it'
--,'i.visaggi@ismea.it'
--,'i.fodera@ismea.it'
--,'l.rosatelli@ismea.it'
--,'l.atorino@ismea.it'
--,'l.fioriti@ismea.it'
--,'l.pittiglio@ismea.it'
--,'l.ottaviani@ismea.it'
-----,'m.federico@ismea.it'
-----,'m.nucera@ismea.it'
--,'m.ortolani@ismea.it'
--,'p.lauricella@ismea.it'
--,'t.sarnari@ismea.it'
--,'u.selmi@ismea.it'
--,'alberto.sturla@crea.gov.it'
--,'alessandra.pesce@crea.gov.it'
--,'alessandra.vaccaro@crea.gov.it'
--,'alessandro.monteleone@crea.gov.it'
--,'alessandro.paletto@crea.gov.it'
--,'andrea.arzeni@crea.gov.it'
--,'andrea.bonfiglio@crea.gov'
--,'andrea.cutini@crea.gov.it'
--,'anna.vagnozzi@crea.gov.it'
--,'annalisa.del prete@crea.gov.it'
--,'antonella.trisorio@crea.gov.it'
--,'antonio.papaleo@crea.gov.it'
--,'assunta.amato@crea.gov.it'
--,'barbara.parisse@crea.gov.it'
--,'barbara.zanetti@crea.gov.it'
--,'beatrice.camaioni@crea.gov.it'
--,'catia.zumpano@crea.gov.it'
--,'chiara.epifani@crea.gov.it'
--,'concetta.cardillo@crea.gov.it'
--,'corrado.ciaccia@crea.gov.it'
--,'daniela.storti@crea.gov.it'
--,'daniele.giordano@crea.gov.it'
--,'danilo.marandola@crea.gov.it'
--,'davide.longhitano@crea.gov.it'
--,'emilia.reda@crea.gov.it'
--,'fabio.muscas@crea.gov.it'
--,'federica.cisilino@crea.gov.it'
--,'federica.demaria@crea.gov.it'
--,'filippo.chiozzotto@crea.gov.it' 
--,'flora.denatale@crea.gov.it'
--,'francesca.antonucci@crea.gov.it'
--,'francesca.giare@crea.gov.it'
--,'francesca.varia@crea.gov.it'
--,'francesco.licciardo@crea.gov.it'
--,'gabriella.ricciardi@crea.gov.it'
--,'giampiero.mazzocchi@crea.gov.it'
--,'giorgia.matteucci@crea.gov.it'
--,'giovanni.daraguccione@crea.gov.it'
--,'giulia.diglio@crea.gov.it'
--,'giuseppe.pignatti@crea.gov.it'
--,'grazia.valentino@crea.gov.it'
--,'laura.bortolotti@crea.gov.it'
--,'laura.vigano@crea.gov.it'
--,'lucia.briamonte@crea.gov.it'
--,'lucia.tudini@crea.gov.it'
--,'manuela.scornaienghi@crea.gov.it'
--,'mara.lai@crea.gov.it'
--,'mariacarmela.macri@crea.gov.it'
--,'marialuisa.scalvedi@crea.gov.it'
--,'mrosaria.dandrea@crea.gov.it'
--,'mvalentina.lasorella@crea.gov.it'
--,'m.cariello@masaf.gov.it'
--,'martina.bolli@crea.gov.it'
--,'milena.verrascina@crea.gov.it'
--,'paola.lionetti@crea.gov.it'
--,'paolo.menesatti@crea.gov.it'
--,'patrizia.borsotto@crea.gov.it'
--,'patrizia.proietti@crea.gov.it'
--,'piermaria.corona@crea.gov.it'
--,'pierpaolo.pallara@crea.gov.it'
--,'raffaeella.dinapoli@crea.gov.it'
--,'raffaella.pergamo@crea.gov.it'
--,'raoul.romano@crea.gov.it'
--,'roberta.ciaravino@crea.gov'
--,'roberta.sardone@crea.gov.it'
--,'roberto.cagliero@crea.gov.it'
--,'roberto.solazzo@crea.gov.it'
--,'rosa.rivieccio@crea.gov.it'
--,'rossella.ugati@crea.gov.it'
--,'sabrina.giuca@crea.gov.it'
--,'sara.bergante@crea.gov.it'
--,'saverio.maluccio@crea.gov.it'
--,'serena.tarangioli@crea.gov.it'
--,'stefano.angeli@crea.gov.it'
--,'tatiana.castellotti@crea.gov.it'
--,'teresa.lettieri@crea.gov.it'
--,'valentina.carta@crea.gov.it'
--)

----6 Assegno ruolo RESPONSABILI mINISTERO (4)
--INSERT INTO AspNetUserRoles
--SELECT id,4 FROM [MonitoraggioPAC25-27].[dbo].[AspNetUsers]
--WHERE id NOT IN --- GIA ASSEGNATI
--(
-- '65aae332-0a9e-48d8-9d69-8061868a6428' ---	1
--,'72e0ce18-c809-4c7f-8dbe-1fb8beb89612' ---	1
--,'e162fde4-5807-4453-a13d-9d1f9c8f8ac3' ---	1
--,'9999999999' ---	4
--,'f632d0f3-9a5a-4e04-928c-6f63404f3bd3' ---	5
--)
--AND UserName IN
--(
-- 'a.manzo@masaf.gov.it'
--,'alessandro.carocci@masaf.gov.it'
--,'a.montefiori@masaf.gov.it'
--,'anna.iovane@masaf.gov.it'
--,'a.diciolla@masaf.gov.it'
--,'a.gangemi@masaf.gov.it'
--,'a.frattarelli@masaf.gov.it'
--,'a.tonolo@masaf.gov.it'
--,'beatrice.tucci@masaf.gov.it'
--,'consiglia.arena@masaf.gov.it'
--,'david.wiersma@masaf.gov.it'
--,'emilio.sabelli@masaf.gov.it'
--,'e.guidi@masaf.gov.it'
--,'f.coniglio@masaf.gov.it'
--,'francesco.rea@masaf.gov.it'
--,'gionatan.brancalenti@masaf.gov.it'
--,'g.vuono@masaf.gov.it'
--,'giulia.orecchio@masaf.gov.it'
--,'g.ciotti@masaf.gov.it'
--,'g.cottignoli@masaf.gov.it'
--,'giuseppe.direnzo@masaf.gov.it'
--,'i.librandi@masaf.gov.it'
--,'l.ferri@masaf.gov.it'
--,'laura.panico@masaf.gov.it'
--,'luisa.guerrera.ext@saf.gov.it'
--,'luna.kappler@masaf.gov.it'
--,'m.pellegrini@masaf.gov.it'
--,'michela.conti@masaf.gov.it'
--,'m.saragosa@masaf.gov.it'
--,'p.gonnelli@masaf.gov.it'
--,'p.ammassari@masaf.gov.it'
--,'paolo.valdarchi@masaf.gov.it'
--,'p.falzarano@masaf.gov.it'
--,'p.giantomasi@masaf.gov.it'
--,'riccardo.meo@masaf.gov.it'
--,'r.rossipaccani@masaf.gov.it'
--,'salvatore.viscardi@masaf.gov.it'
--,'s.piloni@masaf.gov.it'
--,'s.ferlazzo@masaf.gov.it'
--,'s.lafiandra@masaf.gov.it'
--,'veronica.granata@masaf.gov.it'
--,'v.montalbano@masaf.gov.it'
--)

---7 INSERISCO utenti 
--INSERT INTO Utenti( Email,Utente,idAspNetUser)
--SELECT [Email]
--      ,[UserName] as Utente
--      ,Id
--  FROM [MonitoraggioPAC25-27].[dbo].[AspNetUsers]
--UPDATE Utenti SET Utente='Antonio Denaro' WHERE Email='a.denaro@ismea.it'
--UPDATE Utenti SET Utente='Anna Maria Di Ciolla' WHERE Email='a.diciolla@masaf.gov.it'
--UPDATE Utenti SET Utente='Antonio Frattarelli' WHERE Email='a.frattarelli@masaf.gov.it'
--UPDATE Utenti SET Utente='Annunziata Maria Gangemi' WHERE Email='a.gangemi@masaf.gov.it'
--UPDATE Utenti SET Utente='Alberto Manzo' WHERE Email='a.manzo@masaf.gov.it'
--UPDATE Utenti SET Utente='Alessia Montefiori' WHERE Email='a.montefiori@masaf.gov.it'
--UPDATE Utenti SET Utente='Attilio Tonolo' WHERE Email='a.tonolo@masaf.gov.it'
--UPDATE Utenti SET Utente='Alberto Sturla' WHERE Email='alberto.sturla@crea.gov.it'
--UPDATE Utenti SET Utente='Alessandra Pesce' WHERE Email='alessandra.pesce@crea.gov.it'
--UPDATE Utenti SET Utente='Alessandra Vaccaro' WHERE Email='alessandra.vaccaro@crea.gov.it'
--UPDATE Utenti SET Utente='Alessandro Carocci' WHERE Email='alessandro.carocci@masaf.gov.it'
--UPDATE Utenti SET Utente='Alessandro Monteleone' WHERE Email='alessandro.monteleone@crea.gov.it'
--UPDATE Utenti SET Utente='Alessandro Paletto ' WHERE Email='alessandro.paletto@crea.gov.it'
--UPDATE Utenti SET Utente='Andrea Arzeni' WHERE Email='andrea.arzeni@crea.gov.it'
--UPDATE Utenti SET Utente='Andrea Bonfiglio' WHERE Email='andrea.bonfiglio@crea.gov'
--UPDATE Utenti SET Utente='Andrea Cutini' WHERE Email='andrea.cutini@crea.gov.it'
--UPDATE Utenti SET Utente='Anna Chiara Iovane' WHERE Email='anna.iovane@masaf.gov.it'
--UPDATE Utenti SET Utente='Anna Vagnozzi' WHERE Email='anna.vagnozzi@crea.gov.it'
--UPDATE Utenti SET Utente='Annalisa Del Prete' WHERE Email='annalisa.delprete@crea.gov.it'
--UPDATE Utenti SET Utente='Antonella Trisorio' WHERE Email='antonella.trisorio@crea.gov.it'
--UPDATE Utenti SET Utente='Antonio Papaleo' WHERE Email='antonio.papaleo@crea.gov.it'
--UPDATE Utenti SET Utente='Assunta Amato' WHERE Email='assunta.amato@crea.gov.it'
--UPDATE Utenti SET Utente='Barbara Parisse' WHERE Email='barbara.parisse@crea.gov.it'
--UPDATE Utenti SET Utente='Barbara Zanetti' WHERE Email='barbara.zanetti@crea.gov.it'
--UPDATE Utenti SET Utente='Beatrice Camaioni' WHERE Email='beatrice.camaioni@crea.gov.it'
--UPDATE Utenti SET Utente='Beatrice Tucci' WHERE Email='beatrice.tucci@masaf.gov.it'
--UPDATE Utenti SET Utente='Catia Zumpano' WHERE Email='catia.zumpano@crea.gov.it'
--UPDATE Utenti SET Utente='Chiara Epifani' WHERE Email='chiara.epifani@crea.gov.it'
--UPDATE Utenti SET Utente='Concetta Cardillo' WHERE Email='concetta.cardillo@crea.gov.it'
--UPDATE Utenti SET Utente='Consiglia Arena' WHERE Email='consiglia.arena@masaf.gov.it'
--UPDATE Utenti SET Utente='Corrado Ciaccia' WHERE Email='corrado.ciaccia@crea.gov.it'
--UPDATE Utenti SET Utente='Daniela Storti' WHERE Email='daniela.storti@crea.gov.it'
--UPDATE Utenti SET Utente='Daniele Giordano' WHERE Email='daniele.giordano@crea.gov.it'
--UPDATE Utenti SET Utente='Danilo Marandola' WHERE Email='danilo.marandola@crea.gov.it'
--UPDATE Utenti SET Utente='David Wiersma' WHERE Email='david.wiersma@masaf.gov.it'
--UPDATE Utenti SET Utente='Davide Longhitano' WHERE Email='davide.longhitano@crea.gov.it'
--UPDATE Utenti SET Utente='Enrico Guidi' WHERE Email='e.guidi@masaf.gov.it'
--UPDATE Utenti SET Utente='Emilia Reda' WHERE Email='emilia.reda@crea.gov.it'
--UPDATE Utenti SET Utente='Emilio Sabelli' WHERE Email='emilio.sabelli@masaf.gov.it'
--UPDATE Utenti SET Utente='Franca Ciccarelli' WHERE Email='f.ciccarelli@ismea.it'
--UPDATE Utenti SET Utente='Francesca Coniglio' WHERE Email='f.coniglio@masaf.gov.it'
--UPDATE Utenti SET Utente='Federica D''Aprile' WHERE Email='f.daprile@ismea.it'
--UPDATE Utenti SET Utente='Fabio Muscas' WHERE Email='fabio.muscas@crea.gov.it'
--UPDATE Utenti SET Utente='Federica Cisilino' WHERE Email='federica.cisilino@crea.gov.it'
--UPDATE Utenti SET Utente='Federica De Maria' WHERE Email='federica.demaria@crea.gov.it'
--UPDATE Utenti SET Utente='Filippo Chiozzotto' WHERE Email='filippo.chiozzotto@crea.gov.it'
--UPDATE Utenti SET Utente='Flora De Natale' WHERE Email='flora.denatale@crea.gov.it'
--UPDATE Utenti SET Utente='Francesca Antonucci' WHERE Email='francesca.antonucci@crea.gov.it'
--UPDATE Utenti SET Utente='Francesca Giarè' WHERE Email='francesca.giare@crea.gov.it'
--UPDATE Utenti SET Utente='Francesca Varia' WHERE Email='francesca.varia@crea.gov.it'
--UPDATE Utenti SET Utente='Francesco Licciardo' WHERE Email='francesco.licciardo@crea.gov.it'
--UPDATE Utenti SET Utente='Francesco Rea' WHERE Email='francesco.rea@masaf.gov.it'
--UPDATE Utenti SET Utente='Giuseppe Ciotti' WHERE Email='g.ciotti@masaf.gov.it'
--UPDATE Utenti SET Utente='Giuseppe Cottignoli' WHERE Email='g.cottignoli@masaf.gov.it'
--UPDATE Utenti SET Utente='Giovanna Maria Ferrari' WHERE Email='g.ferrari@ismea.it'
--UPDATE Utenti SET Utente='Gianluca Giorgi' WHERE Email='g.giorgi@ismea.it'
--UPDATE Utenti SET Utente='Giorgio Vuono' WHERE Email='g.vuono@masaf.gov.it'
--UPDATE Utenti SET Utente='Gabriella Ricciardi' WHERE Email='gabriella.ricciardi@crea.gov.it'
--UPDATE Utenti SET Utente='Giampiero Mazzocchi' WHERE Email='giampiero.mazzocchi@crea.gov.it'
--UPDATE Utenti SET Utente='Gionatan Bracalenti' WHERE Email='gionatan.brancalenti@masaf.gov.it'
--UPDATE Utenti SET Utente='Giorgia Matteucci' WHERE Email='giorgia.matteucci@crea.gov.it'
--UPDATE Utenti SET Utente='Giovanni Dara Guccione' WHERE Email='giovanni.daraguccione@crea.gov.it'
--UPDATE Utenti SET Utente='Giulia Diglio' WHERE Email='giulia.diglio@crea.gov.it'
--UPDATE Utenti SET Utente='Giulia Orecchio' WHERE Email='giulia.orecchio@masaf.gov.it'
--UPDATE Utenti SET Utente='Giuseppe Di Renzo' WHERE Email='giuseppe.direnzo@masaf.gov.it'
--UPDATE Utenti SET Utente='Giuseppe Pignatti' WHERE Email='giuseppe.pignatti@crea.gov.it'
--UPDATE Utenti SET Utente='Grazia Valentino' WHERE Email='grazia.valentino@crea.gov.it'
--UPDATE Utenti SET Utente='Isabella Foderà' WHERE Email='i.fodera@ismea.it'
--UPDATE Utenti SET Utente='Immacolata Librandi' WHERE Email='i.librandi@masaf.gov.it'
--UPDATE Utenti SET Utente='Irene Visaggi' WHERE Email='i.visaggi@ismea.it'
--UPDATE Utenti SET Utente='Letizia Atorino' WHERE Email='l.atorino@ismea.it'
--UPDATE Utenti SET Utente='Laura Ferri' WHERE Email='l.ferri@masaf.gov.it'
--UPDATE Utenti SET Utente='Linda Fioriti' WHERE Email='l.fioriti@ismea.it'
--UPDATE Utenti SET Utente='Luigi Ottaviani' WHERE Email='l.ottaviani@ismea.it'
--UPDATE Utenti SET Utente='Loredana Pittiglio' WHERE Email='l.pittiglio@ismea.it'
--UPDATE Utenti SET Utente='Laura Rosatelli' WHERE Email='l.rosatelli@ismea.it'
--UPDATE Utenti SET Utente='Laura Bortolotti' WHERE Email='laura.bortolotti@crea.gov.it'
--UPDATE Utenti SET Utente='Laura Panico' WHERE Email='laura.panico@masaf.gov.it'
--UPDATE Utenti SET Utente='Laura Viganò' WHERE Email='laura.vigano@crea.gov.it'
--UPDATE Utenti SET Utente='Lucia Briamonte' WHERE Email='lucia.briamonte@crea.gov.it'
--UPDATE Utenti SET Utente='Lucia Tudini' WHERE Email='lucia.tudini@crea.gov.it'
--UPDATE Utenti SET Utente='Luisa Guerrera' WHERE Email='luisa.guerrera.ext@saf.gov.it'
--UPDATE Utenti SET Utente='Luna Kappler' WHERE Email='luna.kappler@masaf.gov.it'
--UPDATE Utenti SET Utente='Mario Cariello' WHERE Email='m.cariello@masaf.gov.it'
--UPDATE Utenti SET Utente='Margherita Federico' WHERE Email='m.federico@ismea.it'
--UPDATE Utenti SET Utente='Maria Antonia Nucera' WHERE Email='m.nucera@ismea.it'
--UPDATE Utenti SET Utente='Maria Raffaella Ortolani' WHERE Email='m.ortolani@ismea.it'
--UPDATE Utenti SET Utente='Marco Pellegrini' WHERE Email='m.pellegrini@masaf.gov.it'
--UPDATE Utenti SET Utente='Michele Saragosa' WHERE Email='m.saragosa@masaf.gov.it'
--UPDATE Utenti SET Utente='Manuela Scornaienghi' WHERE Email='manuela.scornaienghi@crea.gov.it'
--UPDATE Utenti SET Utente='Mara Lai' WHERE Email='mara.lai@crea.gov.it'
--UPDATE Utenti SET Utente='Maria Carmela Macrì' WHERE Email='mariacarmela.macri@crea.gov.it'
--UPDATE Utenti SET Utente='Maria Luisa Scalvedi' WHERE Email='marialuisa.scalvedi@crea.gov.it'
--UPDATE Utenti SET Utente='Martina Bolli' WHERE Email='martina.bolli@crea.gov.it'
--UPDATE Utenti SET Utente='Michela conti' WHERE Email='michela.conti@masaf.gov.it'
--UPDATE Utenti SET Utente='Milena Verrascina' WHERE Email='milena.verrascina@crea.gov.it'
--UPDATE Utenti SET Utente='Maria Rosaria Pupo D''Andrea' WHERE Email='mrosaria.dandrea@crea.gov.it'
--UPDATE Utenti SET Utente='Maria Valentina Lasorella' WHERE Email='mvalentina.lasorella@crea.gov.it'
--UPDATE Utenti SET Utente='Paolo Ammassari' WHERE Email='p.ammassari@masaf.gov.it'
--UPDATE Utenti SET Utente='Pasquale Falzarano' WHERE Email='p.falzarano@masaf.gov.it'
--UPDATE Utenti SET Utente='Pasquale Giantomasi' WHERE Email='p.giantomasi@masaf.gov.it'
--UPDATE Utenti SET Utente='Paola Gonnelli' WHERE Email='p.gonnelli@masaf.gov.it'
--UPDATE Utenti SET Utente='Paola Lauricella' WHERE Email='p.lauricella@ismea.it'
--UPDATE Utenti SET Utente='Paola Lionetti' WHERE Email='paola.lionetti@crea.gov.it'
--UPDATE Utenti SET Utente='Paolo Menesatti' WHERE Email='paolo.menesatti@crea.gov.it'
--UPDATE Utenti SET Utente='Paolo Valdarchi' WHERE Email='paolo.valdarchi@masaf.gov.it'
--UPDATE Utenti SET Utente='Patrizia Borsotto' WHERE Email='patrizia.borsotto@crea.gov.it'
--UPDATE Utenti SET Utente='Patrizia Proietti' WHERE Email='patrizia.proietti@crea.gov.it'
--UPDATE Utenti SET Utente='Piermaria Corona' WHERE Email='piermaria.corona@crea.gov.it'
--UPDATE Utenti SET Utente='Pierpaolo Pallara' WHERE Email='pierpaolo.pallara@crea.gov.it'
--UPDATE Utenti SET Utente='Riccardo Rossi Paccani' WHERE Email='r.rossipaccani@masaf.gov.it'
--UPDATE Utenti SET Utente='Raffaella Di Napoli' WHERE Email='raffaeella.dinapoli@crea.gov.it'
--UPDATE Utenti SET Utente='Raffaella Pergamo' WHERE Email='raffaella.pergamo@crea.gov.it'
--UPDATE Utenti SET Utente='Raoul Romano' WHERE Email='raoul.romano@crea.gov.it'
--UPDATE Utenti SET Utente='Riccardo Meo' WHERE Email='riccardo.meo@masaf.gov.it'
--UPDATE Utenti SET Utente='Roberta Ciaravino' WHERE Email='roberta.ciaravino@crea.gov'
--UPDATE Utenti SET Utente='Roberta Sardone' WHERE Email='roberta.sardone@crea.gov.it'
--UPDATE Utenti SET Utente='Roberto Cagliero' WHERE Email='roberto.cagliero@crea.gov.it'
--UPDATE Utenti SET Utente='Roberto Solazzo' WHERE Email='roberto.solazzo@crea.gov.it'
--UPDATE Utenti SET Utente='Rosa Rivieccio' WHERE Email='rosa.rivieccio@crea.gov.it'
--UPDATE Utenti SET Utente='Rossella Ugati' WHERE Email='rossella.ugati@crea.gov.it'
--UPDATE Utenti SET Utente='Silvia Ferlazzo' WHERE Email='s.ferlazzo@masaf.gov.it'
--UPDATE Utenti SET Utente='Stefano Lafiandra' WHERE Email='s.lafiandra@masaf.gov.it'
--UPDATE Utenti SET Utente='Sara Piloni' WHERE Email='s.piloni@masaf.gov.it'
--UPDATE Utenti SET Utente='Sabrina Giuca' WHERE Email='sabrina.giuca@crea.gov.it'
--UPDATE Utenti SET Utente='Salvatore Viscardi' WHERE Email='salvatore.viscardi@masaf.gov.it'
--UPDATE Utenti SET Utente='Sara Bergante' WHERE Email='sara.bergante@crea.gov.it'
--UPDATE Utenti SET Utente='Saverio Maluccio' WHERE Email='saverio.maluccio@crea.gov.it'
--UPDATE Utenti SET Utente='Serena Tarangioli' WHERE Email='serena.tarangioli@crea.gov.it'
--UPDATE Utenti SET Utente='Stefano Angeli' WHERE Email='stefano.angeli@crea.gov.it'
--UPDATE Utenti SET Utente='Tiziana Sarnari ' WHERE Email='t.sarnari@ismea.it'
--UPDATE Utenti SET Utente='Tatiana Castellotti' WHERE Email='tatiana.castellotti@crea.gov.it'
--UPDATE Utenti SET Utente='Teresa Lettieri' WHERE Email='teresa.lettieri@crea.gov.it'
--UPDATE Utenti SET Utente='Umberto Selmi' WHERE Email='u.selmi@ismea.it'
--UPDATE Utenti SET Utente='Vincenzo Montalbano' WHERE Email='v.montalbano@masaf.gov.it'
--UPDATE Utenti SET Utente='Valentina Carta' WHERE Email='valentina.carta@crea.gov.it'
--UPDATE Utenti SET Utente='Veronica Granata' WHERE Email='veronica.granata@masaf.gov.it'



---DELETE FROM UtentiSchedaEnte
--DBCC CHECKIDENT ('UtentiSchedaEnte', RESEED, 0);
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (1,(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (2,(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (3,(SELECT idUtente FROM Utenti WHERE Utente ='Maria Antonia Nucera '))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (4,(SELECT idUtente FROM Utenti WHERE Utente ='Giovanna Maria Ferrari'))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (5,(SELECT idUtente FROM Utenti WHERE Utente ='Giovanna Maria Ferrari'))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (6,(SELECT idUtente FROM Utenti WHERE Utente ='Margherita Federico'))
INSERT INTO [UtentiSchedaEnte] ([idScheda],[idUtente]) VALUES (7,(SELECT idUtente FROM Utenti WHERE Utente ='Federica D''Aprile'))

SELECT CodScheda,Scheda,DataMonitoraggio,Utente,Email
FROM Utenti U
INNER JOIN UtentiSchedaEnte US ON U.IdUtente=US.idUtente
INNER JOIN Schede S ON US.idScheda=S.IdScheda


--DELETE FROM UtentiProgettoEnte
--DBCC CHECKIDENT ('UtentiProgettoEnte', RESEED, 0);
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Luigi Ottaviani'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Giovanna Maria Ferrari'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Isabella Foderà'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Gianluca Giorgi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Luigi Ottaviani'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Gianluca Giorgi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.06'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli')) 
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.07'),(SELECT idUtente FROM Utenti WHERE Utente ='Gianluca Giorgi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.08'),(SELECT idUtente FROM Utenti WHERE Utente ='Gianluca Giorgi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.09'),(SELECT idUtente FROM Utenti WHERE Utente ='Isabella Foderà'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Loredana Pittiglio'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.11'),(SELECT idUtente FROM Utenti WHERE Utente ='Letizia Atorino'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Paola Lauricella'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Letizia Atorino'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Paola Lauricella'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Franca Ciccarelli'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Letizia Atorino'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Isabella Foderà'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Tiziana Sarnari')) 
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Linda Fioriti')) 
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Umberto Selmi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Giovanna Maria Ferrari'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Maria Antonia Nucera'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Denaro'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Letizia Atorino'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Laura Rosatelli')) 
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Denaro'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Maria Raffaella Ortolani'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Isabella Foderà'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Maria Raffaella Ortolani'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Denaro'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.06'),(SELECT idUtente FROM Utenti WHERE Utente ='Irene Visaggi'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.07'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Denaro'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.07'),(SELECT idUtente FROM Utenti WHERE Utente ='Giovanna Maria Ferrari'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS06.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Maria Raffaella Ortolani'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS06.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Margherita Federico'))
--INSERT INTO [UtentiProgettoEnte] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS07.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Federica D''Aprile'))

SELECT * FROM  UtentiProgettoEnte  WHERE idProgetto=(SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.05')
---UPDATE UtentiProgettoEnte SET idUtente = (SELECT idUtente FROM Utenti WHERE Utente ='Letizia Atorino') WHERE idUtenteProgettoEnte IN (SELECT idUtenteProgettoEnte FROM  UtentiProgettoEnte  WHERE idProgetto=(SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.05'))


SELECT CodProgetto,Progetto,Utente,Email
FROM Utenti U
INNER JOIN UtentiProgettoEnte UPE ON U.IdUtente=UPE.idUtente
INNER JOIN Progetti P ON UPE.idProgetto=P.idProgetto



--DELETE FROM UtentiProgettoMinistero
--DBCC CHECKIDENT ('UtentiProgettoMinistero', RESEED, 0);
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Paolo Ammassari'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Paolo Ammassari'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Stefano Lafiandra'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Francesco Rea'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Salvatore Viscardi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.06'),(SELECT idUtente FROM Utenti WHERE Utente ='Veronica Granata'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.07'),(SELECT idUtente FROM Utenti WHERE Utente ='Paolo Ammassari'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.08'),(SELECT idUtente FROM Utenti WHERE Utente ='Salvatore Viscardi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.09'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Frattarelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonia Ripepi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Giulia Orecchio'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Laura Ferri'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Luisa Guerrera'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Gionatan Bracalenti'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='David Wiersma'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Marco Pellegrini'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.11'),(SELECT idUtente FROM Utenti WHERE Utente ='Enrico Guidi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Giuseppe Ciotti'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Francesco Rea'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Alessia Montefiori'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Frattarelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS02.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonio Frattarelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonia Ripepi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Anna Maria Di Ciolla'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Laura ferri'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Luisa Guerrera'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Gionatan Bracalenti'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Marco Pellegrini'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Anna Chiara Iovane'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Pasquale Giantomasi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Giorgio Vuono'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Emilio Sabelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Salvatore Viscardi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Alessandro Carocci'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS04.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Alessandro Carocci'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Pasquale Falzarano'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Pasquale Falzarano'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.03'),(SELECT idUtente FROM Utenti WHERE Utente ='Consiglia Arena'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.04'),(SELECT idUtente FROM Utenti WHERE Utente ='Alessia Montefiori'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.05'),(SELECT idUtente FROM Utenti WHERE Utente ='Paola Gonnelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.06'),(SELECT idUtente FROM Utenti WHERE Utente ='Paola Gonnelli'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS05.07'),(SELECT idUtente FROM Utenti WHERE Utente ='Pasquale Falzarano'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS06.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Riccardo Rossi Paccani'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS06.02'),(SELECT idUtente FROM Utenti WHERE Utente ='Riccardo Rossi Paccani'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS07.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Paolo Ammassari'))

SELECT *
FROM Utenti U
INNER JOIN UtentiProgettoMinistero UPM ON U.IdUtente=UPM.idUtente
INNER JOIN Progetti P ON UPM.idProgetto=P.idProgetto


------
----- 20251125 Aggiunta utenti
--- 1 DA APPLICATIVO
---a.ripepi@ismea.it
---DELETE FROM AspNetUsers WHERE username like '%ripepi%'
SELECT * FROM AspNetUsers WHERE username like '%ripepi%'
---UPDATE AspNetUsers Set EmailConfirmed=1 WHERE username like '%ripepi%'
--- 2 DB utente
SELECT * FROM Utenti WHERE Utente like '%ripepi%'
---INSERT INTO Utenti (email,utente,idAspNetUser) VALUES ('a.ripepi@ismea.it','Antonia Ripepi','99fff664-0b71-40ea-8813-f32e7be02385')
--- 2 DB ruolo
SELECT *
  FROM [AspNetUserRoles] UR
  ---INNER JOIN AspNetRoles R ON UR.RoleId=R.Id  
  WHERE UserId='99fff664-0b71-40ea-8813-f32e7be02385'
---INSERT INTO [AspNetUserRoles] (UserId,RoleId) VALUES ('99fff664-0b71-40ea-8813-f32e7be02385',3)
---UPDATE [AspNetUserRoles] SET RoleId=4  WHERE UserId='99fff664-0b71-40ea-8813-f32e7be02385'

--- 3 MINISTERO
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS01.10'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonia Ripepi'))
--INSERT INTO [UtentiProgettoMinistero] ([idProgetto],[idUtente]) VALUES ((SELECT idProgetto FROM Progetti WHERE CodProgetto='IS03.01'),(SELECT idUtente FROM Utenti WHERE Utente ='Antonia Ripepi'))
SELECT * FROM UtentiProgettoMinistero WHERE idUtente=(SELECT idUtente FROM Utenti WHERE Utente ='Antonia Ripepi')

