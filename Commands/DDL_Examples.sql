-- ABOUT DATABASE

-- A sintaxe é meio engraçada, pois precisamos especificar 
-- inclusive na criação do Banco, o tamanho do arquivo do banco, e seu path...

CREATE DATABASE db_Biblioteca
-- Porque vamos utilizar o grupo de arquivos primário do SQL
ON PRIMARY 
(
    -- Nome do Banco
    NAME= db_Biblioteca,
    -- path do banco com extensão MDF
    FILENAME= '/home/db_Biblioteca.MDF',
    -- Tamanho Inicial do arquivo do banco
    SIZE=6MB,
    -- Tamanho máximo
    MAXSIZE=15MB,
    -- Porcentagem de acrescimo que o arquivo do banco
    -- vai crescer, até atingir o valor máximo acima.
    FILEGROWTH=10%

)

-- E assim como o MySql, usamos a Instrução USE.

USE db_Biblioteca


-- Temos o comando especifico do SQL SERVER, que nos explicita
-- toda as infos de criação,status, o dono e id do banco, e etc...

-- sp_helpdb db_Biblioteca

-- ABOUT TABLES
-- Temos aqui, a sintaxe bem padrão mesmo.

CREATE TABLE tbl_livro
(
    -- Identity é o auto-increment do MySql/PostgreSQL/OracleDB, o primeiro
    -- parametro, é o numero inicial, e a segunda, é que quanto em
    -- quanto ele incrementa. SOMENTE UMA POR TABELA !!!
    
    -- Para checarmos o valor atual da identity, usamos "DBCC CHECKIDENT (tbl_livros, NORESEED);"
    ID_Livro SMALLINT PRIMARY KEY IDENTITY(100,1),
    Nome_Livro VARCHAR(50) NOT NULL,
    ISBN VARCHAR(30) NOT NULL UNIQUE,
    ID_Autor SMALLINT NOT NULL,
    Data_Pub DATETIME NOT NULL,
    Preco_Livro MONEY NOT NULL
)

CREATE TABLE tbl_autores
(
    ID_Autor SMALLINT PRIMARY KEY,
    Nome_Autor VARCHAR(50),
    Sobrenome_Autor VARCHAR(60)
)

CREATE TABLE tbl_editoras
(
    -- Por padrão, começa do numero 1, e incrementa de 1 em 1.
    ID_Editora SMALLINT PRIMARY KEY IDENTITY,
    Nome_Editora VARCHAR(50) NOT NULL
)

-- Equivalente ao DESCRIBLE do Mysql e do PostgreSQL, temos o:
-- sp_help tbl_autores


-- ABOUT ALTER TABLE
-- DROP's
ALTER TABLE tbl_livro
DROP COLUMN ID_Autor

ALTER TABLE tabela
DROP CONSTRAINT constraint_name


-- ADD's
ALTER TABLE tbl_livro
ADD ID_Autor SMALLINT NOT NULL
CONSTRAINT fk_ID_Autor FOREIGN KEY (ID_Autor)
REFERENCES tbl_autores

ALTER TABLE tbl_livro
ADD ID_Editora SMALLINT NOT NULL
CONSTRAINT fk_ID_Editora FOREIGN KEY (ID_Editora)
REFERENCES tbl_editoras


-- ALTER's
-- è recomendavel fazer isso daqui sem ter dados na tabela
-- senão vai ser complicado...
ALTER TABLE tbl_livro
ALTER COLUMN ID_Autor SMALLINT

-- ABOUT DROP
-- Só vai excluir se a tabela não tiver relacionamentos.
-- Caso ela tenha, é necessário um Cascade...
-- DROP TABLE nome_tabela