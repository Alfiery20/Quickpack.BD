USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_CambiarEstadoEmpleado') 
	BEGIN
		DROP PROCEDURE usp_CambiarEstadoEmpleado;
	END
GO

CREATE PROCEDURE usp_CambiarEstadoEmpleado
(
	@pidEmpleado INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @EmpleadoExistente INT

			SELECT @EmpleadoExistente = COUNT(Id) FROM EMPLEADO WHERE ID = @pidEmpleado

			IF(@EmpleadoExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Empleado no existe, contactar con servicio.';
				END
			ELSE
				BEGIN

					DECLARE @Estado CHAR(1) = '';

					SELECT 
						@Estado = Estado 
					FROM EMPLEADO 
					WHERE ID = @pidEmpleado

					UPDATE EMPLEADO 
						SET Estado = (
							CASE @Estado
								WHEN 'A' THEN 'I'
								WHEN 'I' THEN 'A' END
						)
					WHERE ID = @pidEmpleado
					SET @codigo = 'OK';
					SET @msj = 'Se edito el estado del empleado de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END