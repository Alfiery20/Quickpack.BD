USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarFichaTecnica') 
	BEGIN
		DROP PROCEDURE usp_EditarFichaTecnica;
	END
GO

CREATE PROCEDURE usp_EditarFichaTecnica
(
	@pidProducto INT,
	@plargoCamara DECIMAL(10, 4),
	@panchoCamara DECIMAL(10, 4),
	@paltoCamara DECIMAL(10, 4),

	@plargoMaquina DECIMAL(10, 4),
	@panchoMaquina DECIMAL(10, 4),
	@paltoMaquina DECIMAL(10, 4),

	@pbarraSellado DECIMAL(10, 4),
	@pcapacidadBomba DECIMAL(10, 4),
	@pcicloInferior INT,
	@pcicloSuperior INT,

	@ppeso DECIMAL(10, 4),
	@ppotencia DECIMAL(10, 4),

	@pplacaInsercion INT,
	@psistemaControl VARCHAR(250),
	@pdeteccionVacioFinal VARCHAR(250),
	@pdeteccionCarne VARCHAR(250),
	@psoftAir VARCHAR(250),
	@pcontrolLiquidos VARCHAR(250),

	@codigo VARCHAR(10) OUTPUT,
	@msj VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @ProductoExistente INT

			SELECT @ProductoExistente = COUNT(Id) FROM PRODUCTO WHERE ID = @pidProducto

			IF(@ProductoExistente = 0)
				BEGIN
					SET @codigo = 'E1';
					SET @msj = 'Producto no existe, contacte con sistema.';
				END
			ELSE
				BEGIN
					UPDATE FICHA_TECNICA
						SET LargoCamara = @plargoCamara,
							AnchoCamara = @panchoCamara,
							AltoCamara = @paltoCamara,
							LargoMaquina = @plargoMaquina,
							AnchoMaquina = @panchoMaquina,
							AltoMaquina = @paltoMaquina,
							BarraSellado = @pbarraSellado,
							CapacidadBomba = @pcapacidadBomba,
							CicloInferior = @pcicloInferior,
							CicloSuperior = @pcicloSuperior,
							Peso = @ppeso,
							Potencia = @ppotencia,
							PlacaInsercion = @pplacaInsercion,
							SistemaControl = @psistemaControl,
							DeteccionVacioFinal = @pdeteccionVacioFinal,
							DeteccionCarne = @pdeteccionCarne,
							SoftAir = @psoftAir,
							ControlLiquidos = @pcontrolLiquidos
					WHERE IdProducto = @pidProducto;
					SET @codigo = 'OK';
					SET @msj = 'Se edito la Ficha Tecnica de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END