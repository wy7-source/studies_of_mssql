/*
    Funções, diferente de Stored Procedures, não alteram nada fora do seu 
escopo interno ( Ou seja não temos INSERT, DELETE nem UPDATE em funções... ).
    Artigo bem legal explicando essa diferença: https://pt.stackoverflow.com/questions/60323/qual-a-diferen%C3%A7a-entre-function-e-procedure

    São especificamente usadas quando você precisa fazer um processamento
que ajude a montar um resultado de uma query.
    Ou precisa de como se fosse uma "View" que aceite parametros, e etc...

    Funções, difernete de Stored Procedures, recebem parametros e retornam valores.
    Existem alguns tipos de retornos como:
    * Escalar: Temos a possibilidade de ter um código bem complexo, e um retorno com valor.
    * Tabela Embutida (Inline): Quando o retorno é uma tabela mesmo, mas com a 
possibilidade de receber parametros.
    * Valor de Tabela com Várias Instruções: Agora e se juntarmos a possibilidade
de conter códigos complexos com o retorno sendo uma tabela, é isso que acontece.

*/

/*
    Temos uma nova Database de exemplo aqui, de uma "Escola", de tabela unica,
só pra uma ilustração do uso de funções, em outro cenário mesmo.
*/

CREATE DATABASE db_Escola
-- Porque vamos utilizar o grupo de arquivos primário do SQL
ON PRIMARY 
(
    -- Nome do Banco
    NAME= db_Escola,
    FILENAME= '/home/db_Escola.MDF',
    SIZE=4MB,
    MAXSIZE=10MB,
    FILEGROWTH=10%
)
GO
use db_Escola
GO

CREATE TABLE tbl_alunos
(
    Id_Aluno SMALLINT IDENTITY PRIMARY KEY,
    Nome_Aluno VARCHAR(20) NOT NULL,
    Nota1 SMALLINT DEFAULT 0,
    Nota2 SMALLINT DEFAULT 0,
    Nota3 SMALLINT DEFAULT 0,
    Nota4 SMALLINT DEFAULT 0
)
GO

INSERT INTO tbl_alunos
    (Nome_Aluno,Nota1,Nota2,Nota3,Nota4)
VALUES
    ('Roselito', 5, 4, 7, 7),
    ('Breno', 3, 8, 8, 7),
    ('João', 2, 10, 10, 2),
    ('Maria', 8, 9, 9, 6),
    ('Rose', 8, 8, 8, 10),
    ('Soares', 10, 9, 9, 9)
GO

-----------------------EXEMPLO-ESCALAR------------------------
CREATE FUNCTION f_nota_media(@nome VARCHAR(20))
RETURNS REAL -- O tipo do valor que será retornado vem aqui.
AS
BEGIN
    DECLARE @media REAL
    SELECT @media = (Nota1 + Nota2 + Nota3 + Nota4 * 2) / 5.00
    FROM tbl_alunos
    WHERE nome_aluno = @nome
    RETURN @media
-- A nossa Variável de retorno...
END

-- E para testarmo o retorno:
SELECT dbo.f_nota_media('Soares');

-----------------------EXEMPLO-INLINE------------------------
-- Voltando a nossa Biblioteca, podemos ter uma "View", que tem um retorno volátil.
USE db_Biblioteca

CREATE FUNCTION f_retorna_livros(@valor REAL)
RETURNS TABLE
AS
RETURN
(
    SELECT L.Nome_Livro, A.Nome_Autor, E.Nome_Editora
    FROM tbl_livro AS L
    INNER JOIN tbl_autores AS A
    ON L.ID_Autor = A.ID_Autor
    INNER JOIN tbl_editoras AS E
    ON L.ID_Editora = E.ID_Editora
    WHERE L.Preco_Livro > @valor
)
GO

-- Agora para usarmos:
SELECT Nome_Livro, Nome_Autor
FROM f_retorna_livros(45.00)



-------------EXEMPLO-VALOR-TABELA-COM-VARIAS-INSTRUÇÕES-------------
-- Podemos deixar muito mais complexo, mas é um exemplo do uso
CREATE FUNCTION f_multi_table()
-- Aqui não se limita ao tipo de retorno "Tabela", mas também a estrutura dessa tabela.
RETURNS @valores TABLE
(
    Nome_Livro VARCHAR(50),
    Data_Pub DATETIME, 
    Nome_Editora VARCHAR(50),
    Preco_Livro MONEY
)
AS
BEGIN
INSERT @valores (Nome_Livro, Data_Pub,Nome_Editora,Preco_Livro)
-- Aqui seria o VALUES
    SELECT L.Nome_Livro, L.Data_Pub, E.Nome_Editora, L.Preco_Livro
    FROM tbl_livro AS L
    INNER JOIN tbl_editoras AS E
    ON L.ID_Editora = E.ID_Editora
RETURN
END

-- Para usarmos a Função:
SELECT * FROM f_multi_table()