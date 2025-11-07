USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerCaracteristicaCategoriaLanding') 
	BEGIN
		DROP PROCEDURE usp_ObtenerCaracteristicaCategoriaLanding;
	END
GO

CREATE PROCEDURE usp_ObtenerCaracteristicaCategoriaLanding
(
	@pIdCategoria INT
)
AS
BEGIN

	SELECT
		CARA.ID AS [ID],
		CARA.Nombre AS [NOMBRE],
		CARA.Descripcion AS [DESCRIPCION],
		CARA.Multimedia AS [MULTIMEDIA]
	FROM CARACTERISTICA CARA
	WHERE CARA.IdCategoria = @pIdCategoria
	
END