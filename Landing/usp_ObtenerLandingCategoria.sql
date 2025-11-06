USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerLandingCategoria') 
	BEGIN
		DROP PROCEDURE usp_ObtenerLandingCategoria;
	END
GO

CREATE PROCEDURE usp_ObtenerLandingCategoria
(
	@pIdTipoProducto INT,
	@pIdCategoria INT
)
AS
BEGIN
	
	DECLARE @existe INT;
	
	SELECT 
		@existe = COUNT(*)
	FROM CATEGORIA 
	WHERE ID = @pIdCategoria AND IdTipoProducto = @pIdTipoProducto

	SELECT 
		Nombre AS [NOMBRE],
		Descripcion AS [DESCRIPCION],  
		Multimedia AS [MULTIMEDIA],
		@existe AS [EXISTE]
	FROM CATEGORIA 
	WHERE ID = @pIdCategoria AND @existe > 0
END