/*
    São query's que servem de DataSets para outras query's.

    Como nosso banco é simples...
    
    Use-case:
    Suponha que você tem um outro banco com 3 tabelas:
    * Produtos
    * Clientes
    * Compras 

    E que você quer agrupar, por nome do cliente, e pelo seu total de compras,
    Para Facilitar seu lado, você na query tem um campo calculado:
    "PR.Preco_Produto * CO.Quantidade as Total", para calcular o total por compra do usuário.

    Se ele tiver mais de uma compra, pelo fato de ter o campo calculado, o GROUP BY vai dar erro.
    Então você precisa de uma Subquery...

*/

SELECT Resultado.Cliente, SUM (Resultado.Total) AS Total
FROM 
(
    SELECT CL.Nome_Cliente AS Cliente, PR.Preco_Produto * CO.Quantidade as Total
    FROM Clientes AS CL
    INNER JOIN Compras AS CO
    ON CL.ID_Cliente = CO.ID_Cliente
    INNER JOIN Produtos AS PR
    ON CO.ID_Produto = PR.ID_Produto
)   AS Resultado
    GROUP BY Resultado.Cliente
    ORDER BY Total

/*
    Uma query como essa, será capaz de além de calcular o total da compra, por compra,
    também somar todas as compras desses clientes com mais de uma compra, agrupa-los e ordena-los sem probleas...

    Uma view também é uma opção...
*/