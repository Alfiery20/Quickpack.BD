USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_ObtenerTipoProducto;
	END
GO

CREATE PROCEDURE usp_ObtenerTipoProducto
(
	@pTermino VARCHAR(100),
	@pPage INT,
	@pCantidad INT,
	@total INT OUTPUT
)
AS
BEGIN
	
	SELECT @total = COUNT(*) FROM TIPO_PRODUCTO TIP_PRO
	WHERE 
		TIP_PRO.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')

	SELECT
		TIP_PRO.Id AS [ID],
		TIP_PRO.Nombre AS [NOMBRE],
		(
			CASE TIP_PRO.Estado 
				WHEN 'A' THEN 'ACTIVO'
				ELSE 'INACTIVO' END
		) AS [ESTADO]
	FROM TIPO_PRODUCTO TIP_PRO
	WHERE 
		TIP_PRO.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')
	ORDER BY TIP_PRO.ID
	OFFSET (@pPage - 1) * @pCantidad ROWS
	FETCH NEXT @pCantidad ROWS ONLY;
END