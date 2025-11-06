USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_EditarTipoProducto;
	END
GO

CREATE PROCEDURE usp_EditarTipoProducto
(
	@pidTipoProducto INT,
	@pnombre VARCHAR(250),
	@pdescripcion TEXT,
	@pmultimedia TEXT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @TipoProductoExistente INT

			SELECT @TipoProductoExistente = COUNT(Id) FROM TIPO_PRODUCTO WHERE Nombre = @pnombre AND ID <> @pidTipoProducto

			IF(@TipoProductoExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Tipo de Producto existente.';
				END
			ELSE
				BEGIN
					UPDATE TIPO_PRODUCTO SET 
						Nombre = @pnombre,
						Descripcion = @pdescripcion,
						Multimedia = @pmultimedia
					WHERE ID = @pidTipoProducto

					SET @codigo = 'OK';
					SET @msj = 'Se edito el Tipo de Producto de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END