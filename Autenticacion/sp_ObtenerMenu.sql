USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerMenu') 
	BEGIN
		DROP PROCEDURE sp_ObtenerMenu;
	END
GO

CREATE PROCEDURE sp_ObtenerMenu
(
	@pIdRol INT,
	@pIdUsuario INT
)
AS
BEGIN
	DECLARE @UsuarioCorrecto INT = 0;
	SELECT 
		@UsuarioCorrecto = COUNT(Id) 
	FROM EMPLEADO EMPL
	WHERE EMPL.Id = @pIdUsuario AND EMPL.IdRol = @pIdRol

	IF(@UsuarioCorrecto <> 0)
	BEGIN
		SELECT 
			MENU.Id AS [ID],
			MENU.Nombre AS [NOMBRE], 
			MENU.Ruta AS [RUTA],
			MENU.MenuPadre AS [ID_PADRE],
			MENU.Orden AS [ORDEN],
			MENU.Icono AS [ICONO]
		FROM ROL ROL
		INNER JOIN MENUXROL MENUXROL ON MENUXROL.IdRol = ROL.Id
		INNER JOIN MENU MENU ON MENU.Id = MENUXROL.IdMenu
		WHERE ROL.Id = @pIdRol
	END
END