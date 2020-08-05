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
/*
    Tã dãa, nada!.
    Claro que o uso disso pode ser para validações e desvios de fluxos, onde uma Rule
não seja suficiente. Muito poderoso se bem usado.
*/

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