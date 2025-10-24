USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerRol') 
	BEGIN
		DROP PROCEDURE usp_VerRol;
	END
GO

CREATE PROCEDURE usp_VerRol
(
	@pIdRol INT
)
AS
BEGIN
	SELECT
		ROL.Id AS [ID],
		ROL.Nombre AS [NOMBRE]
	FROM ROL ROL
	WHERE 
		ROL.ID = @pIdRol
END