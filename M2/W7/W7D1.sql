-- W7D1 punto 1

/* Per verificare che un campo sia una chiave primaria occorre effettuare un check su due condizioni:
	a. il campo deve essere univoco (no valori duplicati)
	b. il campo non deve avere valori null */

-- verifico il punto a
SELECT 
ProductKey
, Count(ProductKey) AS Conteggio
FROM adventureworksdw2020.dimproduct
GROUP BY 
ProductKey;

-- verifico il punto b
SELECT 
ProductKey
, Count(ProductKey) AS Conteggio
FROM adventureworksdw2020.dimproduct
GROUP BY 
ProductKey
HAVING ProductKey = null;

-- in alternativa metto entrambe le condizioni in un test che mi restituisce 0 rows
SELECT 
ProductKey
, Count(ProductKey) AS Conteggio
FROM adventureworksdw2020.dimproduct
GROUP BY 
ProductKey 
HAVING Conteggio > 1 OR ProductKey = null;

/* Risultato: ProductKey vale come PK secondo tutti i test eseguiti */ 


-- W7D1 punto 2 (idem con patate) verifico condizione a
SELECT 
SalesOrderNumber
, SalesOrderLineNumber
, Count(SalesOrderNumber) AS Conteggio 
FROM adventureworksdw2020.factsales
GROUP BY 
SalesOrderNumber
, SalesOrderLineNumber;

-- verifico condizione b
SELECT 
SalesOrderNumber
, SalesOrderLineNumber
, Count(SalesOrderNumber) AS Conteggio 
FROM adventureworksdw2020.factsales
GROUP BY 
SalesOrderNumber
, SalesOrderLineNumber
HAVING SalesOrderNumber = null OR SalesOrderLineNumber = null;

-- test per condizione a + b
SELECT 
SalesOrderNumber
, SalesOrderLineNumber
, Count(SalesOrderNumber) AS Conteggio 
FROM adventureworksdw2020.factsales
GROUP BY 
SalesOrderNumber
, SalesOrderLineNumber
HAVING Conteggio > 1 OR SalesOrderNumber = null OR SalesOrderLineNumber = null;

/* Risultato: La combinazione di SalesOrderNumber e SalesOrderLineNumber vale come PK secondo tutti i test eseguiti */ 



-- W7D1 punto 3
SELECT 
OrderDate
, Count(SalesOrderLineNumber) AS 'Conteggio Transazioni'
FROM adventureworksdw2020.factsales
WHERE OrderDate > '2020-01-01'
GROUP BY 
OrderDate;



-- W7D1 punto 4
SELECT 
ProductKey
, SUM(SalesAmount) AS 'Fatturato Totale'
, SUM(OrderQuantity) AS 'Quantità Totale Venduta'
, AVG(UnitPrice) AS 'Prezzo Medio di Vendita'
FROM adventureworksdw2020.factresellersales
WHERE OrderDate > '2020-01-01'
GROUP BY 
ProductKey
ORDER BY ProductKey;



-- W7D1 punto 5
SELECT 
C.EnglishProductCategoryName
, SUM(SalesAmount) AS 'Fatturato Totale'
, SUM(OrderQuantity) AS 'Quantità Totale Venduta'
FROM
	adventureworksdw2020.factresellersales AS S
 INNER JOIN
	adventureworksdw2020.dimproduct AS P
    ON
    P.ProductKey = S.ProductKey
 INNER JOIN
	adventureworksdw2020.dimproductsubcategory AS SC
    ON
    P.ProductSubcategoryKey = SC.ProductSubcategoryKey  
 INNER JOIN
	adventureworksdw2020.dimproductcategory AS C
    ON
    SC.ProductcategoryKey = C.ProductcategoryKey
GROUP BY 
C.EnglishProductCategoryName;

-- W7D1 punto 6
SELECT 
G.City
, SUM(SalesAmount) AS FatturatoTotale
	FROM
	adventureworksdw2020.factresellersales AS S
    LEFT JOIN
	dimreseller AS R
	ON S.ResellerKey = R.ResellerKey
	INNER JOIN
	dimgeography AS G
	ON G.GeographyKey = R.GeographyKey
WHERE OrderDate > '2020-01-01'
GROUP BY 
G.City
HAVING FatturatoTotale > 60000
ORDER BY FatturatoTotale;