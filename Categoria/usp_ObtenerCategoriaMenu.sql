USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerCategoriaMenu') 
	BEGIN
		DROP PROCEDURE usp_ObtenerCategoriaMenu;
	END
GO

CREATE PROCEDURE usp_ObtenerCategoriaMenu
AS
BEGIN
	SELECT
		CATE.Id AS [ID],
		CATE.Nombre AS [NOMBRE]
	FROM CATEGORIA CATE
	WHERE 
		CATE.Estado = 'A'
	ORDER BY CATE.ID
END