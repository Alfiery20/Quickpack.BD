USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarEmpleado') 
	BEGIN
		DROP PROCEDURE usp_EditarEmpleado;
	END
GO

CREATE PROCEDURE usp_EditarEmpleado
(
	@pIdEmpleado INT,
	@pNombre VARCHAR(150),
	@pApellidoPaterno VARCHAR(200),
	@pApellidoMaterno VARCHAR(200),
	@pTelefono VARCHAR(9),
	@pIdRol INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE EMPLEADO SET 
				Nombre = @pNombre, 
				ApellidoPaterno = @pApellidoPaterno, 
				ApellidoMaterno = @pApellidoMaterno,
				Telefono = @pTelefono, 
				IdRol = @pIdRol
			WHERE ID = @pIdEmpleado
			SET @codigo = 'OK';
			SET @msj = 'Se edito el empleado de forma satisfactoria.';
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END