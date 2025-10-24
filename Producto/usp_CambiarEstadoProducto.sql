USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_CambiarEstadoProducto') 
	BEGIN
		DROP PROCEDURE usp_CambiarEstadoProducto;
	END
GO

CREATE PROCEDURE usp_CambiarEstadoProducto
(
	@pidProducto INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @ProductoExistente INT

			SELECT @ProductoExistente = COUNT(Id) FROM PRODUCTO WHERE ID = @pidProducto

			IF(@ProductoExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Producto no existe, contactar con servicio.';
				END
			ELSE
				BEGIN

					DECLARE @Estado CHAR(1);

					SELECT 
						@Estado = Estado 
					FROM PRODUCTO 
					WHERE ID = @pidProducto

					UPDATE PRODUCTO 
						SET Estado = (
							CASE @Estado
								WHEN 'A' THEN 'I'
								WHEN 'I' THEN 'A' END
						)
					WHERE ID = @pidProducto
					SET @codigo = 'OK';
					SET @msj = 'Se edito el estado del Producto de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END