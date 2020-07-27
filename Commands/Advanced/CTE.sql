/*
    Common Table Expression
    Semelhante a uma Subquery. Vamos ao use-case.
    Como nosso banco é simples...
    
    Use-case:
    Suponha que você tem um outro banco com 3 tabelas:
    * Produtos
    * Clientes
    * Compras 

    Queremos ainda, totalizar as compras de cada cliente,
    para o total de produtos que ele adquiriu ( quantidade de produtos * preço unitário ).
    Não vamos usar Subquery, e sim, CTE.

    A CTE tem uma sintaxe parecida com uma view, começa com a palavra "WITH",
    pode ser chamada mais de uma vez, depois de declarada,
    e também vem antes da Query em sí:
*/
WITH ConsultaCTE (Cliente, Total) -- Campos que vou retornar
AS 
(
    SELECT CL.Nome_Cliente AS Cliente,
    PR.Preco_Produto * CO.Quantidade as Total
    FROM Clientes AS CL
    INNER JOIN Compras AS CO
    ON CL.ID_Cliente = CO.ID_Cliente
    INNER JOIN Produtos AS PR
    ON CO.ID_Produto = PR.ID_Produto
)
SELECT Cliente, SUM(Total) AS ValorTotal
FROM ConsultaCTE
GROUP BY Cliente
ORDER BY ValorTotal

/*
    Assim como uma subquery, essa CTE será capaz de nos auxiliar para o agrupamento por
    nome de cliente, e ordenado por Total.
*/