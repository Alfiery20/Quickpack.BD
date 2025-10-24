USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarRol') 
	BEGIN
		DROP PROCEDURE usp_EditarRol;
	END
GO

CREATE PROCEDURE usp_EditarRol
(
	@pidRol INT,
	@pnombre VARCHAR(250),
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @RolExistente INT

			SELECT @RolExistente = COUNT(Id) FROM ROL WHERE Nombre = @pnombre AND ID <> @pidRol

			IF(@RolExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Rol existente.';
				END
			ELSE
				BEGIN
					UPDATE ROL SET Nombre = @pnombre WHERE ID = @pidRol
					SET @codigo = 'OK';
					SET @msj = 'Se edito el rol de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END