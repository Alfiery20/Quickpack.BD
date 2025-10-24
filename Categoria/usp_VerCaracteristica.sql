USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerCaracteristica') 
	BEGIN
		DROP PROCEDURE usp_VerCaracteristica;
	END
GO

CREATE PROCEDURE usp_VerCaracteristica
(
	@pidCaracteristica INT
)
AS
BEGIN

	SELECT
		ID AS [ID],
		Nombre AS [NOMBRE],
		Descripcion AS [DESCRIPCION],
		Multimedia AS [MULTIMEDIA]
	FROM CARACTERISTICA 
	WHERE ID = @pidCaracteristica

END