USE QuickpackPeru;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerFichaTecnica') 
	BEGIN
		DROP PROCEDURE usp_VerFichaTecnica;
	END
GO

CREATE PROCEDURE usp_VerFichaTecnica
(
	@pidProducto INT
)
AS
BEGIN
	SELECT
		FIC_TEC.ID AS [ID],
		FIC_TEC.LargoCamara AS [LARGO_CAMARA],
		FIC_TEC.AnchoCamara AS [ANCHO_CAMARA],
		FIC_TEC.AltoCamara AS [ALTO_CAMARA],
		FIC_TEC.LargoMaquina AS [LARGO_MAQUINA],
		FIC_TEC.AnchoMaquina AS [ANCHO_MAQUINA],
		FIC_TEC.AltoMaquina AS [ALTO_MAQUINA],
		FIC_TEC.BarraSellado AS [BARRA_SELLADO],
		FIC_TEC.CapacidadBomba AS [CAPACIDAD_BOMBA],
		FIC_TEC.CicloInferior AS [CICLO_INFERIOR],
		FIC_TEC.CicloSuperior AS [CICLO_SUPERIOR],
		FIC_TEC.Peso AS [PESO],
		FIC_TEC.Potencia AS [POTENCIA],
		FIC_TEC.PlacaInsercion AS [PLACA_INSERCION],
		FIC_TEC.SistemaControl AS [SISTEMA_CONTROL],
		FIC_TEC.DeteccionVacioFinal AS [DETECCION_VACIO_FINAL],
		FIC_TEC.DeteccionCarne AS [DETECCION_CARNE],
		FIC_TEC.SoftAir AS [SOFTAIR],
		FIC_TEC.ControlLiquidos AS [CONTROL_LIQUIDOS]
	FROM FICHA_TECNICA FIC_TEC
	WHERE 
		FIC_TEC.IdProducto = @pidProducto
END