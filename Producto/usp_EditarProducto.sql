USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarProducto') 
	BEGIN
		DROP PROCEDURE usp_EditarProducto;
	END
GO

CREATE PROCEDURE usp_EditarProducto
(
	@pid INT,
	@pnombre VARCHAR(250),
	@pdescripcion TEXT,
	@pidCategoria INT,
	@pmultimedia TEXT,
	@pprecio DECIMAL(10,2),
	@pidUsuario INT,
	@pfecha DATETIME,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @ProductoExistente INT

			SELECT @ProductoExistente = COUNT(Id) FROM PRODUCTO WHERE Nombre = @pnombre AND ID <> @pid

			IF(@ProductoExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Producto existente.';
				END
			ELSE
				BEGIN
					UPDATE PRODUCTO SET 
						Nombre = @pnombre,
						Descripcion = @pdescripcion,
						IdCategoria = @pidCategoria,
						Multimedia = @pmultimedia,
						IdUsuarioModificar = @pidUsuario,
						FechaModificar = @pfecha
					WHERE ID = @pid

					UPDATE PRECIO SET Activo = 0 WHERE IdProducto = @pid

					INSERT INTO PRECIO(Monto, Activo, IdProducto) VALUES(@pprecio, 1, @pid)

					SET @codigo = 'OK';
					SET @msj = 'Se edito el Producto de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END