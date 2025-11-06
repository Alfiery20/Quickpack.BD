USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerTipoProductoMenuLanding') 
	BEGIN
		DROP PROCEDURE usp_ObtenerTipoProductoMenuLanding;
	END
GO

CREATE PROCEDURE usp_ObtenerTipoProductoMenuLanding
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