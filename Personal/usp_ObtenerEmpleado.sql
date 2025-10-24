USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerEmpleado') 
	BEGIN
		DROP PROCEDURE usp_ObtenerEmpleado;
	END
GO

CREATE PROCEDURE usp_ObtenerEmpleado
(
	@pNombre VARCHAR(300),
	@pNroDocumento VARCHAR(20),
	@pPage INT,
	@pCantidad INT,
	@total INT OUTPUT
)
AS
BEGIN
	
	SELECT @total = COUNT(*) FROM EMPLEADO EMPL
	WHERE 
		(CONCAT(EMPL.Nombre, ' ', EMPL.ApellidoPaterno, ' ', EMPL.ApellidoMaterno) LIKE CONCAT(@pNombre,'%') OR 
		(@pNombre IS NULL OR @pNombre = '')) AND
		(EMPL.NumeroDocumento LIKE CONCAT(@pNroDocumento, '%') OR
		(@pNroDocumento IS NULL OR @pNroDocumento = ''))

	SELECT
		EMPL.Id AS [ID],
		EMPL.TipoDocumento AS [TIPO_DOCUMENTO],
		EMPL.NumeroDocumento AS [NRO_DOCUMENTO],
		EMPL.Nombre AS [NOMBRE],
		EMPL.ApellidoPaterno AS [APELLIDO_PATERNO],
		EMPL.ApellidoMaterno AS [APELLIDO_MATERNO],
		EMPL.Telefono AS [TELEFONO],
		EMPL.Correo AS [CORREO],
		(
			CASE EMPL.Estado 
				WHEN 'A' THEN 'ACTIVO'
				ELSE 'INACTIVO' END
		) AS [ESTADO],
		ROL.Nombre AS [ROL]
	FROM EMPLEADO EMPL
	LEFT JOIN ROL ROL ON ROL.ID = EMPL.IdRol
	WHERE 
		(CONCAT(EMPL.Nombre, ' ', EMPL.ApellidoPaterno, ' ', EMPL.ApellidoMaterno) LIKE CONCAT(@pNombre,'%') OR 
		(@pNombre IS NULL OR @pNombre = '')) AND
		(EMPL.NumeroDocumento LIKE CONCAT(@pNroDocumento, '%') OR
		(@pNroDocumento IS NULL OR @pNroDocumento = ''))
	ORDER BY ROL.ID
	OFFSET (@pPage - 1) * @pCantidad ROWS
	FETCH NEXT @pCantidad ROWS ONLY;
END