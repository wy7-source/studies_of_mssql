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
-- Com Condicionais
SELECT * FROM tbl_livro
WHERE ID_Livro > 102 AND ID_Autor < 3;
SELECT * FROM tbl_livro
WHERE ID_Livro > 102 OR ID_Autor <= 3;
SELECT * FROM tbl_livro
WHERE ID_Livro > 102 OR NOT ID_Autor <= 3;

-- Usando TOP
-- Podemos usar para mostrar os primeiros registros da tabela,
-- por posição numérica, ou percentual, relativo a quantidade de registros.
SELECT TOP (3) Nome_Livro
FROM tbl_livro;
-- Se precisarmos fazer o inverso, podemos ordenar por DESC alfabeticamente.
SELECT TOP (3) Nome_Livro
FROM tbl_livro ORDER BY Nome_Livro DESC;

-- Usando Alias (AS)
-- Para apelidos para as colunas.
SELECT Nome_Livro AS Livro,
        ID_Autor AS Autor
FROM tbl_livro;

-- Usando Union
-- Podemos juntar 2 saídas Selects, sem repetições...
-- Precisamos que ambas tabelas, tenham a mesma quantidade de colunas, tipos e ordem.
SELECT Nome_Autor FROM tbl_autores
UNION
SELECT Nome_Livro FROM tbl_livro;
-- Um melhor use-case do Union, é quando por exemplo temos um supermercado, com produtos
-- cadastrados em tabelas diferentes, separados por gênero (EX: limpeza, higiene, farináceos ),
-- e quisessemos por exemplo fazer um relatório, com todos os produtos.

-- Usando INTO
-- Select com into, pode ser usado para criar uma tabela, apartir da saída de um select de
-- outra tabela.
-- Um use-case pode ser clonar as tabelas para fazer um backup...
SELECT Nome_Livro, ISBN
INTO Livro_ISBN
FROM tbl_livro
where ID_Livro > 103;
DROP TABLE Livro_ISBN;

-- Usando Funções Agregadas...
-- Funções que retornam alguns calculos simples juntos ao select...
-- MIN
SELECT MIN(Preco_Livro) FROM tbl_livro;
-- MAX
SELECT MAX(Preco_Livro) FROM tbl_livro;
-- COUNT
SELECT COUNT(*) FROM tbl_autores;
-- AVG ( Average )
SELECT AVG(Preco_Livro) FROM tbl_livro;
-- SUM
SELECT SUM(Preco_Livro) FROM tbl_livro;

-- Usando Between 
-- Usado para seleções de intervalos de filtragem.
SELECT * FROM tbl_livro
WHERE Data_Pub BETWEEN '20040517' AND '20110517';
-- Composto
SELECT * FROM tbl_livro
WHERE Data_Pub BETWEEN '20000101' AND '20050101'
OR Data_Pub BETWEEN '20100101' AND '20140101'
AND Preco_Livro BETWEEN 40.00 AND 70.00
ORDER BY Data_Pub DESC;

-- Usando Like e Not like
-- Usado para filtragens com a clausula Where, usamos alguns caracteres coringas:
-- '_' Qualquer caractere único.
-- '%' Qualquer cadeia de 0 ou mais caracteres.
-- "[]" Qualquer caracter único no intervalo ou conjunto especificado ([a-h];[aeiou])
-- "[^]" Qualquer caracter único no intervalo ou conjunto especificado (^[a-h];^[aeiou])
SELECT * FROM tbl_livro
WHERE Nome_Livro LIKE 'F%';
-- o segundo caracter tem que ser i ou s...
SELECT * FROM tbl_livro
WHERE Nome_Livro LIKE '_[is]%';
-- Coringa para 2° letra e negativa
SELECT Nome_Livro
FROM tbl_livro
WHERE Nome_Livro NOT LIKE '_i%';