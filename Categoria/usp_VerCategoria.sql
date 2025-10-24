USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerCategoria') 
	BEGIN
		DROP PROCEDURE usp_VerCategoria;
	END
GO

CREATE PROCEDURE usp_VerCategoria
(
	@pIdCategoria INT
)
AS
BEGIN
	SELECT
		CATE.Id AS [ID],
		CATE.Nombre AS [NOMBRE],
		CATE.Descripcion AS [DESCRIPCION],
		CATE.IdTipoProducto AS [TIPO_PRODUCTO]
	FROM CATEGORIA CATE
	WHERE 
		CATE.ID = @pIdCategoria
END