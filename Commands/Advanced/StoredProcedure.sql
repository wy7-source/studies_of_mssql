-- ABOUT SP's
/*
    São Batches, de SQL's, que podem ser como subrotinas.
    São centralizadores de lógica de acesso a dados, sendo um único lugar para manutenção...
    
    Use-case: Suponha que você tem um banco de um mercado, e todo Sábado, tem promoção
    nos petiscos e doces. Então, você ao invés de ficar hard coded no seu programa, fica
    armazenado no próprio banco.
*/

-- Vamos ter uma SP que nos retorne o Livro do Autor que passarmos como parametro.
-- Para criarmos uma SP:
use db_Biblioteca;

CREATE PROCEDURE Sp_Teste_Autor
    @NomeAutor varchar(25)
AS 
BEGIN
    SELECT DISTINCT L.Nome_Livro AS Livro, A.Nome_Autor AS Autor
    FROM tbl_livro L
    INNER JOIN tbl_autores A
    ON L.ID_Autor = A.ID_Autor
    WHERE Nome_Autor = @NomeAutor;
END;

-- Para executar:
EXEC Sp_Teste_Autor 'Daniel';

-- Para visualizarmos o corpo da procedure
EXEC sp_helptext Sp_Test_Autor;

-- Para alterar a procedure, vamos discartar o corpo antigo, e atribuir um novo...
ALTER PROCEDURE Sp_Teste_Autor
@NomeAutor varchar(25)
WITH ENCRYPTION 
/*
    Habilita a criptografia, impossibilitando que quem tem acesso a ela, veja como ela funciona.
    Use-case: Quando você vende um banco desse para uma empresa por exemplo... 
*/
AS 
BEGIN
SET NOCOUNT ON;  -- Para que a contagem de linhas afetadas não retorne junto com os retornos...
    SELECT DISTINCT L.Nome_Livro AS Livro, A.Nome_Autor + ' ' + A.Sobrenome_Autor AS 'Nome Completo'
    FROM tbl_livro L
    INNER JOIN tbl_autores A
    ON L.ID_Autor = A.ID_Autor
    WHERE Nome_Autor = @NomeAutor;
END;

-- Para checar o funcionamento:
EXEC Sp_Teste_Autor 'Daniel';

-- Para checar a criptografia:
EXEC sp_helptext Sp_Teste_Autor;

-- Para renomea-la:
sp_rename 'Sp_Teste_Autor', 'Sp_Livro_Autor';

-- Para dropa-la:
DROP PROCEDURE Sp_Livro_Autor;