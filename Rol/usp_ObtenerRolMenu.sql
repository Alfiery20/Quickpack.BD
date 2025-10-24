USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerRolMenu') 
	BEGIN
		DROP PROCEDURE usp_ObtenerRolMenu;
	END
GO

CREATE PROCEDURE usp_ObtenerRolMenu
AS
BEGIN

	SELECT
		ROL.Id AS [ID],
		ROL.Nombre AS [NOMBRE]
	FROM ROL ROL
	WHERE Estado = 'A'
END