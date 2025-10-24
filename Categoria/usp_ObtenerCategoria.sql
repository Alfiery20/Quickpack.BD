USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerCategoria') 
	BEGIN
		DROP PROCEDURE usp_ObtenerCategoria;
	END
GO

CREATE PROCEDURE usp_ObtenerCategoria
(
	@pTermino VARCHAR(100),
	@pPage INT,
	@pCantidad INT,
	@total INT OUTPUT
)
AS
BEGIN
	
	SELECT @total = COUNT(*) FROM CATEGORIA CAT
	WHERE 
		CAT.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')

	SELECT
		CAT.Id AS [ID],
		CAT.Nombre AS [NOMBRE],
		CAT.Descripcion AS [DESCRIPCION],
		TIP_PRO.Nombre AS [TIPO_PRODUCTO],
		(
			CASE CAT.Estado 
				WHEN 'A' THEN 'ACTIVO'
				ELSE 'INACTIVO' END
		) AS [ESTADO]
	FROM CATEGORIA CAT
	LEFT JOIN TIPO_PRODUCTO TIP_PRO ON TIP_PRO.ID = CAT.IdTipoProducto
	WHERE 
		CAT.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')
	ORDER BY CAT.ID
	OFFSET (@pPage - 1) * @pCantidad ROWS
	FETCH NEXT @pCantidad ROWS ONLY;
END