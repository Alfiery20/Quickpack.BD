USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_RegistrarProducto') 
	BEGIN
		DROP PROCEDURE usp_RegistrarProducto;
	END
GO

CREATE PROCEDURE usp_RegistrarProducto
(
	@pnombre VARCHAR(250),
	@pdescripcion VARCHAR(150),
	@pidCategoria INT,
	@pprecio DECIMAL(10,2),
	@pmultimedia TEXT,
	@pidUsuario INT,
	@pfecha DATETIME,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @ProductoExistente INT, @idNuevoProducto INT

			SELECT @ProductoExistente = COUNT(Id) FROM PRODUCTO WHERE Nombre = @pnombre

			IF(@ProductoExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Producto existente.';
				END
			ELSE
				BEGIN
					INSERT INTO PRODUCTO(Nombre, Descripcion, Multimedia, Estado, IdCategoria, IdUsuarioCrear, FechaCrear)
					VALUES(@pnombre, @pdescripcion, @pmultimedia, 'A', @pidCategoria, @pidUsuario, @pfecha)

					SET @idNuevoProducto = SCOPE_IDENTITY();

					INSERT INTO PRECIO(Monto, Activo, IdProducto) VALUES(@pprecio, 1, @idNuevoProducto)

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