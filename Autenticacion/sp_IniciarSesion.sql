USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_IniciarSesion') 
	BEGIN
		DROP PROCEDURE sp_IniciarSesion;
	END
GO

CREATE PROCEDURE sp_IniciarSesion
(
	@pemail VARCHAR(250),
	@pclave VARCHAR(MAX)
)
AS
BEGIN
	SELECT 
		EMPL.Id AS [ID],
		EMPL.TipoDocumento AS [TIPO_DOCUMENTO],
		EMPL.NumeroDocumento AS [NUMERO_DOCUMENTO],
		EMPL.Nombre AS [NOMBRE],
		EMPL.ApellidoPaterno AS [APELLIDO_PATERNO],
		EMPL.ApellidoMaterno AS [APELLIDO_MATERNO],
		EMPL.Telefono AS [TELEFONO],
		ROL.Id AS [ID_ROL],
		ROL.Nombre AS [NOMBRE_ROL]
	FROM EMPLEADO EMPL
	LEFT JOIN Rol ROL ON ROL.Id = EMPL.IdRol
	WHERE 
		EMPL.Correo = @pemail 
		AND EMPL.Clave = @pclave 
		AND EMPL.Estado = 'A'
END