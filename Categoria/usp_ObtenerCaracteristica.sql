USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerCaracteristica') 
	BEGIN
		DROP PROCEDURE usp_ObtenerCaracteristica;
	END
GO

CREATE PROCEDURE usp_ObtenerCaracteristica
(
	@pidCategoria INT
)
AS
BEGIN

	SELECT
		ID AS [ID],
		Nombre AS [NOMBRE]
	FROM CARACTERISTICA 
	WHERE IdCategoria = @pidCategoria

END