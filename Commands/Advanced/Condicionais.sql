-- ABOUT conditionals
/*
    Como em linguagens de Programação, temos sim os condicionais...
    Use-case: Stored Procedures e outros...

    Então vamos a um exemplo simples:
*/
DECLARE @n INT,
        @str VARCHAR(10)
SET @n = 20
SET @str = 'Fábio'

IF @n = 20
    SELECT 'Número ' + CONVERT(VARCHAR(2),@n)

IF @str = 'Fábio'
    BEGIN
        SET @n = 30
        SELECT 'Número ' + CONVERT(VARCHAR(2),@n)
    END;
ELSE
    BEGIN
        SET @n = 40
        SELECT 'Número ' + CONVERT(VARCHAR(2),@n)
    END;