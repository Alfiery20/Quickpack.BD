USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerLandingCategoriaProductos') 
	BEGIN
		DROP PROCEDURE usp_ObtenerLandingCategoriaProductos;
	END
GO

CREATE PROCEDURE usp_ObtenerLandingCategoriaProductos
(
	@pIdCategoria INT
)
AS
BEGIN

	SELECT
		PROD.ID AS [ID],
		PROD.Nombre AS [NOMBRE],
		PROD.Descripcion AS [DESCRIPCION],
		PROD.Multimedia AS [MULTIMEDIA]
	FROM PRODUCTO PROD
	WHERE PROD.IdCategoria = @pIdCategoria AND PROD.Estado = 'A'

END