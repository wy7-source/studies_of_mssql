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


-----------------------EXEMPLO-2--------------------------
/*
    Vale salientar que procedures aceitam também parametros:
*/

CREATE PROCEDURE SP_Params
(@par1 int, @par2 VARCHAR(20))
AS 
BEGIN
    SELECT @par1
    SELECT @par2
END;

-- Podemos passar os parametros na ordem que foram criadas:
EXEC Sp_Params 26, 'Laranja'

-- Ou especificando quem é quem mesmo:
EXEC Sp_Params @par2 = 'Laranja', @par1 = 25


/*
    Outro exemplo só pra fixar.
    Vamos aqui indicar um id de livro, e uma variável quantidade, para que o livro me retorne o valor
    total que vou pagar nessa quantidade de livros.
*/
CREATE PROCEDURE Sp_Livro_Valor_Total
(
    -- Podemos colocar valores padrão, caso não sejam passados:
    @Quantidade SMALLINT = 1,
    @ID SMALLINT
)
AS
    SELECT Nome_Livro as Livro, Preco_Livro * @Quantidade AS Preço
    FROM tbl_livro
    WHERE ID_Livro = @ID;

-- Para testarmos isso:
EXEC Sp_Livro_Valor_Total @ID = 103, @Quantidade = 10;


-- E com INSERT, como fica?
CREATE PROCEDURE Sp_Cadastrar_Editora 
(@nome VARCHAR (50))
AS
    INSERT INTO tbl_editoras (Nome_Editora)
    VALUES (@nome);

-- É só respeitar os campos, e voila
EXEC Sp_Cadastrar_Editora @nome = 'Nobel';
-- Para checarmos se deu certo:
SELECT * FROM tbl_editoras;

-----------------------EXEMPLO-3--------------------------
/*
    Como funções. podemos ter um retorno das stored procedures.
    No caso, precisamos armazenar esse retorno em alguma variável...

    Use-case: Tratar o erro antes mesmo de chegar na aplicação, deixando a aplicação considerar
    o melhor cenário possivel ( incomum, mas é uma possibilidade ).
*/
ALTER PROCEDURE Sp_Livro_Valor_Total 
(
  @Quantidade SMALLINT, @Cod SMALLINT = -10,
  @ID SMALLINT
)
AS
  SET NOCOUNT ON
  IF @ID >= 100
    BEGIN
      SELECT Nome_Livro as Livro, Preco_Livro * @Quantidade AS Preço
      FROM tbl_Livros
      WHERE ID_Livro = @ID
      RETURN 1
    END
  ELSE
RETURN @Cod
-- Para executarmos, temos algumas coisas a mais para considerar...
DECLARE @Codigo INT
EXEC @Codigo = sp_LivroValor @ID = 103, @Quantidade = 10
PRINT @Codigo
/*
    E caso retorne o -10, podemos ter uma exceção de código por exemplo...
*/


-----------------------EXEMPLO-4--------------------------
/*
    Caso você precise alterar um valor de uma variável através de uma stored procedure.
    Teremos um exemplo simples, onde uma variável é passada para a procedure
*/
CREATE PROCEDURE Sp_Mult (@par1 AS INT OUTPUT)
AS
SELECT @par1 * 2
RETURN

DECLARE @valor as INT = 15
EXEC Sp_Mult @valor OUTPUT
PRINT @valor
