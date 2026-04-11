-- W8D1 punto 2 + 3
CREATE TABLE Region (
  IDRegion      INT,
  AreaGeografica VARCHAR(255),
  Regione       VARCHAR(255),
  Provincia     VARCHAR(255),
  Città         VARCHAR(255),
  CAP           VARCHAR(255),
  CONSTRAINT PK_Region PRIMARY KEY (IDRegion)
);

INSERT INTO Region
VALUES
  (1,  'Nord-Ovest', 'Lombardia',       'Milano',          'Milano',          '20121'),
  (2,  'Nord-Ovest', 'Piemonte',         'Torino',           'Torino',           '10121'),
  (3,  'Nord-Est',  'Veneto',           'Venezia',          'Venezia',          '30121'),
  (4,  'Nord-Est',  'Emilia-Romagna',   'Bologna',          'Bologna',          '40121'),
  (5,  'Nord-Est',  'Friuli-Venezia G.', 'Trieste',          'Trieste',          '34121'),
  (6,  'Centro',    'Toscana',          'Firenze',          'Firenze',          '50121'),
  (7,  'Centro',    'Lazio',            'Roma',             'Roma',             '00100'),
  (8,  'Sud',       'Campania',         'Napoli',           'Napoli',           '80121'),
  (9,  'Sud',       'Puglia',           'Bari',             'Bari',             '70121'),
  (10, 'Isole',     'Sicilia',          'Palermo',          'Palermo',          '90121');


-- W8D1 punto 1 + 3
CREATE TABLE Store (
  IDStore     INT,
  NomeStore   VARCHAR(255),
  DataApertura DATE,
  OwnerStore  VARCHAR(255),
  Email       VARCHAR(255),
  Telefono    VARCHAR(25),
  Indirizzo   VARCHAR(255),
  MetriQuadri INT,
  IDRegion    INT,
  CONSTRAINT PK_Store  PRIMARY KEY (IDStore),
  CONSTRAINT FK_Region FOREIGN KEY (IDRegion)
    REFERENCES Region (IDRegion)
);

INSERT INTO Store
VALUES
  (1,  'Store Milano Centro',   '2018-03-15', 'Marco Ferretti',    'milano.centro@brand.it',   '+39 02 1234567',  'Via Torino 12, Milano',           320, 1),
  (2,  'Store Milano Navigli',  '2020-06-01', 'Laura Bianchi',     'milano.navigli@brand.it',  '+39 02 7654321',  'Via Corsico 5, Milano',           210, 1),
  (3,  'Store Torino',          '2019-09-20', 'Alessandro Russo',  'torino@brand.it',          '+39 011 9876543', 'Corso Vittorio Em. 88, Torino',   280, 2),
  (4,  'Store Venezia',         '2021-04-10', 'Chiara Moretti',    'venezia@brand.it',         '+39 041 5551234', 'Campo San Polo 142, Venezia',     150, 3),
  (5,  'Store Bologna',         '2017-11-05', 'Giovanni Ricci',    'bologna@brand.it',         '+39 051 3334455', 'Via Indipendenza 34, Bologna',    350, 4),
  (6,  'Store Trieste',         '2022-02-14', 'Elena Conti',       'trieste@brand.it',         '+39 040 6667788', 'Piazza Unità d\'Italia 3, Trieste',180, 5),
  (7,  'Store Firenze',         '2016-07-22', 'Stefano Martini',   'firenze@brand.it',         '+39 055 2223344', 'Via dei Calzaiuoli 20, Firenze',  300, 6),
  (8,  'Store Roma',            '2015-01-30', 'Valentina Esposito','roma@brand.it',             '+39 06 8889900',  'Via del Corso 77, Roma',          420, 7),
  (9,  'Store Napoli',          '2023-05-18', 'Francesco De Luca', 'napoli@brand.it',          '+39 081 4445566', 'Via Toledo 180, Napoli',          260, 8),
  (10, 'Store Palermo',         '2022-10-03', 'Maria Lombardo',    'palermo@brand.it',         '+39 091 1112233', 'Via Maqueda 92, Palermo',         230, 10);



-- W8D1 punto 4

-- Un paio di operazioni di UPDATE
UPDATE Store
SET OwnerStore = 'Francesco De Luca'
WHERE IDStore = 8;

UPDATE Store
SET OwnerStore = 'Valentina Esposito'
WHERE IDStore = 9;

-- Aggiungo una riga per poi eliminarla
INSERT INTO Store
VALUES
(11, 'Store Sbagliato',         '2020-02-20', 'Peppe',    'palermo@brand.it',         '+39 011 1111111', 'Via NessunaParte 1, Campobasso',         1, 1);

-- Transazione con UPDATE e ROLLBACK
START TRANSACTION;

SELECT * 
FROM Store;

UPDATE Store
SET OwnerStore = 'Gennaro'
WHERE IDStore = 5;

SELECT * 
FROM Store;

ROLLBACK;

-- Transazione finale per eliminare la riga 11
START TRANSACTION;

SELECT * 
FROM Store;

DELETE FROM Store
WHERE IDStore = 11;

COMMIT;

SELECT * 
FROM Store;
