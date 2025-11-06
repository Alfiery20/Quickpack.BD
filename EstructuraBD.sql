USE master;
GO

IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'QuickpackPeru') 
	BEGIN
		DROP DATABASE QuickpackPeru;
	END

CREATE DATABASE QuickpackPeru;
GO

USE QuickpackPeru;
GO

CREATE TABLE MENU
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(150),
	Ruta VARCHAR(MAX),
	Orden INT,
	MenuPadre INT,
	Icono VARCHAR(250),
	CONSTRAINT pk_menu
		PRIMARY KEY (ID),
	CONSTRAINT fk_menu_menuhijo
		FOREIGN KEY (MenuPadre)
		REFERENCES MENU(ID)
)

CREATE TABLE ROL
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(150),
	Estado CHAR(1),
	CONSTRAINT pk_rol
		PRIMARY KEY (ID)
)

CREATE TABLE MENUXROL
(
	ID INT IDENTITY(1,1),
	IdMenu INT,
	IdRol INT,
	CONSTRAINT pk_menuxrol
		PRIMARY KEY (ID),
	CONSTRAINT fk_menu_menuxrol
		FOREIGN KEY (IdMenu)
		REFERENCES MENU(ID),
	CONSTRAINT fk_rol_menuxrol
		FOREIGN KEY (IdRol)
		REFERENCES ROL(ID),
)

CREATE TABLE EMPLEADO
(
	ID INT IDENTITY(1,1),
	TipoDocumento CHAR(1),
	NumeroDocumento VARCHAR(35),
	Nombre VARCHAR(150),
	ApellidoPaterno VARCHAR(200),
	ApellidoMaterno VARCHAR(200),
	Telefono VARCHAR(9),
	Correo VARCHAR(200),
	Clave VARCHAR(MAX),
	Estado CHAR(1),
	IdRol INT,
	CONSTRAINT pk_empleado
		PRIMARY KEY (ID),
	CONSTRAINT fk_empleadoxrol
		FOREIGN KEY (IdRol)
		REFERENCES ROL(ID)
)

CREATE TABLE TIPO_PRODUCTO
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(250),
	Descripcion TEXT,
	Multimedia VARCHAR(MAX),
	Estado CHAR(1),
	CONSTRAINT pk_tipo_producto
		PRIMARY KEY (ID)
)

CREATE TABLE CATEGORIA
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(250),
	Descripcion TEXT,
	Multimedia VARCHAR(MAX),
	IdTipoProducto INT,
	Estado CHAR(1),
	CONSTRAINT pk_categoria
		PRIMARY KEY (ID),
	CONSTRAINT fk_categoriaxtipo_producto
		FOREIGN KEY (IdTipoProducto)
		REFERENCES TIPO_PRODUCTO(ID)
)

CREATE TABLE CATEGORIAXBENEFICIO
(
	ID INT IDENTITY(1,1),
	IdCategoria INT,
	Descripcion TEXT,
	CONSTRAINT pk_categoriaxbeneficio
		PRIMARY KEY (ID),
	CONSTRAINT fk_categoriaxbeneficio_categoria
		FOREIGN KEY (IdCategoria)
		REFERENCES CATEGORIA(ID)
)

CREATE TABLE BENEFICIO
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(150),
	IdCategoriaXBeneficio INT,
	CONSTRAINT pk_beneficio
		PRIMARY KEY (ID),
	CONSTRAINT fk_beneficio_categoriaxbeneficio
		FOREIGN KEY (IdCategoriaXBeneficio)
		REFERENCES CATEGORIAXBENEFICIO(ID)
)

CREATE TABLE PRODUCTO
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(150),
	Descripcion TEXT,
	Estado CHAR(1),
	IdCategoria INT,
	Multimedia VARCHAR(MAX),
	IdUsuarioCrear INT,
	FechaCrear DATETIME,
	IdUsuarioModificar INT,
	FechaModificar DATETIME,
	CONSTRAINT pk_producto
		PRIMARY KEY (ID),
	CONSTRAINT fk_producto_categoria
		FOREIGN KEY (IdCategoria)
		REFERENCES CATEGORIA(ID),
	CONSTRAINT fk_producto_usuariocrear
		FOREIGN KEY (IdUsuarioCrear)
		REFERENCES EMPLEADO(ID),
	CONSTRAINT fk_producto_usuariomodificar
		FOREIGN KEY (IdUsuarioModificar)
		REFERENCES EMPLEADO(ID)
)

CREATE TABLE FICHA_TECNICA
(
	ID INT IDENTITY(1,1),
	LargoCamara DECIMAL(10,4),
	AnchoCamara DECIMAL(10,4),
	AltoCamara DECIMAL(10,4),
	LargoMaquina DECIMAL(10,4),
	AnchoMaquina DECIMAL(10,4),
	AltoMaquina DECIMAL(10,4),
	BarraSellado DECIMAL(10,4),
	CapacidadBomba INT,
	CicloInferior INT,
	CicloSuperior INT,
	Peso DECIMAL(10,4),
	PotenciaSuperior DECIMAL(10,4),
	PotenciaInferior DECIMAL(10,4),
	PlacaInsercion INT,
	SistemaControl VARCHAR(250),
	DeteccionVacioFinal VARCHAR(250),
	DeteccionCarne VARCHAR(250),
	SoftAir VARCHAR(250),
	ControlLiquidos VARCHAR(250),
	IdProducto INT,
	CONSTRAINT pk_ficha_tecnica
		PRIMARY KEY (ID),
	CONSTRAINT fk_ficha_tecnicaxproducto
		FOREIGN KEY (IdProducto)
		REFERENCES PRODUCTO(ID)
)

CREATE TABLE PRECIO
(
	ID INT IDENTITY(1,1),
	Monto DECIMAL(10,2),
	Activo BIT,
	IdProducto INT,
	CONSTRAINT pk_precio
		PRIMARY KEY (ID),
	CONSTRAINT fk_precio_producto
		FOREIGN KEY (IdProducto)
		REFERENCES PRODUCTO(ID)
)

CREATE TABLE CARACTERISTICA
(
	ID INT IDENTITY(1,1),
	Nombre VARCHAR(150),
	Descripcion TEXT,
	Multimedia VARCHAR(MAX),
	IdCategoria INT,
	CONSTRAINT pk_caracteristica
		PRIMARY KEY (ID),
	CONSTRAINT fk_caracteristica_producto
		FOREIGN KEY (IdCategoria)
		REFERENCES CATEGORIA(ID)
)
