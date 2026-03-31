-- Intro: il presente TAB SQL non va eseguito in blocco, ma di volta in volta vanno eseguiti i singoli punti dell'esercizio. 

-- W6D4 Punto 1
SELECT 
    C.EnglishProductSubcategoryName AS NomeSottoCategoria
    , P.EnglishProductName AS NomeProdotto
FROM 
    adventureworksdw2020.dimproduct AS P
LEFT JOIN
    adventureworksdw2020.dimproductsubcategory AS C
    ON 
    P.ProductSubcategoryKey = C.ProductSubcategoryKey;

-- W6D4 Punto 1 Prova Subquery
-- (Non mi sembra si possa fare con Subquery in quanto non c'è la possibilità di fare select della colonna NomeSottoProdotto, di seguito un tentativo fatto)
/* SELECT 
    EnglishProductName AS NomeProdotto
, (SELECT EnglishProductSubcategoryName FROM adventureworksdw2020.dimproductsubcategory)
FROM 
    adventureworksdw2020.dimproduct
WHERE 
    ProductSubcategoryKey in
    (SELECT ProductSubcategoryKey FROM dimproductsubcategory 
    );
 */   
    
-- W6D4 Punto 2
SELECT 
	C.EnglishProductCategoryName AS NomeCategoria
    , SC.EnglishProductSubcategoryName AS NomeSottoCategoria
    , P.EnglishProductName AS NomeProdotto
FROM 
    adventureworksdw2020.dimproduct AS P
LEFT JOIN
    adventureworksdw2020.dimproductsubcategory AS SC
    ON 
    P.ProductSubcategoryKey = SC.ProductSubcategoryKey
LEFT JOIN
    adventureworksdw2020.dimproductcategory AS C
    ON 
    SC.ProductcategoryKey = C.ProductcategoryKey;
    
-- W6D4 Punto 3
SELECT DISTINCT
P.EnglishProductName
FROM
	adventureworksdw2020.factresellersales AS S
 INNER JOIN
	adventureworksdw2020.dimproduct AS P
    ON
    P.ProductKey = S.ProductKey;
 
-- W6D4 Punto 3 con subquery
SELECT DISTINCT
EnglishProductName
FROM
	adventureworksdw2020.dimproduct 
 WHERE ProductKey IN 
					(SELECT ProductKey
					FROM adventureworksdw2020.factresellersales);

-- W6D4 Punto 4
SELECT DISTINCT
EnglishProductName
FROM
	adventureworksdw2020.dimproduct 
 WHERE FinishedGoodsFlag = 1;

 
-- W6D4 Punto 5 
SELECT 
S.*
, P.EnglishProductName
FROM
	adventureworksdw2020.factresellersales AS S
 INNER JOIN
	adventureworksdw2020.dimproduct AS P
    ON
    P.ProductKey = S.ProductKey;
    
-- W6D4 Punto 6
SELECT 
S.*
, C.EnglishProductCategoryName
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
    SC.ProductcategoryKey = C.ProductcategoryKey;

-- W6D4 Punto 7, 8   
SELECT 
R.*
, G.EnglishCountryRegionName
FROM DimReseller AS R
LEFT JOIN dimgeography AS G
ON R.GeographyKey = G.GeographyKey;


-- W6D4 Punto 9
SELECT
 S.SalesOrderNumber
 , S.SalesOrderLineNumber
 , S.OrderDate
 , S.UnitPrice
 , S.OrderQuantity
 , S.TotalProductCost
 , P.EnglishProductName
 , R.ResellerName
 , C.EnglishProductCategoryName
 , G.EnglishCountryRegionName
 FROM
 factsales AS S
LEFT JOIN 
dimproduct AS P
ON S.ProductKey = P.ProductKey
LEFT JOIN 
factresellersales AS RS
ON RS.ProductKey = P.ProductKey
INNER JOIN
dimreseller AS R
ON R.ResellerKey = R.ResellerKey
INNER JOIN
dimgeography AS G
ON R.GeographyKey = G.GeographyKey
INNER JOIN
dimproductsubcategory AS SC
ON
P.ProductSubcategoryKey = SC.ProductSubcategoryKey  
INNER JOIN
adventureworksdw2020.dimproductcategory AS C
ON
SC.ProductcategoryKey = C.ProductcategoryKey
