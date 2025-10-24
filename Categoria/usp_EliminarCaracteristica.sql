USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EliminarCaracteristica') 
	BEGIN
		DROP PROCEDURE usp_EliminarCaracteristica;
	END
GO

CREATE PROCEDURE usp_EliminarCaracteristica
(
	@pidCaracteristica INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN

	BEGIN TRY
		BEGIN TRANSACTION

			DELETE FROM CARACTERISTICA WHERE ID = @pidCaracteristica

			SET @codigo = 'OK';
			SET @msj = 'Se elimino la caracteristica de forma satisfactoria.';

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION;
	END CATCH

END