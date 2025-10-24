USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_RegistrarRol') 
	BEGIN
		DROP PROCEDURE sp_RegistrarRol;
	END
GO

CREATE PROCEDURE sp_RegistrarRol
(
	@pnombre VARCHAR(250),
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @RolExistente INT

			SELECT @RolExistente = COUNT(Id) FROM ROL WHERE Nombre = @pnombre

			IF(@RolExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Rol existente.';
				END
			ELSE
				BEGIN
					INSERT INTO ROL(Nombre, Estado)
					VALUES(@pnombre, 'A')
					SET @codigo = 'OK';
					SET @msj = 'Se registró el rol de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END