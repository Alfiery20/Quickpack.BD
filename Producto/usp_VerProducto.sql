USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerProducto') 
	BEGIN
		DROP PROCEDURE usp_VerProducto;
	END
GO

CREATE PROCEDURE usp_VerProducto
(
	@pidProducto INT
)
AS
BEGIN
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		PRE.Monto AS [PRECIO],
		PRO.Multimedia AS [MULTIMEDIA],
		PRO.IdCategoria AS [CATEGORIA]
	FROM PRODUCTO PRO
	LEFT JOIN PRECIO PRE ON PRE.IdProducto = PRO.ID AND PRE.Activo = 1
	WHERE 
		PRO.ID = @pidProducto
END