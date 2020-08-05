/*
    Temos uma coisa chamada Transação, que é desde o momento em que você dá a instrução
sql para o DB, até o momento que de fato é gravado no disco, no processo de IO.

    Mas caso você precise fazer algo no banco, para por exemplo ver como aquela query
se comportaria, sem efetivamente gravar no disco, você precisa manter a transação aberta,
e para isso, temos o Commit e o Rollback.

    O Commit, é quando você efetiva a sua transação.
    O Rollback, é quando você desfaz a query com a transação aberta ainda.
    Ou seja, o Rollback é sua unica chance de reverter algo dentro da transação, fora isso,
já eraaaa.
*/

-- Vamos ao exemplo:
use db_Biblioteca
GO
-- transação com rollback
BEGIN TRANSACTION
  DELETE FROM tbl_trgg_rec -- apaga todos registros da tabela, "sem querer"
  SELECT * FROM tbl_trgg_rec -- mostra tabela vazia
ROLLBACK TRANSACTION; -- desfaz a transação
SELECT * FROM tbl_trgg_rec; -- mostra os dados normalmente

-- transação com commit
BEGIN TRANSACTION
  DELETE FROM tbl_trgg_rec -- apaga todos registros da tabela
  SELECT * FROM tbl_trgg_rec -- mostra tabela vazia
COMMIT TRANSACTION; -- confirma a transação
SELECT * FROM tbl_trgg_rec; -- agora mostra a tabela vazia em definitivo


-- Podemos ter uma espécie de Checkpoint, quando quisermos voltar para um momento da transação:
SAVE TRANSACTION sf_func;
-- E para voltar a ele:
ROLLBACK TRANSACTION sf_func;