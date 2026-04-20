-- ================================================
-- BUILDWEEK - GRUPPO 2 
-- ================================================

CREATE DATABASE VendiCose;
USE VendiCose;

-- Categorie di prodotto
CREATE TABLE DimCategorie (
  IDCategoria   INT
  , NomeCategoria VARCHAR(255) NOT NULL
  , CONSTRAINT PK_DimCategorie PRIMARY KEY (IDCategoria)
);

INSERT INTO DimCategorie VALUES
  (1, 'Alimentari'),
  (2, 'Bevande'),
  (3, 'Cosmetica'),
  (4, 'Pulizia Casa'),
  (5, 'Surgelati'),
  (6, 'Snack e Dolciumi');

-- Anagrafica prodotti
CREATE TABLE DimProdotti (
  IDProdotto   INT,
  NomeProdotto VARCHAR(255) NOT NULL,
  IDCategoria  INT NOT NULL,
  CONSTRAINT PK_DimProdotti  PRIMARY KEY (IDProdotto),
  CONSTRAINT FK_Prod_Cat     FOREIGN KEY (IDCategoria)
    REFERENCES DimCategorie (IDCategoria)
);

INSERT INTO DimProdotti VALUES
  (1,  'Pasta Barilla 500g', 1),
  (2,  'Olio EVO Monini 1L', 1),
  (3,  'Acqua Naturale 1.5L', 2),
  (4,  'Coca Cola 1.5L', 2),
  (5,  'Shampoo Pantene 300ml',  3),
  (6,  'Crema Viso Nivea 50ml',  3),
  (7,  'Detersivo Dash 3kg',    4),
  (8,  'Ammorbidente Lenor 1L',   4),
  (9,  'Bastoncini Findus 400g',  5),
  (10, 'Pizza Surgelata Buitoni',  5),
  (11, 'Patatine Lay s 150g',        6),
  (12, 'Biscotti Mulino Bianco 700g',6);

-- Magazzini
CREATE TABLE DimMagazzini (
  IDMagazzino   INT,
  NomeMagazzino VARCHAR(255) NOT NULL,
  Indirizzo     VARCHAR(255),
  CONSTRAINT PK_DimMagazzini PRIMARY KEY (IDMagazzino)
);

INSERT INTO DimMagazzini VALUES
  (1, 'Magazzino Nord Milano',  'Via Stephenson 40, Milano'),
  (2, 'Magazzino Sud Roma',     'Via Prenestina 120, Roma'),
  (3, 'Magazzino Napoli',       'Via Argine 88, Napoli');

-- Negozi - ogni negozio è associato a un magazzino
CREATE TABLE DimNegozi (
  IDNegozio   INT,
  NomeNegozio VARCHAR(255) NOT NULL,
  Indirizzo   VARCHAR(255),
  IDMagazzino INT NOT NULL,
  CONSTRAINT PK_DimNegozi     PRIMARY KEY (IDNegozio),
  CONSTRAINT FK_Neg_Mag       FOREIGN KEY (IDMagazzino)
    REFERENCES DimMagazzini (IDMagazzino)
);

INSERT INTO DimNegozi VALUES
  (1, 'VendiCose Centrale Milano', 'Corso Buenos Aires 10, Milano',   1),
  (2, 'VendiCose Loreto',          'Piazzale Loreto 5, Milano',        1),
  (3, 'VendiCose Prati',           'Via Cola di Rienzo 88, Roma',      2),
  (4, 'VendiCose Trastevere',      'Via della Lungaretta 14, Roma',    2),
  (5, 'VendiCose Chiaia',          'Via dei Mille 33, Napoli',         3);

-- Soglia di restock per categoria per magazzino. Quando le unità di una categoria scendono sotto Soglia -> nuovo ordine
CREATE TABLE DimMagazziniCategorie (
  IDMagazzino INT,
  IDCategoria INT,
  Soglia      INT NOT NULL,
  CONSTRAINT PK_MagCat        PRIMARY KEY (IDMagazzino, IDCategoria),
  CONSTRAINT FK_MagCat_Mag    FOREIGN KEY (IDMagazzino)
    REFERENCES DimMagazzini (IDMagazzino),
  CONSTRAINT FK_MagCat_Cat    FOREIGN KEY (IDCategoria)
    REFERENCES DimCategorie (IDCategoria)
);

-- ogni magazzino ha soglie diverse per categoria
INSERT INTO DimMagazziniCategorie VALUES
  (1, 1, 500),  -- Milano: alimentari soglia 500 unità
  (1, 2, 300),
  (1, 3, 150),
  (1, 4, 200),
  (1, 5, 250),
  (1, 6, 180),
  (2, 1, 400),  -- Roma: soglie un po più basse
  (2, 2, 250),
  (2, 3, 120),
  (2, 4, 160),
  (2, 5, 200),
  (2, 6, 150),
  (3, 1, 300),  -- Napoli
  (3, 2, 200),
  (3, 3, 100),
  (3, 4, 130),
  (3, 5, 150),
  (3, 6, 120);

-- Stock per prodotto per magazzino. Questa tabella si aggiorna ogni volta che avviene una vendita
CREATE TABLE StockMagazzino (
  IDMagazzino        INT,
  IDProdotto         INT,
  QuantitàDisponibile INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_Stock         PRIMARY KEY (IDMagazzino, IDProdotto),
  CONSTRAINT FK_Stock_Mag     FOREIGN KEY (IDMagazzino)
    REFERENCES DimMagazzini (IDMagazzino),
  CONSTRAINT FK_Stock_Prod    FOREIGN KEY (IDProdotto)
    REFERENCES DimProdotti (IDProdotto)
);

INSERT INTO StockMagazzino VALUES
  (1, 1,  620), (1, 2,  480), (1, 3,  310),
  (1, 4,  290), (1, 5,  140), (1, 6,  190),  
  (1, 7,  210), (1, 8,  175), (1, 9,  260),
  (1, 10, 300), (1, 11, 195), (1, 12, 410),
  (2, 1,  390), (2, 2,  260), (2, 3,  130),
  (2, 4,  240), (2, 5,  110), (2, 6,  155),
  (2, 7,  170), (2, 8,  145), (2, 9,  210),
  (2, 10, 190), (2, 11, 160), (2, 12, 280),
  (3, 1,  295), (3, 2,  185), (3, 3,  105),
  (3, 4,  200), (3, 5,   95), (3, 6,  125),  
  (3, 7,  140), (3, 8,  120), (3, 9,  155),
  (3, 10, 145), (3, 11, 130), (3, 12, 210);

-- Testata vendite - una riga per transazione (scontrino)
CREATE TABLE FactVendite (
  IDTransazione INT,
  IDNegozio     INT NOT NULL,
  DataVendita   DATE NOT NULL,
  CONSTRAINT PK_FactVendite   PRIMARY KEY (IDTransazione),
  CONSTRAINT FK_Vend_Neg      FOREIGN KEY (IDNegozio)
    REFERENCES DimNegozi (IDNegozio)
);

INSERT INTO FactVendite VALUES
  (1,  1, '2025-01-05'),
  (2,  1, '2025-01-05'),
  (3,  2, '2025-01-06'),
  (4,  2, '2025-01-07'),
  (5,  3, '2025-01-08'),
  (6,  3, '2025-01-09'),
  (7,  4, '2025-01-10'),
  (8,  4, '2025-01-10'),
  (9,  5, '2025-01-11'),
  (10, 5, '2025-01-12'),
  (11, 1, '2025-01-13'),
  (12, 2, '2025-01-14'),
  (13, 3, '2025-01-15'),
  (14, 4, '2025-01-15'),
  (15, 5, '2025-01-16');

-- Dettaglio vendite - i prodotti dentro ogni scontrino
CREATE TABLE FactDettaglioVendite (
  IDTransazione INT,
  IDProdotto    INT,
  Quantità      INT  NOT NULL,
  Prezzo        DECIMAL(10,2),
  CONSTRAINT PK_DetVendite    PRIMARY KEY (IDTransazione, IDProdotto),
  CONSTRAINT FK_DetV_Trans    FOREIGN KEY (IDTransazione)
    REFERENCES FactVendite (IDTransazione),
  CONSTRAINT FK_DetV_Prod     FOREIGN KEY (IDProdotto)
    REFERENCES DimProdotti (IDProdotto)
);

INSERT INTO FactDettaglioVendite VALUES
  (1,  1,  3, 1.39),
  (1,  3,  6, 0.49),
  (2,  4,  2, 1.79),
  (2,  11, 1, 1.99),
  (3,  2,  1, 4.99),
  (3,  7,  1, 8.90),
  (4,  5,  2, 3.50),
  (4,  6,  1, 5.20),
  (5,  9,  2, 3.80),
  (5,  10, 1, 4.50),
  (6,  1,  4, 1.39),
  (6,  12, 2, 2.80),
  (7,  3,  8, 0.49),
  (7,  4,  3, 1.79),
  (8,  8,  2, 4.20),
  (9,  11, 3, 1.99),
  (9,  6,  1, 5.20),
  (10, 2,  2, 4.99),
  (10, 1,  5, 1.39),
  (11, 9,  1, 3.80),
  (12, 7,  2, 8.90),
  (13, 5,  1, 3.50),
  (14, 12, 3, 2.80),
  (15, 10, 2, 4.50);

-- Testata ordini - quando il magazzino fa un ordine al fornitore
CREATE TABLE FactOrdini (
  IDOrdine    INT,
  IDMagazzino INT NOT NULL,
  DataOrdine  DATE NOT NULL,
  StatoOrdine VARCHAR(50),  -- es. 'In attesa', 'Spedito', 'Consegnato'
  CONSTRAINT PK_FactOrdini    PRIMARY KEY (IDOrdine),
  CONSTRAINT FK_Ord_Mag       FOREIGN KEY (IDMagazzino)
    REFERENCES DimMagazzini (IDMagazzino)
);

INSERT INTO FactOrdini VALUES
  (1, 1, '2025-01-08', 'Consegnato'),
  (2, 2, '2025-01-09', 'Consegnato'),
  (3, 3, '2025-01-10', 'Spedito'),
  (4, 1, '2025-01-14', 'In attesa');

-- Dettaglio ordini - i prodotti dentro ogni ordine
CREATE TABLE FactDettaglioOrdini (
  IDOrdine   INT,
  IDProdotto INT,
  Quantità   INT NOT NULL,
  Prezzo     DECIMAL(10,2),
  CONSTRAINT PK_DetOrdini     PRIMARY KEY (IDOrdine, IDProdotto),
  CONSTRAINT FK_DetO_Ord      FOREIGN KEY (IDOrdine)
    REFERENCES FactOrdini (IDOrdine),
  CONSTRAINT FK_DetO_Prod     FOREIGN KEY (IDProdotto)
    REFERENCES DimProdotti (IDProdotto)
);

INSERT INTO FactDettaglioOrdini VALUES
  (1, 5,  200, 2.80),  
  (1, 6,  150, 4.10),
  (2, 9,  180, 2.90),  
  (2, 10, 160, 3.50),
  (3, 5,  100, 2.80),  
  (3, 9,  120, 2.90),
  (4, 1,  300, 0.85),  
  (4, 2,  150, 3.90);