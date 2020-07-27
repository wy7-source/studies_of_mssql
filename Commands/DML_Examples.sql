-- ABOUT INSERT's
/*
    Esse arquivo é para demonstrações de uso dos comandos do grupo DML, e também para
    popular o nosso BD previamente criado.

    Bem padrão Mysql/PostgreSQL/OracleDB...
*/

use db_Biblioteca
GO

-- Autores
INSERT INTO tbl_autores
VALUES
(1, 'Daniel', 'Barret'),
(2, 'Gerald', 'Carter'),
(3, 'Mark', 'Sobell'),
(4, 'William', 'Stanek'),
(5, 'Richard', 'Blum')
GO

-- Editoras
INSERT INTO tbl_editoras (Nome_Editora) VALUES ('Prentice Hall')
GO
INSERT INTO tbl_editoras (Nome_Editora) VALUES ('O´Reilly')
GO
INSERT INTO tbl_editoras (Nome_Editora) VALUES ('Microsoft Press')
GO
INSERT INTO tbl_editoras (Nome_Editora) VALUES ('Wiley')
GO

-- Livros
INSERT INTO tbl_livro (Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora)
VALUES
('Linux Command Line and Shell Scripting','9781118983843', '20150109', 68.35, 5, 4),
('SSH, the Secure Shell','9780596008956', '20050517', 58.30, 1, 2),
('Using Samba','9780596002565', '20031221', 61.45, 2, 2),
('Fedora and Red Hat Linux', '9780133477436', '20140110', 62.24, 3, 1),
('Windows Server 2012 Inside Out','9780735666313', '20130125', 66.80, 4, 3),
('Microsoft Exchange Server 2010','9780735640610', '20101201', 45.30, 4, 3)
GO


-- ABOUT TRUNCATE's
-- Rápido e fácil de limpar uma tabela inteira, sem logs,
-- como no MySql/PostgreSQL/OracleDB...

-- TRUNCATE TABLE tbl_autores


-- ABOUT UPDATE's
UPDATE tbl_livro
 SET Preco_Livro = 65.43
 WHERE Nome_Livro = 'Using Samba'
 GO

UPDATE tbl_livro
 SET Preco_Livro = 71.20,
 ISBN = '654738322'
 WHERE ID_Livro = 103
 GO