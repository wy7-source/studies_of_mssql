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