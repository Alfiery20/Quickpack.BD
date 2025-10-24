USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProducto') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProducto;
	END
GO

CREATE PROCEDURE usp_ObtenerProducto
(
	@ptermino VARCHAR(100),
	@pidCategoria INT,
	@pPage INT,
	@pCantidad INT,
	@total INT OUTPUT
)
AS
BEGIN
	
	SELECT @total = COUNT(*) FROM PRODUCTO PRO
	WHERE 
		(PRO.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')) AND 
		(PRO.IdCategoria = @pidCategoria OR 
		(@pidCategoria IS NULL OR @pidCategoria = ''))

	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		PRE.Monto AS [PRECIO],
		(
			CASE PRO.Estado 
				WHEN 'A' THEN 'ACTIVO'
				ELSE 'INACTIVO' END
		) AS [ESTADO],
		CAT.Nombre AS [CATEGORIA],
		CONCAT(USU_CREA.Nombre, ' ', USU_CREA.ApellidoPaterno, ' ' , USU_CREA.ApellidoMaterno) AS [USUARIO_CREA],
		PRO.FechaCrear AS [FECHA_CREA],
		CONCAT(USU_ACTU.Nombre, ' ', USU_ACTU.ApellidoPaterno, ' ' , USU_ACTU.ApellidoMaterno) AS [USUARIO_ACTUALIZA],
		PRO.FechaModificar AS [FECHA_ACTUALIZA]
	FROM PRODUCTO PRO
	LEFT JOIN CATEGORIA CAT ON CAT.ID = PRO.IdCategoria
	LEFT JOIN EMPLEADO USU_CREA ON USU_CREA.ID = PRO.IdUsuarioCrear
	LEFT JOIN EMPLEADO USU_ACTU ON USU_ACTU.ID = PRO.IdUsuarioModificar
	LEFT JOIN PRECIO PRE ON PRE.IdProducto = PRO.ID AND PRE.Activo = 1
	WHERE 
		(PRO.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')) AND 
		(PRO.IdCategoria = @pidCategoria OR 
		(@pidCategoria IS NULL OR @pidCategoria = ''))
	ORDER BY PRO.ID
	OFFSET (@pPage - 1) * @pCantidad ROWS
	FETCH NEXT @pCantidad ROWS ONLY;
END