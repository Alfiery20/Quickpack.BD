USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerBeneficioCategoriaLanding') 
	BEGIN
		DROP PROCEDURE usp_ObtenerBeneficioCategoriaLanding;
	END
GO

CREATE PROCEDURE usp_ObtenerBeneficioCategoriaLanding
(
	@pIdCategoria INT,
	@descripcion TEXT OUTPUT
)
AS
BEGIN

	SELECT 
		@descripcion = CATXBENE.Descripcion
	FROM CATEGORIAXBENEFICIO CATXBENE
	WHERE CATXBENE.IdCategoria = @pIdCategoria

	SELECT
		BENE.ID AS [ID],
		BENE.Nombre AS [NOMBRE]
	FROM CATEGORIAXBENEFICIO CATXBENE
	LEFT JOIN BENEFICIO BENE ON BENE.IdCategoriaXBeneficio = CATXBENE.ID
	WHERE CATXBENE.IdCategoria = @pIdCategoria

END