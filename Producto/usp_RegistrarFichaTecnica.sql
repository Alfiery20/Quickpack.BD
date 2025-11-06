USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_RegistrarFichaTecnica') 
	BEGIN
		DROP PROCEDURE usp_RegistrarFichaTecnica;
	END
GO

CREATE PROCEDURE usp_RegistrarFichaTecnica
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
					INSERT INTO FICHA_TECNICA(
							LargoCamara, AnchoCamara, AltoCamara, 
							LargoMaquina, AnchoMaquina, AltoMaquina,
							BarraSellado, CapacidadBomba, 
							CicloInferior, CicloSuperior,
							Peso, Potencia,
							PlacaInsercion, SistemaControl, 
							DeteccionVacioFinal, DeteccionCarne, SoftAir,
							ControlLiquidos, IdProducto)
					VALUES(
						@plargoCamara, @panchoCamara, @paltoCamara,
						@plargoMaquina, @panchoMaquina, @paltoMaquina,
						@pbarraSellado, @pcapacidadBomba,
						@pcicloInferior, @pcicloSuperior,
						@ppeso, @ppotencia,
						@pplacaInsercion, @psistemaControl,
						@pdeteccionVacioFinal, @pdeteccionCarne, @psoftAir,
						@pcontrolLiquidos, @pidProducto)

					SET @codigo = 'OK';
					SET @msj = 'Se registró la Ficha Tecnica de forma satisfactoria.';
				END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SET @codigo = 'EX';
		SET @msj = ERROR_MESSAGE();
	END CATCH
END