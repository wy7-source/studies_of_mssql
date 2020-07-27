-- ABOUT While
/*
    É o loop que vemos em linguagens de programação, que executa seu bloco enquanto for TRUE.
    Use-case: Stored Procedures que precisem de repetições...
*/

DECLARE @n INT
SET @n = 0

WHILE @n < 10
    BEGIN
    -- Pode ser print ou select...
        PRINT 'Número atual: ' + CAST(@n AS VARCHAR(2))
        SET @n = @n + 1
    END;