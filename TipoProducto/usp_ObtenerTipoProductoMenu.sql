USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerTipoProductoMenu') 
	BEGIN
		DROP PROCEDURE usp_ObtenerTipoProductoMenu;
	END
GO

CREATE PROCEDURE usp_ObtenerTipoProductoMenu
AS
BEGIN
	SELECT
		TIP_PRO.Id AS [ID],
		TIP_PRO.Nombre AS [NOMBRE]
	FROM TIPO_PRODUCTO TIP_PRO
	WHERE 
		TIP_PRO.Estado = 'A'
	ORDER BY TIP_PRO.ID
END