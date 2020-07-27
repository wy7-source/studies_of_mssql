/*
    É uma tabela que é em memória, que se comporta como uma tabela normal,
    Mostra sempre os dados atualizados, pois sempre que recebe uma query,
    ela é recriada.

    Use-case: Query's monstruosas podem ser quebradas em views...
*/
use db_Biblioteca;

CREATE VIEW vw_livro_autores
AS SELECT L.Nome_Livro as Livro,
          A.Nome_Autor as Autor
FROM tbl_livro L
INNER JOIN tbl_autores A
ON L.ID_Autor = A.ID_Autor;
-- Para testarmos
SELECT * FROM vw_livro_autores;

-- Para atualizações a view, para por exemplo também nos retornar o valor do livro, 
-- podemos usar:
ALTER VIEW vw_livro_autores
AS SELECT L.Nome_Livro as Livro,
          A.Nome_Autor as Autor,
          L.Preco_Livro as Valor
FROM tbl_livro L
INNER JOIN tbl_autores A
ON L.ID_Autor = A.ID_Autor;
-- Para confirmar:
SELECT * FROM vw_livro_autores;


-- Para excluirmos a view:
DROP VIEW vw_livro_autores;