USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerEmpleado') 
	BEGIN
		DROP PROCEDURE usp_VerEmpleado;
	END
GO

CREATE PROCEDURE usp_VerEmpleado
(
	@pIdEmpleado INT
)
AS
BEGIN
	SELECT
		EMPL.Id AS [ID],
		EMPL.TipoDocumento AS [TIPO_DOCUMENTO],
		EMPL.NumeroDocumento AS [NRO_DOCUMENTO],
		EMPL.Nombre AS [NOMBRE],
		EMPL.ApellidoPaterno AS [APELLIDO_PATERNO],
		EMPL.ApellidoMaterno AS [APELLIDO_MATERNO],
		EMPL.Telefono AS [TELEFONO],
		EMPL.Correo AS [CORREO],
		EMPL.IdRol AS [ROL]
	FROM EMPLEADO EMPL
	WHERE EMPL.ID = @pIdEmpleado;
END