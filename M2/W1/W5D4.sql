CREATE TABLE Clienti (
IDCliente TINYINT
, RagioneSociale VARCHAR(255)
, PIVA CHAR(13)
, Fatturato INT
, NumeroDipendenti INT
, TotaleAttivo INT
, ATECO INT
, CONSTRAINT PK_Clienti PRIMARY KEY (IDCliente));

CREATE TABLE Area (
ID_Area TINYINT
, DenominazioneArea VARCHAR(255)
, CONSTRAINT PK_Area PRIMARY KEY (ID_Area));

CREATE TABLE Dipendenti (
IDDipendente TINYINT
, ID_Area TINYINT
, Ruolo VARCHAR(255)
, Stato VARCHAR(25)
, Email VARCHAR(255)
, Telefono VARCHAR(25)
, CONSTRAINT PK_Dipendenti PRIMARY KEY (IDDipendente));

CREATE TABLE Progetti (
IDProgetto TINYINT
, DenominazioneProgetto VARCHAR(255)
, ID_Area TINYINT
, IDCliente TINYINT
, NominativoReferente VARCHAR(255)
, IDDipendente TINYINT
, Importo INT
, Stato VARCHAR(25)
, DataInizio DATE 
, DataFine DATE 
, CONSTRAINT PK_Progetti PRIMARY KEY (IDProgetto)
, CONSTRAINT FK_Area_Progetti FOREIGN KEY (ID_Area)
REFERENCES Area (ID_Area)
, CONSTRAINT FK_Clienti_Progetti FOREIGN KEY (IDCliente)
REFERENCES Clienti (IDCliente)
, CONSTRAINT FK_Dipendenti_Progetti FOREIGN KEY (IDDipendente)
REFERENCES Dipendenti (IDDipendente));

INSERT INTO Clienti VALUES 
(001, 'Tim Spa', 'IT00488410010', 92182143, 18447, 117900000, 61)
, (002, 'Enel Spa', 'IT00934061003', 1102100, 1215, 25090000, 3511)
, (003, 'Ferrovie dello Stato Spa', 'IT06359501001', 84200000, 82000, 51000000, 4910)
, (004, 'Poste Italiane Spa', 'IT09722901005', 11220000, 119000, 58000000, 5310)
, (005, 'Leonardo Spa', 'IT00401990585', 147100000, 51500, 37000000, 3030)
, (006, 'Terna Spa', 'IT05779661007', 29400000, 5400, 25000000, 3512)
, (007, 'Saipem Spa', 'IT00825790157', 99800000, 30000, 12000000, 4221)
, (008, 'Pirelli Spa', 'IT00860340157', 65900000, 31300, 11000000, 2211)
, (009, 'Amplifon Spa', 'IT04923960159', 21200000, 18600, 9800000, 4774)
, (010, 'Brembo Spa', 'IT00222620163', 36300000, 12800, 5600000, 2932);

INSERT INTO Area VALUES 
(1, 'Strategy & Innovation')
, (2, 'Finance & Controlling')
, (3, 'Information Technology')
, (4, 'Risorse Umane & Organizzazione')
, (5, 'Legal & Compliance')
, (6, 'Marketing & Comunicazione')
, (7, 'Operations & Supply Chain')
, (8, 'Tax & Fiscalità')
, (9, 'Audit & Risk Management')
, (10, 'M&A e Due Diligence');

INSERT INTO Dipendenti VALUES 
(1, 1, 'Partner', 'Attivo', 'l.bianchi@consulenza.it', 33)
, (2, 2, 'Manager', 'Attivo', 'm.rossi@consulenza.it', 34)
, (3, 3, 'Senior Consultant', 'Attivo', 'g.verdi@consulenza.it', 35)
, (4, 4, 'Consultant', 'Attivo', 'a.romano@consulenza.it', 36)
, (5, 5, 'Partner', 'Attivo', 'f.colombo@consulenza.it', 37)
, (6, 6, 'Analyst', 'Attivo', 's.ferrari@consulenza.it', 38)
, (7, 7, 'Manager', 'Attivo', 'p.ricci@consulenza.it', 39)
, (8, 8, 'Senior Consultant', 'Inattivo', 'c.marino@consulenza.it', 40)
, (9, 9, 'Consultant', 'Attivo', 'e.greco@consulenza.it', 41)
, (10, 10, 'Analyst', 'Attivo', 'd.conti@consulenza.it', 42);

INSERT INTO Progetti VALUES 
(1, 'Piano Strategico Digitale', 1, 1, 'Marco Cellini', 1, 150000, 'Completato', '2024-03-01', '2024-09-30')
, (2, 'Revisione Modello di Controllo', 2, 2, 'Laura Petrini', 2, 85000, 'In corso', '2025-01-15', '2025-07-15')
, (3, 'Migrazione Cloud ERP', 3, 3, 'Giovanni Amato', 3, 220000, 'In corso', '2024-11-01', '2025-12-31')
, (4, 'Ristrutturazione Organizzativa', 4, 4, 'Anna Ferretti', 4, 95000, 'Completato', '2024-06-01', '2024-12-31')
, (5, 'Adeguamento GDPR', 5, 5, 'Roberto Sala', 5, 60000, 'Completato', '2024-02-01', '2024-05-31')
, (6, 'Campagna Rebranding', 6, 6, 'Silvia Mancini', 6, 110000, 'In corso', '2025-02-01', '2025-08-31')
, (7, 'Ottimizzazione Logistica', 7, 7, 'Paolo Galli', 7, 175000, 'Pianificato', '2025-06-01', '2026-03-31')
, (8, 'Transfer Pricing Review', 8, 8, 'Chiara Longo', 2, 70000, 'Completato', '2024-04-01', '2024-08-31')
, (9, 'Internal Audit Framework', 9, 9, 'Elena Barbieri', 9, 130000, 'In corso', '2025-03-01', '2025-11-30')
, (10, 'Due Diligence Acquisizione', 10, 10, 'Davide Rinaldi', 10, 200000, 'Pianificato', '2025-09-01', '2026-02-28');