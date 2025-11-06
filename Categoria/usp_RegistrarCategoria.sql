USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_RegistrarCategoria') 
	BEGIN
		DROP PROCEDURE usp_RegistrarCategoria;
	END
GO

CREATE PROCEDURE usp_RegistrarCategoria
(
	@pnombre VARCHAR(250),
	@pdescripcion TEXT,
	@pidTipoProducto INT,
	@pmultimedia TEXT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @CategoriaExistente INT

			SELECT @CategoriaExistente = COUNT(Id) FROM CATEGORIA WHERE Nombre = @pnombre

			IF(@CategoriaExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Categoria existente.';
				END
			ELSE
				BEGIN
					INSERT INTO CATEGORIA(Nombre, Descripcion, Multimedia, Estado, IdTipoProducto)
					VALUES(@pnombre, @pdescripcion, @pmultimedia, 'A', @pidTipoProducto)
					SET @codigo = 'OK';
					SET @msj = 'Se registró la Categoria de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END