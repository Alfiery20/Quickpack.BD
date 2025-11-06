USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerLandingTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_ObtenerLandingTipoProducto;
	END
GO

CREATE PROCEDURE usp_ObtenerLandingTipoProducto
(
	@pIdTipoProducto INT
)
AS
BEGIN
	
	SELECT 
		Nombre AS [NOMBRE],
		Descripcion AS [DESCRIPCION],  
		Multimedia AS [MULTIMEDIA]
	FROM TIPO_PRODUCTO 
	WHERE ID = @pIdTipoProducto
END