-- ABOUT CAST
/*
    Usamos a CAST, para trocar o tipo de um campo no meio da Select.
    
    O Nosso campo a ser convertido, é do tipo Money, sem essa conversão, é lançado um erro,
    então, precisamos do CAST mesmo.
*/
SELECT 'O Preco do Livro ' + Nome_Livro + ' é de R$ ' + CAST(Preco_Livro AS VARCHAR(6)) AS Item
FROM tbl_livro
WHERE ID_Autor = 2;


-- ABOUT CONVERT
/*
    Trabalha com mais tipos de dados, e também temos uma opção de estilo de dado,
    para o novo dado retornado.

    O Primeiro parametro é o novo tipo do dado, depois o dado, e depois o código do estilo
    Link para exemplo de conversões e estilos: https://docs.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15
    ( o estilo 103, é o nosso formato de data Britanico/Frances): 
*/
SELECT 'A data de Publicação ' + CONVERT(VARCHAR(15),Data_Pub,103)
FROM tbl_livro
WHERE ID_Livro = 102;