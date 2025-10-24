USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_AgregarCaracteristica') 
	BEGIN
		DROP PROCEDURE usp_AgregarCaracteristica;
	END
GO

CREATE PROCEDURE usp_AgregarCaracteristica
(
	@pidCategoria INT,
	@pnombre VARCHAR(250),
	@pdescripcion TEXT,
	@parchivo VARCHAR(MAX),
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO CARACTERISTICA(Nombre, Descripcion, IdCategoria, Multimedia)
			VALUES(@pnombre, @pdescripcion, @pidCategoria, @parchivo)

			SET @codigo = 'OK';
			SET @msj = 'Se registro la caracteristica de forma satisfactoria.';

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END