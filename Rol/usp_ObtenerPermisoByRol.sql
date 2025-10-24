USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerPermisoByRol') 
	BEGIN
		DROP PROCEDURE usp_ObtenerPermisoByRol;
	END
GO

CREATE PROCEDURE usp_ObtenerPermisoByRol
(
	@pIdRol INT
)
AS
BEGIN
	SELECT
		MENU.ID AS [ID],
		MENU.Nombre AS [NOMBRE],
		MENU.MenuPadre AS [PADRE],
		ASIG.ID AS [IS_PERMISO]
	FROM MENU MENU
	LEFT JOIN MENUXROL ASIG ON ASIG.IdMenu = MENU.ID AND ASIG.IdRol = @pIdRol
	--WHERE ASIG.IdRol = @pIdRol

END