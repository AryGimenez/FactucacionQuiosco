SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `ElPam` ;
CREATE SCHEMA IF NOT EXISTS `ElPam` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `ElPam` ;

-- -----------------------------------------------------
-- Table `ElPam`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Categoria` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Categoria` (
  `Cat_Num` INT NOT NULL AUTO_INCREMENT ,
  `Cat_Nom` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Cat_Num`) ,
  UNIQUE INDEX `UnicoNom` (`Cat_Nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Producto` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Producto` (
  `Pro_CodIn` INT NOT NULL AUTO_INCREMENT COMMENT 'Código interno de del articulo este aumenta según agrupado por Cat_Sig' ,
  `Pro_Nom` VARCHAR(45) NOT NULL COMMENT 'Nombre de producto' ,
  `Pro_Descr` VARCHAR(60) NULL COMMENT 'Descripción de producto' ,
  `Pro_CodBar` VARCHAR(45) NULL COMMENT 'Código de barra ' ,
  `Pro_PreVen` DOUBLE NOT NULL COMMENT 'Precio de venta ' ,
  PRIMARY KEY (`Pro_CodIn`) ,
  INDEX `unico` (`Pro_Nom` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Notificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Notificacion` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Notificacion` (
  `Not_Id` INT NOT NULL AUTO_INCREMENT ,
  `Not_Fech` DATETIME NOT NULL ,
  `Not_Detalle` VARCHAR(100) NOT NULL ,
  `Not_Nom` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`Not_Id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`IVA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`IVA` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`IVA` (
  `IVA_Num` INT NOT NULL ,
  `IVA_Nom` VARCHAR(45) NOT NULL ,
  `IVA_Pors` DOUBLE NOT NULL ,
  PRIMARY KEY (`IVA_Num`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`ProductoCom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`ProductoCom` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`ProductoCom` (
  `ProCom_CodIn` INT NOT NULL ,
  `Cat_Num` INT NOT NULL ,
  `ProCom_Stok` DOUBLE NULL DEFAULT 0 ,
  `ProCom_StokMin` DOUBLE NOT NULL COMMENT 'Stok MInimo' ,
  `ProCom_PreCom` DOUBLE NOT NULL COMMENT 'Precio Compra' ,
  `ProCom_TipStok` INT NOT NULL ,
  `IVA_Num` INT NOT NULL ,
  PRIMARY KEY (`ProCom_CodIn`) ,
  INDEX `fk_ProductoCom_Producto1` (`ProCom_CodIn` ASC) ,
  INDEX `fk_ProductoCom_Categoria1` (`Cat_Num` ASC) ,
  INDEX `fk_ProductoCom_IVA1` (`IVA_Num` ASC) ,
  CONSTRAINT `fk_ProductoCom_Producto1`
    FOREIGN KEY (`ProCom_CodIn` )
    REFERENCES `ElPam`.`Producto` (`Pro_CodIn` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductoCom_Categoria1`
    FOREIGN KEY (`Cat_Num` )
    REFERENCES `ElPam`.`Categoria` (`Cat_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductoCom_IVA1`
    FOREIGN KEY (`IVA_Num` )
    REFERENCES `ElPam`.`IVA` (`IVA_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`NotProd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`NotProd` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`NotProd` (
  `Not_Id` INT NOT NULL ,
  `ProCom_CodIn` INT NOT NULL ,
  PRIMARY KEY (`Not_Id`) ,
  INDEX `fk_NotProd_ProductoCom1` (`ProCom_CodIn` ASC) ,
  CONSTRAINT `fk_NotProd_Notoficacion1`
    FOREIGN KEY (`Not_Id` )
    REFERENCES `ElPam`.`Notificacion` (`Not_Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotProd_ProductoCom1`
    FOREIGN KEY (`ProCom_CodIn` )
    REFERENCES `ElPam`.`ProductoCom` (`ProCom_CodIn` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Notificacion de producto\n' ;


-- -----------------------------------------------------
-- Table `ElPam`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Pais` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Pais` (
  `Pai_Num` INT NOT NULL AUTO_INCREMENT ,
  `Pai_Nom` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Pai_Num`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`ProvDep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`ProvDep` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`ProvDep` (
  `ProvD_Num` INT NOT NULL AUTO_INCREMENT ,
  `Pai_Num` INT NOT NULL ,
  `ProvD_Nom` VARCHAR(45) NULL ,
  PRIMARY KEY (`ProvD_Num`, `Pai_Num`) ,
  INDEX `fk_ProvDep_Pais1` (`Pai_Num` ASC) ,
  CONSTRAINT `fk_ProvDep_Pais1`
    FOREIGN KEY (`Pai_Num` )
    REFERENCES `ElPam`.`Pais` (`Pai_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB, 
COMMENT = 'Provincia o departameto ' ;


-- -----------------------------------------------------
-- Table `ElPam`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Persona` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Persona` (
  `Per_Num` INT NOT NULL ,
  `Per_Tip` INT NOT NULL COMMENT 'Representa el tipo de Persona:\n?  1: Cliente\n?  2: Proovedor' ,
  `Per_RasSos` VARCHAR(45) NOT NULL ,
  `Per_Localidad` VARCHAR(45) NOT NULL ,
  `Per_Direccion` VARCHAR(100) NOT NULL ,
  `Per_Rut` VARCHAR(45) NULL ,
  `Per_CondIva` INT NOT NULL COMMENT 'Representa el tipo de Persona:\n?  0: Responsable insripto\n?  1: Consumidor final\n' ,
  `Per_Docum` VARCHAR(45) NULL ,
  `Per_TipDocum` INT NULL COMMENT 'Representa el tipo de Persona:\n?  0: Ci\n?  1: Pasaporte\n?  2: DNI' ,
  `ProvD_Num` INT NOT NULL ,
  `Pai_Num` INT NOT NULL ,
  PRIMARY KEY (`Per_Num`, `Per_Tip`) ,
  INDEX `fk_Persona_ProvDep1` (`ProvD_Num` ASC, `Pai_Num` ASC) ,
  UNIQUE INDEX `Unico Doc` (`Per_TipDocum` ASC, `Per_Docum` ASC) ,
  CONSTRAINT `fk_Persona_ProvDep1`
    FOREIGN KEY (`ProvD_Num` , `Pai_Num` )
    REFERENCES `ElPam`.`ProvDep` (`ProvD_Num` , `Pai_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Moneda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Moneda` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Moneda` (
  `Mon_Num` INT NOT NULL AUTO_INCREMENT ,
  `Mon_Sig` VARCHAR(6) NOT NULL ,
  `Mon_Nom` VARCHAR(45) NOT NULL ,
  `Mon_CotCom` FLOAT NOT NULL ,
  `Mon_CotVenta` FLOAT NOT NULL ,
  `Mon_FechMod` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `Pai_Num` INT NOT NULL ,
  `Mon_Local` TINYINT(1)  NULL DEFAULT 0 ,
  PRIMARY KEY (`Mon_Num`) ,
  INDEX `fk_Moneda_Pais1` (`Pai_Num` ASC) ,
  UNIQUE INDEX `Mon_Sig_UNIQUE` (`Mon_Sig` ASC) ,
  UNIQUE INDEX `Pai_Num_UNIQUE` (`Pai_Num` ASC) ,
  CONSTRAINT `fk_Moneda_Pais1`
    FOREIGN KEY (`Pai_Num` )
    REFERENCES `ElPam`.`Pais` (`Pai_Num` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Saldo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Saldo` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Saldo` (
  `Per_Num` INT NOT NULL ,
  `Per_Tip` INT NOT NULL COMMENT 'Ture: Deudor\nFalse: Hacreedor' ,
  `Mon_Num` INT NOT NULL ,
  `Sal_Valor` FLOAT NOT NULL ,
  `Sal_Tipo` TINYINT(1)  NOT NULL COMMENT 'Determina si el saldo es;\n?  true: Deudor\n?  false: Acreedor' ,
  `Sal_LimDeu` FLOAT NULL DEFAULT 0 ,
  `Sal_LimAcre` FLOAT NULL DEFAULT 0 ,
  `Sal_FechM` DATE NULL COMMENT 'Guarda la ultima fecha de modificacion' ,
  INDEX `fk_Saldo_Persona1` (`Per_Num` ASC, `Per_Tip` ASC) ,
  INDEX `fk_Saldo_Moneda1` (`Mon_Num` ASC) ,
  PRIMARY KEY (`Mon_Num`, `Per_Tip`, `Per_Num`) ,
  CONSTRAINT `fk_Saldo_Persona1`
    FOREIGN KEY (`Per_Num` , `Per_Tip` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` , `Per_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Saldo_Moneda1`
    FOREIGN KEY (`Mon_Num` )
    REFERENCES `ElPam`.`Moneda` (`Mon_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Contacto` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Contacto` (
  `Con_Num` INT NOT NULL AUTO_INCREMENT ,
  `Con_Nom` VARCHAR(45) NULL ,
  `Con_Detalle` VARCHAR(100) NULL ,
  `Con_Tipo` INT NOT NULL COMMENT 'Representa el tipo de Contacto:\n?  1: Telerono\n?  2: Celular\n?  3: Fax\n?  2: Mail' ,
  `Per_Num` INT NOT NULL ,
  `Per_Tip` INT NOT NULL COMMENT 'Representa el tipo de Persona:\n' ,
  PRIMARY KEY (`Con_Num`) ,
  INDEX `fk_Contacto_Persona1` (`Per_Num` ASC, `Per_Tip` ASC) ,
  CONSTRAINT `fk_Contacto_Persona1`
    FOREIGN KEY (`Per_Num` , `Per_Tip` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` , `Per_Tip` )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Cliente` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Cliente` (
  `Cli_Num` INT NOT NULL ,
  `Per_Tip` INT NULL DEFAULT 1 ,
  INDEX `fk_Cliente_Persona1` (`Cli_Num` ASC, `Per_Tip` ASC) ,
  PRIMARY KEY (`Cli_Num`) ,
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`Cli_Num` , `Per_Tip` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` , `Per_Tip` )
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Proveedor` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Proveedor` (
  `Prov_Num` INT NOT NULL ,
  `Per_Tip` INT NULL DEFAULT 2 ,
  PRIMARY KEY (`Prov_Num`) ,
  INDEX `fk_Proveedor_Persona1` (`Prov_Num` ASC, `Per_Tip` ASC) ,
  CONSTRAINT `fk_Proveedor_Persona1`
    FOREIGN KEY (`Prov_Num` , `Per_Tip` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` , `Per_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Factura` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Factura` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NULL DEFAULT 'A' ,
  `Fac_Tip` TINYINT(1)  NOT NULL COMMENT 'Si es true es de venta si es false es de compra ' ,
  `Fac_Fech` DATE NOT NULL ,
  `Fac_ReIvaTb` DOUBLE NULL DEFAULT 0 ,
  `Fac_ReIvaTm` DOUBLE NULL DEFAULT 0 ,
  `Fac_IvaTm` DOUBLE NULL DEFAULT 0 COMMENT 'Guarda el porcentaje del IVA tasa mínima de la fecha de la factura ' ,
  `Fac_IvaTb` DOUBLE NULL DEFAULT 0 COMMENT 'Guarda el porcentaje del IVA tasa básica de la fecha de la factura ' ,
  `Fac_SubTot` DOUBLE NULL DEFAULT 0 ,
  `Fac_Des` DOUBLE NULL DEFAULT 0 ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`FacturaCom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`FacturaCom` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`FacturaCom` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Prov_Num` INT NOT NULL ,
  `Fac_Tip` TINYINT(1)  NULL DEFAULT FALSE ,
  INDEX `fk_FacturaCom_Factura1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`) ,
  INDEX `fk_FacturaCom_Proveedor1` (`Prov_Num` ASC) ,
  CONSTRAINT `fk_FacturaCom_Factura1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Factura` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FacturaCom_Proveedor1`
    FOREIGN KEY (`Prov_Num` )
    REFERENCES `ElPam`.`Proveedor` (`Prov_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`FacturaVen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`FacturaVen` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`FacturaVen` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NULL DEFAULT TRUE ,
  `Cli_Num` INT NULL ,
  INDEX `fk_FacturaVen_Factura1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`) ,
  INDEX `fk_FacturaVen_Cliente1` (`Cli_Num` ASC) ,
  CONSTRAINT `fk_FacturaVen_Factura1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Factura` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FacturaVen_Cliente1`
    FOREIGN KEY (`Cli_Num` )
    REFERENCES `ElPam`.`Cliente` (`Cli_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Movimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Movimiento` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Movimiento` (
  `Mov_Num` INT NOT NULL AUTO_INCREMENT ,
  `Mov_NomEmit` VARCHAR(45) NOT NULL COMMENT 'Nombre de la persona encargada del movimiento\n' ,
  `Mov_FecHor` DATETIME NULL COMMENT 'Fecha hora que se realiza el movimiento ' ,
  `Mov_Detalle` VARCHAR(100) NULL ,
  `Mov_DesOr` VARCHAR(100) NOT NULL COMMENT 'En este  campo se especifica de donde vino o a donde va en caso que sea una orden de ingreso o de retiro de mercadería.' ,
  `Mov_Tip` TINYINT(1)  NOT NULL COMMENT 'Si es true el movimiento es de ingreso\n si es false la orden es de recepción.' ,
  `Mov_CanProd` DOUBLE NOT NULL ,
  `ProCom_CodIn` INT NOT NULL ,
  PRIMARY KEY (`Mov_Num`) ,
  INDEX `fk_Movimiento_ProductoCom1` (`ProCom_CodIn` ASC) ,
  CONSTRAINT `fk_Movimiento_ProductoCom1`
    FOREIGN KEY (`ProCom_CodIn` )
    REFERENCES `ElPam`.`ProductoCom` (`ProCom_CodIn` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`LineaFactura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`LineaFactura` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`LineaFactura` (
  `LinF_Num` INT NOT NULL AUTO_INCREMENT COMMENT 'Numer Factura' ,
  `Pro_CodIn` INT NOT NULL COMMENT 'Numero de producto' ,
  `Fac_Serie` VARCHAR(1) NOT NULL COMMENT 'Serie de factura' ,
  `Fac_Num` INT NOT NULL COMMENT 'Numero Factura' ,
  `Fac_Tip` TINYINT(1)  NOT NULL COMMENT 'Tpo de factura' ,
  `LinF_PrePro` DOUBLE NULL COMMENT 'Precio de porducto en la factura' ,
  `LinF_Iva` DOUBLE NULL COMMENT 'Iva del producto en esta linea ' ,
  `LinF_CanProd` DOUBLE NULL COMMENT 'Cantidad de porducto a vender ' ,
  `LinF_Des` DOUBLE NULL COMMENT 'Descuento echo a esta linea ' ,
  PRIMARY KEY (`LinF_Num`) ,
  INDEX `fk_LineaFactura_Producto1` (`Pro_CodIn` ASC) ,
  INDEX `fk_LineaFactura_Factura1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  CONSTRAINT `fk_LineaFactura_Producto1`
    FOREIGN KEY (`Pro_CodIn` )
    REFERENCES `ElPam`.`Producto` (`Pro_CodIn` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LineaFactura_Factura1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Factura` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`FormaDePago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`FormaDePago` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`FormaDePago` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `ForP_Tip` INT NOT NULL COMMENT 'Tipo de forma de pago:\n?  1: Contado\n?  2: Credito\n?  3: Tarjeta\n' ,
  `Mon_Num` INT NOT NULL ,
  `ForP_MonAPag` DOUBLE NOT NULL COMMENT 'Monto a pagar\n' ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`, `ForP_Tip`) ,
  INDEX `fk_FormaDePago_Factura1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  INDEX `fk_FormaDePago_Moneda1` (`Mon_Num` ASC) ,
  CONSTRAINT `fk_FormaDePago_Factura1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Factura` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FormaDePago_Moneda1`
    FOREIGN KEY (`Mon_Num` )
    REFERENCES `ElPam`.`Moneda` (`Mon_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Intereses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Intereses` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Intereses` (
  `Int_Num` INT NOT NULL ,
  `Int_Tip` BIGINT NULL DEFAULT 2 ,
  `Int_Can` BIGINT NULL DEFAULT 1 ,
  `Int_Pors` DOUBLE NOT NULL COMMENT 'Porsentaje de interes ' ,
  PRIMARY KEY (`Int_Num`) ,
  UNIQUE INDEX `Int_Pors_UNIQUE` (`Int_Pors` ASC, `Int_Can` ASC, `Int_Tip` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Credito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Credito` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Credito` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `ForP_Tip` INT NULL DEFAULT 2 ,
  `Int_Num` INT NULL COMMENT 'Intereses si se pasa fecha de pago\n' ,
  `Cre_CanCuo` BIGINT NOT NULL COMMENT 'Cantidad de cuotas' ,
  `Cre_Tipo` ENUM('Anual','Mensual','Dia','Sin Cuota') NOT NULL COMMENT 'Determina que tipo de intervalo o sea.\n?  Anual  \n?  Mensual\n?  Dia\n?  Sin Cuta' ,
  `Cre_Intervalo` BIGINT NULL DEFAULT 1 COMMENT 'Inervalo en que se ba a pagar\n se es en años cada cuento si es en meses cada cuanto si es en dias etc.' ,
  `Cre_MonPago` DOUBLE NULL DEFAULT 0 COMMENT 'Monto pago' ,
  `Cre_MonNoDiv` DOUBLE NULL DEFAULT 0 COMMENT 'Monto no dividido entre las cutas' ,
  INDEX `fk_Credto_Intereses1` (`Int_Num` ASC) ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`) ,
  CONSTRAINT `fk_Credto_Intereses1`
    FOREIGN KEY (`Int_Num` )
    REFERENCES `ElPam`.`Intereses` (`Int_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Credto_FormaDePago1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    REFERENCES `ElPam`.`FormaDePago` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Cuota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Cuota` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Cuota` (
  `Cuo_FechVen` DATE NOT NULL COMMENT 'Fecha vencimiento cuota' ,
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `Cuo_Monto` DOUBLE NOT NULL ,
  `Cuo_FechPag` DATE NULL ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`, `Cuo_FechVen`) ,
  INDEX `fk_Cuota_Credto1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  CONSTRAINT `fk_Cuota_Credto1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Credito` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Contado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Contado` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Contado` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `ForP_Tip` INT NULL DEFAULT 1 ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`) ,
  CONSTRAINT `fk_Contado_FormaDePago1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    REFERENCES `ElPam`.`FormaDePago` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Tip Tarjeta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Tip Tarjeta` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Tip Tarjeta` (
  `TTar_Num` INT NOT NULL ,
  `TTar_Empresa` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`TTar_Num`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Targeta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Targeta` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Targeta` (
  `Tar_Num` INT NOT NULL ,
  `TTar_Num` INT NOT NULL ,
  `Per_Num` INT NOT NULL ,
  `TTar_Detalle` VARCHAR(45) NULL ,
  PRIMARY KEY (`Tar_Num`) ,
  INDEX `fk_Targeta_Tip Tarjeta1` (`TTar_Num` ASC) ,
  INDEX `fk_Targeta_Persona1` (`Per_Num` ASC) ,
  CONSTRAINT `fk_Targeta_Tip Tarjeta1`
    FOREIGN KEY (`TTar_Num` )
    REFERENCES `ElPam`.`Tip Tarjeta` (`TTar_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Targeta_Persona1`
    FOREIGN KEY (`Per_Num` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`PagTargeta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`PagTargeta` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`PagTargeta` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `ForP_Tip` INT NULL DEFAULT 3 ,
  `Tar_Num` INT NOT NULL ,
  INDEX `fk_PagTargeta_Targeta1` (`Tar_Num` ASC) ,
  PRIMARY KEY (`Fac_Num`, `Fac_Serie`, `Fac_Tip`) ,
  CONSTRAINT `fk_PagTargeta_Targeta1`
    FOREIGN KEY (`Tar_Num` )
    REFERENCES `ElPam`.`Targeta` (`Tar_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PagTargeta_FormaDePago1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    REFERENCES `ElPam`.`FormaDePago` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` , `ForP_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`SubProducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`SubProducto` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`SubProducto` (
  `SubP_CodIn` INT NOT NULL ,
  `ProCom_CodIn` INT NOT NULL ,
  PRIMARY KEY (`SubP_CodIn`) ,
  INDEX `fk_SubProducto_Producto1` (`SubP_CodIn` ASC) ,
  INDEX `fk_SubProducto_ProductoCom1` (`ProCom_CodIn` ASC) ,
  CONSTRAINT `fk_SubProducto_Producto1`
    FOREIGN KEY (`SubP_CodIn` )
    REFERENCES `ElPam`.`Producto` (`Pro_CodIn` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SubProducto_ProductoCom1`
    FOREIGN KEY (`ProCom_CodIn` )
    REFERENCES `ElPam`.`ProductoCom` (`ProCom_CodIn` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`FechPago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`FechPago` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`FechPago` (
  `Per_Num` INT NOT NULL ,
  `Per_Tip` INT NOT NULL ,
  `FechP_Tipo` ENUM('Diario','Mensual','Anual') NOT NULL ,
  `FechP_Intervalo` INT NOT NULL ,
  `FechP_Mes` INT NULL DEFAULT NULL ,
  `FechP_Dia` INT NULL DEFAULT NULL ,
  `FechP_Aviso` INT NOT NULL ,
  `FechP_FechAlta` DATE NOT NULL ,
  PRIMARY KEY (`Per_Num`, `Per_Tip`) ,
  INDEX `fk_FechPago_Persona1` (`Per_Num` ASC, `Per_Tip` ASC) ,
  CONSTRAINT `fk_FechPago_Persona1`
    FOREIGN KEY (`Per_Num` , `Per_Tip` )
    REFERENCES `ElPam`.`Persona` (`Per_Num` , `Per_Tip` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Recibo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Recibo` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Recibo` (
  `Res_Num` INT NOT NULL AUTO_INCREMENT ,
  `Res_Emision` DATETIME NOT NULL ,
  `Res_Monto` FLOAT NOT NULL ,
  `Res_DeQuien` VARCHAR(45) NOT NULL ,
  `Res_Detalle` VARCHAR(100) NOT NULL ,
  `Mon_Num` INT NOT NULL ,
  `Per_Tip` INT NOT NULL ,
  `Per_Num` INT NOT NULL ,
  PRIMARY KEY (`Res_Num`) ,
  INDEX `fk_Recibo_Saldo1` (`Mon_Num` ASC, `Per_Tip` ASC, `Per_Num` ASC) ,
  CONSTRAINT `fk_Recibo_Saldo1`
    FOREIGN KEY (`Mon_Num` , `Per_Tip` , `Per_Num` )
    REFERENCES `ElPam`.`Saldo` (`Mon_Num` , `Per_Tip` , `Per_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ElPam`.`Caja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Caja` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Caja` (
  `Caja_Num` INT NOT NULL AUTO_INCREMENT ,
  `Caja_FechIni` DATETIME NOT NULL ,
  `Caja_FechFin` DATETIME NULL ,
  `Caja_MontoAbrir` FLOAT NOT NULL ,
  `Caja_MontoCerrar` FLOAT NULL ,
  `Caja_Abierta` TINYINT(1)  NOT NULL ,
  `Mon_Num` INT NOT NULL ,
  PRIMARY KEY (`Caja_Num`) ,
  INDEX `fk_Caja_Moneda1` (`Mon_Num` ASC) ,
  CONSTRAINT `fk_Caja_Moneda1`
    FOREIGN KEY (`Mon_Num` )
    REFERENCES `ElPam`.`Moneda` (`Mon_Num` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_ProductoCom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_ProductoCom` (`ProCom_CodIn` INT, `ProCom_Nom` INT, `ProCom_Descr` INT, `ProCom_CodBar` INT, `ProCom_PreVen` INT, `ProCom_Stok` INT, `ProCom_StokMin` INT, `ProCom_PreCom` INT, `ProCom_TipStok` INT, `Cat_Num` INT, `Cat_Nom` INT, `Tipo` INT, `IVA_Num` INT, `IVA_Nom` INT, `IVA_Pors` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumProd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumProd` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumNot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumNot` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumCli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumCli` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumMov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumMov` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_SubProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_SubProducto` (`SubP_CodIn` INT, `SubP_Nom` INT, `SubP_Descr` INT, `SubP_CodBar` INT, `SubP_PreVen` INT, `ProCom_Stok` INT, `ProCom_StokMin` INT, `ProCom_PreCom` INT, `Cat_Num` INT, `Cat_Nom` INT, `ProCom_CodIn` INT, `Tipo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Producto` (`Pro_CodIn` INT, `Pro_Nom` INT, `Pro_Descr` INT, `Pro_CodBar` INT, `Pro_PreVen` INT, `Pro_Stok` INT, `Pro_StokMin` INT, `Pro_PreCom` INT, `Cat_Num` INT, `Cat_Nom` INT, `Tipo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumProv`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumProv` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Tel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Tel` (`Con_Num` INT, `Con_Nom` INT, `Con_Detalle` INT, `Per_Num` INT, `Per_Tip` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Cel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Cel` (`Con_Num` INT, `Con_Nom` INT, `Con_Detalle` INT, `Per_Num` INT, `Per_Tip` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Fax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Fax` (`Con_Num` INT, `Con_Nom` INT, `Con_Detalle` INT, `Per_Num` INT, `Per_Tip` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Mail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Mail` (`Con_Num` INT, `Con_Nom` INT, `Con_Detalle` INT, `Per_Num` INT, `Per_Tip` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Cliente` (`Per_Num` INT, `Per_RasSos` INT, `Per_Localidad` INT, `Per_Direccion` INT, `Per_Docum` INT, `Per_TipDocum` INT, `Per_CondIva` INT, `Per_Rut` INT, `ProvD_Num` INT, `ProvD_Nom` INT, `Pai_Num` INT, `Pai_Nom` INT, `FechP_Tipo` INT, `FechP_Intervalo` INT, `FechP_Mes` INT, `FechP_Dia` INT, `FechP_Aviso` INT, `FechP_FechAlta` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Proveedor` (`Per_Num` INT, `Per_RasSos` INT, `Per_Localidad` INT, `Per_Direccion` INT, `Per_Docum` INT, `Per_TipDocum` INT, `Per_CondIva` INT, `Per_Rut` INT, `ProvD_Num` INT, `ProvD_Nom` INT, `Pai_Num` INT, `Pai_Nom` INT, `FechP_Tipo` INT, `FechP_Intervalo` INT, `FechP_Mes` INT, `FechP_Dia` INT, `FechP_Aviso` INT, `FechP_FechAlta` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Moneda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Moneda` (`Mon_Num` INT, `Mon_Nom` INT, `Mon_Sig` INT, `Mon_CotCom` INT, `Mon_CotVenta` INT, `Mon_FechMod` INT, `Pai_Nom` INT, `Pai_Num` INT, `Mon_Local` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_NumFacVen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_NumFacVen` (`Num` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_FacturaVen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_FacturaVen` (`Fac_Num` INT, `Fac_Serie` INT, `Fac_Fech` INT, `Cli_Num` INT, `Per_RasSos` INT, `Per_Tip` INT, `Fac_IvaTb` INT, `Fac_ReIvaTb` INT, `Fac_IvaTm` INT, `Fac_ReIvaTm` INT, `Fac_SubTot` INT, `Fac_Des` INT, `Fac_Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Saldo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Saldo` (`Per_Num` INT, `Per_Tip` INT, `Sal_Valor` INT, `Sal_Tipo` INT, `Sal_LimDeu` INT, `Sal_LimAcre` INT, `Sal_FechM` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_FacturaCom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_FacturaCom` (`Fac_Num` INT, `Fac_Serie` INT, `Fac_Fech` INT, `Prov_Num` INT, `Per_RasSos` INT, `Per_Tip` INT, `Fac_IvaTb` INT, `Fac_ReIvaTb` INT, `Fac_IvaTm` INT, `Fac_ReIvaTm` INT, `Fac_SubTot` INT, `Fac_Des` INT, `Fac_Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_ReciboFull`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_ReciboFull` (`Res_Num` INT, `Res_Emision` INT, `Res_Monto` INT, `Res_DeQuien` INT, `Res_Detalle` INT, `Per_Tip` INT, `Per_Num` INT);

-- -----------------------------------------------------
-- function Fuc_AltaProdCom
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaProdCom`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaProdCom`(pPro_Nom VARCHAR(45), pPro_Decr VARCHAR(60),
    pPro_CodBar VARCHAR(45), pPro_PreVen DOUBLE, pCat_Num INT, pProCom_StokMin DOUBLE,
    pProCom_PreCom DOUBLE, pProCom_TipStok INT, pIVA_Num INT) RETURNS int(11)
BEGIN
  DECLARE xCon int;
  
  SET xCon = 0;

  
  INSERT INTO `ElPam`.`Producto`(Pro_Nom , Pro_Descr, Pro_CodBar, Pro_PreVen)
  VALUE (pPro_Nom , pPro_Decr, pPro_CodBar, pPro_PreVen);
  
  SET @xNumP=LAST_INSERT_ID();

  INSERT INTO `ElPam`.`ProductoCom`(ProCom_CodIn, Cat_Num, ProCom_StokMin, ProCom_PreCom, ProCom_TipStok, IVA_Num)
  VALUE (@xNumP, pCat_Num, pProCom_StokMin, pProCom_PreCom, pProCom_TipStok, pIVA_Num);

  RETURN @xNumP;

END 

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AlataNotProd
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AlataNotProd`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AlataNotProd` ( pProCom_CodIn INT, pNot_Nom VARCHAR (20), pNot_Fech DATETIME,
pNot_Detalle VARCHAR(100)) RETURNS INT
BEGIN

	INSERT INTO `ElPam`.`Notificacion` (`Not_Fech`, `Not_Detalle`, `Not_Nom`) 
    VALUE (`pNot_Fech`, `pNot_Detalle`, `Not_Nom`);
	SET @XNot_Id = LAST_INSERT_ID();
    
	INSERT INTO `ElPam`.`NotProd` (`Not_Id`,`ProCom_CodIn`) VALUE (`XNot_Id`,`pProCom_CodIn`);
	
	RETURN `xNot_Id`;
END;


$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaSubPro
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaSubPro`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaSubPro` (pPro_Nom VARCHAR(45), pPro_Decr VARCHAR(60),
    pPro_CodBar VARCHAR(45), pPro_PreVen DOUBLE, pProCom_CodIn INT) RETURNS int(11)
BEGIN

  INSERT INTO `ElPam`.`Producto`(Pro_Nom , Pro_Descr, Pro_CodBar, Pro_PreVen)
  VALUE (pPro_Nom , pPro_Decr, pPro_CodBar, pPro_PreVen);
  
  SET @xNumP=LAST_INSERT_ID();

  INSERT INTO `ElPam`.`SubProducto`(SubP_CodIn ,ProCom_CodIn) VALUE (@xNumP, pProCom_CodIn);

  RETURN @xNumP;

END




$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ModifSubProd
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ModifSubProd`;

DELIMITER $$
USE `ElPam`$$






CREATE PROCEDURE `ElPam`.`Pro_ModifSubProd` (IN pPro_CodIn INT, IN pPro_Nom VARCHAR(45), IN pPro_Descr VARCHAR(60),
    IN pPro_CodBar VARCHAR(45), IN pPro_PreVen DOUBLE)
BEGIN 
	UPDATE 
		`ElPam`.`Producto` 
	SET 
		Pro_Nom = pPro_Nom, 
		Pro_Descr = pPro_Descr, 
		Pro_CodBar = pPro_CodBar, 
		Pro_PreVen = pPro_PreVen
	WHERE
    	Pro_CodIn = pPro_CodIn;
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaProv
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaProv`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaProv` (pPer_RasSos VARCHAR(45), pPer_Localidad VARCHAR(45), 
	pPer_Direccion VARCHAR (100),  pPer_Rut VARCHAR(45),pPer_CondIva INT, pPer_Docum VARCHAR (45), pPer_TipDocum INT, 
	pPai_Num INT,  pProvD_Num INT,  pFechP_Tipo VARCHAR (6), pFechP_Intervalo INT, pFechP_Mes INT, 
	pFechP_Dia INT, pFechP_Aviso INT, pFechP_FechAlta DATE) RETURNS VARCHAR (60)
 
BEGIN 

    DECLARE xPer_Num INT;
    
	  DECLARE xRespuesta VARCHAR (60) DEFAULT '';

    SELECT Num INTO xPer_Num  from ElPam.Viw_ProV;

    INSERT INTO 
		`ElPam`.`Persona` 
			(`Per_Num`,`Per_Tip`,`Per_RasSos`, `Per_Localidad`, `Per_Direccion`, `Per_Rut`, 
				`Per_CondIva`, `Per_Docum`, `Per_TipDocum`, `Pai_Num`, `ProvD_Num`) 
		VALUE (`xPer_Num`,2 ,`pPer_RasSos`, `pPer_Localidad`, 
			`pPer_Direccion`, `pPer_Rut`, `pPer_CondIva`,`pPer_Docum`, 
			`pPer_TipDocum`, `pPai_Num`, `pProvD_Num`)
	; -- FIN INSERT

  INSERT INTO 
		`ElPam`.`Proveedor` 
			(`Prov_Num`) 
		VALUE 
			(`xPer_Num`)
	;-- FIN INSERT INTO

	-- //////////////// Metodos FechPago ////////////////////////
	
	IF pFechP_Tipo IS NOT NULL THEN 
		SET xRespuesta = Fuc_AltaFechPago (pFechP_Tipo, pFechP_Intervalo, pFechP_Mes, 
			pFechP_Dia , pFechP_Aviso, pFechP_FechAlta);
	END IF;
	
	IF xRespuesta <> '' THEN
	-- Elimina Provedor recien ingresado
	DELETE FROM
		`ElPam`.`Provedor`
	WHERE
		`Prov_Num` = `pPer_Num`
	; -- Fin DELETE FROM
	
	DELETE FROM
		`ElPam`.`Persona`
	WHERE
		`Per_Num` = `pPer_Num` AND
		`Per_Tip` = 2
	; -- Fin DELETE FROM
		
		RETURN xRespuesta;
	END IF;
	
	-- //////////////// Fin Metodos FechPago ////////////////////////
	
	RETURN  '' + `xPer_Num`;
END;


$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaMon
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaMon`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaMon` (pMon_Sig VARCHAR(6), pMon_Nom VARCHAR(45), pMon_CotCom FLOAT, pMon_CotVen FLOAT, pPai_Num INT) RETURNS INT 
BEGIN

	IF pMon_Local THEN
		UPDATE 
			`ElPam`.`Moneda` 
		SET
			Mon_Local = false
		WHERE 
			Mon_Local = true
		;
	END IF;

	INSERT INTO `ElPam`.`Moneda` 
		(
		`Mon_Sig`, 
		`Mon_Nom`, 
		`Mon_CotCom`, 
		`Mon_CotVenta`, 
		`Mon_FechMod`, 
		`Pai_Num`, 
		`Mon_Local`
		) 
	VALUES 
		( 
		pMon_Sig, 
		pMon_Nom, 
		pMon_CotCom, 
		pMon_CotVen, 
		DEFAULT, 
		pPai_Num, 
		DEFAULT
		)
	;
	
	RETURN LAST_INSERT_ID();
END; 
$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaFacVen
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaFacVen`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION  `ElPam`.`Fuc_AltaFacVen` (pFac_Fech DATE, pCli_Num INT)RETURNS INT
BEGIN
	DECLARE xFac_Num, xCli_Num INT;
	
	SELECT Num INTO xFac_Num FROM `ElPam`.`Viw_NumFacVen`;
  
	INSERT INTO 
		`ElPam`.`Factura`
			(
			`Fac_Num`,  
			`Fac_Tip`, 
			`Fac_Fech`
			) 
	VALUE 
		(
		`xFac_Num`,
		TRUE, 
		`pFac_Fech`
		)
	; 
	-- Comprueba que el numero de cliente
	-- sea un numero valido o sea que no sea igal a -1
	IF (pCli_Num = -1)THEN
		SET xCli_Num = null;
	else 
		SET xCli_Num = pCli_Num;
	end IF;
    
  INSERT INTO 
		`ElPam`.`FacturaVen`
			(
			`Fac_Num`, 
			`Fac_Serie`,
			`Cli_Num`
			) 
	VALUE 
		(
		`xFac_Num`, 
		'A',
		`xCli_Num`
		)
	; 
	
    RETURN xFac_Num;
END; 



$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Fuc_AltaFacCom
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Fuc_AltaFacCom`;

DELIMITER $$
USE `ElPam`$$
CREATE PROCEDURE `ElPam`.`Fuc_AltaFacCom` (IN pFac_Nom int,IN pFac_Serie VARCHAR(1),IN  pFac_Fech DATE,IN  pProv_Num INT)
BEGIN
    
	INSERT INTO 
		`ElPam`.`Factura`
			(
			`Fac_Num`, 
			`Fac_Serie`,
			`Fac_Tip`, 
			`Fac_Fech ` 
			 ) 
	VALUE 
		(
		`pFrm_Num`, 
		`pFac_Serie`, 
		TRUE, 
		`pFac_Fecha`
		)
	; 
    
    INSERT INTO 
		`ElPam`.`FacturaVen`
			(
			`Fac_Num`, 
			`Fac_Serie`,
			`Cli_Num`
			) 
	VALUE 
		(
		`pFrm_Num`, 
		`pFac_Serie`,
		`pProv_Num`
		)
	; 
END; 

$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ActuStok
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ActuStok`;

DELIMITER $$
USE `ElPam`$$
CREATE PROCEDURE `ElPam`.`Pro_ActuStok` (IN pPro_CodIn INT, IN pCanProd DOUBLE, IN pAumentar BOOLEAN)
BEGIN
	DECLARE xPro_CodIn, xExiste, xCanProd INT;
	SET xPro_CodIn = pPro_CodIn;
	SET xCanProd = pCanProd;
	
	IF pAumentar = FALSE THEN
		SET xCanProd= xCanProd * -1;
	END IF; 
	
	SELECT COUNT(*) INTO xExiste FROM ElPam.SubProducto WHERE SubP_CodIn = xPro_CodIn;
	
	IF xExiste <> 0 THEN 
		SELECT 
				ProCom_CodIn 
			INTO 
				xPro_CodIn 
		FROM 
			ElPam.SubProducto 
		WHERE 
			SubP_CodIn = xPro_CodIn
    ;
	END IF;
	
	UPDATE 
		ElPam.ProductoCom  
	SET
		ProCom_Stok = ProCom_Stok + xCanProd
	WHERE 
		ProCom_CodIn = xPro_CodIn
	;
	
END

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaTel
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaTel`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaTel` (pCon_Nom VARCHAR(45), 
	pCon_Detalle VARCHAR(100), pPer_Num INT, pPer_Tip INT) RETURNS INT

BEGIN 

	INSERT INTO `ElPam`.`Contacto` ( Con_Nom, Con_Detalle, Per_Num, Per_Tip, Con_Tipo) 
		VALUE  ( pCon_Nom, pCon_Detalle, pPer_Num, pPer_Tip, 1);

	

	RETURN LAST_INSERT_ID();

END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaCel
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaCel`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaCel` (pCon_Nom VARCHAR(45), 
	pCon_Detalle VARCHAR(100), pPer_Num INT, pPer_Tip INT) RETURNS INT

BEGIN 

	INSERT INTO `ElPam`.`Contacto` (Con_Nom, Con_Detalle, Per_Num, Per_Tip, Con_Tipo) 

		VALUE  (pCon_Nom, pCon_Detalle, pPer_Num, pPer_Tip, 2);

	

	RETURN LAST_INSERT_ID();

END;





$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaFax
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaFax`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaFax` (pCon_Nom VARCHAR(45), 
	pCon_Detalle VARCHAR(100), pPer_Num INT, pPer_Tip INT) RETURNS INT

BEGIN 

	INSERT INTO `ElPam`.`Contacto` (Con_Nom, Con_Detalle, Per_Num, Per_Tip, Con_Tipo) 

		VALUE  (pCon_Nom, pCon_Detalle, pPer_Num, pPer_Tip, 3);

	

	RETURN LAST_INSERT_ID();

END;


$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaMail
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaMail`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaMail` (pCon_Nom VARCHAR(45), 
	pCon_Detalle VARCHAR(100), pPer_Num INT, pPer_Tip INT) RETURNS INT

BEGIN 

	INSERT INTO `ElPam`.`Contacto` (Con_Nom, Con_Detalle, Per_Num, Per_Tip, Con_Tipo) 

		VALUE  (pCon_Nom, pCon_Detalle, pPer_Num, pPer_Tip, 4);

	

	RETURN LAST_INSERT_ID();

END;



$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ModifProdCom
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ModifProdCom`;

DELIMITER $$
USE `ElPam`$$
CREATE PROCEDURE `ElPam`.`Pro_ModifProdCom` (IN pPro_CodIn INT, IN pPro_Nom VARCHAR(45), IN pPro_Descr VARCHAR(60),
    IN pPro_CodBar VARCHAR(45), IN pPro_PreVen DOUBLE, IN pCat_Num INT, IN pProCom_StokMin DOUBLE,
    IN pProCom_PreCom DOUBLE, IN pProCom_TipStok INT, IN pIVA_Num INT)
BEGIN

	UPDATE 
		`ElPam`.`ProductoCom` 
	SET 
		Cat_Num = pCat_Num, 
		ProCom_StokMin = pProCom_StokMin, 
		ProCom_PreCom = pProCom_PreCom, 
		ProCom_TipStok = pProCom_TipStok,
		IVA_Num = pIVA_Num
	WHERE 
		ProCom_CodIn = pPro_CodIn;
	
    
	UPDATE  
		`ElPam`.`Producto` 
	SET 
		Pro_Nom = pPro_Nom , 
		Pro_Descr = pPro_Descr, 
		Pro_CodBar = pPro_CodBar, 
		Pro_PreVen = pPro_PreVen 
	WHERE 
		Pro_CodIn = pPro_CodIn;
        
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaCli
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaCli`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaCli` (pPer_RasSos VARCHAR(45), pPer_Localidad VARCHAR(45), 
	pPer_Direccion VARCHAR (100),  pPer_Rut VARCHAR(45),pPer_CondIva INT, pPer_Docum VARCHAR (45), pPer_TipDocum INT, 
	pPai_Num INT,  pProvD_Num INT, pFechP_Tipo VARCHAR (6), pFechP_Intervalo INT, pFechP_Mes INT, 
	pFechP_Dia INT, pFechP_Aviso INT, pFechP_FechAlta DATE) RETURNS VARCHAR (60)
BEGIN 

  DECLARE xPer_Num INT;
	
	DECLARE xRespuesta VARCHAR (60) DEFAULT '';
	
	SELECT Num INTO xPer_Num  from ElPam.Viw_NumCli;
	
    INSERT INTO `ElPam`.`Persona` (`Per_Num`,`Per_Tip`,`Per_RasSos`, `Per_Localidad`, `Per_Direccion`, `Per_Rut`, 
	  `Per_CondIva`,`Per_Docum`, `Per_TipDocum`, `Pai_Num`, `ProvD_Num`) VALUE (`xPer_Num`,1 ,`pPer_RasSos`, `pPer_Localidad`, 
	  `pPer_Direccion`, `pPer_Rut`,`pPer_CondIva`,`pPer_Docum`, `pPer_TipDocum`, `pPai_Num`, `pProvD_Num`);
    
    INSERT INTO `ElPam`.`Cliente` (`Cli_Num`) VALUE (`xPer_Num`);

	
	-- /////////////////// Metodos FechPago /////////////////////////
	IF pFechP_Tipo IS NOT NULL THEN 
		SET xRespuesta = Fuc_AltaFechPago (pFechP_Tipo, pFechP_Intervalo, pFechP_Mes, 
			pFechP_Dia , pFechP_Aviso, pFechP_FechAlta);
	END IF;
      
	IF xRespuesta <> '' THEN
		-- Elimina Provedor recien ingresado
		DELETE FROM
			`ElPam`.`Provedor`
		WHERE
			`Prov_Num` = `pPer_Num`
		; -- Fin DELETE FROM
		
		DELETE FROM
			`ElPam`.`Persona`
		WHERE
			`Per_Num` = `pPer_Num` AND
			`Per_Tip` = 2
		; -- Fin DELETE FROM
		
		RETURN xRespuesta;
	END IF;
	-- //////////////// Fin Metodos FechPago ////////////////////////
    RETURN xPer_Num + '';
END;



$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ModMon
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ModMon`;

DELIMITER $$
USE `ElPam`$$




CREATE PROCEDURE `ElPam`.`Pro_ModMon` (In pMon_Num INT, IN pMon_Sig VARCHAR(6), IN pMon_Nom VARCHAR(45),IN pMon_CotCom FLOAT,IN pMon_CotVen FLOAT)
BEGIN

	IF pMon_Local THEN
		UPDATE 
			`ElPam`.`Moneda` 
		SET
			Mon_Local = false
		WHERE 
			Mon_Local = true
		;
	END IF;

	UPDATE 
		`ElPam`.`Moneda`
	SET
		`Mon_Sig` = `pMon_Sig`,
		`Mon_Nom` = `pMon_Nom`, 
		`Mon_CotCom` = `pMon_CotCom`,
		`Mon_CotVeta` = `pMon_CotVen`
	WHERE
		`Mon_Num` = `pMon_Num`
	;
	
END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_ModSaldo
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_ModSaldo`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION ElPam.Fuc_ModSaldo (pPer_Tip INT, pPer_Num INT, pMon_Num INT, pSal_LimDeu FLOAT, pSal_LimAcre FLOAT) RETURNS VARCHAR(45)
BEGIN 
    DECLARE xSal_Valor FLOAT;
    DECLARE xSal_Tipo BOOLEAN;

    SELECT 
        Sal_Valor, Sal_Tipo INTO xSal_Valor, xSal_Tipo
    FROM 
        ElPam.Saldo 
    WHERE 
        Per_Tip = pPer_Tip
        AND
        Per_Num = pPer_Num
        AND
        Mon_Num = pMon_Num
    ;

    IF ( xSal_Tipo = TRUE AND xSal_Valor < pSal_LimDeu ) OR
            (xSal_Tipo = FALSE AND xSal_Valor < pSal_LimAcre )
    THEN
        UPDATE 
                ElPam.Saldo 
        SET
            Sal_LimDeu = pSal_LimDeu,
            Sal_LimAcre = pSal_LimAcre
        WHERE
            Per_Tip = pPer_Tip
            AND
            Per_Num = pPer_Num
            AND
            Mon_Num = pMon_Num
        ;
        return '';
    else  return 'El Valor del saldo supero los limites establesidos';
    END IF;
END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_AltaContado
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_AltaContado`;

DELIMITER $$
USE `ElPam`$$
CREATE PROCEDURE `ElPam`.`Pro_AltaContado` (IN pFac_Num INT, IN pFac_Serie VARCHAR(1), IN pFac_Tip BOOLEAN,  IN pMon_Num INT, 
	IN pForP_MonAPag DOUBLE)
BEGIN 
	INSERT INTO 
		ElPam.FormaDePago
		(Fac_Num, Fac_Serie, Fac_Tip, ForP_Tip, Mon_Num, ForP_MonAPag)
	VALUE
		(pFac_Num, pFac_Serie, pFac_Tip, 1, pMon_Num, pForP_MonAPag)
	;
	
	INSERT INTO 
		ElPam.Contado
		(Fac_Num, Fac_Serie, Fac_Tip)
	VALUE
		(pFac_Num, pFac_Serie, pFac_Tip)
	;
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AsigSaldo
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AsigSaldo`;

DELIMITER $$
USE `ElPam`$$


CREATE FUNCTION`ElPam`.`Fuc_AsigSaldo` (pFac_Num INT, pFac_Serie VARCHAR (1), pFac_Tip BOOLEAN,  pMon_Num INT, 
	pForP_MonAPag FLOAT) RETURNS VARCHAR(60)
BEGIN 
	
	DECLARE xPer_Tip , xPer_Num INT;
	DECLARE xSal_LimDeu, xSal_LimAcre, xSal_Valor, xSal_Tipo FLOAT;
	

	
	-- Determina si es factura de comrea o de venta
	-- Se utiliza para sacar el numero de cliente o provedoor respectivante
	
	IF pFac_Tip = TRUE THEN -- Factura Venta //--FacturaVen--//
		SET xPer_Tip = 1;  -- Cliente
		SELECT 
				Cli_Num
			INTO
				xPer_Num
		FROM
			ElPam.FacturaVen
		WHERE
			Fac_Num = pFac_Num AND
			Fac_Serie = pFac_Serie
		;  -- Fin SELECT
		
	else -- Factura Compra //-- Factura Compra--//
		SET xPer_Tip = 2;
		SELECT 
				Prov_Num
			INTO
				xPer_Num
		FROM
			ElPam.FacturaCom
		WHERE
			Fac_Num = pFac_Num AND
			Fac_Serie = pFac_Serie
		; -- Fin SELECT
	END IF;
	
	-- Optiene lod limites del saldo 
	SELECT 
			Sal_LimDeu,
			Sal_LimAcre,
			Sal_Valor,
			Sal_Tipo
		INTO 
			xSal_LimDeu,
			xSal_LimAcre,
			xSal_Valor,
			xSal_Tipo
	FROM
		Saldo
	WHERE
		Per_Num = xPer_Num AND
		Per_Tip = xPer_Tip AND
		Mon_Num = pMon_Num
	; -- Fin SELECT
	
	 

	IF xSal_LimDeu IS NOT NULL THEN
		IF pFac_Tip THEN  -- Si la factura es fenta
		
			IF xSal_Tipo THEN -- Si el saldo es deudor
				SET xSal_Valor = xSal_Valor + pForP_MonAPag;
			ELSE -- Saldo Acreedor
				SET xSal_Valor = xSal_Valor - pForP_MonAPag;
				IF xSal_Valor < 0 THEN 
					SET xSal_Tipo = !xSal_Tipo;
					SET xSal_Valor = xSal_Valor * -1;
				END IF;
			END IF;
			
		ELSE -- Factura Compra
		
			IF xSal_Tipo THEN -- Si el saldo es deudor
				SET xSal_Valor = xSal_Valor - pForP_MonAPag;
				IF xSal_Valor < 0 THEN 
					SET xSal_Tipo = !xSal_Tipo;
					SET xSal_Valor = xSal_Valor * -1;
				END IF;
			ELSE -- Saldo Acreedor
				SET xSal_Valor =  xSal_Valor + pForP_MonAPag;
			END IF;
			
		END IF;
		
		
		IF xSal_LimDeu > 0 AND xSal_Tipo AND xSal_LimDeu < xSal_Valor THEN  -- Deudor
			RETURN 'El saldo deudor supera el límite deudor';
		END IF;
		
		IF xSal_LimAcre > 0 AND xSal_Tipo = FALSE AND xSal_LimAcre < xSal_Valor THEN  -- Acreedor
			RETURN 'El saldo acreedor supera el límite acreedor';
		END IF;
		
		UPDATE 
			ElPam.Saldo 
		SET
			Sal_Tipo = xSal_Tipo,
			Sal_Valor = xSal_Valor
		WHERE
			Per_Num = xPer_Num AND
			Per_Tip = xPer_Tip AND
			Mon_Num = pMon_Num
		; -- Fin Update
		
	ELSE 
               
		INSERT INTO 
			ElPam.Saldo
				(Per_Num, Per_Tip, Mon_Num, Sal_Valor, Sal_Tipo)
		VALUE 
			(xPer_Num, xPer_Tip, pMon_Num, pForP_MonAPag, pFac_Tip)
		;

	END IF;
	
	RETURN "";


END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaCredito
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaCredito`;

DELIMITER $$
USE `ElPam`$$


CREATE FUNCTION`ElPam`.`Fuc_AltaCredito` (pFac_Num INT, pFac_Serie VARCHAR (1), pFac_Tip BOOLEAN,  pMon_Num INT, 
	pForP_MonAPag DOUBLE, pInt_Num INT, pCre_CanCuo BIGINT , pCre_Tipo INT, pCre_Intervalo BIGINT, 
	pCre_FechIni DATE) RETURNS VARCHAR(60)
BEGIN 
	DECLARE xCre_Tipo VARCHAR (40);
	DECLARE xI INT DEFAULT 0; 
	DECLARE xCuo_Monto DOUBLE;
	DECLARE xRes VARCHAR (60);
	
	

	IF pCre_CanCuo < 0 THEN 
		RETURN 'La cantidad de cuotas no puede ser un número negativo';
	end if;
	
	IF pCre_Intervalo < 0 THEN 
		RETURN 'El intervalo no puede ser un numero negativo';
	end if;
	
	IF pCre_CanCuo <> 0 AND pCre_Tipo = 3 THEN 
		RETURN 'Si la tipo de credito es "Sin Cuotas" la cantidad de cuotas debe ser 0';
	end if;
	
	IF pCre_Intervalo <> 0 AND pCre_Tipo = 3 THEN 
		RETURN 'Si la tipo de crédito es "Sin Cuotas" el intervalo debe  ser 0';
	end if;
	
	CASE pCre_Tipo
		WHEN 1 THEN 
			SET xCre_Tipo = 'Anual';
		WHEN 3 THEN
			SET xCre_Tipo = 'Mensual';
		WHEN 2 THEN
			SET xCre_Tipo = 'Dia';
		WHEN 4 THEN
			SET xCre_Tipo = 'Sin Cuota';
		ELSE
			RETURN 'Tipo de crédito "pCre_Tipo" fuera de rango (1 - 4)';
	END CASE;

	SET xRes =  ElPam.Fuc_AsigSaldo 
		(pFac_Num , pFac_Serie,  pFac_Tip ,  pMon_Num , pForP_MonAPag);
        
	IF xRes <> '' THEN
		RETURN xRes;
	END IF;

		

	IF (pInt_Num = -1) THEN  
		SET pInt_Num = null;
	END IF;
	
	INSERT INTO 
		ElPam.FormaDePago
		(Fac_Num, Fac_Serie, Fac_Tip, ForP_Tip, Mon_Num, ForP_MonAPag)
	VALUE
		(pFac_Num, pFac_Serie, pFac_Tip, 2, pMon_Num, pForP_MonAPag)
	;
		
	INSERT INTO
		ElPam.Credito
                (`Fac_Num`,`Fac_Serie`, `Fac_Tip`, `Int_Num`, `Cre_CanCuo`, 
                    `Cre_Tipo`, `Cre_Intervalo`)
	VALUE
		(pFac_Num, pFac_Serie, pFac_Tip, pInt_Num, pCre_CanCuo, 
                    xCre_Tipo, pCre_Intervalo)
	;
	
	SET xCuo_Monto = pForP_MonAPag / pCre_CanCuo; 
	
	WHILE xI < pCre_CanCuo DO 
   
	
		INSERT INTO 
			ElPam.Cuota
				(Cuo_FechVen, Fac_Num, Fac_Serie, Fac_Tip, Cuo_Monto)
			VALUE
				(pCre_FechIni, pFac_Num, pFac_Serie, pFac_Tip, xCuo_Monto)
		;
		
		
		CASE pCre_Tipo
			WHEN 1 THEN 
				SET pCre_FechIni =  pCre_FechIni + YEAR (pCre_Intervalo);
			WHEN 2 THEN 
				SET pCre_FechIni =  pCre_FechIni + MONTH (pCre_Intervalo);
			WHEN 3 THEN  
				SET pCre_FechIni =  pCre_FechIni + DAY (pCre_Intervalo);
		END CASE;
		
		SET xI = xI +1;
		
	END WHILE;
 
  RETURN "";
	
END;


$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_ModProv
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_ModProv`;

DELIMITER $$
USE `ElPam`$$


CREATE FUNCTION `ElPam`.`Fuc_ModProv` (pPer_Num INT, pPer_RasSos VARCHAR(45), pPer_Localidad VARCHAR(45), 
    pPer_Direccion VARCHAR (100), pPer_Rut VARCHAR(45), pPer_CondIva INT, pPer_Docum VARCHAR (45), 
    pPer_TipDocum INT, pPai_Num INT, pProvD_Num INT, pFechP_Tipo VARCHAR (6), pFechP_Intervalo INT, pFechP_Mes INT, 
    pFechP_Dia INT, pFechP_Aviso INT, pFechP_FechAlta DATE) RETURNS VARCHAR (60)
BEGIN 

    DECLARE xPer_Num INT;
    DECLARE xRespuesta VARCHAR (60);

    -- //////////////// Metodos FechPago ////////////////////////
    IF pFechP_Tipo IS NOT NULL THEN 
        SET xRespuesta = Fuc_AltaFechPago(pFechP_Tipo, pFechP_Intervalo, pFechP_Mes, 
                pFechP_Dia, pFechP_Aviso, pFechP_FechAlta);
    ELSE
        DELETE FROM
            El_Pam.FechPago
        WHERE
            Per_Num = pPer_Num AND
            Per_Tip = pPer_Tip
        ; -- Fin DELETE FROM
    END IF;

    IF xRespuesta <> '' THEN
		RETURN xRespuesta;
    END IF;
	
    -- //////////////// Fin Metodos FechPago ////////////////////////
	
    SELECT Num INTO xPer_Num  from ElPam.Viw_ProV;
    
    UPDATE  
        `ElPam`.`Persona`
    SET 
        `Per_RasSos` = pPer_RasSos,
        `Per_Localidad` = pPer_Localidad,
        `Per_Direccion` = pPer_Direccion,
        `Per_Rut` = pPer_Rut, 
        `Per_CondIva` = pPer_CondIva,
        `Per_Docum` = pPer_Docum, 
        `Per_TipDocum` = pPer_TipDocum,
        `Pai_Num` =  pPai_Num,
        `ProvD_Num` = pProvD_Num
	WHERE 
    Per_Num = pPer_Num
	AND
            Per_Tip = 2
	;


END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fun_ModCli
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fun_ModCli`;

DELIMITER $$
USE `ElPam`$$


CREATE FUNCTION `ElPam`.`Fun_ModCli` ( pPer_Num INT, pPer_RasSos VARCHAR(45),  pPer_Localidad VARCHAR(45), 
	pPer_Direccion VARCHAR (100), pPer_Rut VARCHAR(45), pPer_CondIva INT, pPer_Docum VARCHAR (45), 
  pPer_TipDocum INT, pPai_Num INT,  pProvD_Num INT,  pFechP_Tipo VARCHAR (6), pFechP_Intervalo INT, pFechP_Mes INT, 
	pFechP_Dia INT, pFechP_Aviso INT, pFechP_FechAlta DATE) RETURNS VARCHAR (60)

BEGIN 

  DECLARE xPer_Num INT;
  DECLARE xRespuesta VARCHAR (60);
    
	-- //////////////// Metodos FechPago ////////////////////////
	IF pFechP_Tipo IS NOT NULL THEN 
		SET xRespuesta = Fuc_AltaFechPago (pFechP_Tipo, pFechP_Intervalo, pFechP_Mes, 
			pFechP_Dia , pFechP_Aviso, pFechP_FechAlta);
	ELSE
		
    DELETE FROM 
			El_Pam.FechPago
		WHERE
			Per_Num = pPer_Num AND
			Per_Tip = pPer_Tip
		; -- Fin DELETE FROM
	END IF;

	IF xRespuesta <> '' THEN
		RETURN xRespuesta;
	END IF;
	
	-- //////////////// Fin Metodos FechPago ////////////////////////
		
  SELECT Num INTO xPer_Num  from ElPam.Viw_ProV;

    UPDATE  
		`ElPam`.`Persona`
	SET 
	    `Per_RasSos` = pPer_RasSos,
	    `Per_Localidad` = pPer_Localidad,
	    `Per_Direccion` = pPer_Direccion,
	    `Per_Rut` = pPer_Rut, 
	    `Per_CondIva` = pPer_CondIva,
	    `Per_Docum` = pPer_Docum, 
	    `Per_TipDocum` = pPer_TipDocum,
	    `Pai_Num` =  pPai_Num,
	    `ProvD_Num` = pProvD_Num
	WHERE 
			Per_Num = pPer_Num
		AND
			Per_Tip = 1
	;
   RETURN '';
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AltaRecibo
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AltaRecibo`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AltaRecibo` (pRes_Emision DATETIME, pRes_Monto FLOAT, 
	pRes_DeQuien VARCHAR(45), pRes_Detalle VARCHAR (100), pMon_Num INT, pPer_Tip INT, 
	pPer_Num INT) RETURNS VARCHAR (50)

BEGIN 
	IF pRes_Emision IS NULL THEN
		RETURN 'No ha ingresado una Fecha de emisión';
	END IF;
	
	IF pRes_Monto < 0 THEN 
		RETURN 'El monto no puede ser un valor negativo';
	END IF;
	
	IF pRes_DeQuien IS NULL AND pRes = '' THEN 
		RETURN 'No a ingresado de quien reciobio el dine';
	END IF;
	
	INSERT INTO 
		ElPam.Recibo
			(Res_Emision, Res_Monto, Res_DeQuien, Res_Detalle, 
				Mon_Num, Per_Tip, Per_Num)
		VALUE
			(pRes_Emision, pRes_Monto, pRes_DeQuien, pRes_Detalle, 
				pMon_Num, pPer_Tip, pPer_Num)
	; -- Fin INSERT
	
	RETURN "" + LAST_INSERT_ID();
	
END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_AbrirCaja
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_AbrirCaja`;

DELIMITER $$
USE `ElPam`$$
CREATE FUNCTION `ElPam`.`Fuc_AbrirCaja` (pCaja_FechIni DATETIME, pCaja_MontoAbrir FLOAT, pMon_Num INT) RETURNS VARCHAR(60)
BEGIN
	DECLARE xCanCajAct INT;
	
	SELECT 
			COUNT(*) 
		INTO 
			xCanCajAct 
	FROM 
		Caja
	WHERE
		Caja_Abierta = TRUE AND
		Mon_Num = pMon_Num
	; -- Fin SELECT
	
	IF xCanCajAct > 0 THEN
		RETURN 'La caja con esta moneda ya está abierta';
	END IF;
	
	INSERT INTO 
		ElPam.Caja
			(Caja_FechIni, Caja_MontoAbrir, Caja_Abierta, Mon_Num)
		VALUE 
			(pCaja_FechIni, pCaja_MontoAbrir, pCaja_Abierta, pMon_Num)
	; -- Fin INSERT
	
	return '' + LAST_INSERT_ID();
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- function Fuc_CerrarCaja
-- -----------------------------------------------------

USE `ElPam`;
DROP function IF EXISTS `ElPam`.`Fuc_CerrarCaja`;

DELIMITER $$
USE `ElPam`$$


CREATE FUNCTION `ElPam`.`Fuc_CerrarCaja` (pCaja_FechFin DATETIME, pCaja_MontoCerrar FLOAT, pMon_Num INT) RETURNS VARCHAR(60)
BEGIN
	DECLARE xCanCajAct INT;
	
	SELECT 
			COUNT(*) 
		INTO 
			xCanCajAct 
	FROM 
		Caja
	WHERE
		Caja_Abierta = TRUE AND
		Mon_Num = pMon_Num
	; -- Fin SELECT
	
	IF xCanCajAct = 0 THEN
		RETURN 'No hay jaca abierta que coincida con esta moneda';
	END IF;
	
	UPDATE 
		ElPam.Caja
	SET 
		Caja_FechFin = pCaja_FechFin,
		Caja_MontoCerrar = pCaja_MontoCerrar,
		Caja_Abierta = FALSE
	WHERE 
		Caja_Abierta = TRUE AND
		Mon_Num = pMon_Num
	; -- Fin UPDATE
	return '';
END;

$$

DELIMITER ;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_ProductoCom`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_ProductoCom` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_ProductoCom`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_ProductoCom` AS 
SELECT
    ProCom_CodIn,
    (Pro_Nom)AS ProCom_Nom,
    (Pro_Descr)AS ProCom_Descr,
    (Pro_CodBar)AS ProCom_CodBar,
    (Pro_PreVen)AS ProCom_PreVen,
    `ProCom_Stok`,
     `ProCom_StokMin`,
     `ProCom_PreCom`,
     `ProCom_TipStok`,
     Categoria.`Cat_Num`,
     `Cat_Nom`,
     ('Producto')as Tipo,
     IVA.IVA_Num,
     IVA_Nom,
     IVA_Pors
FROM
        ElPam.Producto
    INNER JOIN
        ElPam.ProductoCom
    ON (
        Producto.`Pro_CodIn` = ProductoCom.`ProCom_CodIn`
    )
    
    INNER JOIN
        ElPam.Categoria
    ON(
        ProductoCom.Cat_Num = Categoria.Cat_Num
    )

    INNER JOIN
        ElPam.IVA
    ON(
        ProductoCom.IVA_Num = IVA.IVA_Num
    );

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumProd`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumProd` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumProd`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumProd` AS 
	SELECT
		if (max(Pro_CodIn) is null,
			0,
			max(Pro_CodIn) + 1)AS Num
	FROM
		ElPam.Producto;
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumNot`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumNot` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumNot`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumNot` AS 
	SELECT
		if (max(Not_Id) is null,
			0,
			max(Not_Id) + 1)AS Num
	FROM NotProd
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumCli`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumCli` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumCli`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumCli` AS 
    SELECT
        if (max(`Cli_Num`) is null,
            0,
            max(`Cli_Num`) + 1)AS Num
        
    FROM ElPam.Cliente

;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumMov`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumMov` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumMov`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumMov` AS 

	SELECT

		if (max(Mov_Num) is null,

			0,

			max(Mov_Num) + 1)AS Num

	FROM `ElPam`.`Movimiento`;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_SubProducto`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_SubProducto` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_SubProducto`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_SubProducto` AS
SELECT
    SubP_CodIn,
    (Pro_Nom)AS SubP_Nom,
    (Pro_Descr)AS SubP_Descr,
    (Pro_CodBar)AS SubP_CodBar,
    (Pro_PreVen)AS SubP_PreVen,
    `ProCom_Stok`,
    `ProCom_StokMin`,
    `ProCom_PreCom`,
    `Cat_Num`,
    `Cat_Nom`,
    `SubProducto`.`ProCom_CodIn`,
    (CONCAT('Sub Prod: ', `ProCom_NOm`))as Tipo
FROM
        ElPam.Producto
    INNER JOIN
        ElPam.SubProducto
    ON (
        Producto.`Pro_CodIn` = SubProducto.`SubP_CodIn`
    )
	INNER JOIN
		ElPam.Viw_ProductoCom
	ON (
		Viw_ProductoCom.ProCom_CodIn = SubProducto.ProCom_CodIn
  );

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Producto`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Producto` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Producto`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Producto` AS 

SELECT
	(ProCom_CodIn)AS Pro_CodIn,
	(ProCom_Nom)AS Pro_Nom,
	(ProCom_Descr)AS Pro_Descr,
	(ProCom_CodBar)AS Pro_CodBar,
	(ProCom_PreVen)AS Pro_PreVen,
	(ProCom_Stok)AS Pro_Stok,
	(ProCom_StokMin)AS Pro_StokMin,
	(ProCom_PreCom)AS Pro_PreCom,
	Cat_Num,
	Cat_Nom,
	Tipo
FROM
	ElPam.Viw_ProductoCom

    UNION

SELECT
	(SubP_CodIn)AS Pro_CodIn,
	(SubP_Nom)AS Pro_Nom,
	(SubP_Descr)AS Pro_Descr,
	(SubP_CodBar)AS Pro_CodBar,
	(SubP_PreVen)AS Pro_PreVen,
	(ProCom_Stok)AS Pro_Stok,
	(ProCom_StokMin)AS Pro_StokMin,
	(ProCom_PreCom)AS Pro_PreCom,
	Cat_Num,
	Cat_Nom,
	Tipo
FROM
	ElPam.Viw_SubProducto;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumProv`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumProv` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumProv`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumProv` AS 
	SELECT
		if (max(Prov_Num) is null,
			0,
			max(Prov_Num) + 1)AS Num
	FROM Proveedor;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Tel`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Tel` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Tel`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Tel` AS 
	SELECT 
		Con_Num, 
		Con_Nom, 
		Con_Detalle, 
		Per_Num, 
		Per_Tip
	FROM
		ElPam.Contacto
	WHERE 
		Per_Tip = 1

;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Cel`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Cel` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Cel`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Cel` AS
SELECT 
		Con_Num, 
		Con_Nom, 
		Con_Detalle, 
		Per_Num, 
		Per_Tip
	FROM
		ElPam.Contacto
	WHERE 
		Per_Tip = 2
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Fax`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Fax` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Fax`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Fax` AS
SELECT 
		Con_Num, 
		Con_Nom, 
		Con_Detalle, 
		Per_Num, 
		Per_Tip
	FROM
		ElPam.Contacto
	WHERE 
		Per_Tip = 3
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Mail`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Mail` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Mail`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Mail` AS
	SELECT 
		Con_Num, 
		Con_Nom, 
		Con_Detalle, 
		Per_Num, 
		Per_Tip
	FROM
		ElPam.Contacto
	WHERE 
		Per_Tip = 4
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Cliente`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Cliente` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Cliente`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Cliente` AS 
SELECT 
	Persona.Per_Num,
	Per_RasSos,
	Per_Localidad,
	Per_Direccion,
	Per_Docum,
	Per_TipDocum,
	Per_CondIva,
	Per_Rut,
	ProvDep.ProvD_Num,
	ProvD_Nom,
	Pais.Pai_Num,
	Pai_Nom,
	FechPago.FechP_Tipo,
	FechPago.FechP_Intervalo,
	FechPago.FechP_Mes,
	FechPago.FechP_Dia,
	FechPago.FechP_Aviso,
	FechPago.FechP_FechAlta
FROM
		ElPam.Persona 
	INNER JOIN 
		ElPam.Pais
	ON (
		Persona.Pai_Num = Pais.Pai_Num
	)
	INNER JOIN 
		ElPam.ProvDep
	ON (
		ProvDep.ProvD_Num = Persona.ProvD_Num
	)
	LEFT JOIN 
		ElPam.FechPago
	ON (
		Persona.Per_Num = FechPago.Per_Num AND
		Persona.Per_Tip = FechPago.Per_Tip
	)
WHERE 
    Persona.Per_Tip = 1;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Proveedor`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Proveedor` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Proveedor`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Proveedor` AS 
SELECT 
	Persona.Per_Num,
	Per_RasSos,
	Per_Localidad,
	Per_Direccion,
	Per_Docum,
	Per_TipDocum,
	Per_CondIva,
	Per_Rut,
	ProvDep.ProvD_Num,
	ProvD_Nom,
	Pais.Pai_Num,
	Pai_Nom,
	FechPago.FechP_Tipo,
	FechPago.FechP_Intervalo,
	FechPago.FechP_Mes,
	FechPago.FechP_Dia,
	FechPago.FechP_Aviso,
	FechPago.FechP_FechAlta
FROM
		ElPam.Persona 
	INNER JOIN 
		ElPam.Pais
	ON (
		Persona.Pai_Num = Pais.Pai_Num
	)
	INNER JOIN 
		ElPam.ProvDep
	ON (
		ProvDep.ProvD_Num = Persona.ProvD_Num
	)
	LEFT JOIN 
		ElPam.FechPago
	ON (
		Persona.Per_Num = FechPago.Per_Num AND
		Persona.Per_Tip = FechPago.Per_Tip
	)
WHERE 
    Persona.Per_Tip = 2
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Moneda`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Moneda` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Moneda`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Moneda` AS
SELECT
    `Mon_Num`, 
    `Mon_Nom`, 
    `Mon_Sig`, 
    `Mon_CotCom`, 
    `Mon_CotVenta`, 
    `Mon_FechMod`, 
    `Pai_Nom`, 
     Pais.Pai_Num,
    `Mon_Local`
FROM 
        ElPam.Moneda 
    INNER JOIN 
        ElPam.Pais 
    ON (
        Pais.`Pai_Num` = Moneda.`Pai_Num`
        )
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_NumFacVen`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_NumFacVen` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_NumFacVen`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_NumFacVen` AS
SELECT
	if (max(Fac_Num) is null,
		0,
		max(Fac_Num) + 1)AS Num
FROM
	ElPam.FacturaVen;
USE `ElPam`;

;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_FacturaVen`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_FacturaVen` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_FacturaVen`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_FacturaVen` AS
SELECT 
     Factura.`Fac_Num`, 
     Factura.`Fac_Serie`, 
     Factura.`Fac_Fech`,
    `Cli_Num`,
    `Per_RasSos`,
    `Per_Tip`,
    `Fac_IvaTb`, 
    `Fac_ReIvaTb`, 
    `Fac_IvaTm`, 
    `Fac_ReIvaTm`, 
    `Fac_SubTot`, 
    `Fac_Des`, 
    (
        `Fac_SubTot` + 
        `Fac_Des`+ 
        `Fac_ReIvaTm` + 
        `Fac_ReIvaTb`
    )as Fac_Total
FROM 
        ElPam.Factura 
    INNER JOIN 
        ElPam.FacturaVen 
    ON 
        (
            Factura.`Fac_Num` = 
            FacturaVen.`Fac_Num`
        )


   Left JOIN 
        ElPam.Persona
   ON 
        (
            FacturaVen.`Cli_Num` = 
            Persona.`Per_Num` 
            AND 
            Persona.`Per_Tip` = 1
        )
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Saldo`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Saldo` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Saldo`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Saldo` AS
SELECT 
	Per_Num,
	Per_Tip,
	Sal_Valor,
	Sal_Tipo,
	Sal_LimDeu,
	Sal_LimAcre,
	Sal_FechM,
	Viw_Moneda.*
FROM 
		ElPam.Saldo
	INNER JOIN 
    ElPam.Viw_Moneda
	ON (
    Viw_Moneda.Mon_Num = Saldo.Mon_Num
    )
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_FacturaCom`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_FacturaCom` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_FacturaCom`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_FacturaCom` AS
SELECT 
   Factura.`Fac_Num`, 
	 Factura.`Fac_Serie`,
   Factura.`Fac_Fech`,
	`Prov_Num`,
  `Per_RasSos`,
  `Per_Tip`,
	`Fac_IvaTb`, 
	`Fac_ReIvaTb`, 
	`Fac_IvaTm`, 
	`Fac_ReIvaTm`, 
	`Fac_SubTot`, 
	`Fac_Des`, 
	(
		`Fac_SubTot` + 
		`Fac_Des`+ 
		`Fac_ReIvaTm` + 
		`Fac_ReIvaTb`
	)as Fac_Total
FROM 
		ElPam.Factura 
	INNER JOIN 
		ElPam.FacturaCom 
	ON 
		(
			Factura.`Fac_Num` = 
			FacturaCom.`Fac_Num`
		)

   Left JOIN 
        ElPam.Persona
   ON 
        (
            FacturaCom.`Prov_Num` = 
            Persona.`Per_Num` 
            AND 
            Persona.`Per_Tip` = 2
        )
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_ReciboFull`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_ReciboFull` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_ReciboFull`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_ReciboFull` AS 
SELECT 
    Recibo.Res_Num,
    Recibo.Res_Emision,
    Recibo.Res_Monto,
    Recibo.Res_DeQuien,
    Recibo.Res_Detalle,
    Recibo.Per_Tip,
    Recibo.Per_Num,
    Viw_Moneda.*
FROM 
    ElPam.Recibo
INNER JOIN 
    ElPam.Viw_Moneda
ON (Recibo.Mon_Num = Viw_Moneda.Mon_Num)
;
USE `ElPam`;

DELIMITER $$

USE `ElPam`$$
DROP TRIGGER IF EXISTS `ElPam`.`TriDe_AltaMov` $$
USE `ElPam`$$


CREATE TRIGGER TriDe_AltaMov AFTER INSERT ON `ElPam`.`Movimiento`
FOR EACH ROW 
BEGIN

	DECLARE CanProd DOUBLE;
	SET CanProd = NEW.Mov_CanProd;
	
  IF NEW.Mov_Tip = FALSE THEN
		SET CanProd = CanProd * -1;
	END IF;
    
	UPDATE `ElPam`.`ProductoCom` SET
		ProCom_Stok=ProCom_Stok+CanProd 
		WHERE ProCom_CodIn = NEW.ProCom_CodIn;
                    
END;$$


USE `ElPam`$$
DROP TRIGGER IF EXISTS `ElPam`.`TriAn_AltaMov` $$
USE `ElPam`$$


CREATE TRIGGER TriAn_AltaMov BEFORE INSERT ON `ElPam`.`Movimiento`

FOR EACH ROW 

BEGIN

     SET NEW.Mov_FecHor = NOW();
    
END;$$


DELIMITER ;

DELIMITER $$

USE `ElPam`$$
DROP TRIGGER IF EXISTS `ElPam`.`TriAn_AltaLinF` $$
USE `ElPam`$$


CREATE TRIGGER TriAn_AltaLinF BEFORE INSERT ON `ElPam`.`LineaFactura`

FOR EACH ROW 

BEGIN
	DECLARE xLinF_CanProd, xSubTotal, xIvaTb, xIvaTm, xResIvaTb, xResIvaTm DOUBLE DEFAULT 0;
	DECLARE xIVA_Num INT;
	DECLARE xAumenta BOOLEAN DEFAULT TRUE;
	
	IF NEW.Fac_Tip THEN
		SET xAumenta = FALSE;
	END IF;
	
	
	SET xLinF_CanProd = NEW.LinF_CanProd; 
	SET xSubTotal = NEW.LinF_PrePro * xLinF_CanProd;
	
	
	SELECT IVA_Num INTO xIVA_Num FROM `ElPam`.`IVA` WHERE IVA_Pors = NEW.LinF_IVA;
	
	
	
	CALL Pro_ActuStok (NEW.Pro_CodIn, NEW.LinF_CanProd, xAumenta);
	
	
	IF xIVA_Num = 1 THEN  
		SET xIvaTb = NEW.LinF_IVA;
		SET xResIvaTb = xSubTotal * (xIvaTb /100);
	ELSEIF xIVA_Num = 2 THEN 
		SET xIvaTm = NEW.LinF_IVA;
		SET xResIvaTm = xSubTotal * (xIvaTm /100);
	END IF;
	
	
	UPDATE 
		ElPam.Factura 
	SET 
		Fac_ReIvaTb = Fac_ReIvaTb + xResIvaTb,
		Fac_IvaTb = xIvaTb,
		Fac_ReIvaTm = Fac_ReIvaTm + xResIvaTm,
		Fac_IvaTm = xIvaTm,
		Fac_SubTot = Fac_SubTot + xSubTotal,
		Fac_Des = Fac_Des + NEW.LinF_Des
	WHERE
		Fac_Num = NEW.Fac_Num AND
		Fac_Tip = NEW.Fac_Tip AND
		Fac_Serie = NEW.Fac_Serie
	;
END;$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ElPam`.`IVA`
-- -----------------------------------------------------
START TRANSACTION;
USE `ElPam`;
INSERT INTO `ElPam`.`IVA` (`IVA_Num`, `IVA_Nom`, `IVA_Pors`) VALUES (1, 'Tasa Basica', 22);
INSERT INTO `ElPam`.`IVA` (`IVA_Num`, `IVA_Nom`, `IVA_Pors`) VALUES (2, 'Tasa Minima', 10);
INSERT INTO `ElPam`.`IVA` (`IVA_Num`, `IVA_Nom`, `IVA_Pors`) VALUES (3, 'Exento', 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `ElPam`.`Pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `ElPam`;
INSERT INTO `ElPam`.`Pais` (`Pai_Num`, `Pai_Nom`) VALUES (1, 'Uruguay');

COMMIT;

-- -----------------------------------------------------
-- Data for table `ElPam`.`ProvDep`
-- -----------------------------------------------------
START TRANSACTION;
USE `ElPam`;
INSERT INTO `ElPam`.`ProvDep` (`ProvD_Num`, `Pai_Num`, `ProvD_Nom`) VALUES (1, 1, 'Salto');

COMMIT;
 (1023,'Days sensitive','','7793620002839',24),

-- -----------------------------------------------------
-- Data for table `ElPam`.`Moneda`
-- -----------------------------------------------------
START TRANSACTION;
USE `ElPam`;
INSERT INTO `ElPam`.`Moneda` (`Mon_Num`, `Mon_Sig`, `Mon_Nom`, `Mon_CotCom`, `Mon_CotVenta`, `Mon_FechMod`, `Pai_Num`, `Mon_Local`) VALUES (1, '$U', 'Peso Uruguayo', 0, 0, DEFAULT, 1, 1);

COMMIT;



--
-- Dumping data for table `categoria`
--

/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO ElPam.`categoria` (`Cat_Num`,`Cat_Nom`) VALUES 
 (21,'Aceite'),
 (295,'Aceituna'),
 (45,'Acondicionador'),
 (158,'Aderentes'),
 (179,'Adherentes'),
 (152,'Adobo'),
 (110,'Agua mineral'),
 (124,'Agujas'),
 (181,'Album'),
 (162,'Alcool'),
 (78,'Alfajores'),
 (184,'Alfajores nieve'),
 (268,'Algodon'),
 (60,'Algodon Hidrofilo'),
 (88,'Amarga'),
 (39,'Anana'),
 (273,'Anana Fizz'),
 (11,'Anis'),
 (170,'Aromatizador'),
 (42,'Aromatizante de Ambientes'),
 (17,'Arroz'),
 (23,'Arvejas'),
 (307,'Arvejas Choclo Lata'),
 (30,'Atun'),
 (22,'Avena'),
 (219,'Azafran'),
 (13,'Azucar'),
 (242,'Azucar Colorante'),
 (141,'Bastoncitos de Algodon'),
 (104,'Bebida lactea'),
 (255,'Bebote'),
 (240,'Belas'),
 (223,'Bicarbonato'),
 (259,'Biscochuelo'),
 (54,'Bolsa de Residuos'),
 (263,'Bolsa Residual'),
 (79,'Bombones'),
 (245,'Boxer'),
 (227,'Broche'),
 (243,'Cadenitas'),
 (2,'Cafe'),
 (120,'Cafe  (sobres)'),
 (126,'Caldos'),
 (89,'Caña'),
 (224,'Canela'),
 (127,'Caramelos'),
 (214,'Caravanas'),
 (138,'Carne'),
 (137,'Carne Ovina'),
 (175,'Carne Vacuna'),
 (211,'Cartuchera'),
 (296,'Cebada'),
 (121,'Cepillo de dientes'),
 (284,'Cepillo de ropa'),
 (180,'Cepillo para ropa'),
 (163,'Cera'),
 (182,'Cereal en barra'),
 (167,'Cereales'),
 (185,'Cerveza'),
 (202,'Chalas'),
 (303,'Champiñon'),
 (128,'Chiclets'),
 (168,'Chisitos'),
 (27,'Choclo'),
 (183,'Chocolate'),
 (82,'Chocolate confitado'),
 (135,'Chorizo'),
 (231,'Cierres'),
 (10,'Clavo de Olor'),
 (3,'Cocoa'),
 (119,'Cocoa (sobre)'),
 (216,'Colador'),
 (252,'Coleros'),
 (172,'Colet'),
 (198,'Coloña Niños'),
 (221,'Comino'),
 (213,'Compas'),
 (225,'Condimento Verde'),
 (169,'Conitos'),
 (217,'Cordones'),
 (247,'Cortina BaÃ±o'),
 (205,'Crayolas'),
 (199,'Crema Corporal'),
 (106,'Crema de leche'),
 (310,'Crema Peinar'),
 (257,'Crema Santilli'),
 (70,'Creolina'),
 (204,'Cuadernos'),
 (193,'Delineador'),
 (313,'Desinfestante'),
 (62,'Desodorante'),
 (65,'Desodorante en aerosol'),
 (63,'Desodorante en barra'),
 (64,'Desodorante en roll on'),
 (274,'Desodorante Inodoro'),
 (50,'Detergentes'),
 (173,'Dulce'),
 (101,'Dulce de leche'),
 (38,'Duraznos'),
 (294,'Duraznos en Almivar'),
 (14,'Edulcorante'),
 (287,'Enjuage bucal'),
 (301,'Enlatadas'),
 (308,'Ensalada de Fruta'),
 (166,'Ensendedores'),
 (178,'Escobas'),
 (190,'Espejo de Cartera'),
 (189,'Espejo de Mano'),
 (191,'Espejo grande'),
 (72,'Espirales x bolsa'),
 (67,'Espirales x caja'),
 (286,'Espon de alumino'),
 (309,'Esponja Ace. Inoxidable'),
 (55,'Esponja de aluminio'),
 (57,'Esponjas'),
 (155,'Extracto Tomate'),
 (151,'Fariña'),
 (206,'Fibras'),
 (16,'Fideos'),
 (281,'Fiedo'),
 (292,'Flan'),
 (6,'Flan Godet'),
 (194,'Floreros'),
 (123,'Fosforos'),
 (285,'Franela'),
 (277,'Galleta Arros'),
 (81,'Galletitas'),
 (80,'Galletitas rellenas'),
 (117,'Gasa Hidrofila'),
 (236,'Gel'),
 (304,'Gelatina'),
 (234,'Goma'),
 (241,'Grajeas'),
 (91,'Grappa'),
 (90,'Grappamiel'),
 (153,'Grasa'),
 (97,'Grissines'),
 (246,'Guantes'),
 (53,'Guantes de latex'),
 (19,'Harina'),
 (145,'Harina Calsal'),
 (305,'Helado Polvo'),
 (5,'Helado Richard'),
 (232,'Hilo Coser'),
 (118,'Hilo Dental'),
 (201,'Hojilla'),
 (230,'Hondulines'),
 (177,'Huevos'),
 (144,'Insecticida'),
 (311,'Isopo'),
 (44,'Jabon'),
 (76,'Jabon de labar'),
 (226,'Jabon de Tocador'),
 (140,'Jabon en Barra'),
 (49,'Jabon en polvo'),
 (157,'Jabon Tocador'),
 (161,'Jardinera'),
 (25,'Jardinera de Legumbres'),
 (160,'Jardinera Liquido'),
 (164,'Juego Hauja'),
 (34,'Jugos'),
 (312,'Kaña'),
 (33,'Ketchup'),
 (75,'Lamparas'),
 (266,'Lampaso'),
 (212,'Lapicera'),
 (207,'Lapis Colores'),
 (278,'Lavanda'),
 (52,'Lavandina'),
 (105,'Leche chocolatada'),
 (147,'Leche Larga vida'),
 (150,'Lenteja'),
 (113,'Leuco'),
 (154,'Levadura'),
 (139,'Licores'),
 (289,'Limpiador gatillo'),
 (48,'Limpiador liquido'),
 (276,'Limpiador Ropa'),
 (149,'Maicena'),
 (26,'Maiz Dulce'),
 (95,'Malteada'),
 (218,'Mamadera'),
 (148,'Mani'),
 (108,'Manteca'),
 (122,'Maquina desechables de afeitar'),
 (271,'Margarina'),
 (229,'Mate'),
 (32,'Mayonesa'),
 (244,'Medias'),
 (111,'Medicamentos'),
 (112,'Medicamentosº'),
 (98,'Merengues'),
 (100,'Mermeladas'),
 (210,'Mochila'),
 (176,'Mondongo'),
 (156,'Moztasa'),
 (272,'Okezitos'),
 (256,'Organizador'),
 (131,'Ovina'),
 (264,'Pa?ales'),
 (265,'Pa?o de Piso'),
 (237,'PaÃ±uelos'),
 (71,'Palillos para ropa'),
 (36,'Palitos'),
 (94,'Palitos de harina de maiz y queso'),
 (93,'Palitos de jamon'),
 (302,'Palmitos'),
 (77,'Pañales'),
 (56,'Paño de Piso'),
 (116,'Pañuelos descartables'),
 (92,'Papas fritas'),
 (40,'Papel Higienico'),
 (239,'Parches'),
 (66,'Pasta dental'),
 (283,'Pastilla baño'),
 (129,'Pastillas'),
 (260,'PatÃ©'),
 (300,'Pate'),
 (235,'Peine'),
 (188,'Perfume'),
 (192,'Petacas Maquillaje'),
 (31,'Picadillo de Carne'),
 (69,'Pilas chicas'),
 (73,'Pilas grandes'),
 (74,'Pilas medianas'),
 (270,'Pimenton'),
 (220,'Pimienta Blanca'),
 (222,'Pimienta granulada'),
 (209,'Pinceles'),
 (254,'Pincitas'),
 (251,'Pinsas'),
 (215,'Pinzitas Cabello.'),
 (20,'Polenta'),
 (134,'Pollo'),
 (24,'Porotos'),
 (306,'Porotos Lata'),
 (187,'Porta Retrato'),
 (96,'Porteñita'),
 (293,'Postre'),
 (103,'Postre lacteo'),
 (258,'Postre light'),
 (115,'Preservativos de Latex'),
 (142,'Promocion'),
 (58,'Protectores Diarios'),
 (159,'Protectores Diarioso'),
 (282,'Pulidor'),
 (28,'Pulpa de Tomate'),
 (15,'Pure de Papas'),
 (107,'Queso untable'),
 (238,'Rallador'),
 (171,'Ravioles'),
 (291,'Recarga economica'),
 (290,'Recarga gatillo'),
 (109,'Refrescos'),
 (279,'Regla'),
 (250,'Reloj Pared'),
 (51,'Removedor de sarro'),
 (41,'Rollos de Cocina'),
 (196,'Ropa Interior Fem'),
 (197,'Ropa Interior Mas'),
 (195,'Ropa Invierno'),
 (37,'Royal'),
 (4,'Royarina'),
 (228,'Rueditas'),
 (12,'Sal Fina'),
 (269,'Sal Grusa'),
 (299,'Salas'),
 (298,'Salsa'),
 (261,'Salsa Blanca'),
 (262,'Salsas'),
 (275,'Sampo/Acondicionador'),
 (29,'Sardina'),
 (297,'Servilletas'),
 (43,'Shampoo'),
 (46,'Shampoo y Acondicionador'),
 (186,'Sidra'),
 (200,'Sigarrillo'),
 (233,'Sinta Haislante'),
 (249,'Sonajeros'),
 (18,'Sopa'),
 (248,'Stirer'),
 (47,'Suavizantes'),
 (280,'Tablero'),
 (68,'Tabletas contra mosquitos'),
 (61,'Talco'),
 (288,'Tampon'),
 (174,'Tapas Empanada'),
 (99,'Tapas hojaldradas'),
 (7,'Te'),
 (9,'Te Rojo'),
 (208,'Tijeras'),
 (143,'Tinta'),
 (203,'Tinta Cabello'),
 (253,'Tiquitacas'),
 (59,'Toallas Femeninas'),
 (267,'Toallitas Humeda'),
 (133,'Vacuna'),
 (8,'Vainilla'),
 (125,'Velas de cumpleaños'),
 (114,'Venditas Adhesivas'),
 (84,'Vermouth'),
 (35,'Vinagre'),
 (85,'Vinos'),
 (86,'Vinos en caja'),
 (83,'waffles'),
 (87,'whisky'),
 (1,'Yerba'),
 (165,'Yiled'),
 (102,'Yogurt'),
 (146,'Yogurt Integral');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;





--
-- Dumping data for table `persona`
--

/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO ElPam.`persona` (`Per_Num`,`Per_Tip`,`Per_RasSos`,`Per_Localidad`,`Per_Direccion`,`Per_Rut`,`Per_CondIva`,`Per_Docum`,`Per_TipDocum`,`ProvD_Num`,`Pai_Num`) VALUES 
 (0,1,'Ary ','Constitucion','dsf','',1,NULL,0,1,1),
 (1,1,'Escuela N7','Constitucion','asdf','',1,NULL,0,1,1),
 (2,1,'Monolo Reina','Constitucion','asdf','',1,NULL,0,1,1),
 (3,1,'Pocho Souza','Constitucion','asdf','',1,NULL,0,1,1),
 (4,1,'Olga Da Roza','Constitucion','asdf','',1,NULL,0,1,1),
 (5,1,'Fani Lafuente','Constitucion','df','',1,NULL,0,1,1),
 (6,1,'Picha','Constitucion','asd','',1,NULL,0,1,1),
 (7,1,'Alverto Piris','Constitucion','asd','',1,NULL,0,1,1),
 (8,1,'Alfredo Danieluck','Constitucion','asd','',1,NULL,0,1,1),
 (9,1,'Carlucho Muños','Constitucion','asdf','',1,NULL,0,1,1),
 (10,1,'Pocha De Maria','Constitucion','asdf','',1,NULL,0,1,1),
 (11,1,'Maria del Verdum','Constitucion','asdf','',1,NULL,0,1,1),
 (12,1,'Wilson antunez','Constitucin','zxcv','',1,NULL,0,1,1),
 (13,1,'Wilson Molina','Constitucin','asd','',1,NULL,0,1,1),
 (14,1,'Jose molina ','Constitucin','ASD','',1,NULL,0,1,1),
 (15,1,'Sofildo Lopez','Constitucin','asdf','',1,NULL,0,1,1),
 (16,1,'Mauro Raveli','Constitucin','asdf','',1,NULL,0,1,1),
 (17,1,'Tito Carballo','Constitucin','<zxc','',1,NULL,0,1,1),
 (18,1,'Ivan Reina','Constitucin','asd','',1,NULL,0,1,1),
 (19,1,'Amado Cardozo','Constitucin','asdf','',1,NULL,0,1,1),
 (20,1,'Julio Chiappa','Constitucin','asdf','',1,NULL,0,1,1),
 (21,1,'Olga Da Silva','Constitucin','sd','',1,NULL,0,1,1),
 (22,1,'Alpuy ','Constitucin','sdf','',1,NULL,0,1,1),
 (23,1,'Dario Cabral','Constitucin','s','',1,NULL,0,1,1),
 (24,1,'Ramon Fernandez','Constitucin','ASDF','',1,NULL,0,1,1),
 (25,1,'Richard Francia','Constitucin','asdf','',1,NULL,0,1,1),
 (26,1,'Amanda Chavez','Constitucin','sdf','',1,NULL,0,1,1),
 (27,1,'Victoria Rodriguez','Constitucin','asdf','',1,NULL,0,1,1),
 (28,1,'Dina ','Constitucin','asdf','',1,NULL,0,1,1),
 (29,1,'Maximo Perfecto','Constitucin','sadf','',1,NULL,0,1,1),
 (30,1,'No Existe','Constitucin','asdf','',1,NULL,0,1,1),
 (31,1,'No Existe','Constitucin','asdf','',1,NULL,0,1,1),
 (32,1,'No Existe','Constitucin','asdf','',1,NULL,0,1,1),
 (33,1,'Eloy Garcias','Constitucin','d','',1,NULL,0,1,1),
 (34,1,'Papel','Constitucin','asdf','',1,NULL,0,1,1),
 (35,1,'Angel Hernandez','Constitucin','sdf','',1,NULL,0,1,1),
 (36,1,'Solange','Constitucin','qwer','',1,NULL,0,1,1),
 (37,1,'Secundino Jara','Constitucin','asdf','',1,NULL,0,1,1),
 (38,1,'Everilda Reina','Constitucin','asdf','',1,NULL,0,1,1),
 (39,1,'Jaun Carballo','Constitucin','asdf','',1,NULL,0,1,1),
 (40,1,'Washington Fagundez','Constitucin','d','',1,NULL,0,1,1),
 (41,1,'Dutra','Constitucin','asdf','',1,NULL,0,1,1),
 (42,1,'Elisa Da Costa','Constitucin','asd','',1,NULL,0,1,1),
 (43,1,'Nino Ramirez','Constitucin','s','',1,NULL,0,1,1),
 (44,1,'Jose Luis Acosta','Constitucin','asdf','',1,NULL,0,1,1),
 (45,1,'Filfredo Cardozo','Constitucin','asdf','',1,NULL,0,1,1),
 (46,1,'Paolini','Constitucin','asfds','',1,NULL,0,1,1),
 (47,1,'Raul Chiappa','Constitucin','d','',1,NULL,0,1,1),
 (48,1,'Ngero Rivas','Constitucin','s','',1,NULL,0,1,1),
 (49,1,'Rita Fagundez','Constitucin','sdf','',1,NULL,0,1,1),
 (50,1,'Mara Camara','Constitucin','sdf','',1,NULL,0,1,1),
 (51,1,'No Existe','Constitucin','asdf','',1,NULL,0,1,1),
 (52,1,'Hugo Chiappa','Constitucin','asd','',1,NULL,0,1,1),
 (53,1,'Sandra Echenique','Constitucin','zg','',1,NULL,0,1,1),
 (54,1,'Milton Costa','Constitucin','asdf','',1,NULL,0,1,1),
 (55,1,'Richard Costa','Constitucin','900','',1,NULL,0,1,1),
 (56,1,'Ana Camara','Constitucin','as','',1,NULL,0,1,1),
 (57,1,'Rose Marie','Constitucin','asdf','',1,NULL,0,1,1),
 (58,1,'Teodoro Cardozo','Constitucin','asdf','',1,NULL,0,1,1),
 (59,1,'Juan Ferreira','Constitucin','asdf','',1,NULL,0,1,1);


INSERT INTO ElPam.`cliente` (`Cli_Num`,`Per_Tip`) VALUES 
 (0,1),
 (1,1),
 (2,1),
 (3,1),
 (4,1),
 (5,1),
 (6,1),
 (7,1),
 (8,1),
 (9,1),
 (10,1),
 (11,1),
 (12,1),
 (13,1),
 (14,1),
 (15,1),
 (16,1),
 (17,1),
 (18,1),
 (19,1),
 (20,1),
 (21,1),
 (22,1),
 (23,1),
 (24,1),
 (25,1),
 (26,1),
 (27,1),
 (28,1),
 (29,1),
 (30,1),
 (31,1),
 (32,1),
 (33,1),
 (34,1),
 (35,1),
 (36,1),
 (37,1),
 (38,1),
 (39,1),
 (40,1),
 (41,1),
 (42,1),
 (43,1),
 (44,1),
 (45,1),
 (46,1),
 (47,1),
 (48,1),
 (49,1),
 (50,1),
 (51,1),
 (52,1),
 (53,1),
 (54,1),
 (55,1),
 (56,1),
 (57,1),
 (58,1),
 (59,1);



INSERT INTO ElPam.`producto` (`Pro_CodIn`,`Pro_Nom`,`Pro_Descr`,`Pro_CodBar`,`Pro_PreVen`) VALUES 
 (1,'Abuelita','','7730415000540',69),
 (2,'El Moncayo 1/2','','7730910600221',42),
 (3,'San Pedro','','7730241003463',49),
 (4,'Uruguay 1k','','7730415000359',55),
 (5,'Del Gaucho','','7130903168026',63),
 (7,'Bracafe 100g','','7730109111125',115),
 (9,'Bracafe 204g','','7730109002027',198),
 (10,'Bracafe 50g','','7730109000115',49),
 (11,'Aguila','','7730109012521',75),
 (12,'El Paulista','','7730290002738',28),
 (13,'Montesol','','7730290001182',25),
 (14,'Copacabana','','7730109032123',33),
 (15,'Flam Vainilla 54g','','7730110124220',22),
 (16,'Postre Vainilla 27g','','7730110124046',12),
 (17,'Postre Chocolate','','7622300226237',12),
 (18,'Dulce de leche','','7730476000800',26),
 (19,'Chocolate','','7730476000817',26),
 (20,'Frutilla','','7730476000794',26),
 (21,'Vainilla','','7730476000787',26),
 (22,'Vainilla','','7790580621209',22),
 (23,'Chocolate','','7790580621001',22),
 (24,'Hornimans','','7730261000015',2),
 (25,'Monte Cudine','','77310248',22),
 (26,'La Selva','','7730102008712',2),
 (27,'Monte Cudine','','7730177000338',12),
 (28,'Monte Cudine','','77304902',6),
 (29,'Colosal','','7790641000011',10),
 (30,'Bella Union','','7730106005113',36),
 (31,'Azucarlito','','7730251000056',38),
 (32,'Si diet','','7790036020204',42),
 (33,'Gourmet','','7730306001588',21),
 (34,'R Compuesta 1K','','7130950671470',64),
 (35,'R 1/2','','7730950671427',35),
 (36,'R Comun 1K','','7897230200118',59),
 (37,'Campero 1K','','7730905130993',44),
 (38,'Baldo 1k','','7730241003920',80),
 (39,'Baldo 1/2','','7730241003906',44),
 (40,'R Comun 1/2','','7897230200101',30),
 (41,'Canarias Serena 1/2','','7730241009038',48),
 (42,'Canarias Serena 1K','','7730241010294',71),
 (43,'Canarita Comun 1/2','','7730241003883',41),
 (44,'Canarita Comun 1K','','7730241003876',75),
 (45,'Canarita c/hierbas 1/2 K','','7730241003869',75),
 (46,'Canarias Comun 1/2','','7730241003661',45),
 (47,'Canarias Comun 1K','','7730241003654',87),
 (48,'El Remanso','','7730241003999',39),
 (49,'Adria rizzetos 500g','','7730103300532',35),
 (50,'Epidor  Epidor MoÃ±a Comun','','7730430002444',18),
 (51,'Santa Fe 1k','','7730905571093',31),
 (52,'La Mulata 1/2','','7730290003025',38),
 (53,'La Mulata 1K','','7730290003032',68),
 (54,'Livre Suave','','7730945980053',60),
 (56,'Livre Compuesta 1/2','','7730945980145',37),
 (57,'Livre Compuesta','','7730945980152',71),
 (58,'Livre Clasica 1/2','','7730945980046',25),
 (59,'Livre Clasica 1k','','7730945980039',60),
 (60,'Shiva','','7730114000025',18),
 (61,'Chef','','7730114400016',27),
 (62,'Blue Patna 1k','','7730114000117',30),
 (63,'Maggi Caracolitos','','7802950006636',23),
 (64,'Knorr de arvejas con jamon','','7730343328686',25),
 (65,'Knorr Crema de choclo','','7794000535114',25),
 (66,'Calsal comun','','7730952570018',16),
 (67,'Santafe 1K','','7730905570997',16),
 (68,'Presto Pronta 500g','','7790580660000',19),
 (69,'puritas','','7730354002322',20),
 (70,'Armiño 1/2','','7730205065179',43),
 (71,'Armiño Compuesta 1k','','7730205065162',79),
 (72,'Armiño Compuesta','','7730205037749',42),
 (73,'ArmiÃ±o Suave 1/2','','7730205072870',39),
 (74,'Armiño Clasica 1K','','7730205037756',71),
 (75,'ArmiÃ±o Suave 1K','','7730205072863',71),
 (76,'Silueta Ideal 1/2','','7730498001090',38),
 (77,'Silueta Ideal 1K','','7730498001076',74),
 (78,'Condesa 1L','','7730132000434',46),
 (79,'Optimo','','7730132001165',60),
 (80,'Del Gaucho 48g','','7796039001288',31),
 (81,'Puritas 200gr','','7730354001028',19),
 (82,'Quaker7792170007196','','7792170093120',32),
 (83,'Campero','','7730905130047',10),
 (84,'Cosecha Dorada 825g','','7730905130153',19),
 (85,'Cosecha Dorada','','7730905131297',17),
 (86,'Nidemar','','7730332001729',19),
 (87,'Cosecha Dorada 825g','','7730905130085',15),
 (88,'Ideal','','7730205082268',15),
 (89,'Isla del Tropico','','7730970274165',17),
 (90,'Maravi','','7730922910240',22),
 (91,'Qualita`s','','7730306000840',18),
 (92,'Dukita','','7730566000499',48),
 (93,'Golden Fis 200g','','7730905131242',31),
 (94,'Golden Fish 125g','','7730905131150',20),
 (95,'Golden Fish','','7730905131266',18),
 (96,'Changuito','','7790989003163',12),
 (97,'Uruguay 122g','','7730132000731',9),
 (98,'Uruguay 490g','','7730132000779',32),
 (99,'Dani Fiesta','','7791620001180',9),
 (100,'Hellmanns 125g','','7794000401228',16),
 (101,'Hellmanns 250g','','7794000401280',34),
 (102,'hellmanns Pak','','7730343325012',53),
 (103,'Hellmanns','','7794000957244',12),
 (104,'Verao Mix','','7622300145828',6),
 (105,'Verao Naranja','','7622300145750',6),
 (106,'Verao Durazno','','7622300145781',6),
 (107,'Ricard','','77309679',7),
 (108,'De vino','','7730252000055',24),
 (109,'De Manzana','','7130308372844',31),
 (110,'De Alcohol','','7730302302245',18),
 (111,'Theoto','','7891334150010',5),
 (112,'50g','','7622300302351',10),
 (113,'115g','','7622300434380',25),
 (114,'Tang Naranja Banana','','7622300327118',10),
 (115,'Tang Pomelo Rosado','','7790050987088',10),
 (116,'Tang Mandarina','','7790050987101',10),
 (117,'Tang Pera','','7622300327279',10),
 (118,'Tang Naranja','','7790050987057',10),
 (119,'Jazz Anana','','7730368000215',7),
 (120,'Jazz Naranja','','7730368000147',7),
 (122,'Papo Naranja','','77307620',3),
 (123,'Papo Mix','','77308092',3),
 (124,'En almibar Campero','','7730905130313',46),
 (125,'Ideal En rodajas','','7730205073952',52),
 (126,'En almibar Rio de la Plata','','7730205007179',52),
 (127,'Higienol Texturado X4','','7730219100477',25),
 (128,'Sussex X2','','7730219012022',24),
 (129,'Sussex Basico X3','','7730219012060',33),
 (130,'Poett Bebe','','7793253037413',45),
 (131,'Poett Bosque de Bambu','','7793253039257',45),
 (132,'Poett Espiritu Joven','','7793253039264',45),
 (133,'Poett Latidos de la Tierra','','7793253036478',45),
 (134,'Selton Mata moscas y mosquitos','','7793253238957',50),
 (135,'Selton mata cucarachas y hormigas','','7793253292553',70),
 (136,'Eco Suavex x4','','7730185000603',15),
 (137,'Suavex Classic x4','','7730185000580',21),
 (138,'Johnson Baby','','77504180',6.90000009536743),
 (139,'Scott x6','','7798038151841',50),
 (140,'Primor Verde','','7730205066831',12),
 (141,'Primor Blanco','','7730205066848',12),
 (142,'Primor Azul','','7730205066855',12),
 (143,'Nevex con toque de Vivere','','7791290784123',15),
 (144,'Nevex Fresh','','7791290677944',15),
 (145,'Io Hidratante','','7840118215155',15),
 (146,'Io Soy Joven','','7840118213762',6),
 (147,'Io Frescura','','7840118215131',15),
 (148,'Io Cremosidad','','7840118215148',15),
 (149,'Io Soy Refrescante','','7840118213755',6),
 (150,'Rinde dos Manzana','','7730908400567',10),
 (151,'Astral Deo12','','7891024176788',18),
 (152,'Astral Avena','','7891024176726',18),
 (153,'Io Soy radiante','','7840118213786',6),
 (154,'Bull Dog','','7791290677951',25),
 (155,'Sedal Sos Caspa 350ml','','7791293010663',79),
 (156,'Sedal Sos Crecimiento Fortificado 350ml','','7791293010403',79),
 (157,'Sedal Liso extremo 350ml','','7791293010465',79),
 (158,'Suave Miel y Almendras 930ml','','7130765383773',66),
 (159,'Suave Manzana Verde 930ml','','7730165322343',66),
 (160,'Suave Aloe Vera','','7730165322312',66),
 (161,'Suave Coco y Leche','','7730165323128',66),
 (162,'Plusbelle Anti Frizz','','7790740622428',65),
 (163,'Plusbelle Leche de Almendras','','7790740622268',65),
 (164,'Suave Palta y Oliva','','7791293973180',66),
 (165,'Suave Miel y Almendras','','7791293991313',17),
 (166,'Sedal Duo 2 en 1','','7702006917155',5),
 (167,'Sedal Liso Perfecto','','77901392',5),
 (168,'Sedal Reconstruccion Estructural','','77901507',5),
 (169,'Sedal Ceramidas','','77901248',5),
 (170,'Sedal Reconstruccion estructural','','77901491',5),
 (171,'Pluma Aromas de jardin','','7730377006307',28),
 (172,'Pluma Caricia de sol','','7730377006291',28),
 (173,'Pluma Frescura matinal','','7730377402062',28),
 (174,'Conejo','','7730377003122',22),
 (175,'Cif BaÃ±o 900ML','','7791290785397',37),
 (176,'Cif Vidrios 90ML','','7791290785359',37),
 (177,'Cif Power Cream 900 ml','','7791290782327',42),
 (178,'Drive 800gr lavado a mano','','7791290784437',52),
 (179,'Drive matic 800gr Bailando bajo la lluvia','','7791290783454',52),
 (181,'Postre Chocolate','','7791290783423',27),
 (182,'Drive matic 400gr Un dia en el Parque','','7791290783409',27),
 (184,'Skip 3kg PerfectResults','','7791290783102',262),
 (185,'Zorro matic 800gr Aloe Vera','','7790990184493',44),
 (186,'Nevex matic 400gr','','7791290204980',35),
 (187,'Ace matic 800gr Naturals','','7501065910134',40),
 (188,'Ace matic 400gr Aloe vera','','7501006734065',25),
 (189,'Drive matic 3kg + 400gr de regalo','','7730165326686',179),
 (190,'Nevex matic 3kg Poder del Sol','','7791290000254',212),
 (191,'Nevex matic 3kg Particulas de Extra Limpieza','','7791290205314',212),
 (192,'zorro azul 400g','','7730165325306',28),
 (193,'Nevex 750ml Aloe Vera','','7730165317486',28),
 (195,'Nevex 1.25L Poder de la Naturaleza','','7730165319190',38),
 (196,'Nevex 1.250L Limon','','7730165317424',38),
 (197,'Nevex 1.250L Clasico Frutas Citricas','','7730165318087',38),
 (198,'Nevex 1.250L Aloe Vera','','7730165317448',41),
 (199,'Nevex 1.250L Miel y Almendras','','7730165322558',39),
 (200,'Nevex 1.250L Colageno y Glicerina','','7730165318094',43),
 (201,'Regium 2Lt','','7730969920370',44),
 (202,'Dejavu Dulce de leche','','7805040312631',24),
 (203,'Regium 500ml Limon','','7730969920394',15),
 (207,'Regium 1','','7730969920363',22),
 (209,'Fabuloso 1Lt Lavanda','','7731024700227',39),
 (210,'Fabuloso 500ml Lavanda','','7731024700210',19),
 (211,'Prolimak 1Lt','','7730969920387',47),
 (212,'Sello Rojo 2Lt','','7130494002008',44),
 (213,'Sello Rojo 1Lt','','7730494001001',25),
 (214,'Vitara 1Lt','','730969920233',20),
 (215,'Vitara 2Lt','','7730969920172',37),
 (216,'Regium 2Lt','','7730969920349',24),
 (218,'Funsa TamaÃ±o 10','','7730356303571',50),
 (219,'Funsa TamaÃ±o 7','','7730356303519',50),
 (220,'Funsa TamaÃ±o 9y1/2','','7730356303564',50),
 (221,'Lucky 50x55cm','','18520000',20),
 (222,'Virulana Rollitos x 10unid.','','7794440101702',20),
 (223,'El Revoltijo Blanco','blanco 55x50cm','7730901283419',23),
 (224,'El Revoltijo Chico','','',10),
 (225,'Puritas 400gr','','7730354001042',32),
 (227,'Regium 2Lt','','',22),
 (229,'Drive 400gr lavado a mano','','7791290784413',27),
 (230,'Mortimer Lisita','','7793253038144',12),
 (231,'Mimosa X20','','7793620001474',21),
 (232,'Absorbex','','7130207028101',11),
 (233,'Mimosa 40','','7193620007467',34),
 (234,'Lips 20','','7791906612741',20),
 (235,'Siempre Libres','','7790010890632',24),
 (236,'Cisne','','7730207014519',8),
 (237,'Nube 40g','','7730207005043',14),
 (238,'Polyana','','7793100157004',35),
 (239,'Speed Stick 50g hombre','','7509546038339',76),
 (240,'Rexona en barra  50g hombre','','75024956',71),
 (241,'Rexona women Active emotion barra','','75029982',71),
 (242,'Rexona women Bamboo en barra','','78004498',71),
 (243,'Rexona women Crystal en barra','','75026646',71),
 (244,'Dove pro-age Dama','','75027520',71),
 (245,'Dove Original','','75027513',71),
 (246,'Dove Dermo Aclarant','','75034238',79),
 (248,'Rexona Tuning men','','78927414',39),
 (249,'Dove go fresh pepino','','7791293991283',89),
 (250,'Dove go fresh pomelo','','7191293997276',89),
 (251,'Dove Dermo Aclarant','','7191293998679',99),
 (252,'Dove Invisible Dry','','7791293008868',89),
 (253,'Dove Clear Tone','','7791293008110',89),
 (254,'Rexona women nutritive','','77912938488341',76),
 (255,'Rexona women hair minimising','','7791293004198',76),
 (256,'Rexona men V8','','7791293017396',76),
 (257,'Rexona Absolute','','7791293990651',76),
 (258,'Rexona men cobalt','','7791293990576',76),
 (259,'Rexona men Adventure','','7791293012056',76),
 (260,'Colgate Total 12','','7291024135080',59),
 (261,'Colgate 90gr','','7891024134702',28),
 (262,'Kolynos 90gr','','7793100120121',25),
 (263,'Colgate 50gr','','7891024132906',21),
 (264,'Action 90gr','','7890310110130',21),
 (265,'Clinch X 10','','7840824800003',20),
 (266,'Raid x 24 tabletas','','7790520155450',98),
 (267,'MAS Fuyi X 24 tabletas','','7730900780025',115),
 (268,'Clinch x 24 tabletas','','7798033980149',49),
 (269,'Bic caja x 60 unid.','','0070330800809',5),
 (270,'La Buena Estrella','','',72),
 (271,'madera x 12','','',15),
 (272,'10 unidades','','',19),
 (273,'Bic caja x 24 unidades','','0070330800847',12),
 (274,'Bic caja x 24 unidades','','0070330800823',10),
 (275,'Maxilum 100watts','','6986830780784',14),
 (277,'Barney x 12 unidades pequeño','','7794626995644',45),
 (278,'Barney x 36 unidades pequeño','','7736550084148',180),
 (279,'Barney x 36 unidades mediano','','7736550084155',180),
 (280,'Barney x 30 unidades grande','','7794626995798',150),
 (281,'Barney x 24 unidades extra grande','','7736550084193',120),
 (282,'Babysec x 48 unidades XG','','7730219051342',288),
 (283,'Portezuelo triple chocolate','','77302953',12),
 (284,'Portezuelo triple nieve88','','77302830',12),
 (285,'bon o bon blanco','','77930019',5),
 (286,'bon o bon negro','','77930002',5),
 (287,'Vitoria chocolate blanco','','7898209650644',8),
 (288,'Vitoria morango','','7898209650675',8),
 (289,'Vitoria limon','','7898209650651',8),
 (290,'Maria x 2 unidades','','7898209650330',25),
 (291,'Maria Rika x 3 unidades','','7730116101188',33),
 (292,'mellizas chocolate','','7730116361117',10),
 (293,'Rocklets 15gr','','7898142853706',7),
 (294,'Portezuelo Bocado Black','','77309273',5),
 (295,'Dukita Dce de leche','','7773401001428',10),
 (296,'Dukita chocolate','','7773401001442',10),
 (297,'Portezuelo vainilla','','7730236002433',15),
 (298,'Portezuelo frutilla','','7730236002440',15),
 (299,'Portezuelo chocolate','','7730236002426',15),
 (300,'Mana chocolate','','7790040439306',18),
 (301,'Vitoria limon','','7790040439207',18),
 (302,'Mana frutilla','','7790040439009',18),
 (303,'Mana limon','','7790040439108',18),
 (305,'Martini Bianco','','7730302010126',176),
 (306,'Martini Rosso','','7730302011123',176),
 (307,'Martini Bianco x 2','','7730302000110',349),
 (308,'Bulevar Blanco Americano','','7730940040523',115),
 (309,'1990 Rosado Merlot','','7730168002549',80),
 (310,'1990 Tinto Clasico Tannat','','7730168002143',78),
 (311,'1990 Rosado Moscatel','','7730168002341',78),
 (312,'1990 Tinto Cabernet Sauvignon','','7730168002648',80),
 (314,'Bella Union Rosado Dulce','','7730907180354',48),
 (315,'Bella Union Tinto','','7730907180200',48),
 (316,'Bella Union Rosado','','7730907180224',48),
 (317,'Generacion 2001 Tannat Tinto','','7730262000663',50),
 (318,'Generacion 2001 Cabernet Rosado','','7730262000670',50),
 (319,'Casco Viejo Tinto','','7730900851077',52),
 (320,'Casco Viejo Rosado','','7730900850872',52),
 (321,'Canelon Chico Rosado Moscatel Dulce','','7730900340137',53),
 (322,'Canelon Chico Rosado Moscatel','','7730900340083',53),
 (323,'Canelon Chico Tinto','','7730900340113',53),
 (324,'Vin Up','','7798034241829',30),
 (325,'Vat 69','','5000292262716',369),
 (326,'100 Pipers x 1lt','','080432402856',339),
 (327,'100 Pipers x 1lt + vaso','','0080432402856',349),
 (328,'Old Times x 1lt','','7730928901013',249),
 (329,'Dunbar x 1lt','','7730901310054',254),
 (330,'Añejo x 1lt','','7730106040015',215),
 (331,'5 Raices','','7130302107121',152),
 (332,'Espinillar x 1lt','','7730106030016',182),
 (333,'Victoria x 1lt','','7730302110123',165),
 (334,'Vesubio x 1lt','','7730210000035',140),
 (335,'Vesubio x 500ml','','7730210000462',85),
 (336,'Salerno x 1lt','','7730106000316',158),
 (337,'San Remo x 1lt','','7730106000330',159),
 (338,'San Remo x 1lt','','7730106020017',159),
 (339,'Vitoria dce de leche','','7898209650637',8),
 (340,'Vitoria chocolate','','7898209650668',8),
 (341,'Charly 300gr','','7730955840033',64),
 (342,'Lays 17gr','','7790310924112',7),
 (343,'Lays 30gr','','7790310981306',10),
 (344,'Mana x 3 vainilla','','7790040720800',33),
 (345,'Serranitas105gr','','7790040725003',12),
 (346,'Dukita al agua 85gr','','7773401002029',7),
 (347,'Pali Chip 30gr','','7790310001615',7),
 (348,'Cheetos 17gr','','7790310979976',5),
 (349,'Mira Mar','','',35),
 (350,'El Pepe','','',30),
 (351,'Mira Mar','','',28),
 (352,'Mira Mar','','',35),
 (353,'Bagley de salvado 214gr','','7790040317291',24),
 (354,'Hogareñas Mix de Cereales','','7790040566903',24),
 (355,'Serranitas x 3','','7790040725102',31),
 (356,'Portezuelo chocolate blanco','','7730236002907',7),
 (357,'Portezuelo chocolate','','77305749',7),
 (358,'Play chocolate','','7730303007422',7),
 (359,'Play nieve','','7730303000201',7),
 (360,'Leiva x 3 sanwich','','7790412001292',25),
 (361,'Diversion 400gr','','7790040711105',37),
 (362,'Comodoro 900cm3','','7793065000384',27),
 (363,'Avanti x2 rectangulares','','7730927020098',47),
 (364,'Avanti x 2 redondas','','7730927020166',49),
 (365,'Avanti x 12 unidades para empanadas','','7730927020111',45),
 (366,'Dulciora ciruela x 500gr','','7790580508401',34),
 (367,'Dulciora zapallo x 500gr','','7790580508500',34),
 (368,'Dulciora durazno x 500gr','','7790580508104',34),
 (369,'Dulciora higo x 500gr','','7790580508609',34),
 (370,'Dulciora damasco x 500gr','','7790580508203',34),
 (371,'Ricomax x 1kg','','',63),
 (372,'Biotop x 1lt durazno','','7730105032820',42),
 (373,'Biotop x 1lt frutilla','','7730105032844',42),
 (374,'Biotop x 1lt vainilla','','7730105032899',42),
 (375,'Frutado Conaprole frutillax 145gr','','7730105022173',20),
 (376,'Frutado Conaprole durazno 145gr','','7730105022166',20),
 (377,'Frutado Conaprole ensalada de frutas x 145gr','','7730105022180',20),
 (378,'Yoprole frutilla x 185g','','7730105002366',21),
 (379,'Yoprole durazno x 185g','','7730105002373',21),
 (380,'Conamigos Petit vainilla pack x 2','','7730105015496',22),
 (381,'Conaprole frutilla x 1lt','','7730105002557',32),
 (382,'Conaprole durazno x 1lt','','7730105002564',32),
 (383,'Lactolate x 1lt','','7730105014109',36),
 (384,'Colet 250ml','','7730105014055',20),
 (385,'Conaprole larga vida 250ml','','7730105011337',39),
 (386,'Plus Conaprole naranja 250ml','','7730105015892',20),
 (387,'Plus Conaprole durazno 250ml','','7730105015359',20),
 (388,'Requeson 250gr','','77309549',57),
 (389,'Conaprole 100gr c/sal','','77306494',26),
 (390,'Conaprole 100gr s/sal','','77306210',26),
 (391,'Conaprole 200gr c/sal','','77306456',49),
 (392,'Viva 0% con pulpa de durazno','','7730105026317',39),
 (393,'Viva 0% con pulpa de frutilla,kiwi y arandano','','7730105026300',39),
 (394,'Vital + Bio Transit Ciruela y Manzana','','7730105085116',47),
 (395,'Vital+Bio Transit Light frutilla','','7730105085123',47),
 (396,'Sprite 2lt','','7730197178970',45),
 (397,'Sanly  2lt sabor cola','','7730903090459',22),
 (398,'U 2lt mandarina','','7730905810109',35),
 (399,'U 2lt pomelo','','7730905810116',35),
 (400,'Fanta Pomelo 2lt','','7730197002909',45),
 (401,'Matutina 2lt','','7730922250070',19),
 (402,'Coca Cola 2,25lt','','7730197112967',55),
 (403,'Fanta Naranja 2lt','','7730197208950',45),
 (404,'Nix pomelo 2,5lt','','7730289001148',42),
 (405,'Nix cola 2,5lt','','7730289001124',42),
 (407,'Yasta Clasico 12 sobres 15gr','','7793640210672',10),
 (408,'Alikal + Analgesico','','7794640130724',14),
 (410,'Actron Rapida accion 10 capsulas','','7793640215479',5),
 (411,'Perifar Flex C/U','','7730900570657',7),
 (412,'Perifar Grip C/U','','7730900570879',7),
 (413,'Perifar Espasmo C/U','','7730900571289',9),
 (414,'Perifar Fem C/U','','7730900571333',6),
 (415,'Perifar 400 C/U','','7730900570237',4),
 (416,'Perifar Migra C/U','','7730900570886',8),
 (417,'Sinutab Plus granulado (sobre)','','',28),
 (418,'Zolben C Caliente(sobre)','','',20),
 (420,'ACF 4 (8comprimidos)','','7130381002485',7),
 (421,'Adhesur N*5','','7798066092031',34),
 (422,'Ready Plast','','',2),
 (423,'Prime Texturado','','7791519200069',30),
 (424,'Prime Espermicida','','7791519200076',30),
 (425,'Prime Extra Lubricado','','7791519000676',30),
 (426,'Prime Retardante Climax Control','','7791519702112',30),
 (427,'Prime Ultra Fino','','7791519701061',30),
 (428,'Rosetex Ultrafinos','','7730621002819',25),
 (429,'Kleenex','','0036000003178',8),
 (430,'Farma Medical','','',9),
 (431,'ORAL-B','','7800005081126',69),
 (432,'Saint Colet 8gr','','7730908360618',16),
 (433,'Bracafe Nescafe (caja x 250 unidades)','','7613032780661',1),
 (434,'Dr Cool','','6905147272668',12),
 (435,'Bic Comfort Twin','','0070330709485',16),
 (436,'Bic Comfort 3 (normal)','','',23),
 (437,'Bic Comfort 3 (sensible)','','0070330717565',23),
 (438,'Bic sensitive (amarilla)','','0070330703629',8),
 (439,'The Lion x 10 cajas de 40 unidades c/u','','7896007912285',13),
 (440,'Needles (pack)','','',12),
 (442,'Arisco Galinha Caipira','','7891700023023',5),
 (443,'knorr Verduras','','7794000594708',5),
 (444,'Maggi costilla','','7891000073933',5),
 (445,'masticables Misky 800gr','','7790580178109',0),
 (446,'Frutal Arcor 810gr','','7790580471309',0),
 (447,'Poosh tutti fruti','','77929075',1),
 (448,'Poosh menta','','77929082',1),
 (449,'Topline menta','','77916426',5),
 (450,'Topline strong','','77916396',5),
 (451,'Topline dagron fruit','','77969378',5),
 (452,'Topline mango + melon','','77927705',5),
 (453,'Topline mentol','','77916457',5),
 (454,'Topline ultra defense','','77916419',5),
 (455,'Freegells eucalipto','','7891151001458',5),
 (456,'Freegells frambuesa','','7891151026642',5),
 (458,'El Moncayo','','7730910600214',76),
 (459,'Uruguay 250g','','',12),
 (488,'Ladysoft','','7730219096404',12),
 (513,'Carne Vacuna','','',89),
 (514,'Lomo','','',185),
 (515,'Nalga','','',149),
 (516,'Chuleta','','',100),
 (517,'Aguja','','',95),
 (518,'Asado','','',110),
 (519,'Pulpa Jamon','','',142),
 (520,'Pulpa Cuadril','','',125),
 (521,'Pulpa Redonda','','',125),
 (524,'Ossobuco','','',65),
 (525,'Picada','','',120),
 (526,'Lengua','','',75),
 (527,'Matambre','','',75),
 (528,'Falda','','',75),
 (529,'Carne Ovina','','',89),
 (532,'Vacio','','',110),
 (533,'Higado','','',40),
 (535,'Tiernizada','','',165),
 (537,'Achura','','',35),
 (538,'Parrillada','','',35),
 (539,'Chorizo','','',130),
 (541,'Pollo','','',65),
 (544,'Tapichi','','',35),
 (545,'Dejavu Chocolate','','7798135760229',45),
 (546,'Dejavu Dulce de leche','','7798135760236',45),
 (547,'Dejavu Huevo','','7798135760243',45),
 (548,'Dejavu Menta','','7798135760267',45),
 (550,'Smile Bear','','7730621010852',12),
 (551,'Dove Acondicionador + Shampoo','','',159),
 (552,'Kit Color Rojo Oscuro','','7792321003435',46),
 (553,'Kit Color Rojo','','7792321003473',46),
 (554,'Kit Color Rojo Oscuro','','7792321003466',46),
 (555,'Kit Color Rubio Oscuro','','7792321003183',46),
 (556,'Uruguay 1k','','779808598320',27),
 (558,'Tucutucu 1k','','7793719600049',30),
 (559,'Vapor x5','','',24),
 (560,'Pastelera','','7730952570032',20),
 (561,'ace 400g aloe vera','','7501006734041',25),
 (562,'ace 800g aloe vera','','7501006734050',40),
 (563,'Papo Durazno','','77307637',3),
 (564,'Theoto x200','','7891334150027',14),
 (565,'Higienol x6','','7730219100484',14),
 (566,'Colgate Herbal','','7891024133668',28),
 (567,'Biotop Banatilla','','7730105032905',42),
 (568,'Biotop multifrutal','','7730105032868',42),
 (569,'Vital + pro defensis light multifruta','','7730105088421',45),
 (570,'Conamigos Pudding vainilla','','7730105026348',14),
 (571,'Conamigos Pudding dce d leche','','7730105026362',14),
 (572,'Conaprole dce leche','','7130105002180',20),
 (573,'Alpazul 230gr','','7730705784174',47),
 (574,'Conaprole entera','','7730105001413',34),
 (575,'Conaprole descremada','','7730105001376',34),
 (576,'Dunbar 200ml','','7730901310177',67),
 (577,'Mac Pay','','7730106000118',67),
 (578,'100 Pipers','','5000299202531',83),
 (579,'Grgsons 190ml','','773606047',67),
 (580,'Charamelo Tinto 2L','','7730924670180',149),
 (581,'Vinat','','7798034240013',50),
 (582,'Portesuelo Trip. Chocolate Blanco','','77300140',12),
 (583,'Bon o Bon Chocolate','','77930026',5),
 (584,'Manix 50g','','7790310923023',12),
 (585,'Dulses Sin Asucar','','7730116115116',32),
 (586,'La Tropa 1K7730109000115','','7730208016406',52),
 (587,'De Ley','','7730306001755',21),
 (589,'Suelta 250g','','',12),
 (590,'Adria 1/2K','','7730103301102',33),
 (591,'Adria Forati 1/2','','7730103300051',33),
 (592,'Epidor Corbata 400g','','7730430002413',15),
 (593,'heco 1/2','','',31),
 (594,'Hoyalina chocolate 77g','','7730110124060',12),
 (595,'Suelto 1K','','',45),
 (596,'Suelto 1/2','','',25),
 (597,'Blaco Suelto 250g','','',15),
 (598,'Negro 1/2','','',22),
 (599,'Suelta 200g','','',14),
 (600,'Suelto 50g','','',8),
 (601,'Quaker 1/2g','','7792170007196',13),
 (602,'Mantek 400g','','7730900170055',25),
 (603,'Comsa','','7730279011010',25),
 (604,'Knrr vejetales 3 color 88,5G','','7794000594234',25),
 (605,'Knorr arbeja jamon 67g','','7794000513112',25),
 (606,'Knorr crema de verdura 60g','','7794000519114',25),
 (607,'Knorr Vegetale + Fideo 88g','','7794000594210',25),
 (608,'Knorr pollo + Fideo 88g','','7794000594227',25),
 (609,'Calsal 1k','','7730952570056',18),
 (610,'Legítimo 900cm','','7796039001639',60),
 (611,'Okey 900mg','','7798085990820',27),
 (612,'Instantanea Fleischmann 10g','','77309129',10),
 (613,'Manzana 1/2g','','7730302312244',31),
 (614,'Rinde 2 Durasno','','7730908400',10),
 (615,'Rinde 2 Limon','','7730908401540',10),
 (616,'O`KI Naranja','','7801615771322',6),
 (617,'O´KI frutilla','','7801615771346',6),
 (618,'Golden Fish 290g','','7730905131143',48),
 (619,'Tomatino 140g','','7896387016139',12),
 (620,'Arcor Suabe 520g','','7790580650919',17),
 (621,'Del Gaucho 48g','','',6),
 (622,'Ideal 200g','','7073025083258',10),
 (624,'Hgienol x4 perfumado','','7730219010905',26),
 (625,'Plusbell altas Marinas 1l','','7790740622251',61),
 (626,'Plusbelle altas marina 1L','','7790740528669',65),
 (627,'Plusbelle Frutas Tropicales 1L','','7790740622282',65),
 (628,'Plusbelle Creme','','7790740622244',65),
 (629,'Plusbelle Guarana y moras 1L','','7790740528683',35),
 (630,'Sedal Sachets','','77901293',5),
 (631,'Sedal Saset Efecto liso','','77901484',5),
 (632,'Pantene Sachets','','7506195103272',5),
 (633,'Pantene Sachets','','7130494008008',5),
 (634,'Dove Pro Ag','','7898422750572',27),
 (635,'Dove Men + Care','','7891150006058',27),
 (636,'Lifeduy Crema','','7791293341767',18),
 (637,'Dove Reafirmante','','7898422746810',27),
 (638,'Dove Cremoso','','7898422746759',7),
 (639,'Plusbelle Relajante','','7790990125601',17),
 (640,'Plusbelle energisante','','7790990125502',17),
 (641,'Plusbelle hidratante','','7790990125106',17),
 (642,'Plusbelle Ceramidas','','7790990125205',17),
 (643,'Plusbelle Exfoliante','','7790990125304',17),
 (644,'Rexona Aloe vera','','7791293521558',15),
 (645,'Astral Cream','','7891024176719',17),
 (646,'Rexona Revitalizin','','7702191655733',15),
 (647,'Rexona Triple Protection TOTAL','','7791293521596',15),
 (648,'Astral Aloe','','7891024113653',17),
 (649,'Drive Oxifrescura 400g','','7791290783355',27),
 (650,'Drive Matic 400g','','7791290784420',27),
 (651,'Drive Un dia en El Parque 800g','','7791290783379',52),
 (652,'Drive Caminando Sobre Petalos 800g','','7791290784444',52),
 (653,'Pluma Viletas y Jasmin','','7730377003467',28),
 (654,'Dove FrizzTherapy','','7891150003286',159),
 (655,'SiempreLibre adapt c/alas','','7730198004605',16),
 (656,'Absorbex','','7730207022101',20),
 (657,'Dove Original','','7791293008141',79),
 (658,'Dove Hair Minimisng','','7791293004204',79),
 (660,'Dove Go Fres Naranja','','7791293991276',79),
 (662,'Rexona Men','','7791293990613',79),
 (663,'Rexona V12','','7791293011745',79),
 (665,'Rexona V8','','75024956',79),
 (666,'Speed stick','','7509546038339',79),
 (670,'Dove Original','','75027513',89),
 (671,'Colgate Total 12 90g','','7891024135020',59),
 (672,'Zorro Rosado 400G','','7790990184707',25),
 (673,'Zorro Rojo 400G','','7790990184684',25),
 (674,'zorro azul 400g','','7790990184691',25),
 (675,'Nevex Poder Del sol 400g','','7791290002333',35),
 (676,'Nevex Puresa de 400g','','7791290782631',35),
 (677,'Nevex Poder del sol 800g','','7791290000193',66),
 (678,'Nevex Clasic 800g','','6940350896042',66),
 (679,'Nevex Fresh 800g','','7791290001763',66),
 (680,'Nevex fresh 400g','','7191290007756',35),
 (681,'Nevex  Perfume de violet 400g','','7191290788631',66),
 (683,'Aroma 900ml Vainilla en flor','','',46),
 (686,'Nevex Colagena y Gliserina7','','',27),
 (687,'Mortimer cuadriculada','','7793253038106',16),
 (688,'Bic Mediana','','0070330800809',5),
 (689,'Ancap 1/2L','','7730106001924',59),
 (690,'Ancap 1L','','7730106001917',60),
 (691,'Bic Unidad','','0070330800847',10),
 (692,'Mundo Verde 1l','','',16),
 (693,'Mundo Verde 1L','','',19),
 (694,'next','','',49),
 (695,'Needles','','6940350882762',12),
 (696,'Saint','','7730908360205',1),
 (697,'Big','','0070330705302',8),
 (698,'Shain','','77310583',1),
 (699,'Conaprole 100gr s/sal','','0070330626515',25),
 (700,'Confort 3','','0070330717541',23),
 (701,'Knorr Verdura','','7794000594692',0),
 (703,'San Remo 1/2','','7730106000354',75),
 (704,'Vesubio Flor de Amargo 1L','','7730210000042',152),
 (705,'Portezuelo nieve','','7790310924112',7),
 (706,'Laigs 23g','','7790310001431',10),
 (707,'Suelt 100g','','',9),
 (708,'Suelto 250g','','',20),
 (709,'Maicitos chips 150g','','7790310921739',30),
 (710,'Charly 300g','','7730955840033',64),
 (712,'3D 70g','','7790310000922',35),
 (713,'3D 17g','','7790310921401',7),
 (714,'Saladix  30g','','7790580387006',6),
 (715,'Pino Luz Naranja 1L','','7730494143015',39),
 (716,'Cosinero 900g','','7790060234868',27),
 (717,'Jussara','','7896387000183',15),
 (718,'Ades Frutas Tropicales','','7794000730090',30),
 (719,'Ades Durasno 1l','','7794000730076',30),
 (720,'Pastamania 500g','','7730927020685',87),
 (721,'Conaprole Capuchino','','7730105014239',21),
 (722,'Conaprole Vital + Vio Transit 1l','','7730105086445',45),
 (723,'Ades Naranja 1L','','7794000730045',30),
 (724,'Ades Mansana 1L','','7794000730014',30),
 (725,'Batata 400g','','',26),
 (726,'Membrillo 400g','','',23),
 (727,'Batata + Chocolate 400g','','',27),
 (728,'Ades Frutas Tropicales 200g','','7794000730106',16),
 (729,'Avanti  12','','7730927020111',45),
 (730,'Limol Naranja 2L','','7730963950021',32),
 (731,'Limol Cola Blak','','7730963950045',32),
 (732,'Limol Pomelo 1L','','7730963950038',32),
 (733,'Coclacola 1/2','','7790895000782',20),
 (734,'Milanesa','','',145),
 (736,'Armiño compuesta x 1kg','','',79),
 (737,'Armiño comp. 1/2kg','','',43),
 (738,'mondongo','','',50),
 (744,'milanesas','','',120),
 (752,'osobuco','','',65),
 (754,'huevos','','',4),
 (755,'Qualita^s','','77303006000840',18),
 (756,'plasticos','','',19),
 (757,'Limpia mais','','',64),
 (758,'compañera merla','','',37),
 (759,'Primor angular','','',52),
 (760,'Praktica','','',59),
 (761,'Preferida','','',51),
 (762,'Mimosa c/alas 8+4','','',17),
 (763,'Kolynos','','7753442000390',13),
 (764,'Incava','','',19),
 (765,'Nevex 750ml poder de la naturaleza','','7730165319183',26),
 (766,'Campero 1/2kg','','7730905131006',25),
 (767,'Copa America','','',30),
 (768,'Ritter light','','',10),
 (769,'Haas blanco y menta x 45gr','','',17),
 (770,'Portezuelo nieve','','77303126',7),
 (771,'Hamlet','','',14),
 (772,'San Remo x 1/2 lt','','',75),
 (773,'Sanly  2L Limalimon','','7730903090466',23),
 (774,'Limol limalimon 2L','','7730963950014',30),
 (775,'Agua Nativa 2L','','7730130000153',22),
 (776,'Nix naranja 2,5lt','','7730289000523',47),
 (777,'Nix Limalimon 2,5 L','','7730289001131',47),
 (778,'Pilsen 1L','','77302502',49),
 (779,'La Carolina 1L','','7730983180156',32),
 (780,'Charamelo 1l','','7730924670029',26),
 (781,'Coca Cola 600 ml','','7730197301958',22),
 (782,'Flechman','','7730917690140',49),
 (783,'Cif 900ml','','7791290785335',54),
 (784,'Cif Anti Grasa 900ml','','7791290785311',49),
 (785,'Fabuloso 1L Frescura Amaneser','','7731024700241',38),
 (786,'Porta Retrato','','8427181100436',32),
 (787,'Porta Retrato','','6940350855308',49),
 (788,'Porta Retrato','','6933315516062',69),
 (789,'Perfume','','08571560240',69),
 (790,'Perfume','','080571560250',69),
 (791,'Perfume','','080571560940',69),
 (792,'Perfume','','77309665910658',210),
 (793,'Espejo de mano','','',32),
 (794,'Espejo de cartera','','7730744010494',19),
 (795,'Espejo grande','','6933315599218',59),
 (796,'Petaca Paquillaje','','69013286851522',69),
 (797,'Delineador','','',59),
 (798,'Florero','','6940350871162',49),
 (799,'Buranda + Guante Abrigo','','',129),
 (800,'Colet','','20070705111187',35),
 (801,'Vikini','','',32),
 (802,'Culote','','35',35),
 (803,'Boxer Niño','','',49),
 (804,'Bajitos','','',29),
 (805,'Nevex Ultra 300ml','','7791290000797',27),
 (806,'Vivere 900ml','','7791290783485',49),
 (807,'Vivere Perf. de Hierba 900ml','','7791290784406',49),
 (808,'Vivere Fres. Dia Dia 500ml','','7791290001398',49),
 (809,'Si','','',2),
 (810,'Malvoro','','',2),
 (811,'Coronado','','',5),
 (812,'Nevada','','',5),
 (813,'Hojillas','','',14),
 (814,'Chalas','','81',8),
 (815,'Kit Color Castaño','','7792327003169',46),
 (816,'Kit Color Castaño Claro Ceniza','','7792321003220',46),
 (817,'Kit Color Castaño Oscuro','','7792321003152',46),
 (818,'Kit Color Castaño Claro','','7792321003176',46),
 (819,'Kit Color Rojo Claro','','7792321003480',46),
 (820,'Kit Color Rojo Fuerte','','7792321003527',46),
 (822,'Kit Color Ciruela Roja','','7792321003541',46),
 (823,'Kit Color Rubia Ceniza Tornasol','','7792321003282',46),
 (824,'Kit Color Rojo','','7792321003473',46),
 (825,'Auguri 96h','','7730900221214',12),
 (826,'Matra 96h','','7730271404063',15),
 (827,'Auguri 36h','','77309000221153',0),
 (828,'Auguri 48H','','',0),
 (829,'Auguri 72h','','',0),
 (830,'Auguri 24h','','7730900221139',0),
 (831,'x8','','693698927344',10),
 (832,'x16','','6936298927357',15),
 (833,'Finas','','6931964300624',15),
 (834,'x12 Cortos','','77307440554313',0),
 (835,'x12 Largo','','7796822000870',0),
 (836,'Tojera Colores','','',7),
 (837,'Pinceles','','',4),
 (838,'Mochila Hombre Araña','','',59),
 (839,'Mini Punch','','',40),
 (840,'Lapicera Bic','','',9),
 (841,'Compas','','6221040062542',0),
 (843,'Ernex','','',6),
 (844,'Novemina Fuerte','','',3),
 (845,'Gasa Nevada','','77692220',6),
 (846,'Aspirina va3','','',3),
 (848,'Alical','','',13),
 (849,'Aspirina','','',2),
 (851,'Zolben C Pastila','','7730202000142',5),
 (852,'Aspirina C Caliente','','',14),
 (853,'Aspirineta','','',0),
 (854,'Sertal Compuesto','','',13),
 (855,'Omeprozol','','',0),
 (856,'Algi relax','','',0),
 (857,'Surtido 6 Sobres','','',0),
 (858,'Manzanilla','','',0),
 (859,'Bolbo','','',0),
 (860,'La Virquinia','','',0),
 (861,'Kit Color Platino','','7792321003275',46),
 (862,'Kit Color Amarillo melon','','7792321003510',46),
 (863,'Kit Color Ruebuio Claro','','7792321003206',46),
 (864,'Kit Color Rubuio Oscuro tabaco','','77922321003343',46),
 (865,'Caravanas de colores','','',0),
 (866,'Carabana Fantasia','','',0),
 (867,'Pinzitas Celestes','','',0),
 (868,'Colador de plastico','','',0),
 (869,'Cordones de colores','','',0),
 (870,'Mamaderas','','6936551729249',0),
 (871,'Azafran','','',0),
 (872,'Pimienta blanca','','',0),
 (873,'Comino','','',0),
 (874,'Pimienta Granulada','','',0),
 (875,'Bicarbonato','','',0),
 (876,'Anis','','',0),
 (877,'Condimento Verde','','',0),
 (878,'Gillete Prestobarba','','7501009222729',0),
 (879,'Mdia Tarde','','7790270336307',0),
 (880,'Mana Vainilla','','7790270336307',0),
 (881,'Maestro Cubano','','7730154000573',0),
 (882,'Duchen Maria','','7896034620740',0),
 (884,'Dukita Frutilla','','7773401001411',10),
 (885,'El Pepe','','',0),
 (886,'Famosa sin sal','','7730110311927',44),
 (887,'Cumping vainilla/chocolate','','7730110311927',0),
 (888,'Arcor Chocolate','','7896058252972',0),
 (889,'Arcor Frutilla','','7896058252989',0),
 (890,'Leiva x3','','7790412001292',0),
 (891,'Crocante x3','','7730154001662',27),
 (892,'Astral Propoleo','','7891024106167',18),
 (893,'Rexona Pure. Fresh.','','7791293990132',18),
 (894,'Rexona Energizing mint','','7791293551503',18),
 (895,'Rexona Sport Fan','','7791293013423',18),
 (896,'Suave aloe vera','','7791293991368',18),
 (897,'Suave Coco Leche','','7791293991337',18),
 (898,'Lux Pruelcame','','7791293990781',18),
 (899,'Lux Sienteme','','7791293990828',18),
 (900,'Lux Sorprendeme','','7791293990705',18),
 (901,'Lux Pak Pruebame','','7791293990795',23),
 (902,'Lux Pak Sienteme','','7791293990798',23),
 (903,'Rexona Pak Energizing Mint','','7791293521510',23),
 (904,'Axe Music Star','','7791299005972',73),
 (905,'Axe Ex-Friend','','7791293312750',73),
 (906,'Axe Play 2010','','7791293012902',73),
 (907,'Speed stick','','7509546002523',36),
 (908,'Dove Dermo Aclarant','','7791293938619',36),
 (909,'Dove Invisible','','75027537',36),
 (910,'Topline menta','','77916426',6),
 (911,'Beldent Menta','','77900166',10),
 (912,'Mentoplush Miel','','77922687',8),
 (913,'Mentoplush Menta','','77922694',8),
 (914,'Mentoplush strong','','77922670',8),
 (915,'Axesorio Broche NiÃ±o','','',27),
 (916,'Tulipan','','7791014090325',21),
 (918,'Saint Cafe','','7730908360014',1),
 (919,'Cafe Bracafe','','',1),
 (920,'Lays 23','','7790310001431',10),
 (921,'Rueditas','','7790310980224',5),
 (922,'Mate Con Pasa Mate','','',53),
 (923,'Mate Porcelana','','',60),
 (924,'Hondulines Negros Comunes','','',0),
 (925,'Ensendedor Golddragon','','',0),
 (926,'Cierres','','',0),
 (927,'Hilo Cocer Rasas','','',0),
 (928,'Sinta Haislante','','6933315522186',0),
 (929,'Globos','','',0),
 (930,'Peine Blanco','','',0),
 (931,'Peine De Colores','','',0),
 (932,'Gel Skin 120g','','',14),
 (933,'PaÃ±uelos Dama','','',12),
 (934,'Rallador','','',25),
 (935,'Parches','','',3),
 (936,'Parches2','','',4),
 (937,'Belas para torta cotillon','pakete','',0),
 (938,'Grajeas Color liso','','',0),
 (939,'Grajeas Perlas NÂ°1','','',0),
 (940,'Grajeas Perlas NÂ°2','','',0),
 (942,'Grajeas Perlas NÂ°3','','',0),
 (943,'Grajeas Perlas NÂ°4','','',0),
 (944,'Azucar Colorante','','',31),
 (945,'Perlas de Colores 125','','',0),
 (946,'Perlas de Chocolate','','',0),
 (947,'Cadenitas','','7791293010663',0),
 (948,'Besubio flor de amargo','','7730210000042',152),
 (949,'Suelta 250g','','',9),
 (950,'Damas (Por)','','',25),
 (951,'Medias NiÃ±as (Por)','','',25),
 (952,'Boxer','','',64),
 (953,'Guantes','','',15),
 (954,'Cortina BaÃ±o','','6933315527686',179),
 (955,'Cortina BaÃ±o','','6940350882472',49),
 (956,'Stirer','','',49),
 (957,'Sonajeros','','0200912260145',44),
 (958,'Flor Lampara','','',19),
 (959,'Reloj Pares','','6940350886142',69),
 (960,'Reloj Pared','','6940350853779',69),
 (961,'Pinsas (PQR)','','',19),
 (962,'Pinsa (Pqr)','','',18),
 (963,'Coleros (PQR)','','409040',15),
 (964,'Coleros C/MuÃ±ecos','','',12),
 (965,'Pinsas Ch (Pro)','','',19),
 (966,'Tikitaka','','',12),
 (967,'Tiquitaca Par','','',22),
 (968,'Tiquitaca Par','','',19),
 (969,'Coleros','','',10),
 (970,'Coleros','','',10),
 (971,'Pincitas','','',3),
 (972,'Bebote','','7730744004608',269),
 (973,'Organizador','','',70),
 (975,'Epidor Tirabuzon','','7730430002406',15),
 (976,'Epidor Rigatti','','7730430002437',15),
 (977,'Epidor Cerientani','','7730430002420',15),
 (978,'Petitosa','','7896041133011',10),
 (979,'Siglo de Oro','','779487000330',27),
 (980,'Soja','','480017524508',27),
 (981,'De Mais','','7790580108106',75),
 (982,'Los Ã±etitos durazno','','7730124010205',29),
 (983,'Los Nietitos Zapallo','','7730124011202',29),
 (984,'Los Nietitos Higo','','7730124012209',29),
 (985,'Parmalat','','',63),
 (986,'Hornex','','7730910430910',36),
 (987,'Hornex','','7730910430750',34),
 (988,'Goodet LimÃ³n','','7790580236212',44),
 (989,'Goodet Chocolate','','7790580626600',44),
 (990,'Goodet Marmolado','','7790580236519',44),
 (991,'Goodet Naranja','','7790580626709',44),
 (992,'Goodet Coco','','7790580626907',44),
 (993,'Oderich JamÃ³n','','7896041108064',15),
 (994,'Oderich Carne','','7896041108019',15),
 (995,'Oderich Palita','','7896041108097',15),
 (996,'Hornex 32g','','7730910430415',14),
 (997,'Royarina','','7730110143566',28),
 (998,'Norr Pomalora','','7794000783805',39),
 (999,'Poett Lavanda','','7793253039028',45),
 (1000,'Poett Primavera','','7793253039066',45),
 (1001,'Nevex 3kg vivere','','7793290783287',229),
 (1002,'Nevex 3Kg fresh','','7791290205321',229),
 (1003,'Bolsa Residual x30 Par. Edificio','','',62),
 (1004,'Bolsa Residual x30 (50X55)','','',49),
 (1005,'Bolsa Residual x30 Super G.','','',32),
 (1006,'Bolsa Residual x30 (50x55)','','',32),
 (1007,'Bolsa Residual x10 (50x55)','','',16),
 (1008,'Bolsa Residual x10 Par. Edificio','','',16),
 (1009,'Cotidian (Para Adulto)','','7806500772408',20),
 (1010,'Paño Piso Comun R','','',20),
 (1011,'Lampaso Comun','','7896230900295',55),
 (1012,'Lampaso','','',5),
 (1013,'Huggies','','7861023204430',5),
 (1014,'Algodon Nube 104g','','7730207005142',0),
 (1015,'Zig - Zag','','7730207004107',5),
 (1016,'Days','','7793620923615',20),
 (1017,'Carefreex X90','','7790010889001',40),
 (1018,'Carefree X20','','7790010888981',22),
 (1019,'Carefree Conper','','7790010888974',22),
 (1020,'Mimosa X40','','7793620001467',35),
 (1021,'Mimosa Fina','','7793620400048',18),
 (1022,'Days esencial','','7793620924028',19),
 (1024,'Days Teens','','7793620924001',25),
 (1025,'Lady Sort','','7790250096085',29),
 (1026,'250g','','7730106001931',38),
 (1027,'Azul 1L','','7730106002518',55),
 (1029,'Zas 250ml','','',36),
 (1030,'cocoa','','',10),
 (1032,'lenteja','','',10),
 (1033,'Sal Sek 500g','','77300614',0),
 (1034,'Santafe 5K','','7730905571000',0),
 (1035,'Colorifico 1K','','7896492700107',0),
 (1036,'Santafe 5K','','7730905571109',0),
 (1037,'Uruguy 500g','','7730132001172',0),
 (1038,'Dukita Limon','','7773401002074',0),
 (1039,'Soya 250g','','7891080404863',0),
 (1040,'Okeazitos 60g','','7897189729838',0),
 (1041,'51 Suave X 20','','7840624000139',0),
 (1042,'Ades Anana PiÃ±a 1L','','7794000730250',0),
 (1043,'Babysec XG X52','','7730219051441',0),
 (1044,'Babysec l X72','','7730219051328',0),
 (1045,'Babysec G X66','','7730219051434',0),
 (1046,'Richard Arandano','','7730476006611',0),
 (1047,'Suave Aloevera 930ml','','7791293999890',0),
 (1048,'Dejabu Cafe al chocolate 200cm3','','7798135761394',45),
 (1050,'Regium Limon y Aloevera 1L','','7730969920325',0),
 (1051,'Noche Buena 1l','','7730909450295',0),
 (1052,'Ayudin Ropa Blanca 1/2','','7793253091804',0),
 (1053,'S&A 1L','','',22),
 (1054,'Next Floral','','7792150124523',0),
 (1055,'Panten Liso Extremo','','7506195103333',0),
 (1056,'Panten Cotrol Caida','','',0),
 (1057,'Ayudin Colores Vivos','','7793253940102',0),
 (1058,'Zas 500ml','','',0),
 (1059,'Ayudin Ropa Blanca 1L','','7790132094109',0),
 (1060,'Drive Un Dia en el Par. 800G','','7791290783430',0),
 (1061,'Drive BaÃ±o Blancura 800g','','7791290783447',0),
 (1062,'Nevex fress','','7791290001756',0),
 (1063,'Babysec XXG X48','','7730219051359',0),
 (1064,'5 raices 1L','','7130308701187',0),
 (1065,'Helman 500g + Ketchup','','7730343001275',0),
 (1066,'Mggi Panseta','','7891000034767',0),
 (1067,'Uruguay alcohol','','7730132001202',0),
 (1068,'Blue Patna Sin Sal 150g','','7730114000049',0),
 (1069,'Blue Patman 150g','','7730114000032',0),
 (1070,'Hol Times + Baso','','7730928900191',0),
 (1071,'Lysoform 450cm3','','7790520986542',38),
 (1073,'fama 1l','','7130922370073',59),
 (1074,'nevex limon 750ml','','7730165317479',26),
 (1075,'nevex ultra frutas citricas 300ml','','7791290000780',29),
 (1076,'nevex ultra limon 300ml','','7791290000759',29),
 (1077,'nevex 800g','','',0),
 (1078,'skip 100g','','7191290007190',12),
 (1079,'drive poder del campo 400g','','7791290783362',25),
 (1080,'drive baño de blacura','','7791290783416',25),
 (1082,'Harina suelta 1k','','',13),
 (1083,'mas 900g','','7795848000017',30),
 (1084,'regla T','','',39),
 (1085,'tablero','','',85),
 (1086,'las acacias 500g','','7730430001157',0),
 (1087,'hellmanns light 125cm3','','7794000451391',18),
 (1088,'fanacoa 125cm3','','7794000482067',10),
 (1089,'savora 60g','','7794000957602',12),
 (1090,'hellmanns light 250cm3','','7794000451285',0),
 (1091,'hellmanns light 350cm3','','7794000451292',58),
 (1092,'hellmanns 400g','','7794000744264',58),
 (1093,'massa 500g','','',23),
 (1094,'tu massa 250g','','',0),
 (1095,'adria verimcelli 500g','','7730103300082',35),
 (1096,'fideo moñita','','7730103301072',35),
 (1097,'adria macarrones 500g','','7730103300242',0),
 (1098,'arroz suelto 2k','','',30),
 (1099,'fideo solo 1/2','','',18),
 (1100,'bao 400g','','7793100311079',33),
 (1101,'next','','7792150124516',9),
 (1102,'cepillo de ropa ncavas bicolor','','7896230900271',9),
 (1103,'cif ballerina','','7791290647176',27),
 (1104,'morimel x 10','','7793253040031',22),
 (1105,'aux sienteme x3','','7791293990835',0),
 (1106,'plusbelle refrescante 150','','7790990125007',19),
 (1107,'plusbelle cremoso 150g','','7790990125403',19),
 (1109,'Rexona Fresh intense','','7791293521503',0),
 (1110,'Rexona V8','','7791293554624',0),
 (1111,'Rexona Export Fan','','7791293013923',0),
 (1112,'Rexona Triple Protexion Sensitibe','','',0),
 (1113,'Primor Con Gli. X5','','7730205078575',0),
 (1114,'Praktica','','7730281001641',0),
 (1115,'el revoltijo amarillo','','',0),
 (1116,'elite x2','','7730219012039',0),
 (1117,'pack dove','','7891150000285',159),
 (1118,'pack dove lila','','7730165325535',159),
 (1119,'pack dove marron','','7891150002982',159),
 (1120,'pack dove azul','','7791293004976',159),
 (1121,'pantene res. prof.','','7501006721119',69),
 (1122,'pentene brillo extremo 200ml','','7501007457819',69),
 (1123,'pantene control caida 200ml','','7501001303501',0),
 (1124,'pantene frzz control','','7501001319885',69),
 (1125,'pantene color radiante','','7501001169121',69),
 (1126,'pantene control caida','','7501001303396',69),
 (1127,'sedal brillo gloss x3','','7730165329793',0),
 (1128,'sedal rojos vibr.','','7791293004389',0),
 (1129,'pantene brillo extremo','','7501007465555',0),
 (1130,'suave miel y almendras','','7791293973197',68),
 (1131,'suave coco y leche','','7791293973210',68),
 (1132,'suave coco leche','','7791293973227',68),
 (1133,'suave vainilla y canela','','7791293973234',68),
 (1134,'suave manzanilla','','7791293008394',68),
 (1135,'suave palta y oliva','','7791293973173',68),
 (1136,'sauve multivitamina e&b','','7791293008400',68),
 (1137,'bambis','','7730995830070',29),
 (1138,'colgateplax whitening c sarro','','7891024179659',89),
 (1139,'colgate 70g','','7790630001432',0),
 (1140,'days x20','','7793620924445',0),
 (1141,'absorvex x20','','7730207022576',17),
 (1142,'days escencial','','7793620924018',19),
 (1143,'mimosa clasica','','7793620400017',12),
 (1144,'mimosa con alas x8','','7793620400031',16),
 (1145,'mimosa con alas nocturna','','7793620000156',24),
 (1146,'cif crema 250ml','','7791290000469',33),
 (1147,'cif crema aroma a lima 500ml','','7791290000414',59),
 (1148,'cif cloro activado','','7791290008182',91),
 (1149,'cif proteccion activa','','7791290782334',91),
 (1150,'cif anti bacterial','','7791290001534',84),
 (1151,'cif limpieza diaraia','','7791290785298',0),
 (1152,'cif power cram','','7791290782341',41),
 (1153,'guante de latex funza','','7730356303557',0),
 (1154,'Maggi 19g','','7891000073742',6),
 (1155,'Maggi Costilla 19','','7891000022344',6),
 (1156,'Maggi Carne 19g','','7891000073711',6),
 (1157,'Maggi Panceta','','7891000034750',6),
 (1158,'Monte cudine 120ml','','7130717000376',38),
 (1159,'Hornex Dulse Deleche','','7730910430651',16),
 (1160,'Hornex Dulsedeleche','','7730910430644',16),
 (1161,'Hornex Caramelo','','7730910430118',16),
 (1162,'Hornex Chocolate','','7730910430668',16),
 (1163,'Royarina Caramelo','','7730110124015',16),
 (1164,'Royarina Bainilla','','7730110140534',16),
 (1165,'Hornex Bainilla','','7730910430156',16),
 (1166,'Nort 125g','','7794000592506',35),
 (1167,'Vida 100g','','7730205082688',15),
 (1168,'Monte Cudine 5g','','77304896',6),
 (1169,'Cabral Compuesta 1K','','7730498000499',85),
 (1170,'La Vuelta 500g','','7730197002688',29),
 (1171,'Cararita1/2K','','7730241003852',45),
 (1172,'R Compuesta 1k','','7730950671410',64),
 (1173,'Cosecha Dorada 825g','','7730905130375',52),
 (1174,'Perlas Mendosina 160g','','7793567016234',21),
 (1175,'Ricard light','','7730476006598',26),
 (1176,'Uruguay de Alcol 500ml','','7730132001226',16),
 (1177,'Cucharita 250g','','7730421155142',32),
 (1178,'Cucharita 500g','','7730421155159',58),
 (1179,'Sidiet 600ml','','7790036020235',75),
 (1180,'Delit x100','','7730219006212',12),
 (1181,'Philips 60','','7894400001148',12),
 (1182,'Hpilips 75','','7894400001155',14),
 (1183,'Philips 100w','','7894400001162',12),
 (1184,'La Granjera 980g','','7730970274660',49),
 (1185,'Gurmet Consentrada 250g','','7730306000185',12),
 (1186,'Gurmet Consentrada 1030g','','7730306000017',39),
 (1187,'knorr zapallo','','7794000533110',27),
 (1188,'knorr sopa de cebolla','','7794000595279',27),
 (1189,'knorr sopa cholclo','','7794000594845',27),
 (1190,'salsa knorr 3 min. p/pastas','','7794000783140',0),
 (1191,'magg crema champiñones','','7802950062250',26),
 (1192,'sopa maggi pollo con fideos','','7802950006612',27),
 (1193,'sopa maggi costilla y fideo','','7613030612247',27),
 (1194,'sopa maggi esparragos','','7802950006735',27),
 (1195,'salsa knorr arrabiata','','7794000783300',39),
 (1196,'salas knorr scarparo','','7794000783102',39),
 (1197,'pate oderich 100g','','7896041108040',0),
 (1198,'pate oderich peru','','7896041108057',0),
 (1199,'pate oderich pollo','','7296041708071',14),
 (1200,'Tropical 200g mas cocoa','','7730907870248',99),
 (1201,'ordrich arveja y choclo','','7896041160109',26),
 (1202,'ordrich choclo','','7896041156010',15),
 (1203,'oderich legumbres','','7896041160017',0),
 (1204,'pequeña granja 170g','','7730465001672',0),
 (1205,'el emigrante 400g','','7730267000309',0),
 (1206,'rio 400g','','7730205076489',39),
 (1207,'cosecha dorada 400g','','7730905130238',0),
 (1208,'Adria Dedales 500g','','7730103305353',35),
 (1209,'Adria Tirabuzones 500g','','7730103300488',35),
 (1210,'Adria Tipolino','','7730103301140',35),
 (1211,'Pak Suelto 150g','','',15),
 (1212,'Lider 125','','7730205076021',15),
 (1213,'Alex 1K','','7797190000738',32),
 (1214,'Hornex Naranja 50g','','7730910430224',15),
 (1215,'Hornex Frutilla 100g','','7730910439425',26),
 (1216,'Hornex Vainilla 100g','','7730910439432',26),
 (1217,'Hornex Chocolate 100g','','7730910439449',26),
 (1218,'Hrnex Dulce de leche','','7730910439456',26),
 (1219,'La Vuelta 1K','','7730197002671',63),
 (1220,'La Granjera 330g','','7730970279504',17),
 (1221,'Jussara 300g','','7896387010243',15),
 (1222,'Oberch Frango','','7896041108071',30),
 (1223,'Golden Fish Desmenusado','','7730905131259',30),
 (1224,'Pltzer 60g','','7730385000014',9),
 (1225,'Tang Limon 25g','','7622300631215',6),
 (1226,'Tang Manzana 25g','','7622300631161',9),
 (1227,'Rinde 2 Anana Piña','','7730908401588',5),
 (1228,'Royal 20g','','7730110120635',25),
 (1229,'Hellmanns 250g','','7794000744295',35),
 (1230,'O\'KY Pera 20g','','7801615771391',5),
 (1231,'Hellmann\'s 500 cm3','','7794000401389',50),
 (1232,'Nidefrut 820g','','7730332000173',60),
 (1233,'Higienol Texturisado Pak X8','','7730219000500',48),
 (1234,'Lysoform Lavanda 257g','','7790520000446',70),
 (1235,'Pusdell Cremoso 150g','','7790990586099',20),
 (1236,'Astral Propolio 125','','',20),
 (1237,'Plusbelle Energisante','','7790990586105',20),
 (1238,'Astral Anis 125g','','7891024176825',20),
 (1239,'Io Soy Sensual!','','7840118213748',20),
 (1240,'Plusbelle Ceramidas 150g','','7790990586075',20),
 (1241,'Drive Suav. Perfumado','','7191290003680',60),
 (1242,'Drive Frescura del Mar 800g','','7791290003705',50),
 (1243,'Apsordex x 19','','7130807082107',20),
 (1244,'Mortimer X 1','','7793253386160',3),
 (1245,'Rexona Calming 175Ml','','',81),
 (1246,'Rexona Active Emotion 175ml','','7791293004310',81),
 (1247,'Rexona Sin Perfume','','7791293011769',81),
 (1248,'Dove beauty finish 100g','','7791293014012',92),
 (1249,'Dove Go Fre Durasno','','7191293347712',92),
 (1250,'Rexona Nutritive 175','','7791293848341',81),
 (1251,'Rexona Men Superherue','','7791293005270',81),
 (1252,'Dove Organics','','7791293005348',81),
 (1253,'Selby Natura 250g','','',60),
 (1254,'Sedal Liso Extremo 300 ml','','7891150006539',92),
 (1255,'Sedal Clima Resist','','7891150007963',92),
 (1256,'Kit Color','','7792321003138',92),
 (1257,'Kit Color Negro Intenso','','7792321003145',0),
 (1258,'Kit Color Tornasol','','7792321003299',92),
 (1259,'Rexona Bambu','','7791293884592',92),
 (1260,'Primor Supermatic 800g','','7730205064363',50),
 (1261,'Nevex Multiaccion 400g','','7791290002937',50),
 (1262,'Rexona Men Invisible 105g','','7791293568942',60),
 (1263,'Chicco','','5000000356072',2),
 (1264,'Nevex Par. Exstra Lim. 400g','','7791290003453',45),
 (1265,'Zorro Bio Cristales 400g','','7790990184714',50),
 (1266,'Nevex 3k + Vivere','','7730165333332',100),
 (1267,'Nevex Fresh 400g','','7791290003330',50),
 (1268,'Rexona Crystal 179g','','7791293991054',90),
 (1269,'Rexona Men Turbo','','7791293990637',90),
 (1270,'Rexona Extra Fresh 175g','','7791293009155',90),
 (1271,'Plusbelle Algas Marinas','q','7790740528768',50),
 (1272,'Plusbelle Bambu y Aloe 1000 ml','','7790740528706',63),
 (1273,'Elvive Color-Vive','','7899026409729',78),
 (1274,'Pantene Fucion Naturaleza 200ml','','7506195126516',65),
 (1275,'Pantene Liso y sedoso 200ml','','7501001169046',65),
 (1276,'Pantene Liso y Sedoso 200ml','','7501001169039',65),
 (1277,'Elvive Hydra - curl 200ml','','7899026422018',78),
 (1278,'Pantene Fucion Naturaleza 200ml','','7506195126301',65),
 (1279,'Elvive Citrus 200ml','','7899026421998',78),
 (1280,'Elvive Nutri - Gloss','','7899026422032',78),
 (1281,'Kolynos Super Blanco 90g','','7891528020020',20),
 (1282,'SiempreLibre Epecial 16','','7790010890649',40),
 (1283,'Rexona 60g','','77923424',49),
 (1284,'O\'ky Piña 20g','','7801615771339',6),
 (1285,'Kit Color Miel 2732','','7792321003329',60),
 (1286,'Dove +Care','','78927254',20),
 (1287,'Rexona Cobalt 50ml','','78923393',20),
 (1288,'Rexona Sensitive 50 ml','','78923423',20),
 (1289,'BIC Confor3','','0070330717534',60),
 (1290,'Pezeto','','',141),
 (1291,'Mondongo','','',45),
 (1293,'Puchero','','',55),
 (1294,'The Lion x1','','',2),
 (1295,'Parney X1 Mediano','','',6),
 (1296,'Fabuloso 1L Navidad','','7731024700326',39),
 (1297,'Fabuloso Mar Fresco 1L','','7731024700302',39),
 (1298,'Pino luz Original','','',20),
 (1299,'Fabuloso Fresca Menta 1L','','7731024700272',39),
 (1300,'Fabuloso Paraiso Tropical 1l','','7731024700012',39),
 (1301,'Fabuloso Pacion Frutas 1L','','7731024700111',39),
 (1302,'Glasgou 1L','','7798135760205',99),
 (1303,'Pioneer 1L','','7790163013018',50),
 (1304,'Whitehorse 1L Caja','','5000265090056',449),
 (1305,'5 Raices 1L','','7730302101121',152),
 (1306,'De Los 33 500ml','','7730106000026',50),
 (1307,'Gregson\'s 190ml','','77366047',67),
 (1308,'Balles Peñas Rosado 1L','','7798038430298',30),
 (1309,'Calvinor Tinto 500 ml','','0799223510006',108),
 (1310,'Portesuelo 130g Chocolate','','7730236003218',14),
 (1311,'Portesuelo 130g Frutilla','','7730236003232',12),
 (1312,'Portesuelo 130g Bainilla','','7730236003249',14),
 (1313,'Portesuelo 130g Dulse Leche','','7730236003225',14),
 (1314,'Mundo Verde 1l','','',20),
 (1315,'Mundo Verde 1L','','',20),
 (1316,'Rinde2 24g multifruta','','7730908400536',10),
 (1317,'tang 25g  mandarina','','7622300656416',10),
 (1318,'tang 25g naranja','','7622300615840',10),
 (1319,'tang 25g anana','','7622300656508',10),
 (1320,'rinde 2 24g naranja','','7730908400529',10),
 (1321,'rinde 2 30g','','7730908401526',10),
 (1322,'rinde2 24g naranja banana','','7730908400987',10),
 (1323,'rinde2 24g durazno','','7730908400543',10),
 (1324,'juguito 18g naranja','','7730354001950',5),
 (1325,'portezuelo chocolate','','77305749',7);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;



INSERT INTO ElPam.`productocom` (`ProCom_CodIn`,`Cat_Num`,`ProCom_Stok`,`ProCom_StokMin`,`ProCom_PreCom`,`ProCom_TipStok`,`IVA_Num`) VALUES 
 (1,1,0,1,0,0,1),
 (2,1,5,1,0,0,1),
 (3,1,5,1,0,0,1),
 (4,1,6,1,0,0,1),
 (5,1,8,1,0,0,1),
 (7,2,3,1,0,0,1),
 (9,2,2,1,0,0,1),
 (10,2,1,1,0,0,1),
 (11,2,0,0,0,0,1),
 (12,2,0,1,0,0,1),
 (13,2,1,1,0,0,1),
 (14,3,0,0,0,0,1),
 (15,4,0,0,0,0,1),
 (16,4,0,0,0,0,1),
 (17,4,0,0,0,0,1),
 (18,5,0,0,0,0,1),
 (19,5,0,0,0,0,1),
 (20,5,0,0,0,0,1),
 (21,5,0,0,0,0,1),
 (22,6,0,0,0,0,1),
 (23,6,0,0,0,0,1),
 (24,7,0,1,0,0,1),
 (25,8,0,0,0,0,1),
 (26,9,2,0,0,0,1),
 (27,10,2,0,0,0,1),
 (28,11,0,0,0,0,1),
 (29,12,12,0,0,0,1),
 (30,13,0,0,0,0,1),
 (31,13,0,0,0,0,1),
 (32,14,0,0,0,0,1),
 (33,15,0,0,0,0,1),
 (34,1,0,0,0,0,1),
 (35,1,6,0,0,0,1),
 (36,1,4,0,0,0,1),
 (37,1,6,0,0,0,1),
 (38,1,8,0,0,0,1),
 (39,1,5,0,0,0,1),
 (40,1,6,0,0,0,1),
 (41,1,4,0,0,0,1),
 (42,1,4,0,0,0,1),
 (43,1,1,0,0,0,1),
 (44,1,5,0,0,0,1),
 (45,1,24,0,0,0,1),
 (46,1,2,0,0,0,1),
 (47,1,6,0,0,0,1),
 (48,1,0,0,0,0,1),
 (49,16,3,0,0,0,1),
 (50,16,0,0,0,0,1),
 (51,16,18,0,0,0,1),
 (52,1,9,0,0,0,1),
 (53,1,7,0,0,0,1),
 (54,1,4,0,0,0,1),
 (56,1,8,0,0,0,1),
 (57,1,0,0,0,0,1),
 (58,1,6,0,0,0,1),
 (59,1,2,0,0,0,1),
 (60,17,1,0,0,0,1),
 (61,17,0,0,0,0,1),
 (62,17,1,0,0,0,1),
 (63,18,0,0,0,0,1),
 (64,18,0,0,0,0,1),
 (65,18,2,0,0,0,1),
 (66,19,11,0,0,0,1),
 (67,20,0,0,0,0,1),
 (68,20,5,0,0,0,1),
 (69,20,4,0,0,0,1),
 (70,1,3,0,0,0,1),
 (71,1,3,0,0,0,1),
 (72,1,0,0,0,0,1),
 (73,1,3,0,0,0,1),
 (74,1,7,0,0,0,1),
 (75,1,5,0,0,0,1),
 (76,1,4,0,0,0,1),
 (77,1,9,0,0,0,1),
 (78,21,0,0,0,0,1),
 (79,21,0,0,0,0,1),
 (80,21,0,0,0,0,1),
 (81,22,18,0,0,0,1),
 (82,22,0,0,0,0,1),
 (83,23,12,0,0,0,1),
 (84,24,25,0,0,0,1),
 (85,25,9,0,0,0,1),
 (86,24,2,0,0,0,1),
 (87,27,7,0,0,0,1),
 (88,27,0,0,0,0,1),
 (89,28,0,0,0,0,1),
 (90,28,0,0,0,0,1),
 (91,28,17,0,0,0,1),
 (92,29,7,0,0,0,1),
 (93,29,82,0,0,0,1),
 (94,29,9,0,0,0,1),
 (95,30,0,0,0,0,1),
 (96,31,24,0,0,0,1),
 (97,32,9,0,0,0,1),
 (98,32,5,0,0,0,1),
 (99,32,1,0,0,0,1),
 (100,32,23,0,0,0,1),
 (101,32,0,0,0,0,1),
 (102,32,0,0,0,0,1),
 (103,33,0,0,0,0,1),
 (104,34,0,0,0,0,1),
 (105,34,0,0,0,0,1),
 (106,34,0,0,0,0,1),
 (107,34,0,0,0,0,1),
 (108,35,0,0,0,0,1),
 (109,35,0,0,0,0,1),
 (110,35,3,0,0,0,1),
 (111,36,15,0,0,0,1),
 (112,37,0,0,0,0,1),
 (113,37,11,0,0,0,1),
 (114,34,0,0,0,0,1),
 (115,34,0,0,0,0,1),
 (116,34,0,0,0,0,1),
 (117,34,31,0,0,0,1),
 (118,34,0,0,0,0,1),
 (119,34,36,0,0,0,1),
 (120,34,0,0,0,0,1),
 (122,34,0,0,0,0,1),
 (123,34,22,0,0,0,1),
 (124,38,5,0,0,0,1),
 (125,39,5,0,0,0,1),
 (126,39,10,0,0,0,1),
 (127,40,2,0,0,0,1),
 (128,41,8,0,0,0,1),
 (129,41,1,0,0,0,1),
 (130,42,2,0,0,0,1),
 (131,42,2,0,0,0,1),
 (132,42,1,0,0,0,1),
 (133,42,5,0,0,0,1),
 (134,144,0,0,0,0,1),
 (135,144,0,0,0,0,1),
 (136,40,12,0,0,0,1),
 (137,40,6,0,0,0,1),
 (138,43,50,0,0,0,1),
 (139,40,0,0,0,0,1),
 (140,44,23,0,0,0,1),
 (141,44,7,0,0,0,1),
 (142,44,24,0,0,0,1),
 (143,44,26,0,0,0,1),
 (144,44,38,0,0,0,1),
 (145,44,1,0,0,0,1),
 (146,44,0,0,0,0,1),
 (147,44,2,0,0,0,1),
 (148,44,6,0,0,0,1),
 (149,44,2,0,0,0,1),
 (150,34,11,0,0,0,1),
 (151,157,0,0,0,0,1),
 (152,34,1,0,0,0,1),
 (153,44,2,0,0,0,1),
 (154,44,26,0,0,0,1),
 (155,45,0,0,0,0,1),
 (156,45,0,0,0,0,1),
 (157,45,0,0,0,0,1),
 (158,45,0,0,0,0,1),
 (159,45,0,0,0,0,1),
 (160,43,0,0,0,0,1),
 (161,43,0,0,0,0,1),
 (162,43,0,0,0,0,1),
 (163,43,0,0,0,0,1),
 (164,45,0,0,0,0,1),
 (165,157,0,0,0,0,1),
 (166,46,0,0,0,0,1),
 (167,43,27,0,0,0,1),
 (168,43,0,0,0,0,1),
 (169,43,24,0,0,0,1),
 (170,45,37,0,0,0,1),
 (171,47,2,0,0,0,1),
 (172,47,0,0,0,0,1),
 (173,47,1,0,0,0,1),
 (174,47,4,0,0,0,1),
 (175,48,0,0,0,0,1),
 (176,48,0,0,0,0,1),
 (177,48,0,0,0,0,1),
 (178,49,5,0,0,0,1),
 (179,49,1,0,0,0,1),
 (181,49,10,0,0,0,1),
 (182,49,0,0,0,0,1),
 (184,49,0,0,0,0,1),
 (185,49,0,0,0,0,1),
 (186,49,0,0,0,0,1),
 (187,49,0,0,0,0,1),
 (188,49,0,0,0,0,1),
 (189,49,0,0,0,0,1),
 (190,49,0,0,0,0,1),
 (191,49,1,0,0,0,1),
 (192,50,0,0,0,0,1),
 (193,50,0,0,0,0,1),
 (195,50,0,0,0,0,1),
 (196,50,0,0,0,0,1),
 (197,50,0,0,0,0,1),
 (198,50,0,0,0,0,1),
 (199,50,0,0,0,0,1),
 (200,50,0,0,0,0,1),
 (201,50,2,0,0,0,1),
 (202,50,1,0,0,0,1),
 (203,50,0,0,0,0,1),
 (207,48,7,0,0,0,1),
 (209,48,0,0,0,0,1),
 (210,48,2,0,0,0,1),
 (211,51,1,0,0,0,1),
 (212,52,0,0,0,0,1),
 (213,52,0,0,0,0,1),
 (214,52,0,0,0,0,1),
 (215,52,0,0,0,0,1),
 (216,47,4,0,0,0,1),
 (218,53,0,0,0,0,1),
 (219,53,0,0,0,0,1),
 (220,53,0,0,0,0,1),
 (221,54,0,0,0,0,1),
 (222,55,0,0,0,0,1),
 (223,56,12,0,0,0,1),
 (224,56,0,0,0,0,1),
 (225,22,13,0,0,0,1),
 (227,48,0,0,0,0,1),
 (229,49,0,0,0,0,1),
 (230,57,0,0,0,0,1),
 (231,159,0,0,0,0,1),
 (232,58,0,0,0,0,1),
 (233,58,0,0,0,0,1),
 (234,58,0,0,0,0,1),
 (235,59,23,0,0,0,1),
 (236,59,0,0,0,0,1),
 (237,60,0,0,0,0,1),
 (238,61,0,0,0,0,1),
 (239,62,0,0,0,0,1),
 (240,62,0,0,0,0,1),
 (241,62,0,0,0,0,1),
 (242,62,2,0,0,0,1),
 (243,62,2,0,0,0,1),
 (244,62,0,0,0,0,1),
 (245,63,0,0,0,0,1),
 (246,63,0,0,0,0,1),
 (248,64,0,0,0,0,1),
 (249,65,2,0,0,0,1),
 (250,65,0,0,0,0,1),
 (251,65,0,0,0,0,1),
 (252,65,0,0,0,0,1),
 (253,65,0,0,0,0,1),
 (254,65,0,0,0,0,1),
 (255,65,4,0,0,0,1),
 (256,65,0,0,0,0,1),
 (257,65,1,0,0,0,1),
 (258,65,1,0,0,0,1),
 (259,65,1,0,0,0,1),
 (260,66,0,0,0,0,1),
 (261,66,2,0,0,0,1),
 (262,66,1,0,0,0,1),
 (263,66,0,0,0,0,1),
 (264,66,0,0,0,0,1),
 (265,67,6,0,0,0,1),
 (266,68,0,0,0,0,1),
 (267,68,2,0,0,0,1),
 (268,68,7,0,0,0,1),
 (269,69,0,0,0,0,1),
 (270,70,0,0,0,0,1),
 (271,71,3,0,0,0,1),
 (272,72,29,0,0,0,1),
 (273,73,0,0,0,0,1),
 (274,74,2,0,0,0,1),
 (275,75,0,0,0,0,1),
 (277,77,0,0,0,0,1),
 (278,77,6,0,0,0,1),
 (279,77,0,0,0,0,1),
 (280,77,0,0,0,0,1),
 (281,77,0,0,0,0,1),
 (282,77,0,0,0,0,1),
 (283,78,0,0,0,0,1),
 (284,78,0,0,0,0,1),
 (285,79,0,0,0,0,1),
 (286,79,0,0,0,0,1),
 (287,80,3,0,0,0,1),
 (288,80,10,0,0,0,1),
 (289,80,0,0,0,0,1),
 (290,81,0,0,0,0,1),
 (291,81,0,0,0,0,1),
 (292,80,0,0,0,0,1),
 (293,82,0,0,0,0,1),
 (294,78,0,0,0,0,1),
 (295,83,6,0,0,0,1),
 (296,83,8,0,0,0,1),
 (297,83,4,0,0,0,1),
 (298,83,2,0,0,0,1),
 (299,83,4,0,0,0,1),
 (300,80,0,0,0,0,1),
 (301,80,0,0,0,0,1),
 (302,80,0,0,0,0,1),
 (303,80,0,0,0,0,1),
 (305,84,2,0,0,0,1),
 (306,84,2,0,0,0,1),
 (307,84,3,0,0,0,1),
 (308,84,2,0,0,0,1),
 (309,85,17,0,0,0,1),
 (310,85,0,0,0,0,1),
 (311,85,5,0,0,0,1),
 (312,85,0,0,0,0,1),
 (314,86,19,0,0,0,1),
 (315,86,8,0,0,0,1),
 (316,86,8,0,0,0,1),
 (317,86,0,0,0,0,1),
 (318,86,1,0,0,0,1),
 (319,86,0,0,0,0,1),
 (320,86,6,0,0,0,1),
 (321,86,1,0,0,0,1),
 (322,86,12,0,0,0,1),
 (323,86,11,0,0,0,1),
 (324,86,0,0,0,0,1),
 (325,87,6,0,0,0,1),
 (326,87,3,0,0,0,1),
 (327,87,5,0,0,0,1),
 (328,87,0,0,0,0,1),
 (329,87,0,0,0,0,1),
 (330,87,2,0,0,0,1),
 (331,88,0,0,0,0,1),
 (332,89,6,0,0,0,1),
 (333,90,0,0,0,0,1),
 (334,90,4,0,0,0,1),
 (335,90,6,0,0,0,1),
 (336,90,0,0,0,0,1),
 (337,90,15,0,0,0,1),
 (338,91,3,0,0,0,1),
 (339,80,0,0,0,0,1),
 (340,80,2,0,0,0,1),
 (341,92,0,0,0,0,1),
 (342,92,0,0,0,0,1),
 (343,92,0,0,0,0,1),
 (344,80,0,0,0,0,1),
 (345,81,0,0,0,0,1),
 (346,81,0,0,0,0,1),
 (347,69,0,0,0,0,1),
 (348,94,0,0,0,0,1),
 (349,95,0,0,0,0,1),
 (350,96,0,0,0,0,1),
 (351,97,0,0,0,0,1),
 (352,98,0,0,0,0,1),
 (353,81,0,0,0,0,1),
 (354,81,0,0,0,0,1),
 (355,81,0,0,0,0,1),
 (356,78,4,0,0,0,1),
 (357,78,5,0,0,0,1),
 (358,78,0,0,0,0,1),
 (359,78,0,0,0,0,1),
 (360,81,0,0,0,0,1),
 (361,81,0,0,0,0,1),
 (362,21,25,0,0,0,1),
 (363,99,0,0,0,0,1),
 (364,99,0,0,0,0,1),
 (365,99,0,0,0,0,1),
 (366,100,0,0,0,0,1),
 (367,100,0,0,0,0,1),
 (368,100,0,0,0,0,1),
 (369,100,0,0,0,0,1),
 (370,100,0,0,0,0,1),
 (371,101,0,0,0,0,1),
 (372,102,0,0,0,0,1),
 (373,102,0,0,0,0,1),
 (374,102,0,0,0,0,1),
 (375,102,0,0,0,0,1),
 (376,102,0,0,0,0,1),
 (377,102,0,0,0,0,1),
 (378,102,0,0,0,0,1),
 (379,102,0,0,0,0,1),
 (380,103,0,0,0,0,1),
 (381,104,0,0,0,0,1),
 (382,104,0,0,0,0,1),
 (383,105,0,0,0,0,1),
 (384,105,0,0,0,0,1),
 (385,106,0,0,0,0,1),
 (386,34,0,0,0,0,1),
 (387,34,0,0,0,0,1),
 (388,107,0,0,0,0,1),
 (389,108,0,0,0,0,1),
 (390,108,0,0,0,0,1),
 (391,108,0,0,0,0,1),
 (392,102,0,0,0,0,1),
 (393,102,0,0,0,0,1),
 (394,102,0,0,0,0,1),
 (395,102,0,0,0,0,1),
 (396,109,8,0,0,0,1),
 (397,109,0,0,0,0,1),
 (398,109,0,0,0,0,1),
 (399,109,0,0,0,0,1),
 (400,109,15,0,0,0,1),
 (401,110,0,0,0,0,1),
 (402,109,44,0,0,0,1),
 (403,109,14,0,0,0,1),
 (404,109,9,0,0,0,1),
 (405,109,9,0,0,0,1),
 (407,111,0,0,0,0,1),
 (408,111,0,0,0,0,1),
 (410,111,0,0,0,0,1),
 (411,111,0,0,0,0,1),
 (412,111,0,0,0,0,1),
 (413,111,0,0,0,0,1),
 (414,111,0,0,0,0,1),
 (415,111,0,0,0,0,1),
 (416,111,0,0,0,0,1),
 (417,111,0,0,0,0,1),
 (418,111,0,0,0,0,1),
 (420,111,0,0,0,0,1),
 (421,113,0,0,0,0,1),
 (422,114,0,0,0,0,1),
 (423,115,0,0,0,0,1),
 (424,115,0,0,0,0,1),
 (425,115,0,0,0,0,1),
 (426,115,0,0,0,0,1),
 (427,115,0,0,0,0,1),
 (428,115,0,0,0,0,1),
 (429,116,0,0,0,0,1),
 (430,117,0,0,0,0,1),
 (431,118,0,0,0,0,1),
 (432,119,0,0,0,0,1),
 (433,120,0,0,0,0,1),
 (434,121,0,0,0,0,1),
 (435,122,0,0,0,0,1),
 (436,122,0,0,0,0,1),
 (437,122,0,0,0,0,1),
 (438,122,0,0,0,0,1),
 (439,123,8,0,0,0,1),
 (440,124,0,0,0,0,1),
 (442,126,0,0,0,0,1),
 (443,126,0,0,0,0,1),
 (444,126,0,0,0,0,1),
 (445,127,0,0,0,0,1),
 (446,127,0,0,0,0,1),
 (447,128,0,0,0,0,1),
 (448,128,0,0,0,0,1),
 (449,128,0,0,0,0,1),
 (450,128,0,0,0,0,1),
 (451,128,0,0,0,0,1),
 (452,128,0,0,0,0,1),
 (453,128,0,0,0,0,1),
 (454,128,0,0,0,0,1),
 (455,129,0,0,0,0,1),
 (456,129,0,0,0,0,1),
 (458,1,5,0,0,0,1),
 (459,1,10,0,0,0,1),
 (488,58,0,0,0,0,1),
 (513,138,150,0,0,1,1),
 (529,138,50,0,0,1,1),
 (539,138,0,0,0,1,1),
 (541,138,0,0,0,1,1),
 (545,139,2,0,0,0,1),
 (546,139,1,0,0,0,1),
 (547,139,2,0,0,0,1),
 (548,139,0,0,0,0,1),
 (550,141,0,0,0,0,1),
 (551,142,0,0,0,0,1),
 (552,203,0,0,0,0,1),
 (553,203,0,0,0,0,1),
 (554,203,5,0,0,0,1),
 (555,203,7,0,0,0,1),
 (556,21,0,0,0,0,1),
 (558,13,0,0,0,0,1),
 (559,140,0,0,0,0,1),
 (560,145,8,0,0,0,1),
 (561,49,0,0,0,0,1),
 (562,49,0,0,0,0,1),
 (563,34,26,0,0,0,1),
 (564,36,2,0,0,0,1),
 (565,40,0,0,0,0,1),
 (566,66,0,0,0,0,1),
 (567,102,0,0,0,0,1),
 (568,102,0,0,0,0,1),
 (569,102,0,0,0,0,1),
 (570,103,0,0,0,0,1),
 (571,103,0,0,0,0,1),
 (572,146,0,0,0,0,1),
 (573,107,0,0,0,0,1),
 (574,147,0,0,0,0,1),
 (575,147,0,0,0,0,1),
 (576,87,1,0,0,0,1),
 (577,87,0,0,0,0,1),
 (578,87,1,0,0,0,1),
 (579,87,0,0,0,0,1),
 (580,85,0,0,0,0,1),
 (581,85,0,0,0,0,1),
 (582,85,0,0,0,0,1),
 (583,79,0,0,0,0,1),
 (584,148,0,0,0,0,1),
 (585,81,0,0,0,0,1),
 (586,1,3,0,0,0,1),
 (587,15,0,0,0,0,1),
 (589,150,0,0,0,0,1),
 (590,16,4,0,0,0,1),
 (591,16,0,0,0,0,1),
 (592,16,0,0,0,0,1),
 (593,16,8,0,0,0,1),
 (594,103,0,0,0,0,1),
 (595,151,0,0,0,0,1),
 (596,151,0,0,0,0,1),
 (597,24,0,0,0,0,1),
 (598,24,0,0,0,0,1),
 (599,3,0,0,0,0,1),
 (600,152,0,0,0,0,1),
 (601,20,0,0,0,0,1),
 (602,153,9,0,0,0,1),
 (603,153,0,0,0,0,1),
 (604,18,0,0,0,0,1),
 (605,18,10,0,0,0,1),
 (606,18,0,0,0,0,1),
 (607,18,0,0,0,0,1),
 (608,18,0,0,0,0,1),
 (609,17,1,0,0,0,1),
 (610,21,0,0,0,0,1),
 (611,21,0,0,0,0,1),
 (612,154,1,0,0,0,1),
 (613,35,0,0,0,0,1),
 (614,34,0,0,0,0,1),
 (615,34,0,0,0,0,1),
 (616,34,0,0,0,0,1),
 (617,34,0,0,0,0,1),
 (618,29,0,0,0,0,1),
 (619,155,0,0,0,0,1),
 (620,28,0,0,0,0,1),
 (621,156,6,0,0,0,1),
 (622,23,0,0,0,0,1),
 (624,40,4,0,0,0,1),
 (625,43,0,0,0,0,1),
 (626,45,0,0,0,0,1),
 (627,43,0,0,0,0,1),
 (628,43,0,0,0,0,1),
 (629,43,1,0,0,0,1),
 (630,45,0,0,0,0,1),
 (631,45,0,0,0,0,1),
 (632,43,0,0,0,0,1),
 (633,45,0,0,0,0,1),
 (634,157,0,0,0,0,1),
 (635,157,0,0,0,0,1),
 (636,157,0,0,0,0,1),
 (637,157,0,0,0,0,1),
 (638,157,0,0,0,0,1),
 (639,157,0,0,0,0,1),
 (640,157,0,0,0,0,1),
 (641,157,0,0,0,0,1),
 (642,157,0,0,0,0,1),
 (643,157,4,0,0,0,1),
 (644,157,0,0,0,0,1),
 (645,157,0,0,0,0,1),
 (646,157,0,0,0,0,1),
 (647,157,0,0,0,0,1),
 (648,157,0,0,0,0,1),
 (649,49,7,0,0,0,1),
 (650,49,0,0,0,0,1),
 (651,49,6,0,0,0,1),
 (652,49,5,0,0,0,1),
 (653,49,0,0,0,0,1),
 (654,46,0,0,0,0,1),
 (655,158,0,0,0,0,1),
 (656,159,0,0,0,0,1),
 (657,62,0,0,0,0,1),
 (658,65,1,0,0,0,1),
 (660,65,1,0,0,0,1),
 (662,65,2,0,0,0,1),
 (663,65,1,0,0,0,1),
 (665,63,0,0,0,0,1),
 (666,63,0,0,0,0,1),
 (670,63,0,0,0,0,1),
 (671,66,0,0,0,0,1),
 (672,49,0,0,0,0,1),
 (673,49,9,0,0,0,1),
 (674,49,4,0,0,0,1),
 (675,49,0,0,0,0,1),
 (676,49,0,0,0,0,1),
 (677,49,0,0,0,0,1),
 (678,49,0,0,0,0,1),
 (679,49,0,0,0,0,1),
 (680,49,0,0,0,0,1),
 (681,49,0,0,0,0,1),
 (683,44,3,0,0,0,1),
 (686,50,0,0,0,0,1),
 (687,57,2,0,0,0,1),
 (688,69,0,0,0,0,1),
 (689,162,1,0,0,0,1),
 (690,162,4,0,0,0,1),
 (691,73,2,0,0,0,1),
 (692,47,5,0,0,0,1),
 (693,52,0,0,0,0,1),
 (694,163,0,0,0,0,1),
 (695,164,0,0,0,0,1),
 (696,7,0,0,0,0,1),
 (697,165,0,0,0,0,1),
 (698,120,0,0,0,0,1),
 (699,166,0,0,0,0,1),
 (700,165,0,0,0,0,1),
 (701,126,0,0,0,0,1),
 (703,89,0,0,0,0,1),
 (704,88,0,0,0,0,1),
 (705,92,0,0,0,0,1),
 (706,92,0,0,0,0,1),
 (707,167,0,0,0,0,1),
 (708,167,0,0,0,0,1),
 (709,168,0,0,0,0,1),
 (710,92,0,0,0,0,1),
 (712,169,0,0,0,0,1),
 (713,169,0,0,0,0,1),
 (714,81,0,0,0,0,1),
 (715,170,5,0,0,0,1),
 (716,21,0,0,0,0,1),
 (717,27,0,0,0,0,1),
 (718,34,0,0,0,0,1),
 (719,34,0,0,0,0,1),
 (720,171,0,0,0,0,1),
 (721,172,0,0,0,0,1),
 (722,102,0,0,0,0,1),
 (723,34,0,0,0,0,1),
 (724,34,0,0,0,0,1),
 (725,173,0,0,0,0,1),
 (726,173,0,0,0,0,1),
 (727,173,0,0,0,0,1),
 (728,34,0,0,0,0,1),
 (729,174,0,0,0,0,1),
 (730,109,0,0,0,0,1),
 (731,109,8,0,0,0,1),
 (732,109,2,0,0,0,1),
 (733,109,0,0,0,0,1),
 (734,134,0,0,0,0,1),
 (736,1,0,0,0,0,1),
 (737,1,0,1,0,0,1),
 (738,176,0,0,0,1,1),
 (744,175,0,0,0,1,1),
 (752,138,0,0,0,1,1),
 (754,177,0,0,0,0,1),
 (755,28,0,0,0,0,1),
 (756,306,0,0,0,0,1),
 (757,178,0,0,0,0,1),
 (758,178,0,0,0,0,1),
 (759,178,0,0,0,0,1),
 (760,178,0,0,0,0,1),
 (761,178,0,0,0,0,1),
 (762,179,0,0,0,0,1),
 (763,121,8,0,0,0,1),
 (764,180,0,0,0,0,1),
 (765,50,0,0,0,0,1),
 (766,1,5,0,0,0,1),
 (767,181,0,0,0,0,1),
 (768,182,0,0,0,0,1),
 (769,183,0,0,0,0,1),
 (770,78,0,0,0,0,1),
 (771,183,0,0,0,0,1),
 (772,90,0,0,0,0,1),
 (773,109,0,0,0,0,1),
 (774,109,0,0,0,0,1),
 (775,110,0,0,0,0,1),
 (776,109,16,0,0,0,1),
 (777,109,2,0,0,0,1),
 (778,185,0,0,0,0,1),
 (779,186,0,0,0,0,1),
 (780,186,0,0,0,0,1),
 (781,109,0,0,0,0,1),
 (782,154,0,0,0,0,1),
 (783,48,0,0,0,0,1),
 (784,291,0,0,0,0,1),
 (785,48,2,0,0,0,1),
 (786,187,0,0,0,0,1),
 (787,187,0,0,0,0,1),
 (788,187,0,0,0,0,1),
 (789,188,0,0,0,0,1),
 (790,188,0,0,0,0,1),
 (791,188,0,0,0,0,1),
 (792,188,0,0,0,0,1),
 (793,189,0,0,0,0,1),
 (794,190,0,0,0,0,1),
 (795,191,0,0,0,0,1),
 (796,192,0,0,0,0,1),
 (797,193,0,0,0,0,1),
 (798,194,0,0,0,0,1),
 (799,195,0,0,0,0,1),
 (800,105,0,0,0,0,1),
 (801,196,0,0,0,0,1),
 (802,196,0,0,0,0,1),
 (803,197,0,0,0,0,1),
 (804,198,0,0,0,0,1),
 (805,50,0,0,0,0,1),
 (806,47,0,0,0,0,1),
 (807,47,0,0,0,0,1),
 (808,47,0,0,0,0,1),
 (809,200,0,0,0,0,1),
 (810,200,0,0,0,0,1),
 (811,200,0,0,0,0,1),
 (812,200,0,0,0,0,1),
 (813,201,0,0,0,0,1),
 (814,202,0,0,0,0,1),
 (815,203,0,0,0,0,1),
 (816,203,0,0,0,0,1),
 (817,203,0,0,0,0,1),
 (818,203,1,0,0,0,1),
 (819,203,0,0,0,0,1),
 (820,203,0,0,0,0,1),
 (822,203,0,0,0,0,1),
 (823,203,0,0,0,0,1),
 (824,203,0,0,0,0,1),
 (825,204,0,0,0,0,1),
 (826,204,0,0,0,0,1),
 (827,204,0,0,0,0,1),
 (828,204,0,0,0,0,1),
 (829,204,0,0,0,0,1),
 (830,204,0,0,0,0,1),
 (831,205,0,0,0,0,1),
 (832,205,0,0,0,0,1),
 (833,206,0,0,0,0,1),
 (834,207,0,0,0,0,1),
 (835,207,0,0,0,0,1),
 (836,208,0,0,0,0,1),
 (837,209,0,0,0,0,1),
 (838,210,0,0,0,0,1),
 (839,211,0,0,0,0,1),
 (840,212,0,0,0,0,1),
 (841,213,0,0,0,0,1),
 (843,111,0,0,0,0,1),
 (844,111,0,0,0,0,1),
 (845,111,0,0,0,0,1),
 (846,111,0,0,0,0,1),
 (848,111,0,0,0,0,1),
 (849,111,0,0,0,0,1),
 (851,111,0,0,0,0,1),
 (852,111,0,0,0,0,1),
 (853,111,0,0,0,0,1),
 (854,111,0,0,0,0,1),
 (855,111,0,0,0,0,1),
 (856,111,0,0,0,0,1),
 (857,7,0,0,0,0,1),
 (858,7,0,0,0,0,1),
 (859,7,0,0,0,0,1),
 (860,7,0,0,0,0,1),
 (861,203,0,0,0,0,1),
 (862,203,0,0,0,0,1),
 (863,203,5,0,0,0,1),
 (864,203,0,0,0,0,1),
 (865,214,0,0,0,0,1),
 (866,214,0,0,0,0,1),
 (867,215,0,0,0,0,1),
 (868,216,0,0,0,0,1),
 (869,217,0,0,0,0,1),
 (870,218,0,0,0,0,1),
 (871,219,0,0,0,0,1),
 (872,220,0,0,0,0,1),
 (873,221,0,0,0,0,1),
 (874,222,0,0,0,0,1),
 (875,223,0,0,0,0,1),
 (876,11,0,0,0,0,1),
 (877,225,0,0,0,0,1),
 (878,165,0,0,0,0,1),
 (879,81,0,0,0,0,1),
 (880,81,0,0,0,0,1),
 (881,81,0,0,0,0,1),
 (882,81,0,0,0,0,1),
 (884,83,0,0,0,0,1),
 (885,95,0,0,0,0,1),
 (886,95,0,0,0,0,1),
 (887,81,0,0,0,0,1),
 (888,80,0,0,0,0,1),
 (889,80,0,0,0,0,1),
 (890,81,0,0,0,0,1),
 (891,81,0,0,0,0,1),
 (892,157,4,0,0,0,1),
 (893,157,0,0,0,0,1),
 (894,157,0,0,0,0,1),
 (895,157,0,0,0,0,1),
 (896,157,0,0,0,0,1),
 (897,157,0,0,0,0,1),
 (898,157,0,0,0,0,1),
 (899,157,0,0,0,0,1),
 (900,157,0,0,0,0,1),
 (901,157,0,0,0,0,1),
 (902,157,0,0,0,0,1),
 (903,157,0,0,0,0,1),
 (904,65,0,0,0,0,1),
 (905,65,0,0,0,0,1),
 (906,65,0,0,0,0,1),
 (907,65,0,0,0,0,1),
 (908,65,0,0,0,0,1),
 (909,65,0,0,0,0,1),
 (910,128,0,0,0,0,1),
 (911,128,0,0,0,0,1),
 (912,128,0,0,0,0,1),
 (913,128,0,0,0,0,1),
 (914,128,0,0,0,0,1),
 (915,227,0,0,0,0,1),
 (916,115,0,0,0,0,1),
 (918,2,0,0,0,0,1),
 (919,2,0,0,0,0,1),
 (920,92,0,0,0,0,1),
 (921,228,0,0,0,0,1),
 (922,229,0,0,0,0,1),
 (923,229,0,0,0,0,1),
 (924,230,0,0,0,0,1),
 (925,166,0,0,0,0,1),
 (926,231,0,0,0,0,1),
 (927,232,0,0,0,0,1),
 (928,233,0,0,0,0,1),
 (929,234,0,0,0,0,1),
 (930,235,0,0,0,0,1),
 (931,235,0,0,0,0,1),
 (932,236,0,0,0,0,1),
 (933,237,0,0,0,0,1),
 (934,238,0,0,0,0,1),
 (935,239,0,0,0,0,1),
 (936,239,0,0,0,0,1),
 (937,240,0,0,0,0,1),
 (938,241,0,0,0,0,1),
 (939,241,0,0,0,0,1),
 (940,241,0,0,0,0,1),
 (942,241,0,0,0,0,1),
 (943,241,0,0,0,0,1),
 (944,13,0,0,0,0,1),
 (945,242,0,0,0,0,1),
 (946,242,0,0,0,0,1),
 (947,243,0,0,0,0,1),
 (948,139,0,0,0,0,1),
 (949,149,0,0,0,0,1),
 (950,244,0,0,0,0,1),
 (951,244,0,0,0,0,1),
 (952,245,0,0,0,0,1),
 (953,246,0,0,0,0,1),
 (954,247,0,0,0,0,1),
 (955,247,0,0,0,0,1),
 (956,248,0,0,0,0,1),
 (957,249,0,0,0,0,1),
 (958,75,0,0,0,0,1),
 (959,250,0,0,0,0,1),
 (960,250,0,0,0,0,1),
 (961,251,0,0,0,0,1),
 (962,251,0,0,0,0,1),
 (963,252,0,0,0,0,1),
 (964,252,0,0,0,0,1),
 (965,251,0,0,0,0,1),
 (966,253,0,0,0,0,1),
 (967,253,0,0,0,0,1),
 (968,253,0,0,0,0,1),
 (969,252,0,0,0,0,1),
 (970,252,0,0,0,0,1),
 (971,254,0,0,0,0,1),
 (972,255,0,0,0,0,1),
 (973,256,0,0,0,0,1),
 (975,16,0,0,0,0,1),
 (976,16,0,0,0,0,1),
 (977,16,0,0,0,0,1),
 (978,23,0,0,0,0,1),
 (979,21,0,0,0,0,1),
 (980,21,0,0,0,0,1),
 (981,21,0,0,0,0,1),
 (982,100,0,0,0,0,1),
 (983,100,0,0,0,0,1),
 (984,100,0,0,0,0,1),
 (985,101,0,0,0,0,1),
 (986,257,0,0,0,0,1),
 (987,258,0,0,0,0,1),
 (988,259,0,0,0,0,1),
 (989,259,0,0,0,0,1),
 (990,259,0,0,0,0,1),
 (991,259,0,0,0,0,1),
 (992,259,0,0,0,0,1),
 (993,260,0,0,0,0,1),
 (994,260,0,0,0,0,1),
 (995,260,0,0,0,0,1),
 (996,261,0,0,0,0,1),
 (997,261,0,0,0,0,1),
 (998,262,0,0,0,0,1),
 (999,42,0,0,0,0,1),
 (1000,42,0,0,0,0,1),
 (1001,49,0,0,0,0,1),
 (1002,49,0,0,0,0,1),
 (1003,263,0,0,0,0,1),
 (1004,263,0,0,0,0,1),
 (1005,263,0,0,0,0,1),
 (1006,263,0,0,0,0,1),
 (1007,263,0,0,0,0,1),
 (1008,263,0,0,0,0,1),
 (1009,264,0,0,0,0,1),
 (1010,56,0,0,0,0,1),
 (1011,266,0,0,0,0,1),
 (1012,266,0,0,0,0,1),
 (1013,267,0,0,0,0,1),
 (1014,268,0,0,0,0,1),
 (1015,268,0,0,0,0,1),
 (1016,58,0,0,0,0,1),
 (1017,58,0,0,0,0,1),
 (1018,58,0,0,0,0,1),
 (1019,58,0,0,0,0,1),
 (1020,58,1,0,0,0,1),
 (1021,158,0,0,0,0,1),
 (1022,158,0,0,0,0,1),
 (1023,158,0,0,0,0,1),
 (1024,158,32,0,0,0,1),
 (1025,158,17,0,0,0,1),
 (1026,162,0,0,0,0,1),
 (1027,162,0,0,0,0,1),
 (1029,144,6,0,0,0,1),
 (1030,3,0,0,0,1,1),
 (1032,150,0,0,0,1,1),
 (1033,269,0,0,0,0,1),
 (1034,20,0,0,0,0,1),
 (1035,270,0,0,0,0,1),
 (1036,16,0,0,0,0,1),
 (1037,153,0,0,0,0,1),
 (1038,83,0,0,0,0,1),
 (1039,271,0,0,0,0,1),
 (1040,272,0,0,0,0,1),
 (1041,200,0,0,0,0,1),
 (1042,34,0,0,0,0,1),
 (1043,264,0,0,0,0,1),
 (1044,264,0,0,0,0,1),
 (1045,264,0,0,0,0,1),
 (1046,5,0,0,0,0,1),
 (1047,45,0,0,0,0,1),
 (1048,139,0,0,0,0,1),
 (1050,50,2,0,0,0,1),
 (1051,273,0,0,0,0,1),
 (1052,52,0,0,0,0,1),
 (1053,48,7,0,0,0,1),
 (1054,274,0,0,0,0,1),
 (1055,45,0,0,0,0,1),
 (1056,275,0,0,0,0,1),
 (1057,276,0,0,0,0,1),
 (1058,144,0,0,0,0,1),
 (1059,52,0,0,0,0,1),
 (1060,49,0,0,0,0,1),
 (1061,49,0,0,0,0,1),
 (1062,49,0,0,0,0,1),
 (1063,49,0,0,0,0,1),
 (1064,88,0,0,0,0,1),
 (1065,32,0,0,0,0,1),
 (1066,126,0,0,0,0,1),
 (1067,35,0,0,0,0,1),
 (1068,277,0,0,0,0,1),
 (1069,277,0,0,0,0,1),
 (1070,87,0,0,0,0,1),
 (1071,48,0,0,0,0,1),
 (1073,163,0,0,0,0,1),
 (1074,50,10,0,0,0,1),
 (1075,50,0,0,0,0,1),
 (1076,50,0,0,0,0,1),
 (1077,49,0,0,0,0,1),
 (1078,49,0,0,0,0,1),
 (1079,49,0,0,0,0,1),
 (1080,49,0,0,0,0,1),
 (1082,19,0,0,0,0,1),
 (1083,13,0,0,0,0,1),
 (1084,279,0,0,0,0,1),
 (1085,280,0,0,0,0,1),
 (1086,281,0,0,0,0,1),
 (1087,32,0,0,0,0,1),
 (1088,32,0,0,0,0,1),
 (1089,156,0,0,0,0,1),
 (1090,32,0,0,0,0,1),
 (1091,32,0,0,0,0,1),
 (1092,33,0,0,0,0,1),
 (1093,281,0,0,0,0,1),
 (1094,281,0,0,0,0,1),
 (1095,281,0,0,0,0,1),
 (1096,281,2,0,0,0,1),
 (1097,281,2,0,0,0,1),
 (1098,17,0,0,0,0,1),
 (1099,281,0,0,0,0,1),
 (1100,282,0,0,0,0,1),
 (1101,283,7,0,0,0,1),
 (1102,284,2,0,0,0,1),
 (1103,285,0,0,0,0,1),
 (1104,286,8,0,0,0,1),
 (1105,157,0,0,0,0,1),
 (1106,157,0,0,0,0,1),
 (1107,157,0,0,0,0,1),
 (1109,157,0,0,0,0,1),
 (1110,157,0,0,0,0,1),
 (1111,157,0,0,0,0,1),
 (1112,157,0,0,0,0,1),
 (1113,157,0,0,0,0,1),
 (1114,178,0,0,0,0,1),
 (1115,56,0,0,0,0,1),
 (1116,41,0,0,0,0,1),
 (1117,43,0,0,0,0,1),
 (1118,43,0,0,0,0,1),
 (1119,43,0,0,0,0,1),
 (1120,43,0,0,0,0,1),
 (1121,43,0,0,0,0,1),
 (1122,43,0,0,0,0,1),
 (1123,43,2,0,0,0,1),
 (1124,43,0,0,0,0,1),
 (1125,43,0,0,0,0,1),
 (1126,43,0,0,0,0,1),
 (1127,43,0,0,0,0,1),
 (1128,43,0,0,0,0,1),
 (1129,43,1,0,0,0,1),
 (1130,43,0,0,0,0,1),
 (1131,43,0,0,0,0,1),
 (1132,45,0,0,0,0,1),
 (1133,43,0,0,0,0,1),
 (1134,45,0,0,0,0,1),
 (1135,43,0,0,0,0,1),
 (1136,43,0,0,0,0,1),
 (1137,267,0,0,0,0,1),
 (1138,287,1,0,0,0,1),
 (1139,66,0,0,0,0,1),
 (1140,288,0,0,0,0,1),
 (1141,58,0,0,0,0,1),
 (1142,58,0,0,0,0,1),
 (1143,58,2,0,0,0,1),
 (1144,58,0,0,0,0,1),
 (1145,58,0,0,0,0,1),
 (1146,48,0,0,0,0,1),
 (1147,48,0,0,0,0,1),
 (1148,289,0,0,0,0,1),
 (1149,289,0,0,0,0,1),
 (1150,289,0,0,0,0,1),
 (1151,289,0,0,0,0,1),
 (1152,291,0,0,0,0,1),
 (1153,290,2,0,0,0,1),
 (1154,126,0,0,0,0,1),
 (1155,126,0,0,0,0,1),
 (1156,126,0,0,0,0,1),
 (1157,126,0,0,0,0,1),
 (1158,133,0,0,0,0,1),
 (1159,292,0,0,0,0,1),
 (1160,293,0,0,0,0,1),
 (1161,293,0,0,0,0,1),
 (1162,292,0,0,0,0,1),
 (1163,293,0,0,0,0,1),
 (1164,293,0,0,0,0,1),
 (1165,292,0,0,0,0,1),
 (1166,15,0,0,0,0,1),
 (1167,15,0,0,0,0,1),
 (1168,224,2,0,0,0,1),
 (1169,1,0,0,0,0,1),
 (1170,1,5,0,0,0,1),
 (1171,1,0,0,0,0,1),
 (1172,1,5,0,0,0,1),
 (1173,294,0,0,0,0,1),
 (1174,295,0,0,0,0,1),
 (1175,293,0,0,0,0,1),
 (1176,35,0,0,0,0,1),
 (1177,296,0,0,0,0,1),
 (1178,296,0,0,0,0,1),
 (1179,14,6,0,0,0,1),
 (1180,297,0,0,0,0,1),
 (1181,75,0,0,0,0,1),
 (1182,75,10,0,0,0,1),
 (1183,75,0,0,0,0,1),
 (1184,298,0,0,0,0,1),
 (1185,28,0,0,0,0,1),
 (1186,28,0,0,0,0,1),
 (1187,18,0,0,0,0,1),
 (1188,18,0,0,0,0,1),
 (1189,18,0,0,0,0,1),
 (1190,298,0,0,0,0,1),
 (1191,298,0,0,0,0,1),
 (1192,18,0,0,0,0,1),
 (1193,18,0,0,0,0,1),
 (1194,18,0,0,0,0,1),
 (1195,299,0,0,0,0,1),
 (1196,299,0,0,0,0,1),
 (1197,300,0,0,0,0,1),
 (1198,300,0,0,0,0,1),
 (1199,300,0,0,0,0,1),
 (1200,2,0,0,0,0,1),
 (1201,301,0,0,0,0,1),
 (1202,301,22,0,0,0,1),
 (1203,301,0,0,0,0,1),
 (1204,30,0,0,0,0,1),
 (1205,302,0,0,0,0,1),
 (1206,303,0,0,0,0,1),
 (1207,303,0,0,0,0,1),
 (1208,16,2,0,0,0,1),
 (1209,16,1,0,0,0,1),
 (1210,16,2,0,0,0,1),
 (1211,15,8,0,0,0,1),
 (1212,15,3,0,0,0,1),
 (1213,13,8,0,0,0,1),
 (1214,304,6,0,0,0,1),
 (1215,305,3,0,0,0,1),
 (1216,305,4,0,0,0,1),
 (1217,305,4,0,0,0,1),
 (1218,305,3,0,0,0,1),
 (1219,1,6,0,0,0,1),
 (1220,306,22,0,0,0,1),
 (1221,307,71,0,0,0,1),
 (1222,300,5,0,0,0,1),
 (1223,30,8,0,0,0,1),
 (1224,155,9,0,0,0,1),
 (1225,34,13,0,0,0,1),
 (1226,34,14,0,0,0,1),
 (1227,34,24,0,0,0,1),
 (1228,37,19,0,0,0,1),
 (1229,33,5,0,0,0,1),
 (1230,34,3,0,0,0,1),
 (1231,32,4,0,0,0,1),
 (1232,308,9,0,0,0,1),
 (1233,40,4,0,0,0,1),
 (1234,65,2,0,0,0,1),
 (1235,157,1,0,0,0,1),
 (1236,157,4,0,0,0,1),
 (1237,157,4,0,0,0,1),
 (1238,157,3,0,0,0,1),
 (1239,157,1,0,0,0,1),
 (1240,157,1,0,0,0,1),
 (1241,49,1,0,0,0,1),
 (1242,49,3,0,0,0,1),
 (1243,58,2,0,0,0,1),
 (1244,309,12,0,0,0,1),
 (1245,65,2,0,0,0,1),
 (1246,65,3,0,0,0,1),
 (1247,65,1,0,0,0,1),
 (1248,65,2,0,0,0,1),
 (1249,65,1,0,0,0,1),
 (1250,65,4,0,0,0,1),
 (1251,65,1,0,0,0,1),
 (1252,65,1,0,0,0,1),
 (1253,61,2,0,0,0,1),
 (1254,310,2,0,0,0,1),
 (1255,310,2,0,0,0,1),
 (1256,203,2,0,0,0,1),
 (1257,203,1,0,0,0,1),
 (1258,203,3,0,0,0,1),
 (1259,203,1,0,0,0,1),
 (1260,49,2,0,0,0,1),
 (1261,49,2,0,0,0,1),
 (1262,65,1,0,0,0,1),
 (1263,311,4,0,0,0,1),
 (1264,49,5,0,0,0,1),
 (1265,49,14,0,0,0,1),
 (1266,49,1,0,0,0,1),
 (1267,49,1,0,0,0,1),
 (1268,62,1,0,0,0,1),
 (1269,65,1,0,0,0,1),
 (1270,65,1,0,0,0,1),
 (1271,45,1,0,0,0,1),
 (1272,43,2,0,0,0,1),
 (1273,45,1,0,0,0,1),
 (1274,45,1,0,0,0,1),
 (1275,45,1,0,0,0,1),
 (1276,43,1,0,0,0,1),
 (1277,43,1,0,0,0,1),
 (1278,43,1,0,0,0,1),
 (1279,43,1,0,0,0,1),
 (1280,43,2,0,0,0,1),
 (1281,66,4,0,0,0,1),
 (1282,58,5,0,0,0,1),
 (1283,62,10,0,0,0,1),
 (1284,34,11,0,0,0,1),
 (1285,203,4,0,0,0,1),
 (1286,64,1,0,0,0,1),
 (1287,64,1,0,0,0,1),
 (1288,64,1,0,0,0,1),
 (1289,122,21,0,0,0,1),
 (1294,123,11,0,0,0,1),
 (1295,77,20,0,0,0,1),
 (1296,48,1,0,0,0,1),
 (1297,48,1,0,0,0,1),
 (1298,48,4,0,0,0,1),
 (1299,48,7,0,0,0,1),
 (1300,48,2,0,0,0,1),
 (1301,48,2,0,0,0,1),
 (1302,87,3,0,0,0,1),
 (1303,87,3,0,0,0,1),
 (1304,87,1,0,0,0,1),
 (1305,88,2,0,0,0,1),
 (1306,312,6,0,0,0,1),
 (1307,87,1,0,0,0,1),
 (1308,86,19,0,0,0,1),
 (1309,85,4,0,0,0,1),
 (1310,81,3,0,0,0,1),
 (1311,81,2,0,0,0,1),
 (1312,81,2,0,0,0,1),
 (1313,81,3,0,0,0,1),
 (1314,313,1,0,0,0,1),
 (1315,76,2,0,0,0,1),
 (1316,34,11,0,0,0,1),
 (1317,34,0,12,0,0,1),
 (1318,34,0,40,0,0,1),
 (1319,34,0,12,0,0,1),
 (1320,34,0,3,0,0,1),
 (1321,34,17,0,0,0,1),
 (1322,34,16,0,0,0,1),
 (1323,34,18,0,0,0,1),
 (1324,34,27,0,0,0,1),
 (1325,78,5,0,0,0,1);


INSERT INTO ElPam.`saldo` (`Per_Num`,`Per_Tip`,`Mon_Num`,`Sal_Valor`,`Sal_Tipo`,`Sal_LimDeu`,`Sal_LimAcre`,`Sal_FechM`) VALUES 
 (2,1,1,14790,1,0,0,'2012-01-23'),
 (3,1,1,1594,1,0,0,'2012-01-23'),
 (4,1,1,3095,1,0,0,'2012-01-23'),
 (5,1,1,3737,1,0,0,'2012-01-23'),
 (6,1,1,214,1,0,0,'2012-01-23'),
 (7,1,1,2208,1,0,0,'2012-01-23'),
 (8,1,1,530,1,0,0,'2012-01-23'),
 (9,1,1,1228,1,0,0,'2012-01-23'),
 (10,1,1,340,1,0,0,'2012-01-23'),
 (11,1,1,744,1,0,0,'2012-01-23'),
 (12,1,1,2727,1,0,0,'2012-01-24'),
 (13,1,1,2930,1,0,0,'2012-01-24'),
 (14,1,1,1587,1,0,0,'2012-01-24'),
 (15,1,1,2077,1,0,0,'2012-01-24'),
 (16,1,1,1918,1,0,0,'2012-01-24'),
 (17,1,1,0,1,0,0,'2012-01-24'),
 (18,1,1,10797,1,0,0,'2012-01-24'),
 (19,1,1,1428,1,0,0,'2012-01-24'),
 (20,1,1,1490,1,0,0,'2012-01-24'),
 (21,1,1,961,1,0,0,'2012-01-24'),
 (22,1,1,384,1,0,0,'2012-01-24'),
 (23,1,1,2713,1,0,0,'2012-01-24'),
 (24,1,1,1935,1,0,0,'2012-01-24'),
 (25,1,1,455,1,0,0,'2012-01-24'),
 (26,1,1,634,1,0,0,'2012-01-24'),
 (27,1,1,6048,1,0,0,'2012-01-24'),
 (29,1,1,951,1,0,0,'2012-01-24'),
 (33,1,1,10663,1,0,0,'2012-01-24'),
 (34,1,1,2091,1,0,0,'2012-01-24'),
 (35,1,1,820,1,0,0,'2012-01-24'),
 (36,1,1,3034,1,0,0,'2012-01-24'),
 (37,1,1,781,1,0,0,'2012-01-24'),
 (38,1,1,1074,1,0,0,'2012-01-24'),
 (39,1,1,104,1,0,0,'2012-01-24'),
 (40,1,1,300,1,0,0,'2012-01-24'),
 (42,1,1,672,1,0,0,'2012-01-24'),
 (43,1,1,1640,1,0,0,'2012-01-24'),
 (44,1,1,912,1,0,0,'2012-01-24'),
 (46,1,1,522,1,0,0,'2012-01-24'),
 (47,1,1,1422,1,0,0,'2012-01-24'),
 (48,1,1,4351,1,0,0,'2012-01-24'),
 (49,1,1,552,1,0,0,'2012-01-24'),
 (50,1,1,1229,1,0,0,'2012-01-24'),
 (53,1,1,2230,1,0,0,'2012-01-24'),
 (55,1,1,908,1,0,0,'2012-01-24'),
 (56,1,1,4152,1,0,0,'2012-01-24'),
 (57,1,1,11551,1,0,0,'2012-01-24'),
 (59,1,1,743,1,0,0,'2012-01-24');
/*!40000 ALTER TABLE `saldo` ENABLE KEYS */;


INSERT INTO ElPam.`subproducto` (`SubP_CodIn`,`ProCom_CodIn`) VALUES 
 (514,513),
 (515,513),
 (516,513),
 (517,513),
 (518,513),
 (519,513),
 (520,513),
 (521,513),
 (524,513),
 (525,513),
 (526,513),
 (527,513),
 (528,513),
 (532,513),
 (533,513),
 (535,513),
 (537,513),
 (538,513),
 (544,513),
 (1290,513),
 (1291,513),
 (1293,513);

UPDATE 
ElPam.ProductoCom
set
IVA_Num = 3;