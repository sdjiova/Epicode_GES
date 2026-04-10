-- W7D4 punto 1 
CREATE VIEW Product
AS (
SELECT 
	P.EnglishProductName AS NomeProdotto
    , SC.EnglishProductSubcategoryName AS NomeSottoCategoria
    , C.EnglishProductCategoryName AS NomeCategoria

FROM 
    adventureworksdw2020.dimproduct AS P
LEFT JOIN
    adventureworksdw2020.dimproductsubcategory AS SC
    ON 
    P.ProductSubcategoryKey = SC.ProductSubcategoryKey
LEFT JOIN
    adventureworksdw2020.dimproductcategory AS C
    ON 
    SC.ProductcategoryKey = C.ProductcategoryKey
    );
    
    
-- W7D4 punto 2 
CREATE VIEW Reseller
AS (
SELECT
	R.ResellerName AS NomeReseller
 , G.City AS Città
 , G.EnglishCountryRegionName AS NomeRegione
 FROM 
dimreseller AS R
INNER JOIN
dimgeography AS G
ON R.GeographyKey = G.GeographyKey
    );
    
    
-- W7D4 punto 3
CREATE VIEW Sales
AS (
SELECT
OrderDate AS DataOrdine
, SalesOrderNumber AS CodiceDocumento
, SalesOrderLineNumber AS  RigaCorpoDocumento
, Orderquantity  AS QuantitàVenduta
, SalesAmount AS ImportoTotale
, SalesAmount - TotalProductCost AS Profitto
 FROM 
factsales
    );
    