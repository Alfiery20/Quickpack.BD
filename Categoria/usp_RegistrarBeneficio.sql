USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_RegistrarBeneficio') 
	BEGIN
		DROP PROCEDURE usp_RegistrarBeneficio;
	END
GO

CREATE PROCEDURE usp_RegistrarBeneficio
(
	@pidCategoria INT,
	@pdescripcion TEXT,
	@pbeneficiosXml XML,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			DECLARE @pCatXBene INT, @pIdCatXBeneNuevo INT;

			SELECT 
				@pCatXBene = ID 
			FROM CATEGORIAXBENEFICIO 
				WHERE IdCategoria = @pidCategoria

			DELETE FROM BENEFICIO WHERE IdCategoriaXBeneficio = @pCatXBene

			DELETE FROM CATEGORIAXBENEFICIO WHERE ID = @pCatXBene

			INSERT INTO CATEGORIAXBENEFICIO(Descripcion, IdCategoria)
			VALUES(@pdescripcion, @pidCategoria)

			SET @pIdCatXBeneNuevo = SCOPE_IDENTITY();

			INSERT INTO BENEFICIO (Nombre, IdCategoriaXBeneficio)
			SELECT
			  TRIM(B.value('(Nombre)[1]', 'NVARCHAR(150)')) AS Nombre,
			  @pIdCatXBeneNuevo AS IdCategoriaXBeneficio
			FROM @pbeneficiosXml.nodes('/Beneficios/Beneficio') AS T(B);

			SET @codigo = 'OK'
			SET @msj = 'Se registro los beneficios de forma satisfactoria.'

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END