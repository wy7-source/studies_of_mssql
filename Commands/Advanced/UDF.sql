/*
    Funções, diferente de Stored Procedures, não alteram nada fora do seu 
escopo interno ( Ou seja não temos INSERT, DELETE nem UPDATE em funções... ).

    São especificamente usadas quando você precisa fazer um processamento
que ajude a montar um resultado de uma query.

    Temos uma nova Database de exemplo aqui, de uma "Escola", de tabela unica,
logo aqui abaixo.

    Funções, difernete de Stored Procedures, recebem parametros e retornam valores.
    Existem alguns tipos de retornos como:
    * Escalar: Quando passamos um parametro e temos um retorno.


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
-----------------------EXEMPLO------------------------
CREATE FUNCTION f_nota_media(@nome VARCHAR(20))
RETURNS REAL -- O tipo do valor que será retornado vem aqui.
AS
BEGIN
    DECLARE @media REAL
    SELECT @media = (Nota1 + Nota2 + Nota3 + Nota4 * 2) / 5.00
    FROM tbl_alunos
    WHERE nome_aluno = @nome
    RETURN @media -- A nossa Variável de retorno...
END

-- E para testarmo o retorno:
SELECT dbo.f_nota_media('Soares');