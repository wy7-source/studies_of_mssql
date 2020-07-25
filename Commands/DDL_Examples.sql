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
    FILEGROUWTH=10%

)

-- E assim como o MySql, usamos a Instrução USE.

USE db_Biblioteca


-- Temos o comando especifico do SQL SERVER, que nos explicita
-- toda as infos de criação,status, o dono e id do banco, e etc...

sp_helpdb db_Biblioteca
