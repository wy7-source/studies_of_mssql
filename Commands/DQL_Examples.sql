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