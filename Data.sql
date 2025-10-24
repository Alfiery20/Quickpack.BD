INSERT INTO ROL(Nombre, Estado) VALUES('Admin', 'A')

INSERT INTO EMPLEADO(TipoDocumento, NumeroDocumento, 
				Nombre, ApellidoPaterno, ApellidoMaterno, 
				Telefono, Correo, Clave, Estado, IdRol)
		VALUES('1', '74128515', 'Rodolfo Alfiery', 'Furlong',
				'Millones', '966676402', 'alfiery@gmail.com', 
				'RTBEODQ2WVBNVUxucXhzeFJXN3FVdz09', 'A', 1)

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Configuracion', 'configuracion', 1, null, 'bi-gear-fill')

DECLARE @idMenuConfiguracion INT, @idMenuRol INT, @idMenuPersonal INT;
SET @idMenuConfiguracion = SCOPE_IDENTITY();

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Rol', 'rol', 1, @idMenuConfiguracion, 'bi-shield-lock-fill')
SET @idMenuRol = SCOPE_IDENTITY();

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Personal', 'personal', 2, @idMenuConfiguracion, 'bi-people-fill')
SET @idMenuPersonal = SCOPE_IDENTITY();

----------------------------------------------------------------------------

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Gestión Comercial', 'gestion', 2, null, 'bi-briefcase-fill')

DECLARE @idMenuGestionComercial INT, @idMenuTipoProducto INT, @idMenuCategoria INT, @idMenuProducto INT;
SET @idMenuGestionComercial = SCOPE_IDENTITY();

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Tipo de Producto', 'tipoproducto', 1, @idMenuGestionComercial, 'bi-journal')
SET @idMenuTipoProducto = SCOPE_IDENTITY();

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Categoria', 'categoria', 2, @idMenuGestionComercial, 'bi-tags-fill')
SET @idMenuCategoria = SCOPE_IDENTITY();

INSERT INTO MENU(Nombre, Ruta, Orden, MenuPadre, Icono)
		VALUES('Producto', 'producto', 3, @idMenuGestionComercial, 'bi-box-seam')
SET @idMenuProducto = SCOPE_IDENTITY();

INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuConfiguracion, 1)
INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuRol, 1)
INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuPersonal, 1)

INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuGestionComercial, 1)
INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuTipoProducto, 1)
INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuCategoria, 1)
INSERT INTO MENUXROL(IdMenu, IdRol) VALUES(@idMenuProducto, 1)