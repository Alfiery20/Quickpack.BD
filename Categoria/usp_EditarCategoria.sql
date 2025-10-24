USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarCategoria') 
	BEGIN
		DROP PROCEDURE usp_EditarCategoria;
	END
GO

CREATE PROCEDURE usp_EditarCategoria
(
	@pidCategoria INT,
	@pnombre VARCHAR(250),
	@pdescripcion TEXT,
	@pidTipoProducto INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @CategoriaExistente INT

			SELECT @CategoriaExistente = COUNT(Id) FROM CATEGORIA WHERE Nombre = @pnombre AND ID <> @pidCategoria

			IF(@CategoriaExistente != 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Nombre de Categoria existente.';
				END
			ELSE
				BEGIN
					UPDATE CATEGORIA 
						SET Nombre = @pnombre, Descripcion = @pdescripcion, IdTipoProducto = @pidTipoProducto
					WHERE ID = @pidCategoria
					SET @codigo = 'OK';
					SET @msj = 'Se edito la Categoria de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END