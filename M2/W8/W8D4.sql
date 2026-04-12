/* 
Questions

	1.  Il database è una collezione di dati organizzata in modo logico e coerente, ottimizzata per le operazioni CRUD. 
		Un Database contiene dati strutturati ovvero organizzati in formato tabellare, suddivisi in righe e colonne. 
        In altre parole sono dati inseriti in una struttura modellizzata, logica e coerente. 
        Al contrario i dati non strutturati, che non hanno una struttura predefinita sono collezionati in data lake.
	
    2.  Un Database Management System è un sistema software che consente le operazioni CRUD, ovvero è progettato per svolgere le funzioni di creazione, lettura, modifica, eliminazione dei dati.
		Tipicamente i database sono relazionali ovvero seguono un modello logico di organizzazione dei dati in tabelle (entità) collegate fra loro tramite relazioni. 
        Si parla in questo caso di Relational Database Management System.
        
	3. Lo statement SELECT segue il seguente ordine di esecuzione logica:
		1. FROM - Definisce l'orgine ovvero quale tabella/e interrogare 
        2. WHERE - Definisce la condizione per filtrare le righe da restituire all'interno della tabella di origine
        3. GROUP BY - Definisce la condizione per raggruppare i record secondo ogni combinazione univoca di valori
        4. HAVING -  Definisce la condizione per filtrare le righe da restituire dopo l'aggregazione fatta con GROUP BY
        5. SELECT - Definisce quali campi (colonne) devono essere restituiti nell'output della query
        6. ORDER BY - Definisce la condizione per ordinare i dati in senso ascendente o discendente 
	
    4.  Il GROUP BY non è altro che la tabella Pivot in Excel. Concetto molto familiare a qualsiasi colletto bianco e la base per qualsiasi analisi dati. 
		Se ad esempio ho un DB che contiene dati finanziari di una banca in termini di crediti/investimenti, vogliamo fare analisi sull'andamento economico della banca oppure analisi di marketing su come stanno andando determinati prodotti venduti dalla banca. 
        Dalle tabelle che potranno contenere innumerevoli righe per transazioni o per regioni o per clienti ecc. dovrò fare dei GROUP BY che aggregano i dati in modo sintentico facendo operazioni di Somma, Media, Min, Max ecc. per restituire delle viste parlanti per prodotto, settore, cliente. 
        Se non avessi la possibilità di aggregare sarebbe molto difficile capirci qualcosa avendo migliaia di righe. 
        Un altro esempio classico è il lavoro del Controllo di Gestione sui dati budget, consuntivo, forecast di un azienda. Per avere questi dati in formato utile in senso di business intelligence alla base ci dovranno essere delle aggregazioni che in SQL si fanno tramite GROUP BY.
       
	5.  OLTP - OnLine Transactional Processing. Tipici per la gestione e la scrittura dei dati. Obiettivo è garantire coerenza, integrità e sicurezza (secondo lo schema ACID) delle transazioni.
		OLAP - OnLine Analytical Processing. Tipici per l'analisi complessa di grandi quanità di dati. Obiettivo è una riorganizzazione di dati esistenti ottimizzata per l'analisi dei dati a supporto della BI.
        Differenze: Visto che non è possibile avere massime performance contemporaneamente nella scrittura/modifica/eliminazione e nella lettura/analisi, OLTP spinge sulla prima mentre OLAP sulla seconda.
	
    6.  JOIN       -  Combina i record di due tabelle. A parte il CROSS JOIN che fa il prodotto cartesiano, negli altri casi si basa sulla corrispondenza di un campo in comume. 
					 Il risultato è una nuova tabella che combina colonne tra le due tabelle. 
		SUBQUERY   -  Una query innestata dentro un'altra query. Serve tipicamente per dare delle condizioni o dei valori che devono essere prima calcolati tramite una seconda query (che viene esequita prima come input della seconda). 
					 Si può anche fare una SUBQUERY che calcola uno o più valori da una seconda tabella. In questo caso possiamo avere una sovrapposizione tra SUBQUERY e JOIN.
		DIFFERENZE - Se mi occorre come output una tabella che aggreghi record da due o più tabelle devo fare per forza JOIN. 
					 Se invece i record delle altre tabelle mi servono più come condizione per un filtro o come valore calcolato da confrontare utilizzero SUBQUERY 
        
	7.  DML - Data Manipulation Language. Linguaggio SQL che serve per gestire i dati all'interno delle tabelle preesistenti.
		DDL - Data Definition Language. Linguaggio SQL che serve per definire, modificare o eliminare gli oggetti del database. 
        
	8.  Per estrarre l'anno da un campo data si usa la funzione YEAR.
		Esempio preso dall'esercizio W8D1 in cui ho costruito due tabelle. Nella tabella Store è presente l'anagrafica di alcuni negozi, che include il campo DataApertura espresso come DATE. 
        Se volessi aggiungere la colonna 'Anno' dovrei scrivere le seguenti istruzioni:
        SELECT 
		*
		, YEAR(DataApertura) AS AnnoApertura
		FROM Store;
        
	9.  AND - Richiede che siano vere entrambe le condizioni
		OR - Richiede che sia vera almeno una delle due condizioni
        Dal mio libro di matematica del liceo (Zwirner, Scaglianti):
        In logica matematica AND sarebbe l'operazione di congiunzione logica ovvero il connettivo che ad ogni coppia di proposizioni (p, q), 
        associa la proposizione composta p ∧ b, vera se p e q sono entrambe vere, falsa negli altri casi.
        Tabella di verità della congiunzione logica
		|-------|-------|-------|
		|   p   |   q   | p ∧ q |
		|-------|-------|-------|
		|   V   |   V   |   V   |
		|   V   |   F   |   F   |
		|   F   |   V   |   F   |
		|   F   |   F   |   F   |
		|-------|-------|-------|
        Invece OR sarebbe la disgiunzione logica inclusiva ovvero il connettivo che ad ogni coppia di proposizioni (p, q), 
        associa la proposizione composta p ∨ b, vera se almeno una delle due proposizioni p e q è vera, falsa se p e q sono entrambe false.
		Tabella di verità della disgiunzione logica inclusiva
		|-------|-------|-------|
		|   p   |   q   | p ∨ q |
		|-------|-------|-------|
		|   V   |   V   |   V   |
		|   V   |   F   |   V   |
		|   F   |   V   |   V   |
		|   F   |   F   |   F   |
		|-------|-------|-------|
        
	10. Facciamo una prova: voglio una query che aggiunga una colonna 'ValoreMedioMQ' a fianco alla colonna 'MetriQuadri'. 
		Per farlo utilizzo una SUBQUERY
				SELECT 
				IDStore
				, Nomestore
				, MetriQuadri
				, (SELECT AVG(MetriQuadri) FROM Store) AS ValoreMedioMQ
				FROM Store 
		Funziona. Si può fare!
	
    11. OR - Richiede che sia vera almeno una delle due condizioni. Disgiunzione logica inclusiva rispetto a due espressioni booleane. 
		IN - Richiede che sia vera almeno una delle espressioni elencate. A livello logico fa la stessa cosa di OR ma più volte, è come se fossero tanti OR. E' il filtro di excel. 
	
    12. Si include anche gli estremi del range specificato. Esempio:
				SELECT 
				IDStore
				, Nomestore
				, MetriQuadri
				, (SELECT AVG(MetriQuadri) FROM Store) AS ValoreMedioMQ
				FROM Store 
				WHERE MetriQuadri BETWEEN 210 AND 320
		Restituisce anche 210 e 320.
*/ 

SELECT 
IDStore
, Nomestore
, MetriQuadri
, (SELECT AVG(MetriQuadri) FROM Store) AS ValoreMedioMQ
FROM Store 
WHERE MetriQuadri BETWEEN 210 AND 320;

-- Task 1 -> Vedi file PDF W8D4 con il Diagramma Entità Relazione

-- Task 2 + 3
CREATE DATABASE ToysGroup;

CREATE TABLE DimCategoria (
  IDCategoria INT
  , NomeCategoria VARCHAR(255) NOT NULL
  , CONSTRAINT PK_DimCategoria PRIMARY KEY (IDCategoria)
);

INSERT INTO DimCategoria
VALUES
  (1, 'Action Figures')
  , (2, 'Bambole e Accessori')
  , (3, 'Veicoli e Radiocomandati')
  , (4, 'Giochi da Tavolo');

CREATE TABLE DimProdotto (
  IDProdotto    INT
  , IDCategoria   INT NOT NULL
  , NomeProdotto  VARCHAR(255) NOT NULL
  , PrezzoListino DECIMAL(10,2)
  , CostoStandard DECIMAL(10,2)
  , Peso DECIMAL(10,3)
  , DataInizio DATE
  , DataFine DATE
  , CONSTRAINT PK_DimProdotto PRIMARY KEY (IDProdotto)
  , CONSTRAINT FK_Prod_Cat FOREIGN KEY (IDCategoria)
    REFERENCES DimCategoria (IDCategoria)
);

INSERT INTO DimProdotto
VALUES
  (1, 1, 'Gormiti Serie Natura', 24.99, 10.50, 0.280, '2020-01-15', NULL)
  , (2, 1, 'Gormiti Serie Fuoco',  29.99, 12.00, 0.320, '2021-03-01', NULL)
  , (3, 2, 'Principessa Sissi Deluxe', 34.99, 14.00, 0.450, '2019-09-10', NULL)
  , (4, 2, 'Baby Born Accessori Set', 19.99, 8.50, 0.200, '2022-06-01', NULL)
  , (5, 3, 'Radiocomandato Turbo Racer', 49.99, 22.00, 0.750, '2021-11-01', NULL)
  , (6, 4, 'Scarabeo Junior', 21.99, 9.00, 0.600, '2018-04-20', '2023-12-31')
  ,  (7, 3, 'Drone Esploratore Pro',   59.99, 28.00, 0.420, '2024-01-01', NULL)
 ,  (8, 4, 'Monopoly Edizione Italia', 27.99, 11.00, 0.850, '2023-06-15', NULL);
 
 
  
CREATE TABLE DimRegione (
  IDRegione   INT
  , NomeRegione VARCHAR(255) NOT NULL
  , CONSTRAINT PK_DimRegione PRIMARY KEY (IDRegione)
);

INSERT INTO DimRegione
VALUES
  (1, 'Nord Italia')
  , (2, 'Centro Italia')
  , (3, 'Sud Italia')
  , (4, 'Europa Occidentale')
  , (5, 'Europa Orientale');

CREATE TABLE DimPaese (
  IDPaese INT
  , NomePaese VARCHAR(255) NOT NULL
  , IDRegione INT
  , CONSTRAINT PK_DimPaese PRIMARY KEY (IDPaese)
  , CONSTRAINT FK_Paese_Reg FOREIGN KEY (IDRegione)
    REFERENCES DimRegione (IDRegione)
);

INSERT INTO DimPaese 
VALUES
  (1, 'Lombardia', 1)
  , (2, 'Veneto', 1)
  , (3, 'Piemonte', 1)
  , (4, 'Toscana', 2)
  , (5, 'Lazio',  2)
  , (6, 'Campania', 3)
  , (7, 'Francia', 4)
  , (8, 'Polonia', 5);

CREATE TABLE FactTransazioni (
  IDOrdine INT
  , IDProdotto INT
  , IDPaese  INT
  , DataOrdine DATE NOT NULL
  , DataSpedizione DATE
  , QuantitàOrdine INT
  , PrezzoVendita DECIMAL(10,2)
  , Ricavi DECIMAL(10,2)
  , CONSTRAINT PK_FactTransazioni PRIMARY KEY (IDOrdine)
  , CONSTRAINT FK_Fact_Prod FOREIGN KEY (IDProdotto)
    REFERENCES DimProdotto (IDProdotto)
  , CONSTRAINT FK_Fact_Paese FOREIGN KEY (IDPaese)
    REFERENCES DimPaese (IDPaese)
);

INSERT INTO FactTransazioni
VALUES
  (1, 1, 1, '2024-01-10', '2024-01-13', 50, 24.99, 1249.50)
  , (2, 2, 1, '2024-02-14', '2024-02-17', 30, 29.99,  899.70)
  , (3, 3, 2, '2024-03-05', '2024-03-08', 20, 34.99,  699.80)
  , (4, 4, 3, '2025-04-22', '2025-04-25', 40, 19.99,  799.60)
  , (5, 5, 4, '2025-05-18', '2025-05-22', 15, 49.99,  749.85)
 ,  (6, 1, 5, '2025-06-30', '2025-07-04', 60, 24.99, 1499.40)
  , (7, 6, 5, '2025-07-11', '2025-07-15', 25, 21.99,  549.75)
  , (8, 3, 6, '2025-09-03', '2025-09-07', 10, 34.99,  349.90)
 ,  (9, 2, 7, '2025-10-20', '2025-10-24', 35, 29.99, 1049.65)
  , (10, 5, 8, '2025-11-28', '2025-12-02', 22, 49.99, 1099.78);
  

-- Task 4 punto 1
/* Per verificare che un campo sia una chiave primaria occorre effettuare un check su due condizioni:
	a. il campo deve essere univoco (no valori duplicati)
	b. il campo non deve avere valori null */

/* Test per DimCategoria */
SELECT 
IDCategoria
, Count(IDCategoria) AS TestCategoria
FROM dimcategoria
GROUP BY 
IDCategoria
HAVING TestCategoria > 1 OR IDCategoria IS NULL;

/* Test per DimProdotto */
SELECT 
  IDProdotto
, COUNT(IDProdotto) AS TestProdotto
FROM DimProdotto
GROUP BY IDProdotto
HAVING TestProdotto > 1
    OR IDProdotto IS NULL;
    
/* Test per DimRegione */ 
SELECT 
  IDRegione
, COUNT(IDRegione) AS TestRegione
FROM DimRegione
GROUP BY IDRegione
HAVING TestRegione > 1
    OR IDRegione IS NULL;

/* Test per DimPaese */ 
SELECT 
  IDPaese
, COUNT(IDPaese) AS TestPaese
FROM DimPaese
GROUP BY IDPaese
HAVING TestPaese > 1
    OR IDPaese IS NULL;

/* Test per FactTransazioni */  
SELECT 
  IDOrdine
, COUNT(IDOrdine) AS TestOrdine
FROM FactTransazioni
GROUP BY IDOrdine
HAVING TestOrdine > 1
    OR IDOrdine IS NULL;
    
    
    

-- Task 4 punto 2
SELECT 
T.IDOrdine
, P.NomeProdotto
, T.DataOrdine
, C.NomeCategoria
, PA.NomePaese
, R.NomeRegione
, IF (DATEDIFF(CURRENT_DATE(), DataOrdine) > 180, 'VERO', 'FALSO') AS OrdineVecchio
FROM facttransazioni AS T
LEFT JOIN dimprodotto AS P
ON T.IDProdotto = P.IDProdotto
INNER JOIN dimcategoria AS C
ON P.IDCategoria = C.IDCategoria
LEFT JOIN  dimpaese AS PA
ON T.IDPaese = PA.IDPaese
INNER JOIN dimregione AS R
ON PA.IDRegione = R.IDRegione
ORDER BY DataOrdine;



-- Task 4 punto 3
SELECT 
IDProdotto
, SUM(QuantitàOrdine) AS QuantitàTotaleVenduta
FROM facttransazioni
WHERE YEAR (DataOrdine) = '2025'
GROUP BY IDProdotto 
HAVING QuantitàTotaleVenduta > (SELECT 
								AVG(QuantitàOrdine) 
								FROM facttransazioni);
                                
                                
-- Task 4 punto 4
sELECT 
P.IDProdotto
, P.NomeProdotto
, YEAR(T.DataOrdine) AS Anno
, SUM(T.Ricavi) AS FatturatoTotale
FROM dimprodotto AS P 
INNER JOIN facttransazioni AS T
ON T.IDProdotto = P.IDProdotto
GROUP BY 
P.IDProdotto
, Anno
HAVING FatturatoTotale <> 0;


-- Task 4 punto 5
sELECT 
PA.NomePaese
, YEAR(T.DataOrdine) AS Anno
, SUM(T.Ricavi) AS FatturatoTotale
FROM dimpaese AS PA 
INNER JOIN facttransazioni AS T
ON T.IDPaese = PA.IDPaese
GROUP BY 
PA.IDPaese,
Anno
ORDER BY 
Anno ASC
, FatturatoTotale DESC;


-- Task 4 punto 6
/* Per verificare qual è la categoria maggiormente richiesta dal mercato, effettuiamo una query che aggrega le vendite totali di ciascuna categoria. Restituiamo il risultato in ordine discendente di vendite.*/
sELECT 
C.NomeCategoria
, SUM(T.QuantitàOrdine) AS VenditeTotali
FROM dimcategoria AS C 
INNER JOIN dimprodotto AS P
ON C.IDCategoria = P.IDCategoria
INNER JOIN facttransazioni AS T
ON P.IDProdotto = T.IDProdotto	
GROUP BY 
c.IDCategoria
ORDER BY VenditeTotali DESC;

/* La categoria più richiesta dal mercato è la 'Action Figures', a seguire 'Bambole e Accessori, 'Veicoli e Radiocomandati', mentre i 'Giochi da Tavolo' sono i meno richesti.*/



-- Task 4 punto 7 
/* opzione a usando JOIN */
SELECT 
  P.IDProdotto
, P.NomeProdotto
FROM DimProdotto AS P
LEFT JOIN FactTransazioni AS T
  ON P.IDProdotto = T.IDProdotto
WHERE T.IDProdotto IS NULL;

/* opzione B usando SUBQUERY */
SELECT 
IDProdotto
, NomeProdotto
FROM DimProdotto 
WHERE IDProdotto NOT IN (
    SELECT IDProdotto 
    FROM FactTransazioni);
    

-- Task 4 punto 8
CREATE VIEW VistaProdotti AS (
SELECT
  P.IDProdotto
, P.NomeProdotto
, C.NomeCategoria
FROM DimProdotto AS P
INNER JOIN DimCategoria AS C
  ON P.IDCategoria = C.IDCategoria);

-- Task 4 punto 9
CREATE VIEW VistaGeografia AS (
SELECT
  PA.IDPaese
, PA.NomePaese
, R.IDRegione
, R.NomeRegione
FROM DimPaese AS PA
INNER JOIN DimRegione AS R
  ON PA.IDRegione = R.IDRegione);