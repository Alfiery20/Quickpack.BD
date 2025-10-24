USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerBeneficio') 
	BEGIN
		DROP PROCEDURE usp_ObtenerBeneficio;
	END
GO

CREATE PROCEDURE usp_ObtenerBeneficio
(
	@pidCategoria INT,
	@descripcion TEXT OUTPUT
)
AS
BEGIN
	
	SELECT 
		@descripcion = Descripcion
	FROM CATEGORIAXBENEFICIO 
		WHERE IdCategoria = @pidCategoria

	SELECT 
		BEN.ID AS [ID],
		BEN.Nombre AS [NOMBRE]
	FROM BENEFICIO BEN
	INNER JOIN CATEGORIAXBENEFICIO CAT_BENE ON CAT_BENE.ID = BEN.IdCategoriaXBeneficio
	WHERE CAT_BENE.IdCategoria = @pidCategoria
END