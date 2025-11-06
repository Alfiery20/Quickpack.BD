USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_RegistrarTipoProducto') 
	BEGIN
		DROP PROCEDURE usp_RegistrarTipoProducto;
	END
GO

CREATE PROCEDURE usp_RegistrarTipoProducto
(
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

			SELECT @TipoProductoExistente = COUNT(Id) FROM TIPO_PRODUCTO WHERE Nombre = @pnombre

			IF(@TipoProductoExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de tipo de producto existente.';
				END
			ELSE
				BEGIN
					INSERT INTO TIPO_PRODUCTO(Nombre, Descripcion, Multimedia, Estado)
					VALUES(@pnombre, @pdescripcion, @pmultimedia, 'A')
					SET @codigo = 'OK';
					SET @msj = 'Se registró el tipo de producto de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END