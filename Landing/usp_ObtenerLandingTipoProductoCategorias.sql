USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerLandingTipoProductoCategorias') 
	BEGIN
		DROP PROCEDURE usp_ObtenerLandingTipoProductoCategorias;
	END
GO

CREATE PROCEDURE usp_ObtenerLandingTipoProductoCategorias
(
	@pIdTipoProducto INT
)
AS
BEGIN

	SELECT
		CAT.ID AS [ID],
		CAT.Nombre AS [NOMBRE],
		CAT.Descripcion AS [DESCRIPCION],
		CAT.Multimedia AS [MULTIMEDIA]
	FROM CATEGORIA CAT
	WHERE IdTipoProducto = @pIdTipoProducto AND Estado = 'A'

END