USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_RegistrarEmpleado') 
	BEGIN
		DROP PROCEDURE sp_RegistrarEmpleado;
	END
GO

CREATE PROCEDURE sp_RegistrarEmpleado
(
	@pTipoDocumento CHAR(1),
	@pNroDocumento VARCHAR(35),
	@pNombre VARCHAR(150),
	@pApellidoPaterno VARCHAR(200),
	@pApellidoMaterno VARCHAR(200),
	@pTelefono VARCHAR(9),
	@pCorreo VARCHAR(200),
	@pClave VARCHAR(MAX),
	@pIdRol INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @nroDocumento INT

			SELECT @nroDocumento = COUNT(Id) FROM EMPLEADO WHERE TipoDocumento = @pTipoDocumento AND NumeroDocumento = @pNroDocumento

			IF(@nroDocumento != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Numero de documento ya existente.';
				END
			ELSE
				BEGIN
					INSERT INTO EMPLEADO(TipoDocumento, NumeroDocumento, Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Clave, Estado, IdRol)
						VALUES(@pTipoDocumento, @pNroDocumento, @pNombre, @pApellidoPaterno, @pApellidoMaterno, @pTelefono, @pCorreo, @pClave, 'A', @pIdRol)
					SET @codigo = 'OK';
					SET @msj = 'Se registró el empleado de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END