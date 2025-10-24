USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerRol') 
	BEGIN
		DROP PROCEDURE usp_ObtenerRol;
	END
GO

CREATE PROCEDURE usp_ObtenerRol
(
	@pTermino VARCHAR(100),
	@pPage INT,
	@pCantidad INT,
	@total INT OUTPUT
)
AS
BEGIN
	
	SELECT @total = COUNT(*) FROM ROL ROL
	WHERE 
		ROL.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')

	SELECT
		ROL.Id AS [ID],
		ROL.Nombre AS [NOMBRE],
		(
			CASE ROL.Estado 
				WHEN 'A' THEN 'ACTIVO'
				ELSE 'INACTIVO' END
		) AS [ESTADO]
	FROM ROL ROL
	WHERE 
		ROL.Nombre LIKE CONCAT(@pTermino,'%') OR 
		(@pTermino IS NULL OR @pTermino = '')
	ORDER BY ROL.ID
	OFFSET (@pPage - 1) * @pCantidad ROWS
	FETCH NEXT @pCantidad ROWS ONLY;
END