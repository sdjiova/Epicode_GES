-- W6D1 Punti 1, 2, 3, 4
SELECT ProductKey AS ChiaveProdotto, ProductAlternateKey AS ChiaveProdottoAlternativa, EnglishProductName AS NomeProdotto, Color AS Colore, StandardCost, FinishedGoodsFlag AS ProdottoFinito
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

-- W6D1 Punti 5, 6 
SELECT ProductKey AS ChiaveProdotto, ProductAlternateKey AS ChiaveProdottoAlternativa, EnglishProductName AS NomeProdotto, Color AS Colore, StandardCost AS CostoStandard, Listprice AS PrezzoDiListino, ListPrice - StandardCost AS Markup
FROM dimproduct
WHERE EnglishProductName LIKE "FR%" OR EnglishProductName LIKE "BK%";

-- W6D1 Punto 7
SELECT EnglishProductName AS NomeProdotto, Listprice AS PrezzoDiListino
FROM dimproduct
WHERE Listprice BETWEEN 1000 AND 2000;

-- W6D1 Punto 8, 9
SELECT  EmployeeKey AS IDDipendente, FirstName AS Nome, LastName AS Cognome, SalesPersonFlag AS Agente
FROM dimemployee
WHERE SalesPersonFlag = 1;

-- W6D1 Punto 10
SELECT  SalesOrderNumber AS 'Numero Ordine', OrderDate AS 'Data Ordine', ProductKey AS 'ID Prodotto', SalesAmount AS Vendite, TotalProductCost AS 'Costo Totale Prodotto', SalesAmount - TotalProductCost AS Profitto
FROM factresellersales
WHERE OrderDate > '2020-01-01'


