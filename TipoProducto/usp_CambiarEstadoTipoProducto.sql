USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_CambiarEstadoTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_CambiarEstadoTipoProducto;
	END
GO

CREATE PROCEDURE usp_CambiarEstadoTipoProducto
(
	@pidTipoProducto INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @TipoProductoExistente INT

			SELECT @TipoProductoExistente = COUNT(Id) FROM TIPO_PRODUCTO WHERE ID = @pidTipoProducto

			IF(@TipoProductoExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Tipo de Producto no existe, contactar con servicio.';
				END
			ELSE
				BEGIN

					DECLARE @Estado CHAR(1) = '';

					SELECT 
						@Estado = Estado 
					FROM TIPO_PRODUCTO 
					WHERE ID = @pidTipoProducto

					UPDATE TIPO_PRODUCTO 
						SET Estado = (
							CASE @Estado
								WHEN 'A' THEN 'I'
								WHEN 'I' THEN 'A' END
						)
					WHERE ID = @pidTipoProducto
					SET @codigo = 'OK';
					SET @msj = 'Se edito el estado Tipo de Producto de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END