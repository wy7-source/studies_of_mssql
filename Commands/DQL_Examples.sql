-- ABOUT Select's
-- Bem estilo Mysql/PostgreSQL/OracleDB...
use db_Biblioteca

-- Simples
SELECT Nome_Autor FROM tbl_autores;
SELECT * FROM tbl_autores;
SELECT Nome_Livro FROM tbl_livro;
SELECT Nome_Livro, Preco_Livro FROM tbl_livro;
SELECT Nome_Livro, ISBN
FROM tbl_livro;

-- Usando OrderBy
SELECT * FROM tbl_livro
 ORDER BY Nome_Livro ASC;
SELECT Nome_Livro, ID_Editora FROM tbl_livro
 ORDER BY ID_Editora;
SELECT Nome_Livro, Preco_Livro FROM tbl_livro
 ORDER BY Preco_Livro DESC;

--  Usando Distinct ( algumas colunas tem valores duplicados )
-- para exibir somente os valores individuais, usamos:
SELECT DISTINCT ID_Autor
FROM tbl_livro;

-- Usando WHERE
-- filtragem...
SELECT Nome_Livro, Data_Pub FROM tbl_livro WHERE ID_Autor = 1;
SELECT ID_Autor, Nome_Autor FROM tbl_autores WHERE Sobrenome_Autor = 'Stanek';
