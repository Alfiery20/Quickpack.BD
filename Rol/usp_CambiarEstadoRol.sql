USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_CambiarEstadoRol') 
	BEGIN
		DROP PROCEDURE usp_CambiarEstadoRol;
	END
GO

CREATE PROCEDURE usp_CambiarEstadoRol
(
	@pidRol INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @RolExistente INT

			SELECT @RolExistente = COUNT(Id) FROM ROL WHERE ID = @pidRol

			IF(@RolExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Rol no existe, contactar con servicio.';
				END
			ELSE
				BEGIN

					DECLARE @Estado CHAR(1) = '';

					SELECT 
						@Estado = Estado 
					FROM ROL 
					WHERE ID = @pidRol

					UPDATE ROL 
						SET Estado = (
							CASE @Estado
								WHEN 'A' THEN 'I'
								WHEN 'I' THEN 'A' END
						)
					WHERE ID = @pidRol
					SET @codigo = 'OK';
					SET @msj = 'Se edito el estado rol de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END