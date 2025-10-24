USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarEstadoCategoria') 
	BEGIN
		DROP PROCEDURE usp_EditarEstadoCategoria;
	END
GO

CREATE PROCEDURE usp_EditarEstadoCategoria
(
	@pidCategoria INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @CategoriaExistente INT

			SELECT @CategoriaExistente = COUNT(Id) FROM CATEGORIA WHERE ID = @pidCategoria

			IF(@CategoriaExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Categoria no existe, contactar con servicio.';
				END
			ELSE
				BEGIN

					DECLARE @Estado CHAR(1) = '';

					SELECT 
						@Estado = Estado 
					FROM CATEGORIA 
					WHERE ID = @pidCategoria

					UPDATE CATEGORIA 
						SET Estado = (
							CASE @Estado
								WHEN 'A' THEN 'I'
								WHEN 'I' THEN 'A' END
						)
					WHERE ID = @pidCategoria
					SET @codigo = 'OK';
					SET @msj = 'Se edito el estado de Categoria de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END