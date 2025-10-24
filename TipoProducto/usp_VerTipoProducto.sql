USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_VerTipoProducto;
	END
GO

CREATE PROCEDURE usp_VerTipoProducto
(
	@pIdTipoProducto INT
)
AS
BEGIN
	SELECT
		TIP_PRO.Id AS [ID],
		TIP_PRO.Nombre AS [NOMBRE]
	FROM TIPO_PRODUCTO TIP_PRO
	WHERE 
		TIP_PRO.ID = @pIdTipoProducto
END