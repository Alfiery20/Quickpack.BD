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
		PROD.Multimedia AS [MULTIMEDIA],
		PRE.Monto AS [PRECIO]
	FROM PRODUCTO PROD
	INNER JOIN PRECIO PRE ON PRE.IdProducto = PROD.ID
	WHERE 
		PROD.IdCategoria = @pIdCategoria AND 
		PROD.Estado = 'A' AND
		PRE.Activo = 1

END