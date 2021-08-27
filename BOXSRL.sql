-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Almacen` (
  `IDAlmacen` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Codigo Postal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDAlmacen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Articulos` (
  `IDArticulos` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Stock` INT NOT NULL,
  `U.M` VARCHAR(10) NOT NULL,
  `P. Unitario` INT NOT NULL,
  `Tipo` VARCHAR(30) NULL,
  PRIMARY KEY (`IDArticulos`),
  INDEX `IDAlmacen` (`IDAlmacen` ASC) ,
  CONSTRAINT `IDAlmacen`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`Almacen` (`IDAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveedores` (
  `IDProveedores` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(30) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `CUIT` INT NOT NULL,
  PRIMARY KEY (`IDProveedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sucursal` (
  `IDSucursal` INT NOT NULL,
  `Codigo Postal` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDSucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleados` (
  `IDEmpleados` INT NOT NULL,
  `IDSucursal` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(30) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `DNI` INT NOT NULL,
  `CUIT` INT NOT NULL,
  PRIMARY KEY (`IDEmpleados`),
  INDEX `IDSucursal` (`IDSucursal` ASC) ,
  CONSTRAINT `IDSucursal`
    FOREIGN KEY (`IDSucursal`)
    REFERENCES `mydb`.`Sucursal` (`IDSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `IDCliente` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `CUIT` INT NOT NULL,
  PRIMARY KEY (`IDCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Maestro_Procesos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Maestro_Procesos` (
  `IDProceso` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Orden` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDProceso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `IDProductos` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDProceso` INT NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Costo` INT NOT NULL,
  `Margen` VARCHAR(45) NOT NULL,
  `P. Venta` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDProductos`),
  INDEX `IDClientes` (`IDCliente` ASC) ,
  INDEX `IDProceso` (`IDProceso` ASC) ,
  CONSTRAINT `IDClientes`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`Clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProcesoFK`
    FOREIGN KEY (`IDProceso`)
    REFERENCES `mydb`.`Maestro_Procesos` (`IDProceso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recetas` (
  `IDReceta` INT NOT NULL,
  `IDProductos` INT NOT NULL,
  `IDProceso` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`IDReceta`),
  INDEX `IDProducto` (`IDProductos` ASC) ,
  INDEX `IDProceso` (`IDProceso` ASC) ,
  CONSTRAINT `IDProceso`
    FOREIGN KEY (`IDProceso`)
    REFERENCES `mydb`.`Maestro_Procesos` (`IDProceso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProducto`
    FOREIGN KEY (`IDProductos`)
    REFERENCES `mydb`.`Productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Materiales_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Materiales_Producto` (
  `IDMaterial` INT NOT NULL,
  `IDProveedor` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `IDProducto` INT NOT NULL,
  `IDReceta` INT NOT NULL,
  `Planos` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `P. Unitario` INT NOT NULL,
  `Stock` INT NOT NULL,
  `U.M` VARCHAR(12) NOT NULL,
  `Costo` INT NOT NULL,
  `Margen` VARCHAR(45) NOT NULL,
  `Precio_Venta` INT NOT NULL,
  `Fecha_Alta` DATETIME NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDMaterial`),
  INDEX `IDProveedor` (`IDProveedor` ASC) ,
  INDEX `IDCliente` (`IDCliente` ASC) ,
  INDEX `IDAlmacen` (`IDAlmacen` ASC) ,
  INDEX `IDProducto` (`IDProducto` ASC) ,
  INDEX `IDReceta` (`IDReceta` ASC) ,
  CONSTRAINT `IDProveedor_MP`
    FOREIGN KEY (`IDProveedor`)
    REFERENCES `mydb`.`Proveedores` (`IDProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDClientes_MP`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`Clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDAlmacen_MP`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`Almacen` (`IDAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProducto_MP`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`Productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDReceta_MP`
    FOREIGN KEY (`IDReceta`)
    REFERENCES `mydb`.`Recetas` (`IDReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrdenPedidoCompras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrdenPedidoCompras` (
  `IDPedido` INT NOT NULL,
  `IDArticulos` INT NOT NULL,
  `IDMaterial` INT NOT NULL,
  `IDProveedor` INT NOT NULL,
  `IDSucursal` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `FechaCreacion` DATETIME NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `P. Unitario` INT NOT NULL,
  `IVA` VARCHAR(10) NOT NULL,
  `Importe` INT NOT NULL,
  PRIMARY KEY (`IDPedido`),
  INDEX `IDArticulos` (`IDArticulos` ASC) ,
  INDEX `IDMaterial` (`IDMaterial` ASC) ,
  INDEX `IDProveedor` (`IDProveedor` ASC) ,
  INDEX `IDSucursal` (`IDSucursal` ASC) ,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) ,
  CONSTRAINT `IDArticulos_OPC`
    FOREIGN KEY (`IDArticulos`)
    REFERENCES `mydb`.`Articulos` (`IDArticulos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDMaterial_OPC`
    FOREIGN KEY (`IDMaterial`)
    REFERENCES `mydb`.`Materiales_Producto` (`IDMaterial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProveedor_OPC`
    FOREIGN KEY (`IDProveedor`)
    REFERENCES `mydb`.`Proveedores` (`IDProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDSucursal_OPC`
    FOREIGN KEY (`IDSucursal`)
    REFERENCES `mydb`.`Sucursal` (`IDSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDEmpleado_OPC`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`Empleados` (`IDEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

 
-- -----------------------------------------------------
-- Table `mydb`.`Operarios_Almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Operarios_Almacen` (
  `IDOperarioA` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `DNI` INT NOT NULL,
  PRIMARY KEY (`IDOperarioA`),
  INDEX `IDAlmacen` (`IDAlmacen` ASC) ,
  CONSTRAINT `IDAlmacen_OA`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`Almacen` (`IDAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plantas_Fabricacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plantas_Fabricacion` (
  `IDPlanta` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Codigo Postal` INT NOT NULL,
  PRIMARY KEY (`IDPlanta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orden_Acopio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orden_Acopio` (
  `IDAcopio` INT NOT NULL,
  `IDOperarioA` INT NOT NULL,
  `IDMaterial` INT NOT NULL,
  `IDPlanta` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Cantidad` VARCHAR(45) NOT NULL,
  `Destino` VARCHAR(45) NOT NULL,
  `Detalles` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDAcopio`),
  INDEX `IDOperarioAFK` (`IDOperarioA` ASC) ,
  INDEX `IDMaterial_idx` (`IDMaterial` ASC) ,
  INDEX `IDAlmacen_idx` (`IDAlmacen` ASC) ,
  INDEX `IDPlantaFK` (`IDPlanta` ASC) ,
  CONSTRAINT `IDOperarioAFK_OAC`
    FOREIGN KEY (`IDOperarioA`)
    REFERENCES `mydb`.`Operarios_Almacen` (`IDOperarioA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDMaterial_OAC`
    FOREIGN KEY (`IDMaterial`)
    REFERENCES `mydb`.`Materiales_Producto` (`IDMaterial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDPlanta_OAC`
    FOREIGN KEY (`IDPlanta`)
    REFERENCES `mydb`.`Plantas_Fabricacion` (`IDPlanta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDAlmacen_OAC`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`Almacen` (`IDAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FacturaC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FacturaC` (
  `IDFactura` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `FechaEntrega` DATE NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IDFactura`),
  INDEX `IDCliente` (`IDCliente` ASC) ,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) ,
  CONSTRAINT `IDCliente_FC`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`Clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDEmpleado_FC`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`Empleados` (`IDEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Formas_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Formas_Pago` (
  `IDPago` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orden_Fabricacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orden_Fabricacion` (
  `IDFabricado` INT NOT NULL,
  `IDFactura` INT NOT NULL,
  `IDPlanta` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDPago` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `FechaCreacion` DATETIME NOT NULL,
  `FechaAlta` DATETIME NOT NULL,
  `FechaEntrega` DATETIME NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Contacto` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`IDFabricado`),
  INDEX `IDFactura` (`IDFactura` ASC) ,
  INDEX `IDPlanta` (`IDPlanta` ASC) ,
  INDEX `IDCliente` (`IDCliente` ASC) ,
  INDEX `IDPago` (`IDPago` ASC) ,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) ,
  CONSTRAINT `IDFactura_OF`
    FOREIGN KEY (`IDFactura`)
    REFERENCES `mydb`.`FacturaC` (`IDFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDPlanta_OF`
    FOREIGN KEY (`IDPlanta`)
    REFERENCES `mydb`.`Plantas_Fabricacion` (`IDPlanta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDCliente_OF`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`Clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDPago_OF`
    FOREIGN KEY (`IDPago`)
    REFERENCES `mydb`.`Formas_Pago` (`IDPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDEmpleado_OF`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`Empleados` (`IDEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial_Compra` (
  `IDPedido` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Costo` INT NOT NULL,
  INDEX `IDPedido` (`IDPedido` ASC) ,
  CONSTRAINT `IDPedido_HC`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `mydb`.`OrdenPedidoCompras` (`IDPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venta_Producto` (
  `IDVenta` INT NOT NULL,
  `IDProducto` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `IDPago` INT NOT NULL,
  `Cantidad` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `IVA` INT NOT NULL,
  `Precio` INT NOT NULL,
  `Importe` INT NOT NULL,
  PRIMARY KEY (`IDVenta`),
  INDEX `IDProducto` (`IDProducto` ASC) ,
  INDEX `IDCliente` (`IDCliente` ASC) ,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) ,
  INDEX `IDPago` (`IDPago` ASC) ,
  CONSTRAINT `IDProductoFK_VP`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`Productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDClienteFK_VP`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`Clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDEmpleadoFK_VP`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`Empleados` (`IDEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial_Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial_Ventas` (
  `IDVenta` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Fecha` VARCHAR(45) NOT NULL,
  `Insumo` VARCHAR(45) NOT NULL,
  INDEX `IDVenta` (`IDVenta` ASC) ,
  CONSTRAINT `IDVenta_HV`
    FOREIGN KEY (`IDVenta`)
    REFERENCES `mydb`.`Venta_Producto` (`IDVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orden_Fabricacion_Detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orden_Fabricacion_Detalle` (
  `IDFabricado` INT NOT NULL,
  `IDProducto` INT NOT NULL,
  `Item` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `P.Unitario` DECIMAL(8,2) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Importe` DECIMAL(8,2) NOT NULL,
  INDEX `IDFabricado` (`IDFabricado` ASC) ,
  INDEX `IDProducto` (`IDProducto` ASC) ,
  CONSTRAINT `IDFabricado_OFD`
    FOREIGN KEY (`IDFabricado`)
    REFERENCES `mydb`.`Orden_Fabricacion` (`IDFabricado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProducto_OFD`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`Productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura_Detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura_Detalle` (
  `IDFactura` INT NOT NULL,
  `IDProducto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `IVA` VARCHAR(45) NOT NULL,
  `Precio` DECIMAL(8,2) NOT NULL,
  `Importe` DECIMAL(8,2) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  INDEX `IDFactura` (`IDFactura` ASC) ,
  INDEX `IDProducto` (`IDFactura` ASC) ,
  INDEX `IDProducto_idx` (`IDProducto` ASC) ,
  CONSTRAINT `IDFactura_FD`
    FOREIGN KEY (`IDFactura`)
    REFERENCES `mydb`.`FacturaC` (`IDFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDProducto_FD`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`Productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
