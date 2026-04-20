-- ================================================
-- Query operative - VendiCose SpA
-- ================================================


-- PUNTO 1: aggiornamento stock quando avviene una vendita
-- --------------------------------------------------------
-- Scenario: nel negozio 1 viene venduta 1 unità del prodotto 1 (Pasta Barilla)
-- Il negozio 1 è servito dal magazzino 1, quindi scalo lo stock da magazzino 1


-- tutto dentro una transazione: se qualcosa va storto si annulla tutto
START TRANSACTION;

-- prima inserisco la vendita nella testata
INSERT INTO FactVendite (IDTransazione, IDNegozio, DataVendita)
VALUES (16, 1, '2025-01-17');

-- poi il dettaglio - es. 2 paste e 1 coca cola
INSERT INTO FactDettaglioVendite (IDTransazione, IDProdotto, Quantità, Prezzo)
VALUES 
  (16, 1, 2, 1.39),
  (16, 4, 1, 1.79);

SELECT * FROM StockMagazzino; -- anteprima stockmagazzino

-- aggiorno lo stock scalando le quantità vendute
-- il magazzino lo ricavo dal negozio tramite subquery
UPDATE StockMagazzino
SET QuantitàDisponibile = QuantitàDisponibile - (
    SELECT Quantità 
    FROM FactDettaglioVendite 
    WHERE IDTransazione = 16 
      AND IDProdotto = 1
)
WHERE IDMagazzino = (SELECT IDMagazzino FROM DimNegozi WHERE IDNegozio = 1)
  AND IDProdotto = 1;

UPDATE StockMagazzino
SET QuantitàDisponibile = QuantitàDisponibile - (
    SELECT Quantità 
    FROM FactDettaglioVendite 
    WHERE IDTransazione = 16 
      AND IDProdotto = 4
)
WHERE IDMagazzino = (SELECT IDMagazzino FROM DimNegozi WHERE IDNegozio = 1)
  AND IDProdotto = 4;

SELECT * FROM StockMagazzino; -- verifica stockmagazzino dopo update

-- se tutto ok si committa, altrimenti fare ROLLBACK
COMMIT;

SELECT * FROM StockMagazzino; -- verifica stockmagazzino dopo COMMIT


-- PUNTO 2a: quante unità ci sono di un prodotto in un dato magazzino?
-- -------------------------------------------------------------------
-- esempio: quanto stock ho del prodotto 'Pasta Barilla' nel magazzino di Milano?

SELECT 
  M.NomeMagazzino
, P.NomeProdotto
, S.QuantitàDisponibile
FROM StockMagazzino AS S
INNER JOIN DimMagazzini AS M
  ON S.IDMagazzino = M.IDMagazzino
INNER JOIN DimProdotti AS P
  ON S.IDProdotto = P.IDProdotto
WHERE S.IDMagazzino = 1
  AND S.IDProdotto = 1;


-- PUNTO 2b: monitoraggio soglie di restock
-- -----------------------------------------
-- voglio vedere tutti i prodotti che sono SOTTO SOGLIA
-- la soglia è per categoria, quindi devo joinare StockMagazzino con DimProdotti (per avere la categoria) e con DimMagazziniCategorie (per avere la soglia)

SELECT
  M.NomeMagazzino
, P.NomeProdotto
, C.NomeCategoria
, S.QuantitàDisponibile
, MC.Soglia
, S.QuantitàDisponibile - MC.Soglia AS DifferenzaSoglia
FROM StockMagazzino AS S
INNER JOIN DimMagazzini AS M
  ON S.IDMagazzino = M.IDMagazzino
INNER JOIN DimProdotti AS P
  ON S.IDProdotto = P.IDProdotto
INNER JOIN DimCategorie AS C
  ON P.IDCategoria = C.IDCategoria
INNER JOIN DimMagazziniCategorie AS MC
  ON S.IDMagazzino = MC.IDMagazzino
  AND P.IDCategoria = MC.IDCategoria
WHERE S.QuantitàDisponibile < MC.Soglia
ORDER BY M.NomeMagazzino, DifferenzaSoglia;


/*
-- ================================================
-- PUNTO EXTRA - Creazione automatica ordini
-- ================================================

-- logica quantità da ordinare:
-- se mancano meno di 100 unità alla soglia -> ordina 100
-- se mancano tra 100 e 200 -> ordina 200
-- se mancano più di 200 -> ordina 300

START TRANSACTION;

-- creo la testata ordine per il magazzino 1 (esempio magazzino Milano)
INSERT INTO FactOrdini (IDOrdine, IDMagazzino, DataOrdine, StatoOrdine)
VALUES (5, 1, CURDATE(), 'In attesa');

SELECT * FROM FactDettaglioOrdini;

-- inserisco il dettaglio ordine per tutti i prodotti del magazzino 1 sotto soglia
INSERT INTO FactDettaglioOrdini (IDOrdine, IDProdotto, Quantità, Prezzo)
SELECT 
  5 AS IDOrdine
, S.IDProdotto
, CASE 
    WHEN (MC.Soglia - S.QuantitàDisponibile) < 100  THEN 100
    WHEN (MC.Soglia - S.QuantitàDisponibile) < 200  THEN 200
    ELSE 300
  END                      AS Quantità
, NULL                     AS Prezzo  -- il prezzo lo definirà il fornitore
FROM StockMagazzino AS S
INNER JOIN DimProdotti AS P
  ON S.IDProdotto = P.IDProdotto
INNER JOIN DimMagazziniCategorie AS MC
  ON S.IDMagazzino = MC.IDMagazzino
  AND P.IDCategoria = MC.IDCategoria
WHERE S.IDMagazzino = 1
  AND S.QuantitàDisponibile < MC.Soglia;

SELECT * FROM FactDettaglioOrdini;

ROLLBACK;


-- dopo il commit puoi verificare che l'ordine sia stato creato correttamente
SELECT 
  O.IDOrdine
, O.DataOrdine
, O.StatoOrdine
, P.NomeProdotto
, C.NomeCategoria
, S.QuantitàDisponibile  AS StockAttuale
, MC.Soglia
, D.Quantità             AS QuantitàOrdinata
FROM FactOrdini AS O
INNER JOIN FactDettaglioOrdini AS D
  ON O.IDOrdine = D.IDOrdine
INNER JOIN DimProdotti AS P
  ON D.IDProdotto = P.IDProdotto
INNER JOIN DimCategorie AS C
  ON P.IDCategoria = C.IDCategoria
INNER JOIN StockMagazzino AS S
  ON D.IDProdotto = S.IDProdotto
  AND O.IDMagazzino = S.IDMagazzino
INNER JOIN DimMagazziniCategorie AS MC
  ON O.IDMagazzino = MC.IDMagazzino
  AND P.IDCategoria = MC.IDCategoria
WHERE O.IDOrdine = 5;

*/