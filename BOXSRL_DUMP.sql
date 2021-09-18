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
-- Table `mydb`.`almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`almacen` (
  `IDAlmacen` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Codigo Postal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDAlmacen`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`articulos` (
  `IDArticulos` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Stock` INT NOT NULL,
  `U.M` VARCHAR(10) NOT NULL,
  `P. Unitario` INT NOT NULL,
  `Tipo` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`IDArticulos`),
  INDEX `IDAlmacen` (`IDAlmacen` ASC) VISIBLE,
  CONSTRAINT `IDAlmacen`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`almacen` (`IDAlmacen`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `IDCliente` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `CUIT` INT NOT NULL,
  PRIMARY KEY (`IDCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sucursal` (
  `IDSucursal` INT NOT NULL,
  `Codigo Postal` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDSucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleados` (
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
  INDEX `IDSucursal` (`IDSucursal` ASC) VISIBLE,
  CONSTRAINT `IDSucursal`
    FOREIGN KEY (`IDSucursal`)
    REFERENCES `mydb`.`sucursal` (`IDSucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`factura_cabecera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factura_cabecera` (
  `IDFactura` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `FechaCreacion` DATE NOT NULL,
  `FechaEntrega` DATE NOT NULL,
  PRIMARY KEY (`IDFactura`),
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) VISIBLE,
  CONSTRAINT `IDCliente_FC`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`),
  CONSTRAINT `IDEmpleado_FC`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`empleados` (`IDEmpleados`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`maestro_procesos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`maestro_procesos` (
  `IDProceso` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Orden` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDProceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos` (
  `IDProductos` VARCHAR(45) NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDProceso` INT NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Costo` INT NOT NULL,
  `Margen` VARCHAR(45) NOT NULL,
  `P. Venta` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDProductos`),
  INDEX `IDClientes` (`IDCliente` ASC) VISIBLE,
  INDEX `IDProceso` (`IDProceso` ASC) VISIBLE,
  CONSTRAINT `IDClientes`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`),
  CONSTRAINT `IDProcesoFK`
    FOREIGN KEY (`IDProceso`)
    REFERENCES `mydb`.`maestro_procesos` (`IDProceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`factura_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factura_detalle` (
  `IDFactura` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `IVA` VARCHAR(45) NOT NULL,
  `Precio` DECIMAL(8,2) NOT NULL,
  `Importe` DECIMAL(8,2) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  INDEX `IDFactura` (`IDFactura` ASC) VISIBLE,
  INDEX `IDProducto` (`IDFactura` ASC) VISIBLE,
  INDEX `IDProducto_idx` (`IDProducto` ASC) VISIBLE,
  CONSTRAINT `IDFactura_FD`
    FOREIGN KEY (`IDFactura`)
    REFERENCES `mydb`.`factura_cabecera` (`IDFactura`),
  CONSTRAINT `IDProducto_FD`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`formas_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`formas_pago` (
  `IDPago` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDPago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedores` (
  `IDProveedores` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(30) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `CUIT` INT NOT NULL,
  PRIMARY KEY (`IDProveedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recetas` (
  `IDReceta` INT NOT NULL,
  `IDProductos` VARCHAR(45) NOT NULL,
  `IDProceso` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`IDReceta`),
  INDEX `IDProducto` (`IDProductos` ASC) VISIBLE,
  INDEX `IDProceso` (`IDProceso` ASC) VISIBLE,
  CONSTRAINT `IDProceso`
    FOREIGN KEY (`IDProceso`)
    REFERENCES `mydb`.`maestro_procesos` (`IDProceso`),
  CONSTRAINT `IDProducto`
    FOREIGN KEY (`IDProductos`)
    REFERENCES `mydb`.`productos` (`IDProductos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`materiales_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`materiales_producto` (
  `IDMaterial` INT NOT NULL,
  `IDProveedor` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
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
  INDEX `IDProveedor` (`IDProveedor` ASC) VISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  INDEX `IDAlmacen` (`IDAlmacen` ASC) VISIBLE,
  INDEX `IDProducto` (`IDProducto` ASC) VISIBLE,
  INDEX `IDReceta` (`IDReceta` ASC) VISIBLE,
  CONSTRAINT `IDAlmacen_MP`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`almacen` (`IDAlmacen`),
  CONSTRAINT `IDClientes_MP`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`),
  CONSTRAINT `IDProducto_MP`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`),
  CONSTRAINT `IDProveedor_MP`
    FOREIGN KEY (`IDProveedor`)
    REFERENCES `mydb`.`proveedores` (`IDProveedores`),
  CONSTRAINT `IDReceta_MP`
    FOREIGN KEY (`IDReceta`)
    REFERENCES `mydb`.`recetas` (`IDReceta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pedido_orden_cabecera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido_orden_cabecera` (
  `IDPedido` INT NOT NULL,
  `IDArticulos` INT NOT NULL,
  `IDMaterial` INT NOT NULL,
  `IDProveedor` INT NOT NULL,
  `IDSucursal` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `FechaCreacion` DATETIME NOT NULL,
  `FechaEntrega` DATETIME NOT NULL,
  PRIMARY KEY (`IDPedido`),
  INDEX `IDArticulos` (`IDArticulos` ASC) VISIBLE,
  INDEX `IDMaterial` (`IDMaterial` ASC) VISIBLE,
  INDEX `IDProveedor` (`IDProveedor` ASC) VISIBLE,
  INDEX `IDSucursal` (`IDSucursal` ASC) VISIBLE,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) VISIBLE,
  CONSTRAINT `IDArticulos_OPC`
    FOREIGN KEY (`IDArticulos`)
    REFERENCES `mydb`.`articulos` (`IDArticulos`),
  CONSTRAINT `IDEmpleado_OPC`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`empleados` (`IDEmpleados`),
  CONSTRAINT `IDMaterial_OPC`
    FOREIGN KEY (`IDMaterial`)
    REFERENCES `mydb`.`materiales_producto` (`IDMaterial`),
  CONSTRAINT `IDProveedor_OPC`
    FOREIGN KEY (`IDProveedor`)
    REFERENCES `mydb`.`proveedores` (`IDProveedores`),
  CONSTRAINT `IDSucursal_OPC`
    FOREIGN KEY (`IDSucursal`)
    REFERENCES `mydb`.`sucursal` (`IDSucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`historial_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historial_compra` (
  `IDPedido` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Costo` INT NOT NULL,
  INDEX `IDPedido` (`IDPedido` ASC) VISIBLE,
  CONSTRAINT `IDPedido_HC`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `mydb`.`pedido_orden_cabecera` (`IDPedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`venta_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venta_producto` (
  `IDVenta` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `IDPago` INT NOT NULL,
  `Cantidad` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `IVA` INT NOT NULL,
  `Precio` INT NOT NULL,
  `Importe` INT NOT NULL,
  PRIMARY KEY (`IDVenta`),
  INDEX `IDProducto` (`IDProducto` ASC) VISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) VISIBLE,
  INDEX `IDPago` (`IDPago` ASC) VISIBLE,
  CONSTRAINT `IDClienteFK_VP`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`),
  CONSTRAINT `IDEmpleadoFK_VP`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`empleados` (`IDEmpleados`),
  CONSTRAINT `IDProductoFK_VP`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`historial_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historial_ventas` (
  `IDVenta` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Fecha` VARCHAR(45) NOT NULL,
  `Insumo` VARCHAR(45) NOT NULL,
  INDEX `IDVenta` (`IDVenta` ASC) VISIBLE,
  CONSTRAINT `IDVenta_HV`
    FOREIGN KEY (`IDVenta`)
    REFERENCES `mydb`.`venta_producto` (`IDVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`operarios_almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`operarios_almacen` (
  `IDOperarioA` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Contactos` VARCHAR(45) NOT NULL,
  `DNI` INT NOT NULL,
  PRIMARY KEY (`IDOperarioA`),
  INDEX `IDAlmacen` (`IDAlmacen` ASC) VISIBLE,
  CONSTRAINT `IDAlmacen_OA`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`almacen` (`IDAlmacen`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`plantas_fabricacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plantas_fabricacion` (
  `IDPlanta` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Codigo Postal` INT NOT NULL,
  PRIMARY KEY (`IDPlanta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`orden_acopio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orden_acopio` (
  `IDAcopio` INT NOT NULL,
  `IDOperarioA` INT NOT NULL,
  `IDMaterial` INT NOT NULL,
  `IDPlanta` INT NOT NULL,
  `IDAlmacen` INT NOT NULL,
  `Cantidad` VARCHAR(45) NOT NULL,
  `Destino` VARCHAR(45) NOT NULL,
  `Detalles` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDAcopio`),
  INDEX `IDOperarioAFK` (`IDOperarioA` ASC) VISIBLE,
  INDEX `IDMaterial_idx` (`IDMaterial` ASC) VISIBLE,
  INDEX `IDAlmacen_idx` (`IDAlmacen` ASC) VISIBLE,
  INDEX `IDPlantaFK` (`IDPlanta` ASC) VISIBLE,
  CONSTRAINT `IDAlmacen_OAC`
    FOREIGN KEY (`IDAlmacen`)
    REFERENCES `mydb`.`almacen` (`IDAlmacen`),
  CONSTRAINT `IDMaterial_OAC`
    FOREIGN KEY (`IDMaterial`)
    REFERENCES `mydb`.`materiales_producto` (`IDMaterial`),
  CONSTRAINT `IDOperarioAFK_OAC`
    FOREIGN KEY (`IDOperarioA`)
    REFERENCES `mydb`.`operarios_almacen` (`IDOperarioA`),
  CONSTRAINT `IDPlanta_OAC`
    FOREIGN KEY (`IDPlanta`)
    REFERENCES `mydb`.`plantas_fabricacion` (`IDPlanta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`orden_fabricacion_cabecera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orden_fabricacion_cabecera` (
  `IDFabricado` INT NOT NULL,
  `IDFactura` INT NOT NULL,
  `IDPlanta` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDPago` INT NOT NULL,
  `IDEmpleado` INT NOT NULL,
  `FechaCreacion` DATETIME NOT NULL,
  `FechaEntrega` DATETIME NOT NULL,
  PRIMARY KEY (`IDFabricado`),
  INDEX `IDFactura` (`IDFactura` ASC) VISIBLE,
  INDEX `IDPlanta` (`IDPlanta` ASC) VISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  INDEX `IDPago` (`IDPago` ASC) VISIBLE,
  INDEX `IDEmpleado` (`IDEmpleado` ASC) VISIBLE,
  CONSTRAINT `IDCliente_OF`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`),
  CONSTRAINT `IDEmpleado_OF`
    FOREIGN KEY (`IDEmpleado`)
    REFERENCES `mydb`.`empleados` (`IDEmpleados`),
  CONSTRAINT `IDFactura_OF`
    FOREIGN KEY (`IDFactura`)
    REFERENCES `mydb`.`factura_cabecera` (`IDFactura`),
  CONSTRAINT `IDPago_OF`
    FOREIGN KEY (`IDPago`)
    REFERENCES `mydb`.`formas_pago` (`IDPago`),
  CONSTRAINT `IDPlanta_OF`
    FOREIGN KEY (`IDPlanta`)
    REFERENCES `mydb`.`plantas_fabricacion` (`IDPlanta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`orden_fabricacion_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orden_fabricacion_detalle` (
  `IDFabricado` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
  `Item` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `P.Unitario` DECIMAL(8,2) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Importe` DECIMAL(8,2) NOT NULL,
  INDEX `IDFabricado` (`IDFabricado` ASC) VISIBLE,
  INDEX `IDProducto` (`IDProducto` ASC) VISIBLE,
  CONSTRAINT `IDFabricado_OFD`
    FOREIGN KEY (`IDFabricado`)
    REFERENCES `mydb`.`orden_fabricacion_cabecera` (`IDFabricado`),
  CONSTRAINT `IDProducto_OFD`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pedido_orden_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido_orden_detalle` (
  `IDPedido` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `P. Unitario` DECIMAL(8,2) NOT NULL,
  `IVA` DECIMAL(8,2) NOT NULL,
  `Importe` INT NOT NULL,
  INDEX `IDPedido` (`IDPedido` ASC) VISIBLE,
  CONSTRAINT `IDPedido`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `mydb`.`pedido_orden_cabecera` (`IDPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`envios` (
  `IDEnvio` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDEnvio`),
  INDEX `IDProducto` (`IDProducto` ASC) VISIBLE,
  CONSTRAINT `IDProducto`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`remito_cabecera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`remito_cabecera` (
  `IDRemito` INT NOT NULL,
  `IDProducto` VARCHAR(45) NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDEnvio` INT NOT NULL,
  `FechaCreacion` DATETIME NOT NULL,
  `FechaEntrega` DATETIME NOT NULL,
  PRIMARY KEY (`IDRemito`),
  INDEX `IDProducto` (`IDProducto` ASC) INVISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  INDEX `IDEnvio` (`IDEnvio` ASC) VISIBLE,
  CONSTRAINT `IDProducto`
    FOREIGN KEY (`IDProducto`)
    REFERENCES `mydb`.`productos` (`IDProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDCliente`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `mydb`.`clientes` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDEnvio`
    FOREIGN KEY (`IDEnvio`)
    REFERENCES `mydb`.`envios` (`IDEnvio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`remito_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`remito_detalle` (
  `IDRemito` INT NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Importe` DECIMAL(8,2) NOT NULL,
  `Precio` DECIMAL(8,2) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  INDEX `IDRemito` (`IDRemito` ASC) VISIBLE,
  CONSTRAINT `IDRemito`
    FOREIGN KEY (`IDRemito`)
    REFERENCES `mydb`.`remito_cabecera` (`IDRemito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
