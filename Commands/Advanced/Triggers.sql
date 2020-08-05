/*
    É um tipo de Stored Procedure, que é executado depois que um usuário realiza
uma operação que modifique o DB ( sobre o DML nesse caso ).

    AFTER: será executado antes do commit, e depois do dml.
    Insted OF: é executada uma trigger no lugar do dml.

    Para os exemplos, usaremos o nosso querido db_Biblioteca.
*/
use db_Biblioteca
GO

------------EXEMPLO-TRIGGER-AFTER----------------
CREATE TRIGGER trgg_after_teste
ON tbl_editoras
AFTER INSERT -- Aqui vai a definição da Trigger, e sobre qual instrução DML ela terá efeito.
AS -- Daqui pra baixo, são as intruções da Trigger.
PRINT 'Opa, valor inserido'
GO

-- Para efetivamente vermos a Trigger funcionando...
INSERT INTO tbl_editoras
VALUES ('Editora 10')
GO

-- Para notarmos que a trigger não interferiu na inserção no DB.
SELECT * FROM tbl_editoras
GO

-- Que tal uma Trigger que não importa a Editora, ela precisa ter um livro 'X', do autor 'Y' ?
CREATE TRIGGER trgg_after_teste2
ON tbl_editoras
AFTER INSERT
AS
INSERT INTO tbl_autores VALUES (25,'José','da Silva')
INSERT INTO tbl_livro VALUES ('Livro1','134560000','20001010',77,25,2)

-- Para ativarmos a trigger:
INSERT INTO tbl_editoras VALUES ('Editora Top')
GO

------------EXEMPLO-TRIGGER-INSTEAD-OF---------------
-- Uma trigger que não vai te deixar inserir nada !!
CREATE TRIGGER trgg_instedof
ON tbl_editoras
INSTEAD OF INSERT
AS
PRINT 'Opa, não dessa vez!!!'
GO

-- Nem se você tentar kk
INSERT INTO tbl_autores VALUES (26, 'João','Moura')
GO
-- Quer ver?
SELECT * FROM tbl_autores
GO
-- Tã dãa, nada!.

-- Para desativar ou habilitar uma Tigger

ALTER TABLE tbl_editoras
DISABLE TRIGGER trgg_instedof
GO

-- Para verificarmos as triggers existentes nas tabelas:
EXEC sp_helptrigger @tabname=tbl_editoras
GO

-- Ou no banco todo mesmo:
SELECT * FROM sys.triggers WHERE is_disabled = 0
GO

/*
    Claro que o uso disso pode ser para validações e desvios de fluxos, onde uma Rule
não seja suficiente. Muito poderoso se bem usado. Vamos usar a função update():
*/
CREATE TRIGGER trgg_after_autores
ON tbl_autores
AFTER INSERT, UPDATE -- Pode valer para mais de uma instrução DML...
AS
IF UPDATE(Nome_Autor)
-- Vale ressaltar que mesmo não tendo afetado nenhuma coluna, o resultado é TRUE.
    BEGIN
        PRINT 'O nome do autor foi alterado.'
    END
ELSE
    BEGIN
        PRINT 'Nome do autor não foi alterado.'
    END
GO

-- Então, quando atualiazmos o nome do autor:
UPDATE tbl_autores
SET Nome_Autor = 'João'
WHERE ID_Autor = 101
GO

select * from tbl_autores;
-- E quando não fazemos isso:
UPDATE tbl_autores
SET Sobrenome_Autor = 'Da Silva'
WHERE ID_Autor = 103
GO

---------EXEMPLO-TRIGGER-RECURSIVA-AFTER---------
/*
    Uma possibilidade que temos, são triggers aninhadas,
que são triggers que chamam outras triggers ( No máximo 32 recursividades ).
    E também, triggers que chamam a si mesmas, e para ilustrar isso, vamos
exemplificar, preenchendo uma tabela de campo unico, com um único insert, 10 posições...
*/

-- Antes disso, precisamos habilitar no nosso servidor, o ANINHAMENTO entre triggers:
EXEC sp_configure 'Nested Triggers', 1
GO
RECONFIGURE
GO
-- Vamos precisar também habilitar agora a funcinoalidade de recursividade no DB
ALTER DATABASE db_Biblioteca
SET RECURSIVE_TRIGGERS ON
GO

-- Vamos criar a tabela de exemplo:
CREATE TABLE tbl_trgg_rec( ID SMALLINT PRIMARY KEY)
GO

-- A nossa trigger recursiva
-- LEMBRE-SE DE USAR UM DELIMITADOR DA RECURSIVIDADE ( se bem que o servidor limita a 32, mas enfim... ) 
CREATE TRIGGER trgg_rec ON tbl_trgg_rec
AFTER INSERT
AS
DECLARE @n INT
SELECT @n = MAX(ID) FROM tbl_trgg_rec
IF @n < 15
    BEGIN  
        INSERT INTO tbl_trgg_rec SELECT MAX(ID) + 1 FROM tbl_trgg_rec
    END
ELSE
    BEGIN  
       PRINT 'Terminado'
    END

GO

-- Para fazer isso acontecer:
INSERT INTO tbl_trgg_rec VALUES (4)
GO

-- E voilá:
SELECT * FROM tbl_trgg_rec;