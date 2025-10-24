USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ActualizarPermiso') 
	BEGIN
		DROP PROCEDURE usp_ActualizarPermiso;
	END
GO

CREATE PROCEDURE usp_ActualizarPermiso
(
	@pIdPermiso BIT,
	@pIdMenu INT,
	@pIdRol INT,
	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF(@pIdPermiso = 0)
			BEGIN 
				INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@pIdMenu, @pIdRol)
				SET @codigo = 'OK';
				SET @msj = 'Permiso otorgado.';
			END
			ELSE
			BEGIN
				DELETE FROM MENUXROL WHERE IdMenu = @pIdMenu AND IdRol = @pIdRol
				SET @codigo = 'OK';
				SET @msj = 'Permiso removido.';
			END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END