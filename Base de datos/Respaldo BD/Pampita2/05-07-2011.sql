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
  `Pro_CodIn` INT NOT NULL AUTO_INCREMENT COMMENT 'CÛdigo interno de del articulo este aumenta seg˙n agrupado por Cat_Sig' ,
  `Pro_Nom` VARCHAR(45) NOT NULL COMMENT 'Nombre de producto' ,
  `Pro_Descr` VARCHAR(60) NULL COMMENT 'DescripciÛn de producto' ,
  `Pro_CodBar` VARCHAR(45) NULL COMMENT 'CÛdigo de barra ' ,
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
  `Per_Tip` INT NOT NULL ,
  `Mon_Num` INT NOT NULL ,
  `Sal_Valor` FLOAT NOT NULL ,
  `Sal_Tipo` TINYINT(1)  NOT NULL COMMENT 'Determina si el saldo es;\n?  true: Deudor\n?  false: Acreedor' ,
  `Sal_LimDeu` FLOAT NULL DEFAULT 0 ,
  `Sal_LimAcre` FLOAT NULL DEFAULT 0 ,
  `Sal_FechM` DATE NULL COMMENT 'Guarda la ultima fecha de modificacion' ,
  PRIMARY KEY (`Per_Num`, `Per_Tip`, `Mon_Num`) ,
  INDEX `fk_Saldo_Persona1` (`Per_Num` ASC, `Per_Tip` ASC) ,
  INDEX `fk_Saldo_Moneda1` (`Mon_Num` ASC) ,
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
  `Fac_IvaTm` DOUBLE NULL DEFAULT 0 COMMENT 'Guarda el porcentaje del IVA tasa mÌnima de la fecha de la factura ' ,
  `Fac_IvaTb` DOUBLE NULL DEFAULT 0 COMMENT 'Guarda el porcentaje del IVA tasa b·sica de la fecha de la factura ' ,
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
  `Mov_DesOr` VARCHAR(100) NOT NULL COMMENT 'En este  campo se especifica de donde vino o a donde va en caso que sea una orden de ingreso o de retiro de mercaderÌa.' ,
  `Mov_Tip` TINYINT(1)  NOT NULL COMMENT 'Si es true el movimiento es de ingreso\n si es false la orden es de recepciÛn.' ,
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
-- Table `ElPam`.`Credto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ElPam`.`Credto` ;

CREATE  TABLE IF NOT EXISTS `ElPam`.`Credto` (
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `ForP_Tip` INT NULL DEFAULT 2 ,
  `Int_Num` INT NULL COMMENT 'Intereses si se pasa fecha de pago\n' ,
  `Cre_CanCuo` BIGINT NOT NULL COMMENT 'Cantidad de cuotas ' ,
  `Cre_Tipo` BIGINT NOT NULL COMMENT 'Determina que tipo de intervalo o sea.\n?  Anual: 0\n?  Mensual: 1\n?  Dia: 2\n?  Personalizado: 3' ,
  `Cre_Intervalo` BIGINT NULL DEFAULT 1 COMMENT 'Inervalo en que se ba a pagar\n se es en aÒos cada cuento si es en meses cada cuanto si es en dias etc.' ,
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
  `Cuo_FechVen` DATE NOT NULL ,
  `Fac_Num` INT NOT NULL ,
  `Fac_Serie` VARCHAR(1) NOT NULL ,
  `Fac_Tip` TINYINT(1)  NOT NULL ,
  `Cuo_Monto` DOUBLE NOT NULL ,
  `Cuo_FechPag` DATE NULL ,
  PRIMARY KEY (`Cuo_FechVen`, `Fac_Num`, `Fac_Serie`, `Fac_Tip`) ,
  INDEX `fk_Cuota_Credto1` (`Fac_Num` ASC, `Fac_Serie` ASC, `Fac_Tip` ASC) ,
  CONSTRAINT `fk_Cuota_Credto1`
    FOREIGN KEY (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
    REFERENCES `ElPam`.`Credto` (`Fac_Num` , `Fac_Serie` , `Fac_Tip` )
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
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Cliente` (`Per_Num` INT, `Per_RasSos` INT, `Per_Localidad` INT, `Per_Direccion` INT, `Per_Docum` INT, `Per_TipDocum` INT, `Per_CondIva` INT, `Per_Rut` INT, `ProvD_Num` INT, `ProvD_Nom` INT, `Pai_Num` INT, `Pai_Nom` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ElPam`.`Viw_Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ElPam`.`Viw_Proveedor` (`Per_Num` INT, `Per_RasSos` INT, `Per_Localidad` INT, `Per_Direccion` INT, `Per_Docum` INT, `Per_TipDocum` INT, `Per_CondIva` INT, `Per_Rut` INT, `ProvD_Num` INT, `ProvD_Nom` INT, `Pai_Num` INT, `Pai_Nom` INT);

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

pPai_Num INT,  pProvD_Num INT) RETURNS INT



BEGIN 



    DECLARE xPer_Num INT;

    

    SELECT Num INTO xPer_Num  from ElPam.Viw_ProV;



    INSERT INTO `ElPam`.`Persona` (`Per_Num`,`Per_Tip`,`Per_RasSos`, `Per_Localidad`, `Per_Direccion`, `Per_Rut`, 

	  `Per_CondIva`, `Per_Docum`, `Per_TipDocum`, `Pai_Num`, `ProvD_Num`) VALUE (`xPer_Num`,2 ,`pPer_RasSos`, `pPer_Localidad`, 

	  `pPer_Direccion`, `pPer_Rut`, `pPer_CondIva`,`pPer_Docum`, `pPer_TipDocum`, `pPai_Num`, `pProvD_Num`);

      

    INSERT INTO `ElPam`.`Proveedor` (`Prov_Num`) VALUE (`xPer_Num`);

    

	  RETURN `xPer_Num`;

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
END; $$

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

pPai_Num INT,  pProvD_Num INT) RETURNS INT

BEGIN 

    DECLARE xPer_Num INT;



	  SELECT Num INTO xPer_Num  from ElPam.Viw_NumCli;

      

    INSERT INTO `ElPam`.`Persona` (`Per_Num`,`Per_Tip`,`Per_RasSos`, `Per_Localidad`, `Per_Direccion`, `Per_Rut`, 

	  `Per_CondIva`,`Per_Docum`, `Per_TipDocum`, `Pai_Num`, `ProvD_Num`) VALUE (`xPer_Num`,1 ,`pPer_RasSos`, `pPer_Localidad`, 

	  `pPer_Direccion`, `pPer_Rut`,`pPer_CondIva`,`pPer_Docum`, `pPer_TipDocum`, `pPai_Num`, `pProvD_Num`);

    

    INSERT INTO `ElPam`.`Cliente` (`Cli_Num`) VALUE (`xPer_Num`);



    RETURN xPer_Num;

END;



$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ModCli
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ModCli`;

DELIMITER $$
USE `ElPam`$$










CREATE PROCEDURE `ElPam`.`Pro_ModCli` (IN pPer_Num INT, IN pPer_RasSos VARCHAR(45), IN  pPer_Localidad VARCHAR(45), 

IN pPer_Direccion VARCHAR (100), IN pPer_Rut VARCHAR(45), IN pPer_CondIva INT, IN pPer_Docum VARCHAR (45), 

IN pPer_TipDocum INT, pPai_Num INT,  pProvD_Num INT) 



BEGIN 



    DECLARE xPer_Num INT;

    

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





END;



$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Pro_ModProv
-- -----------------------------------------------------

USE `ElPam`;
DROP procedure IF EXISTS `ElPam`.`Pro_ModProv`;

DELIMITER $$
USE `ElPam`$$








CREATE PROCEDURE `ElPam`.`Pro_ModProv` (IN pPer_Num INT, IN pPer_RasSos VARCHAR(45), IN  pPer_Localidad VARCHAR(45), 

IN pPer_Direccion VARCHAR (100), IN pPer_Rut VARCHAR(45), IN pPer_CondIva INT, IN pPer_Docum VARCHAR (45), 

IN pPer_TipDocum INT, pPai_Num INT,  pProvD_Num INT) 



BEGIN 



    DECLARE xPer_Num INT;

    

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





END;$$

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
	Per_Num,
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
	Pai_Nom
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
WHERE 
    Persona.Per_Tip = 1
;

-- -----------------------------------------------------
-- View `ElPam`.`Viw_Proveedor`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ElPam`.`Viw_Proveedor` ;
DROP TABLE IF EXISTS `ElPam`.`Viw_Proveedor`;
USE `ElPam`;
CREATE  OR REPLACE VIEW `ElPam`.`Viw_Proveedor` AS 
SELECT 
	Per_Num,
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
	Pai_Nom
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
        ElPam.persona
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
USE `ElPam`;



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

--
-- Dumping data for table ElPam.`categoria`
--

LOCK TABLES ElPam.`categoria` WRITE;
/*!40000 ALTER TABLE ElPam.`categoria` DISABLE KEYS */;
INSERT INTO ElPam.`categoria` VALUES (21,'Aceite'),(45,'Acondicionador'),(158,'Ades'),(157,'Adesml'),(110,'Agua mineral'),(124,'Agujas'),(78,'Alfajores'),(60,'Algodon Hidrofilo'),(88,'Amarga'),(39,'Anana'),(11,'Anis'),(150,'Aromantisante de ropas'),(42,'Aromatizante de Ambientes'),(17,'Arroz'),(23,'Arvejas'),(30,'Atun'),(22,'Avena'),(13,'Azucar'),(141,'Bastoncitos de Algodon'),(104,'Bebida lactea'),(54,'Bolsa de Residuos'),(79,'Bombones'),(168,'BUTIFARRA'),(89,'Ca√±a'),(2,'Cafe'),(120,'Cafe  (sobres)'),(126,'Caldos'),(127,'Caramelos'),(138,'Carne'),(137,'Carne Ovina'),(136,'Carne Vacuna'),(121,'Cepillo de dientes'),(169,'Cera'),(128,'Chiclets'),(27,'Choclo'),(82,'Chocolate confitado'),(135,'Chorizo'),(10,'Clavo de Olor'),(3,'Cocoa'),(119,'Cocoa (sobre)'),(106,'Crema de leche'),(162,'Crema dental'),(70,'Creolina'),(62,'Desodorante'),(65,'Desodorante en aerosol'),(63,'Desodorante en barra'),(64,'Desodorante en roll on'),(50,'Detergentes'),(101,'Dulce de leche'),(38,'Duraznos'),(14,'Edulcorante'),(160,'Encendedor'),(72,'Espirales x bolsa'),(67,'Espirales x caja'),(55,'Esponja de aluminio'),(57,'Esponjas'),(144,'Extracto de Tomate'),(155,'Fanta'),(163,'FariÒa'),(16,'Fideos'),(6,'Flan Godet'),(123,'Fosforos'),(81,'Galletitas'),(80,'Galletitas rellenas'),(117,'Gasa Hidrofila'),(149,'Gelatina'),(91,'Grappa'),(90,'Grappamiel'),(97,'Grissines'),(53,'Guantes de latex'),(152,'Gunate'),(19,'Harina'),(5,'Helado Richard'),(118,'Hilo Dental'),(159,'Huevo'),(148,'Insecticidas'),(170,'Jabo en polvo'),(44,'Jabon'),(76,'Jabon de labar'),(140,'Jabon en Barra'),(49,'Jabon en polvo'),(151,'Jabon tocador'),(25,'Jardinera de Legumbres'),(34,'Jugos'),(33,'Ketchup'),(75,'Lamparas'),(52,'Lavandina'),(105,'Leche chocolatada'),(171,'Lechon'),(165,'Lenteja'),(113,'Leuco'),(139,'Licores'),(48,'Limpiador liquido'),(26,'Maiz Dulce'),(95,'Malteada'),(108,'Manteca'),(122,'Maquina desechables de afeitar'),(32,'Mayonesa'),(111,'Medicamentos'),(112,'Medicamentos¬∫'),(98,'Merengues'),(100,'Mermeladas'),(167,'Milanesa'),(131,'Ovina'),(77,'Pa√±ales'),(56,'Pa√±o de Piso'),(116,'Pa√±uelos descartables'),(71,'Palillos para ropa'),(36,'Palitos'),(94,'Palitos de harina de maiz y queso'),(93,'Palitos de jamon'),(92,'Papas fritas'),(40,'Papel Higienico'),(66,'Pasta dental'),(129,'Pastillas'),(147,'Pastillas de ba√±o'),(31,'Picadillo de Carne'),(69,'Pilas chicas'),(73,'Pilas grandes'),(74,'Pilas medianas'),(20,'Polenta'),(164,'Polentas'),(134,'Pollo'),(24,'Porotos'),(96,'Porte√±ita'),(103,'Postre lacteo'),(115,'Preservativos de Latex'),(161,'Prestobarba'),(142,'Promocion'),(58,'Protectores Diarios'),(28,'Pulpa de Tomate'),(145,'Pure'),(15,'Pure de Papas'),(107,'Queso untable'),(109,'Refrescos'),(51,'Removedor de sarro'),(41,'Rollos de Cocina'),(37,'Royal'),(4,'Royarina'),(12,'Sal Fina'),(153,'Salsa blanca'),(29,'Sardina'),(166,'Serbilletas'),(43,'Shampoo'),(46,'Shampoo y Acondicionador'),(18,'Sopa'),(154,'Sopas'),(156,'Sprite'),(47,'Suavizantes'),(146,'Surtidas'),(68,'Tabletas contra mosquitos'),(61,'Talco'),(99,'Tapas hojaldradas'),(7,'Te'),(9,'Te Rojo'),(143,'Tinta'),(59,'Toallas Femeninas'),(133,'Vacuna'),(8,'Vainilla'),(125,'Velas de cumplea√±os'),(114,'Venditas Adhesivas'),(84,'Vermouth'),(35,'Vinagre'),(85,'Vinos'),(86,'Vinos en caja'),(83,'waffles'),(87,'whisky'),(1,'Yerba'),(102,'Yogurt');
/*!40000 ALTER TABLE ElPam.`categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `producto`
--

LOCK TABLES ElPam.`producto` WRITE;
/*!40000 ALTER TABLE ElPam.`producto` DISABLE KEYS */;
INSERT INTO ElPam.`producto` VALUES (1,'Abuelita','','7730415000540',69),(2,'El Moncayo 1/2','','7730910600221',42),(3,'San Pedro','','7730241003463',49),(4,'Uruguay','','7730415000359',55),(5,'Del Gaucho','','7130903168026',63),(6,'La Tropa','','7730208016406',52),(7,'Bracafe 100g','','7730109111125',115),(9,'Bracafe 204g','','7730109002027',198),(10,'Bracafe 50g','','7730109000115',49),(11,'Aguila','','7730109012521',75),(12,'El Paulista','','7730290002738',28),(13,'Montesol','','7730290001182',25),(14,'Copacabana','','7730109032123',33),(15,'Flam Vainilla 54g','','7730110124220',22),(16,'Postre Vainilla 27g','','7730110124046',12),(17,'Postre Chocolate','','7622300226237',12),(18,'Dulce de leche','','7730476000800',26),(19,'Chocolate','','7730476000817',26),(20,'Frutilla','','7730476000794',26),(21,'Vainilla','','7730476000787',26),(22,'Vainilla','','7790580621209',22),(23,'Chocolate','','7790580621001',22),(24,'Hornimans','','7730261000015',2),(25,'Monte Cudine','','77310248',22),(26,'La Selva','','7730102008712',0),(27,'Monte Cudine','','7730177000338',12),(28,'Monte Cudine','','77304902',6),(29,'Colosal','','7790641000011',10),(30,'Bella Union','','7730106005113',36),(31,'Azucarlito','','7730251000056',38),(32,'Si diet','','7790036020204',38),(33,'Gourmet','','7730306001588',21),(35,'R comp. 1/2k','','7730950671427',35),(36,'R Comun 1k','','7897230200118',56),(37,'Campero','','7730905130993',39),(38,'Baldo 1k','','7730241003920',80),(39,'Baldo 1/2','','7730241003906',44),(40,'R Comun 1/2','','7897230200101',30),(41,'Canarias Serena 1/2','','7730241009038',48),(42,'Canarias Serena 1K','','7730241010294',71),(43,'Canarita Comun 1/2','','7730241003883',41),(44,'Canarita Comun 1K','','7730241003876',75),(45,'Canarita c/hierbas','','7730241003869',75),(46,'Canarias Comun 1/2','','7730241003661',45),(47,'Canarias Comun 1K','','7730241003654',83),(48,'El Remanso','','7730241003999',39),(49,'Adria','','7730103300532',33),(50,'Epidor','','7730430002444',18),(51,'Santa Fe 1K','','7730905571093',31),(52,'La Mulata 1/2','','7730290003025',20),(53,'La Mulata 1K','','7730290003032',40),(54,'Livre Suave 1k','','7730945980053',60),(56,'Livre Compuesta 1/2','','7730945980145',37),(57,'Livre Compuesta 1k','','7730945980152',71),(58,'Livre Clasica 1/2','','7730945980046',25),(59,'Livre Clasica 1k','','7730945980039',60),(60,'Shiva','','7730114000025',19),(61,'Chef','','7730114400016',30),(62,'Blue Patna','','7730114000117',32),(63,'Maggi Caracolitos','','7802950006636',23),(64,'Knorr de arvejas con jamon','','7730343328686',25),(65,'Knorr Crema de choclo','','7794000535114',25),(66,'Calsal comun','','7730952570018',19),(67,'Santa Fe','','7730905570997',16),(68,'Presto Pronta','','7790580660000',19),(69,'Minuto purita','','7730354002322',20),(70,'ArmiÒo com.1/2k','','7730205065179',43),(71,'Compuesta 1k','','7730205065162',79),(72,'Armi√±o+Armi√±o Compuesta','','7730205037749',42),(73,'Armi√±o Suave 1/2','','7730205072870',39),(74,'ArmiÒo Clasica','','7730205037756',71),(75,'ArmiÒo Suave 1k','','7730205072863',60),(76,'Silueta Ideal 1/2','','7730498001090',38),(77,'Silueta Ideal 1K','','7730498001076',74),(78,'Condesa','','7730132000434',44),(79,'Optimo','','7730132001165',60),(80,'Midas','','7796039001288',32),(81,'Puritas 200gr','','7730354001028',14),(82,'Quaker','','7792170093120',32),(83,'Campero','','7730905130047',11),(84,'Cosecha Dorada','','7730905130153',19),(85,'Cosecha Dorada','','7730905131297',16),(86,'Nidemar','','7730332001729',19),(87,'Cosecha dorada','','7730905130085',15),(88,'Ideal','','7730205082268',15),(89,'Isla del Tropico','','7730970274165',19),(90,'Maravi','','7730922910240',22),(91,'Qualita`s','','7730306000840',18),(92,'Dukita','','7730566000499',48),(93,'Golden Fis 200g','','7730905131242',31),(94,'Golden Fish 125g','','7730905131150',20),(95,'Golden Fish','','7730905131266',18),(96,'Changuito','','7790989003163',12),(97,'Uruguay 122g','','7730132000731',11),(98,'Uruguay 490g','','7730132000779',34),(99,'Dani Fiesta','','7791620001180',9),(100,'Hellmanns 118g','','7794000401228',19),(101,'Hellmanns 250g','','7794000401280',34),(102,'hellmanns Pak','','7730343325012',54),(103,'Hellmanns','','7794000957244',42),(104,'Verao Mix','','7622300145828',6),(105,'Verao Naranja','','7622300145750',6),(106,'Verao Durazno','','7622300145781',6),(107,'Ricard','','77309679',7),(108,'De vino','','7730252000055',24),(109,'De Manzana','','7130308372844',31),(110,'De Alcohol','','7730302302245',18),(111,'Theoto','','7891334150010',5),(112,'50g','','7622300302351',10),(113,'115g','','7622300434380',25),(114,'Tang Naranja Banana','','7622300327118',10),(115,'Tang Pomelo Rosado','','7790050987088',10),(116,'Tang Mandarina','','7790050987101',10),(117,'Tang Pera','','7622300327279',10),(118,'Tang Naranja','','7790050987057',10),(119,'Jazz Anana','','7730368000215',7),(120,'Jazz Naranja','','7730368000147',7),(121,'Rinde 2 n-b','','7730908400987',10),(122,'Papo Naranja','','77307620',3),(123,'Papo Mix','','77308092',3),(124,'En almibar Campero','','7730905130313',46),(125,'En rodajas Ideal','','7730205073952',52),(126,'En almibar Rio de la Plata','','7730205007179',52),(127,'Higienol Texturado X4','','7730219100477',25),(128,'Sussex X2','','7730219012022',25),(129,'Sussex Basico X3','','7730219012060',33),(130,'Poett Bebe','','7793253037413',45),(131,'Poett Bosque de Bambu','','7793253039257',45),(132,'Poett Espiritu Joven','','7793253039264',45),(133,'Poett Latidos de la Tierra','','7793253036478',45),(134,'Selton Mata moscas y mosquitos','','7793253238957',50),(135,'Selton mata cucarachas y hormigas','','7793253292553',60),(137,'Suavex Classic x4','','7730185000580',21),(138,'Johnson Baby','','77504180',6),(139,'Scott x6','','7798038151841',50),(140,'Primor Verde','','7730205066831',12),(141,'Primor Blanco','','7730205066848',12),(142,'Primor Azul','','7730205066855',12),(143,'Nevex con toque de Vivere','','7791290784123',18),(144,'Nevex Fresh','','7791290677944',16),(145,'io Hidratante','','7840118215155',15),(146,'io Soy Joven','','7840118213762',15),(147,'io Frescura','','7840118215131',15),(148,'io Cremosidad','','7840118215148',15),(149,'io Soy Refrescante','','7840118213755',15),(150,'Rinde dos Manzana','','7730908400567',6),(153,'io Soy radiante','','7840118213786',15),(154,'Bull Dog','','7791290677951',25),(155,'Sedal Sos Caspa 350ml','','7791293010663',79),(156,'Sedal Sos Crecimiento Fortificado 350ml','','7791293010403',79),(157,'Sedal Liso extremo 350ml','','7791293010465',79),(158,'Suave Miel y Almendras 930ml','','7130765383773',66),(159,'Suave Manzana Verde 930ml','','7730165322343',66),(160,'Suave Aloe Vera','','7730165322312',66),(161,'Suave Coco y Leche','','7730165323128',66),(162,'Plusbelle Anti Frizz','','7790740622428',65),(163,'Plusbelle Leche de Almendras','','7790740622268',65),(164,'Suave Palta y Oliva','','7791293973180',66),(165,'Suave Miel y Almendras','','7791293991313',17),(166,'Sedal Duo 2 en 1','','7702006917155',5),(167,'Sedal Liso Perfecto','','77901392',5),(168,'Sedal Reconstruccion Estructural','','77901507',5),(169,'Sedal Ceramidas','','77901248',5),(170,'Sedal Reconstruccion estructural','','77901491',5),(171,'Pluma Aromas de jardin','','7730377006307',28),(172,'Pluma Caricia de sol','','7730377006291',28),(173,'Pluma Frescura matinal','','7730377402062',28),(174,'Conejo','','7730377003122',22),(175,'Cif Ba√±o','','7791290785397',46),(176,'Cif Vidrios','','7791290785359',46),(177,'Cif Power Cream','','7791290782341',46),(178,'Drive 800gr lavado a mano','','7791290784437',52),(179,'Drive matic 800gr Bailando bajo la lluvia','','7791290783454',52),(180,'Drive matic 400gr Caminando sobre petalos','','7791290784420',27),(181,'Drive matic 400gr Bailando bajo la lluvia','','7791290783423',27),(182,'Drive matic 400gr Un dia en el Parque','','7791290783409',27),(183,'Drive matic 400gr Ba√±o de Blancura','','7791290783416',27),(184,'Skip 3kg PerfectResults','','7791290783102',262),(185,'Zorro matic 800gr Aloe Vera','','7790990184493',44),(186,'Nevex matic 400gr','','7791290204980',32),(187,'Ace matic 800gr Naturals','','7501065910134',40),(188,'Ace matic 400gr Aloe vera','','7501006734065',25),(189,'Drive matic 3kg + 400gr de regalo','','7730165326686',179),(190,'Nevex matic 3kg Poder del Sol','','7791290000254',212),(191,'Nevex matic 3kg Particulas de Extra Limpieza','','7791290205314',212),(192,'Nevex 750ml Colageno y glicerina','','7730165325306',30),(193,'Nevex 750ml Aloe Vera','','7730165317486',30),(195,'Nevex 1.250L Poder de la Naturaleza','','7730165319190',41),(196,'Nevex 1.250L Limon','','7730165317424',41),(197,'Nevex 1.250L Clasico Frutas Citricas','','7730165318087',41),(198,'Nevex 1.250L Aloe Vera','','7730165317448',41),(199,'Nevex 1.250L Miel y Almendras','','7730165322558',41),(200,'Nevex 1.250L Colageno y Glicerina','','7730165318094',41),(201,'Regium 2Lt Limon','','7730969920370',44),(202,'Regium 1Lt Limon','','7730969920325',24),(203,'Regium 500ml Limon','','7730969920394',15),(204,'Regium 1Lt Floral','','7730969920363',22),(205,'Regium 1Lt Marina','','',23),(206,'Regium 1Lt Lavanda','','7730969920363',23),(207,'Regium 1Lt Pino7730969920400','','7730969920363',23),(208,'Aroma 900ml Vainilla en flor','','7805040312631',25),(209,'Fabuloso 1Lt Lavanda','','7731024700227',39),(210,'Fabuloso 500ml Lavanda','','7731024700210',25),(211,'Prolimak 1Lt','','7730969920387',47),(212,'Sello Rojo 2Lt','','7730494002008',44),(213,'Sello Rojo 1Lt','','7130494007001',25),(214,'Vitara 1Lt','','730969920233',20),(215,'Vitara 2Lt','','7730969920172',44),(216,'Regium 1Lt','','7730969920400',24),(217,'Regium 2Lt','','7730969920349',45),(218,'Funsa Tama√±o 10','','7730356303571',50),(219,'Funsa Tama√±o 7','','7730356303519',65),(220,'Funsa Tama√±o 9y1/2','','7730356303564',65),(221,'Lucky 50x55cm','','18520000',20),(222,'Virulana Rollitos x 10unid.','','7794440101702',20),(223,'El Revoltijo','blanco 55x50cm','7730901283419',23),(225,'Puritas 400gr','','7730354001042',25),(226,'S&A verde','','',22),(227,'S&A rojo','','',22),(228,'S&A azul','','',22),(229,'Drive 400gr lavado a mano','','7791290784413',27),(230,'Mortimer Lisita','','7793253038144',12),(231,'Mimosa','','7793620001474',16),(232,'Absorbex','','7130207028101',11),(233,'Mimosa 40','','7193620007467',34),(234,'Lips 20','','7791906612741',0),(235,'Siempre Libres','','7790010890632',24),(236,'Cisne','','7730207014519',8),(237,'Nube','','7730207005043',14),(238,'Polyana','','7793100157004',35),(239,'Speed Stick 50g hombre','','7509546038339',76),(240,'Rexona en barra  50g hombre','','75024956',71),(241,'Rexona women Active emotion barra','','75029982',71),(242,'Rexona women Bamboo en barra','','78004498',71),(243,'Rexona women Crystal en barra','','75026646',71),(244,'Dove pro-age Dama','','75027520',71),(245,'Dove Original','','75027513',71),(246,'Dove Dermo Aclarant','','75034238',79),(247,'Dove Invisible Dry','','75027537',79),(248,'Rexona Tuning men','','78927414',39),(249,'Dove go fresh pepino','','7791293991283',79),(250,'Dove go fresh pomelo','','7191293997276',79),(251,'Dove Dermo Aclarant','','7191293998679',79),(252,'Dove Invisible Dry','','7791293008868',79),(253,'Dove Clear Tone','','7791293008110',79),(254,'Rexona women nutritive','','7791293848341',76),(255,'Rexona women hair minimising','','7791293004198',76),(256,'Rexona men V8','','7791293017396',76),(257,'Rexona men quantum','','7791293990651',76),(258,'Rexona men cobalt','','7791293990576',76),(259,'Rexona men Adventure','','7791293012056',76),(260,'Colgate Total 12','','7291024135080',59),(261,'Colgate 90gr','','7891024134702',29),(262,'Kolynos 90gr','','7793100120121',25),(263,'Colgate 50gr','','7891024132906',21),(264,'Action 90gr','','7890310110130',21),(265,'Clinch','','7840824800003',20),(266,'Raid x 24 tabletas','','7790520155450',98),(267,'MAS Fuyi X 24 tabletas','','7730900780025',115),(268,'Clinch x 24 tabletas','','7798033980149',49),(269,'Bic caja x 60 unid.','','0070330800809',5),(270,'La Buena Estrella','','',72),(271,'madera','','',15),(272,'10 unidades','','',19),(273,'Bic caja x 24 unidades','','0070330800847',12),(274,'Bic caja x 24 unidades','','0070330800823',10),(275,'Maxilum 100watts','','6986830780784',14),(277,'Barney x 12 unidades peque√±o','','7794626995644',45),(278,'Barney x 36 unidades peque√±o','','7736550084148',180),(279,'Barney x 36 unidades mediano','','7736550084155',180),(280,'Barney x 30 unidades grande','','7794626995798',150),(281,'Barney x 24 unidades extra grande','','7736550084193',120),(282,'Babysec x 48 unidades XG','','7730219051342',288),(283,'Portezuelo triple chocolate','','77302953',12),(284,'Portezuelo triple nieve','','77302830',12),(285,'bon o bon blanco','','77930019',5),(286,'bon o bon negro','','77930002',5),(287,'Vitoria chocolate blanco','','7898209650644',8),(288,'Vitoria morango','','7898209650675',8),(289,'Vitoria limon','','7898209650651',8),(290,'Maria x 2 unidades','','7898209650330',25),(291,'Maria Rika x 3 unidades','','7730116101188',33),(292,'mellizas chocolate','','7730116361117',10),(293,'Rocklets 15gr','','7898142853706',7),(294,'Portezuelo Bocado Black','','77309273',5),(295,'Dukita Dce de leche','','7773401001428',10),(296,'Dukita chocolate','','7773401001442',10),(297,'Portezuelo vainilla','','7730236002433',15),(298,'Portezuelo frutilla','','7730236002440',15),(299,'Portezuelo chocolate','','7730236002426',15),(300,'Mana chocolate','','7790040439306',18),(301,'Mana vainilla','','7790040439207',18),(302,'Mana frutilla','','7790040439009',18),(303,'Mana limon','','7790040439108',18),(304,'El Trigal sin azucar 150gr','','7730116115116',32),(305,'Martini Bianco','','7730308070186',176),(306,'Martini Rosso','','7730302011123',176),(307,'Martini Bianco x 2','','7730302000110',349),(308,'Bulevar Blanco Americano','','7730940040523',115),(309,'1990 Rosado Merlot','','7730168002549',80),(310,'1990 Tinto Clasico Tannat','','7730168002143',80),(311,'1990 Rosado Moscatel','','7730168002341',78),(312,'1990 Tinto Cabernet Sauvignon','','7730168002648',80),(313,'Charamelo Cabernet Sauvignon Tinto','','7730924670180',149),(314,'Bella Union Rosado Dulce','','7730907180354',48),(315,'Bella Union Tinto','','7730907180200',48),(316,'Bella Union Rosado','','7730907180224',48),(317,'Generacion 2001 Tannat Tinto','','7730262000663',50),(318,'Generacion 2001 Cabernet Rosado','','7730262000670',50),(319,'Casco Viejo Tinto','','7730900851077',52),(320,'Casco Viejo Rosado','','7730900850872',52),(321,'Canelon Chico Rosado Moscatel Dulce','','7730900340137',53),(322,'Canelon Chico Rosado Moscatel','','7730900340083',53),(323,'Canelon Chico Tinto','','7730900340113',53),(324,'Vin Up','','7798034241829',30),(325,'Vat 69','','5000292262716',369),(326,'100 Pipers x 1lt','','080432402856',339),(327,'Vitara 1Lt','','0080432402856',349),(328,'Old Times x 1lt','','7730928901013',249),(329,'Dunbar x 1lt','','7730901310054',254),(330,'AÒejo x 1lt','','7730106040015',215),(331,'5 Raices','','7130302107121',152),(332,'Espinillar x 1lt','','7130106030076',182),(333,'Victoria x 1lt','','7730302110123',165),(334,'Vesubio x 1lt','','7730210000035',140),(335,'Vesubio x 500ml','','7730210000462',85),(336,'Salerno x 1lt','','7730106000316',158),(337,'San Remo x 1lt','','7730106000330',159),(338,'San Remo x 1lt','','7730106020017',159),(339,'Vitoria dce de leche','','7898209650637',8),(340,'Vitoria chocolate','','7898209650668',8),(341,'Charly 300gr','','7730955840033',64),(342,'Lays 17gr','','7790310924112',7),(343,'Lays 30gr','','7790310981306',10),(344,'Mana x 3 vainilla','','7790040720800',33),(345,'Serranitas105gr','','7790040725003',12),(346,'Dukita al agua 85gr','','7773401002029',7),(347,'Pali Chip 30gr','','7790310001615',7),(348,'Cheetos 17gr','','7790310979976',5),(349,'Mira Mar','','',32),(350,'El Pepe','','',29),(351,'Mira Mar','','',25),(352,'Mira Mar','','',35),(353,'Bagley de salvado 214gr','','7790040317291',24),(354,'Hogare√±as Mix de Cereales','','7790040566903',24),(355,'Serranitas x 3','','7790040725102',31),(356,'portezuelo blanco','','7730236002907',7),(357,'Portezuelo chocolate','','77305749',7),(358,'Play chocolate','','7730303007422',7),(359,'Play nieve','','7730303000201',7),(360,'Leiva x 3 sanwich','','7790412001292',25),(361,'Diversion 400gr','','7790040711105',37),(362,'Comodoro 900cm3','','7793065000384',28),(363,'Avanti x2 rectangulares','','7730927020098',62),(365,'Avanti x 12 unidades para empanadas','','7730927020111',45),(366,'Dulciora ciruela x 500gr','','7790580508401',34),(367,'Dulciora zapallo x 500gr','','7790580508500',34),(368,'Dulciora durazno x 500gr','','7790580508104',34),(369,'Dulciora higo x 500gr','','7790580508609',34),(370,'Dulciora damasco x 500gr','','7790580508203',34),(371,'Ricomax x 1kg','','',63),(372,'Biotop x 1lt durazno','','7730105032820',42),(373,'Biotop x 1lt frutilla','','7730105032844',42),(374,'Biotop x 1lt vainilla','','7730105032899',42),(375,'Frutado Conaprole frutillax 145gr','','7730105022173',20),(376,'Frutado Conaprole durazno 145gr','','7730105022166',20),(377,'Frutado Conaprole ensalada de frutas x 145gr','','7730105022180',20),(378,'Yoprole frutilla x 185g','','7730105002366',21),(379,'Yoprole durazno x 185g','','7730105002373',21),(380,'Conamigos Petit vainilla pack x 2','','7730105015496',22),(381,'Conaprole frutilla x 1lt','','7730105002557',32),(382,'Conaprole durazno x 1lt','','7730105002564',32),(383,'Lactolate x 1lt','','7730105014109',36),(384,'Colet 250ml','','7730105014055',20),(385,'Conaprole larga vida 250ml','','7730105011337',39),(386,'Plus Conaprole naranja 250ml','','7730105015892',20),(387,'Plus Conaprole durazno 250ml','','7730105015359',20),(388,'Requeson 250gr','','77309549',57),(389,'Conaprole 100gr c/sal','','77306494',26),(390,'Conaprole 100gr s/sal','','77306210',26),(391,'Conaprole 200gr c/sal','','77306456',49),(392,'Viva 0% con pulpa de durazno','','7730105026317',39),(393,'Viva 0% con pulpa de frutilla,kiwi y arandano','','7730105026300',39),(394,'Vital + Bio Transit Ciruela y Manzana','','7730105085116',45),(395,'Vital+Bio Transit Light frutilla','','7730105085123',45),(396,'Sprite 2lt','','7730197178970',45),(397,'Sanly  2lt sabor cola','','7730903090459',22),(398,'U 2lt mandarina','','7730905810109',40),(399,'U 2lt pomelo','','7730905810116',40),(400,'Fanta Pomelo 2lt','','7730197002909',45),(401,'Matutina 2lt','','7730922250070',19),(402,'Coca Cola 2,25lt','','7730197112967',55),(403,'Fanta Naranja 2lt7730197178970','','7730197208950',45),(404,'Nix pomelo 2,5lt','','7730289001148',42),(405,'Nix cola 2,5lt','','7730289001124',42),(406,'Aspirina C Caliente','','78003880',17),(407,'Yasta Clasico 12 sobres 15gr','','7793640210672',0),(408,'Alikal + Analgesico','','7794640130724',0),(409,'Zolben 8 comprimidos','','7730202000142',0),(410,'Actron Rapida accion 10 capsulas','','7793640215479',0),(411,'Perifar Flex 8 comprimidos','','7730900570657',0),(412,'Perifar Grip 8 comprimidos','','7730900570879',0),(413,'Perifar Espasmo 8comprimidos','','7730900571289',0),(414,'Perifar Fem 8 comprimidos','','7730900571333',0),(415,'Perifar 400 8comprimidos','','7730900570237',0),(416,'Perifar Migra 8comrimidos','','7730900570886',0),(417,'Sinutab Plus granulado (sobre)','','',28),(418,'Zolben C Caliente(sobre)','','',20),(419,'Novemina','','',3),(420,'ACF 4 (8comprimidos)','','7130381002485',0),(421,'Adhesur N*5','','7798066092031',34),(422,'Ready Plast','','',2),(423,'Prime Texturado','','7791519200069',30),(424,'Prime Espermicida','','7791519200076',30),(425,'Prime Extra Lubricado','','7791519000676',30),(426,'Prime Retardante Climax Control','','7791519702112',30),(427,'Prime Ultra Fino','','7791519701061',30),(428,'Rosetex Ultrafinos','','7730621002819',25),(429,'Kleenex','','0036000003178',8),(430,'Farma Medical','','',9),(431,'ORAL-B','','7800005081126',69),(432,'Saint Colet 8gr','','7730908360618',1),(433,'Bracafe Nescafe (caja x 250 unidades)','','7613032780661',1),(434,'Dr Cool','','6905147272668',12),(435,'Bic Comfort Twin','','0070330709485',16),(436,'Bic Comfort 3 (normal)','','',23),(437,'Bic Comfort 3 (sensible)','','0070330717565',23),(438,'Bic sensitive (amarilla)','','0070330703629',9),(439,'The Lion x 10 cajas de 40 unidades c/u','','7896007912285',13),(440,'Needles (pack)','','',12),(441,'Magic (pack)','','6940350896042',12),(442,'Arisco Galinha Caipira','','7891700023023',5),(443,'knorr Verduras','','7794000594708',5),(444,'Maggi Gallina','','7891000073933',5),(445,'masticables Misky 800gr','','7790580178109',0),(446,'Frutal Arcor 810gr','','7790580471309',0),(447,'Poosh tutti fruti','','77929075',1),(448,'Poosh menta','','77929082',1),(449,'Topline menta','','77916426',5),(450,'Topline strong','','77916396',5),(451,'Topline dagron fruit','','77969378',5),(452,'Topline mango + melon','','77927705',5),(453,'Topline mentol','','77916457',5),(454,'Topline ultra defense','','77916419',5),(455,'Freegells eucalipto','','7891151001458',59),(456,'Freegells frambuesa','','7891151026642',5),(458,'moncayo 1k','','7730910600214',76),(459,'Uruguay 250g','','',12),(488,'Ladysoft','','7730219096404',12),(513,'Carne Vacuna','','',89),(514,'Lomo','','',185),(515,'Nalga','','',149),(516,'Chuleta','','',100),(517,'Aguja','','',95),(518,'Asado','','',110),(519,'Pulpa Jamon','','',125),(520,'Pulpa Cuadril','','',125),(521,'Pulpa Redonda','','',125),(522,'Puchero','','',55),(523,'Carne Vacuna','','',85),(524,'Ossobuco','','',65),(525,'Picada','','',120),(526,'Lengua','','',75),(527,'Matambre','','',75),(528,'Falda','','',75),(529,'Carne Ovina','','',89),(530,'Carne Ovina','','',89),(531,'Carne Vacuna','','',85),(532,'Vacio','','',110),(533,'Higado','','',40),(534,'Mondongo','','',50),(535,'churrasco','','',160),(536,'Milanesa','','',120),(538,'Parrillada','','',40),(539,'Chorizo','','',130),(541,'Pollo','','',55),(543,'Carne Vacuna','','',85),(544,'Tapichi','','',35),(545,'Dejavu Chocolate','','7798135760229',45),(546,'Dejavu Dulce de leche','','7798135760236',45),(548,'Dejavu Menta','','7798135760267',45),(549,'Vapor X5','','',25),(550,'Smile Bear','','7730621010852',12),(551,'Dove Acondicionador + Shampoo','','',159),(552,'Kit Color Caoba Claro','','7792321003435',46),(553,'Kit Color Rojo','','7792321003473',46),(554,'Kit Color Rojo Oscuro','','7792321003466',46),(555,'Kit Color Rubio Oscuro','','7792321003183',46),(556,'nevex con un toque de vivere','','7791290782631',32),(557,'Tomatino','','7896387016139',12),(558,'suave aloe vera','','7730165322336',66),(559,'caÒuelas','','7792180001641',32),(561,'Sedal S.O.S rec. estructural','','7791293011172',79),(562,'Mundo Verde','','',20),(563,'lider','','7730205076021',13),(564,'De ley','','7730306001755',13),(565,'Lia 400g','','7790040274303',26),(566,'Portezuelo nieve','','77300126',7),(567,'Cosecha Dorada','','7730905130375',51),(568,'Rexona Sensive','','7791293521619',15),(570,'Rexona Aloe Vera','','7791293521558',15),(571,'Rexona V8','','7791293554624',15),(572,'Rexona Total','','7791293521596',15),(573,'Rexona Rev. Fresh','','7791293012919',15),(574,'Rexona Rev.Min','','7791293521503',15),(575,'Lux Degustame','','7702191655832',18),(576,'Lux Pruebame','','7791293990781',18),(577,'Lux Deseo d Mora','','7791293038858',18),(578,'Lux Encantame','','7791293990668',18),(579,'Astral Avena','','7891024176726',18),(580,'Astral Aloe','','7891024113653',18),(581,'Astral Deo 12','','7891024176788',18),(582,'Astral Cream','','7891024176719',18),(583,'KDT Verde','','7730176000674',14),(584,'Espadol Fresh','','7791130018043',22),(585,'Espadol Skincare','','7791130018029',22),(586,'Drive Ba√±o d blancura 400g','','7791290783355',27),(587,'Nevex Poder del Sol 400g','','7791290002332',32),(588,'Nevex con toq d vivere 400g','','7791290782031',32),(589,'Nevex con toq d vivere 800g','','7791290782617',64),(590,'Nevex Poder del Sol 800g','','7791290000193',64),(591,'Nevex co vivere clasico 800g','','7791290783294',64),(592,'Suave Aloe Vera','','7791293991368',17),(593,'Suave Coco y Leche','','7791293991337',17),(594,'Casco Viejo R. Dulce','','177309008535521',52),(595,'Maggi con Fideos','','17802950006612',23),(596,'Knorr Caracol','','17794000525115',23),(597,'knorr tricolor','','7794000594234',23),(598,'Higienol x 6','','7730219100484',35),(599,'Adria Anillos','','7730103305629',33),(600,'Adria Mo√±a','','7730103301102',33),(601,'Adria Estrellitas','','7730103305681',33),(602,'Adria Tirabuzones','','7730103300488',33),(603,'Adria Tripolino','','7730103301140',33),(604,'Glutina Dedales','','7730354000717',20),(605,'Glutina Coditos','','7730354000724',20),(606,'Glutina Trompetines','','7730354000793',20),(607,'Glutina Mo√±as','','7730354000779',20),(608,'Glutina Corbatas','','7730354000786',20),(609,'Glutina Alfabeto','','7730354000670',20),(611,'Tu Massa Fideo','','',22),(612,'Rexona Men Adventure','','7791293011745',76),(613,'Rexona Men invisible','','7791293568942',76),(614,'Nevex limon 750ml','','7730165317479',30),(615,'Knorr verduras con fideos dedalitos','','7794000522114',23),(616,'Knorr crema de pollo','','7794000514119',23),(617,'Mortimer','','7793253040031',19),(618,'Colgate 70g','','7790630001432',26),(619,'Next Floral','','7792150124523',19),(620,'Next Lavanda','','7792150124516',19),(621,'Astral Protex','','7891024176771',18),(622,'Dove Sabonete cremoso','','7898422746759',27),(623,'Dove Reafirmante','','7898422746810',27),(624,'Dove Men Care','','7891150006058',27),(625,'Dove Pro-age','','7898422750572',27),(626,'Calsal Pastera','','7730952570032',20),(627,'Calsal 1K','','7730952570131',17),(628,'Hornex 50g Naranja','','7730910430224',23),(629,'Hornex 50g Frutilla','','7730910430231',23),(630,'Hornex 50g Manzana','','7730910430255',23),(631,'Hornex 50g Cereza','','7730910430248',23),(632,'Hellmanns 500g','','7794000401389',54),(633,'Hellmanns 125g Light','','7794000451391',19),(634,'nevexpoder de la naturalez','','7730165319183',30),(635,'Pino luz','','7730494143015',20),(636,'Regium 1l','','7730969920264',20),(637,'cif cocina','','7791290782341',46),(638,'Girando sol 1l','','7296404607003',29),(639,'Nevex multi accion 400g','','7791290204997',16),(640,'rexona antivacterial','','7702191655733',15),(641,'axe fusion','','7791293028187',69),(642,'axe marine','','7791293022437',69),(643,'tropical','','7730907870200',31),(644,'funsa','','7730356303540',65),(645,'rinde 2 limon','','7730908401540',10),(646,'juguito','','7730354001967',6),(647,'tang durazno','','7790050987644',10),(648,'rinde 2 anana','','7730908401588',10),(649,'jAZZ naranja banana','','7730368000154',7),(650,'rinde 2 naranja','','7730908400529',10),(651,'Tang limonada','','7790050987095',10),(652,'papo durazno','','77307637',3),(653,'ricard citrus','','77309624',8),(654,'icard naranja','','77309655',8),(655,'bracafe 3 en 1','','7613032351175',7),(656,'ornex salsa','','7730910430415',13),(657,'Colgate total 12','','7891024135020',59),(658,'Casco viejo','','7730900853552',52),(659,'maggi 5 plato','','7802950006612',23),(660,'Coca 600 ml','','7730197301958',26),(661,'FANTA 600','','7730197001469',26),(662,'600 ML','','7730197001452',26),(663,'ades naranja 200','','7794000730052',15),(664,'ades manzana','','7794000730014',30),(665,'huevo carton','','',75),(666,'algas marinas','','7790740622251',63),(667,'Manzana Y pera','','7790740622237',63),(668,'ceramidas activas','','7790740622220',63),(670,'Knorr con fideos caracolitos','','7794000525115',23),(671,'Bx7','','3086126612027',10),(672,'Bic','','0070330703629',9),(673,'golden fish','','7730905131143',47),(674,'Dove','','7791293991276',79),(675,'Dove Original','','7791293008141',79),(676,'dove','','7791293004204',79),(677,'Rexona men','','7791293990620',76),(678,'Rexona men sensitive','','7791293990613',76),(679,'Funsa Uruguay t8','','7730356303533',65),(680,'Funsa Uruguay t8 1/2','','7730356303540',65),(681,'Funsa Uruguay','','7730356303557',65),(682,'Funsa Uruguay','','7730356303564',65),(683,'Closeup','','7891037009844',24),(684,'closeuptriple','','7898422749262',24),(685,'Nevex hurra','','7730165317424',41),(686,'de manzana','','7730302312244',27),(687,'Higienol Perfumado','','7730219010905',26),(688,'eco suavex','','7730185000603',14),(689,'de Gallina','','7794000594722',7),(691,'Campero 1/2','','7730905131006',25),(692,'Adria alfabeto','','7730103305674',33),(693,'Adria dedales','','7730103305353',33),(694,'Adria macarrones','','7730103300242',33),(695,'Adria moÒitas','','7730103301072',33),(696,'Adria moÒas','','7730103301102',33),(697,'moncayo 1/2','','7730910600245',42),(698,'R compuesta 1k','','7730950671410',56),(699,'fariÒa','','',45),(700,'1/2','','',25),(701,'quaker','','7792170007196',40),(702,'Suelta 250g','','',13),(703,'Suelta 250g','','',12),(704,'Huevo','','',3),(705,'Elite','','',12),(706,'Ades Frutas Tropicales','','7794000730090',30),(707,'Okey','','7798085990820',28),(708,'Cocinero','','7790060234868',30),(709,'rinde 2 frutilla','','7730908401526',10),(710,'RINDE 2 MIX','','7730908400536',10),(711,'BUTIFARRA','','',100),(712,'ENTRECO','','',170),(713,'milanesa de pollo','','',145),(714,'mundo verde','','',49),(715,'mundo verde','','',22),(716,'bic','','',25),(717,'nevex multiaccion800g','','7791290205260',64),(718,'nevex fresh800g','','7791290001763',64),(719,'nevex poder dl sol800g','','7791290000193',64),(720,'pantene','','',5),(721,'pantene 2en1','','',5),(722,'pantene','','',5),(723,'ideal','','7730205083258',10),(725,'SUAVE COCO Y LECHE','','7791293973227',68),(726,'SUAVE MIEL Y ALMENDRA','','7791293973197',68),(727,'SUAVE VAINILLA Y CANELA','','7791293973241',68),(728,'SUAVE MULTI VITAMINAS','','7791293008400',68),(729,'SUAVE CHOCOLATE','','7791293785189',68),(730,'SAUVE VAINILLA Y CANELA','','7791293973234',68),(731,'PALTA Y OLIVA','','7791293973173',68),(732,'SUVE COCO Y LECHE','','7791293973210',68),(733,'lechon asado','','',180),(734,'Argentina','','',30),(735,'milanesa','','',120);
/*!40000 ALTER TABLE ElPam.`producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productocom`
--

LOCK TABLES ElPam.`productocom` WRITE;
/*!40000 ALTER TABLE ElPam.`productocom` DISABLE KEYS */;
INSERT INTO ElPam.`productocom` VALUES (1,1,0,1,0,0,1),(2,1,0,1,0,0,1),(3,1,0,1,0,0,1),(4,1,0,1,0,0,1),(5,1,0,1,0,0,1),(6,1,0,1,0,0,1),(7,2,0,1,0,0,1),(9,2,4,1,0,0,1),(10,2,0,1,0,0,1),(11,2,0,0,0,0,1),(12,2,0,1,0,0,1),(13,2,0,1,0,0,1),(14,3,0,0,0,0,1),(15,4,0,0,0,0,1),(16,4,0,0,0,0,1),(17,4,0,0,0,0,1),(18,5,0,0,0,0,1),(19,5,0,0,0,0,1),(20,5,0,0,0,0,1),(21,5,0,0,0,0,1),(22,6,0,0,0,0,1),(23,6,0,0,0,0,1),(24,7,0,1,0,0,1),(25,8,0,0,0,0,1),(26,9,0,0,0,0,1),(27,10,0,0,0,0,1),(28,11,0,0,0,0,1),(29,12,12,0,0,0,1),(30,13,0,0,0,0,1),(31,13,7,0,0,0,1),(32,14,1,0,0,0,1),(33,15,0,0,0,0,1),(35,1,6,0,0,0,1),(36,1,3,0,0,0,1),(37,1,0,0,0,0,1),(38,1,7,0,0,0,1),(39,1,4,0,0,0,1),(40,1,8,0,0,0,1),(41,1,4,0,0,0,1),(42,1,10,0,0,0,1),(43,1,5,0,0,0,1),(44,1,4,0,0,0,1),(45,1,14,0,0,0,1),(46,1,10,0,0,0,1),(47,1,4,0,0,0,1),(48,1,0,0,0,0,1),(49,16,0,0,0,0,1),(50,16,0,0,0,0,1),(51,16,8,0,0,0,1),(52,1,4,0,0,0,1),(53,1,2,0,0,0,1),(54,1,5,0,0,0,1),(56,1,14,0,0,0,1),(57,1,1,0,0,0,1),(58,1,14,0,0,0,1),(59,1,1,0,0,0,1),(60,17,9,0,0,0,1),(61,17,5,0,0,0,1),(62,17,12,0,0,0,1),(63,18,0,0,0,0,1),(64,18,0,0,0,0,1),(65,18,0,0,0,0,1),(66,19,11,0,0,0,1),(67,20,4,0,0,0,1),(68,20,0,0,0,0,1),(69,20,2,0,0,0,1),(70,1,2,0,0,0,1),(71,1,2,0,0,0,1),(72,1,0,0,0,0,1),(73,1,0,0,0,0,1),(74,1,3,0,0,0,1),(75,1,0,0,0,0,1),(76,1,5,0,0,0,1),(77,1,4,0,0,0,1),(78,21,8,0,0,0,1),(79,21,0,0,0,0,1),(80,21,23,0,0,0,1),(81,22,0,0,0,0,1),(82,22,0,0,0,0,1),(83,23,1,0,0,0,1),(84,24,13,0,0,0,1),(85,25,27,0,0,0,1),(86,24,8,0,0,0,1),(87,26,5,0,0,0,1),(88,27,13,0,0,0,1),(89,28,0,0,0,0,1),(90,28,0,0,0,0,1),(91,28,19,0,0,0,1),(92,29,2,0,0,0,1),(93,29,0,0,0,0,1),(94,29,6,0,0,0,1),(95,30,0,0,0,0,1),(96,31,0,0,0,0,1),(97,32,11,0,0,0,1),(98,32,4,0,0,0,1),(99,32,19,0,0,0,1),(100,32,10,0,0,0,1),(101,32,1,0,0,0,1),(102,32,0,0,0,0,1),(103,33,0,0,0,0,1),(104,34,0,0,0,0,1),(105,34,0,0,0,0,1),(106,34,0,0,0,0,1),(107,34,0,0,0,0,1),(108,35,2,0,0,0,1),(109,35,0,0,0,0,1),(110,35,5,0,0,0,1),(111,36,2,0,0,0,1),(112,37,19,0,0,0,1),(113,37,17,0,0,0,1),(114,34,0,0,0,0,1),(115,34,0,0,0,0,1),(116,34,3,0,0,0,1),(117,34,0,0,0,0,1),(118,34,42,0,0,0,1),(119,34,12,0,0,0,1),(120,34,0,0,0,0,1),(121,34,16,0,0,0,1),(122,34,9,0,0,0,1),(123,34,8,0,0,0,1),(124,38,7,0,0,0,1),(125,39,0,0,0,0,1),(126,39,0,0,0,0,1),(127,40,6,0,0,0,1),(128,41,0,0,0,0,1),(129,41,1,0,0,0,1),(130,42,1,0,0,0,1),(131,42,2,0,0,0,1),(132,42,0,0,0,0,1),(133,42,5,0,0,0,1),(134,148,3,0,0,0,1),(135,148,8,0,0,0,1),(137,40,2,0,0,0,1),(138,43,0,0,0,0,1),(139,40,0,0,0,0,1),(140,44,0,0,0,0,1),(141,44,0,0,0,0,1),(142,44,0,0,0,0,1),(143,44,20,0,0,0,1),(144,44,9,0,0,0,1),(145,44,0,0,0,0,1),(146,44,0,0,0,0,1),(147,44,0,0,0,0,1),(148,44,0,0,0,0,1),(149,44,1,0,0,0,1),(150,34,0,0,0,0,1),(153,44,4,0,0,0,1),(154,44,4,0,0,0,1),(155,45,0,0,0,0,1),(156,45,0,0,0,0,1),(157,45,0,0,0,0,1),(158,45,0,0,0,0,1),(159,45,0,0,0,0,1),(160,43,0,0,0,0,1),(161,43,0,0,0,0,1),(162,43,0,0,0,0,1),(163,43,0,0,0,0,1),(164,45,0,0,0,0,1),(165,44,0,0,0,0,1),(166,46,0,0,0,0,1),(167,43,0,0,0,0,1),(168,43,0,0,0,0,1),(169,43,0,0,0,0,1),(170,45,18,0,0,0,1),(171,47,0,0,0,0,1),(172,47,1,0,0,0,1),(173,47,0,0,0,0,1),(174,47,3,0,0,0,1),(175,48,1,0,0,0,1),(176,48,0,0,0,0,1),(177,48,0,0,0,0,1),(178,49,0,0,0,0,1),(179,49,0,0,0,0,1),(180,49,0,0,0,0,1),(181,49,0,0,0,0,1),(182,49,0,0,0,0,1),(183,49,0,0,0,0,1),(184,49,0,0,0,0,1),(185,49,0,0,0,0,1),(186,49,0,0,0,0,1),(187,49,0,0,0,0,1),(188,49,0,0,0,0,1),(189,49,0,0,0,0,1),(190,49,0,0,0,0,1),(191,49,0,0,0,0,1),(192,50,1,0,0,0,1),(193,50,1,0,0,0,1),(195,50,4,0,0,0,1),(196,50,3,0,0,0,1),(197,50,2,0,0,0,1),(198,50,2,0,0,0,1),(199,50,2,0,0,0,1),(200,50,2,0,0,0,1),(201,50,1,0,0,0,1),(202,50,2,0,0,0,1),(203,50,3,0,0,0,1),(204,50,0,0,0,0,1),(205,48,0,0,0,0,1),(206,48,0,0,0,0,1),(207,48,5,0,0,0,1),(208,48,0,0,0,0,1),(209,48,4,0,0,0,1),(210,48,4,0,0,0,1),(211,51,0,0,0,0,1),(212,52,3,0,0,0,1),(213,52,3,0,0,0,1),(214,52,3,0,0,0,1),(215,52,0,0,0,0,1),(216,47,0,0,0,0,1),(217,47,0,0,0,0,1),(218,53,0,0,0,0,1),(219,53,0,0,0,0,1),(220,53,0,0,0,0,1),(221,54,5,0,0,0,1),(222,55,0,0,0,0,1),(223,56,4,0,0,0,1),(225,22,0,0,0,0,1),(226,48,0,0,0,0,1),(227,48,0,0,0,0,1),(228,48,0,0,0,0,1),(229,49,0,0,0,0,1),(230,57,0,0,0,0,1),(231,58,0,0,0,0,1),(232,58,0,0,0,0,1),(233,58,0,0,0,0,1),(234,58,0,0,0,0,1),(235,59,3,0,0,0,1),(236,59,9,0,0,0,1),(237,60,0,0,0,0,1),(238,61,0,0,0,0,1),(239,62,0,0,0,0,1),(240,62,0,0,0,0,1),(241,62,0,0,0,0,1),(242,62,2,0,0,0,1),(243,62,0,0,0,0,1),(244,62,0,0,0,0,1),(245,63,1,0,0,0,1),(246,63,0,0,0,0,1),(247,63,0,0,0,0,1),(248,64,0,0,0,0,1),(249,65,0,0,0,0,1),(250,65,0,0,0,0,1),(251,65,0,0,0,0,1),(252,65,2,0,0,0,1),(253,65,0,0,0,0,1),(254,65,0,0,0,0,1),(255,65,0,0,0,0,1),(256,65,3,0,0,0,1),(257,65,0,0,0,0,1),(258,65,1,0,0,0,1),(259,65,3,0,0,0,1),(260,66,0,0,0,0,1),(261,66,2,0,0,0,1),(262,66,0,0,0,0,1),(263,66,0,0,0,0,1),(264,66,0,0,0,0,1),(265,67,0,0,0,0,1),(266,68,0,0,0,0,1),(267,68,1,0,0,0,1),(268,68,0,0,0,0,1),(269,69,0,0,0,0,1),(270,70,0,0,0,0,1),(271,71,0,0,0,0,1),(272,72,22,0,0,0,1),(273,73,0,0,0,0,1),(274,74,0,0,0,0,1),(275,75,0,0,0,0,1),(277,77,0,0,0,0,1),(278,77,0,0,0,0,1),(279,77,0,0,0,0,1),(280,77,0,0,0,0,1),(281,77,0,0,0,0,1),(282,77,0,0,0,0,1),(283,78,0,0,0,0,1),(284,78,0,0,0,0,1),(285,79,0,0,0,0,1),(286,79,0,0,0,0,1),(287,80,0,0,0,0,1),(288,80,4,0,0,0,1),(289,80,4,0,0,0,1),(290,81,0,0,0,0,1),(291,81,0,0,0,0,1),(292,80,0,0,0,0,1),(293,82,0,0,0,0,1),(294,78,0,0,0,0,1),(295,83,0,0,0,0,1),(296,83,0,0,0,0,1),(297,83,0,0,0,0,1),(298,83,0,0,0,0,1),(299,83,0,0,0,0,1),(300,80,0,0,0,0,1),(301,80,0,0,0,0,1),(302,80,0,0,0,0,1),(303,80,0,0,0,0,1),(304,81,0,0,0,0,1),(305,84,2,0,0,0,1),(306,84,0,0,0,0,1),(307,84,1,0,0,0,1),(308,84,1,0,0,0,1),(309,85,6,0,0,0,1),(310,85,7,0,0,0,1),(311,85,0,0,0,0,1),(312,85,4,0,0,0,1),(313,85,0,0,0,0,1),(314,86,5,0,0,0,1),(315,86,0,0,0,0,1),(316,86,0,0,0,0,1),(317,86,0,0,0,0,1),(318,86,0,0,0,0,1),(319,86,7,0,0,0,1),(320,86,1,0,0,0,1),(321,86,3,0,0,0,1),(322,86,1,0,0,0,1),(323,86,7,0,0,0,1),(324,86,1,0,0,0,1),(325,87,0,0,0,0,1),(326,87,2,0,0,0,1),(327,87,0,0,0,0,1),(328,87,1,0,0,0,1),(329,87,3,0,0,0,1),(330,87,1,0,0,0,1),(331,88,1,0,0,0,1),(332,89,1,0,0,0,1),(333,90,0,0,0,0,1),(334,90,0,0,0,0,1),(335,90,0,0,0,0,1),(336,90,0,0,0,0,1),(337,90,2,0,0,0,1),(338,91,0,0,0,0,1),(339,80,3,0,0,0,1),(340,80,5,0,0,0,1),(341,92,0,0,0,0,1),(342,92,0,0,0,0,1),(343,92,0,0,0,0,1),(344,81,0,0,0,0,1),(345,81,0,0,0,0,1),(346,81,0,0,0,0,1),(347,93,0,0,0,0,1),(348,94,0,0,0,0,1),(349,95,5,0,0,0,1),(350,96,3,0,0,0,1),(351,97,10,0,0,0,1),(352,98,0,0,0,0,1),(353,81,0,0,0,0,1),(354,81,0,0,0,0,1),(355,81,0,0,0,0,1),(356,78,6,0,0,0,1),(357,78,3,0,0,0,1),(358,78,6,0,0,0,1),(359,78,7,0,0,0,1),(360,81,0,0,0,0,1),(361,81,0,0,0,0,1),(362,21,9,0,0,0,1),(363,99,0,0,0,0,1),(365,99,0,0,0,0,1),(366,100,0,0,0,0,1),(367,100,0,0,0,0,1),(368,100,0,0,0,0,1),(369,100,0,0,0,0,1),(370,100,0,0,0,0,1),(371,101,0,0,0,0,1),(372,102,0,0,0,0,1),(373,102,0,0,0,0,1),(374,102,0,0,0,0,1),(375,102,0,0,0,0,1),(376,102,0,0,0,0,1),(377,102,0,0,0,0,1),(378,102,0,0,0,0,1),(379,102,0,0,0,0,1),(380,103,0,0,0,0,1),(381,104,0,0,0,0,1),(382,104,0,0,0,0,1),(383,105,0,0,0,0,1),(384,105,0,0,0,0,1),(385,106,0,0,0,0,1),(386,34,0,0,0,0,1),(387,34,0,0,0,0,1),(388,107,0,0,0,0,1),(389,108,0,0,0,0,1),(390,108,0,0,0,0,1),(391,108,0,0,0,0,1),(392,102,0,0,0,0,1),(393,102,0,0,0,0,1),(394,102,0,0,0,0,1),(395,102,0,0,0,0,1),(396,109,0,0,0,0,1),(397,109,3,0,0,0,1),(398,109,0,0,0,0,1),(399,109,14,0,0,0,1),(400,109,8,0,0,0,1),(401,110,29,0,0,0,1),(402,109,5,0,0,0,1),(403,109,6,0,0,0,1),(404,109,0,0,0,0,1),(405,109,0,0,0,0,1),(406,111,0,0,0,0,1),(407,111,0,0,0,0,1),(408,111,0,0,0,0,1),(409,111,0,0,0,0,1),(410,111,0,0,0,0,1),(411,112,0,0,0,0,1),(412,111,0,0,0,0,1),(413,111,0,0,0,0,1),(414,111,0,0,0,0,1),(415,111,0,0,0,0,1),(416,111,0,0,0,0,1),(417,111,0,0,0,0,1),(418,111,0,0,0,0,1),(419,111,0,0,0,0,1),(420,111,0,0,0,0,1),(421,113,0,0,0,0,1),(422,114,0,0,0,0,1),(423,115,0,0,0,0,1),(424,115,0,0,0,0,1),(425,115,0,0,0,0,1),(426,115,0,0,0,0,1),(427,115,0,0,0,0,1),(428,115,0,0,0,0,1),(429,116,0,0,0,0,1),(430,117,0,0,0,0,1),(431,118,0,0,0,0,1),(432,119,40,0,0,0,1),(433,120,87,0,0,0,1),(434,121,0,0,0,0,1),(435,122,0,0,0,0,1),(436,122,0,0,0,0,1),(437,122,0,0,0,0,1),(438,122,0,0,0,0,1),(439,123,0,0,0,0,1),(440,124,0,0,0,0,1),(441,125,0,0,0,0,1),(442,126,0,0,0,0,1),(443,126,0,0,0,0,1),(444,126,0,0,0,0,1),(445,127,0,0,0,0,1),(446,127,0,0,0,0,1),(447,128,0,0,0,0,1),(448,128,0,0,0,0,1),(449,128,0,0,0,0,1),(450,128,0,0,0,0,1),(451,128,0,0,0,0,1),(452,128,0,0,0,0,1),(453,128,0,0,0,0,1),(454,128,0,0,0,0,1),(455,129,0,0,0,0,1),(456,129,0,0,0,0,1),(458,1,3,0,0,0,1),(459,1,0,0,0,0,1),(488,58,0,0,0,0,1),(513,138,139.330000936985,0,0,1,1),(529,138,0,0,0,1,1),(536,167,-0.0949997901916495,0,0,1,1),(539,138,-0.164941549301263,0,0,1,1),(541,138,0,0,0,1,1),(545,139,6,0,0,0,1),(546,139,6,0,0,0,1),(548,139,6,0,0,0,1),(549,140,5,0,0,0,1),(550,141,0,0,0,0,1),(551,142,0,0,0,0,1),(552,143,0,0,0,0,1),(553,143,0,0,0,0,1),(554,143,0,0,0,0,1),(555,143,0,0,0,0,1),(556,49,0,0,0,0,1),(557,144,19,0,0,0,1),(558,45,0,0,0,0,1),(559,21,0,0,0,0,1),(561,45,1,0,0,0,1),(562,52,1,0,0,0,1),(563,145,0,0,0,0,1),(564,145,0,0,0,0,1),(565,146,8,0,0,0,1),(566,78,4,0,0,0,1),(567,39,5,0,0,0,1),(568,44,2,0,0,0,1),(570,44,5,0,0,0,1),(571,44,0,0,0,0,1),(572,44,2,0,0,0,1),(573,44,0,0,0,0,1),(574,44,0,0,0,0,1),(575,44,4,0,0,0,1),(576,44,2,0,0,0,1),(577,44,2,0,0,0,1),(578,44,1,0,0,0,1),(579,44,0,0,0,0,1),(580,44,0,0,0,0,1),(581,44,4,0,0,0,1),(582,44,1,0,0,0,1),(583,44,12,0,0,0,1),(584,44,4,0,0,0,1),(585,44,5,0,0,0,1),(586,49,1,0,0,0,1),(587,49,0,0,0,0,1),(588,49,0,0,0,0,1),(589,49,3,0,0,0,1),(590,49,0,0,0,0,1),(591,49,1,0,0,0,1),(592,44,0,0,0,0,1),(593,44,0,0,0,0,1),(594,85,0,0,0,0,1),(595,18,0,0,0,0,1),(596,18,0,0,0,0,1),(597,18,2,0,0,0,1),(598,40,1,0,0,0,1),(599,16,0,0,0,0,1),(600,16,3,0,0,0,1),(601,16,1,0,0,0,1),(602,16,1,0,0,0,1),(603,16,4,0,0,0,1),(604,16,0,0,0,0,1),(605,16,0,0,0,0,1),(606,16,0,0,0,0,1),(607,16,0,0,0,0,1),(608,16,2,0,0,0,1),(609,16,1,0,0,0,1),(611,16,11,0,0,0,1),(612,65,1,0,0,0,1),(613,65,2,0,0,0,1),(614,50,2,0,0,0,1),(615,18,1,0,0,0,1),(616,18,0,0,0,0,1),(617,55,2,0,0,0,1),(618,66,5,0,0,0,1),(619,147,1,0,0,0,1),(620,147,9,0,0,0,1),(621,44,0,0,0,0,1),(622,44,0,0,0,0,1),(623,44,1,0,0,0,1),(624,44,3,0,0,0,1),(625,44,2,0,0,0,1),(626,19,11,0,0,0,1),(627,17,1,0,0,0,2),(628,149,6,0,0,0,1),(629,149,6,0,0,0,1),(630,149,1,0,0,0,1),(631,149,2,0,0,0,1),(632,32,0,0,0,0,1),(633,32,6,0,0,0,1),(634,50,4,0,0,0,1),(635,48,4,0,0,0,1),(636,52,1,0,0,0,1),(637,48,1,0,0,0,1),(638,150,1,0,0,0,1),(639,76,6,0,0,0,1),(640,151,1,0,0,0,1),(641,62,1,0,0,0,1),(642,62,1,0,0,0,1),(643,2,0,0,0,0,1),(644,152,1,0,0,0,1),(645,34,22,0,0,0,1),(646,34,11,0,0,0,1),(647,34,6,0,0,0,1),(648,34,0,0,0,0,1),(649,34,6,0,0,0,1),(650,34,4,0,0,0,1),(651,34,5,0,0,0,1),(652,34,10,0,0,0,1),(653,34,14,0,0,0,1),(654,34,12,0,0,0,1),(655,34,7,0,0,0,1),(656,153,1,0,0,0,1),(657,66,10,0,0,0,1),(658,85,5,0,0,0,1),(659,154,2,0,0,0,1),(660,3,0,0,0,0,1),(661,155,2,0,0,0,1),(662,156,1,0,0,0,1),(663,157,8,0,0,0,1),(664,158,6,0,0,0,1),(665,159,0,293,0,0,1),(666,43,1,0,0,0,1),(667,43,0,0,0,0,1),(668,43,1,0,0,0,1),(670,18,2,0,0,0,1),(671,160,1,0,0,0,1),(672,161,21,0,0,0,1),(673,29,5,0,0,0,1),(674,62,2,0,0,0,1),(675,62,2,0,0,0,1),(676,62,1,0,0,0,1),(677,62,1,0,0,0,1),(678,62,0,0,0,0,1),(679,53,2,0,0,0,1),(680,53,5,0,0,0,1),(681,53,4,0,0,0,1),(682,53,4,0,0,0,1),(683,162,0,0,0,0,1),(684,162,0,0,0,0,1),(685,50,4,0,0,0,1),(686,35,2,0,0,0,1),(687,40,5,0,0,0,1),(688,40,4,0,0,0,1),(689,126,13,0,0,0,1),(691,1,6,0,0,0,1),(692,16,2,0,0,0,1),(693,16,0,0,0,0,1),(694,16,2,0,0,0,1),(695,16,1,0,0,0,1),(696,16,2,0,0,0,1),(697,1,7,0,0,0,1),(698,1,5,0,0,0,1),(699,163,5,0,0,0,1),(700,163,3,0,0,0,1),(701,164,1,0,0,0,1),(702,22,5,0,0,0,1),(703,165,8,0,0,0,1),(704,159,140,0,0,0,1),(705,166,7,0,0,0,1),(706,34,20,0,0,0,1),(707,21,9,0,0,0,1),(708,21,0,0,0,0,1),(709,34,20,0,0,0,1),(710,34,18,0,0,0,1),(711,168,5.4449999332428,0,0,1,1),(712,138,0,0,0,1,1),(713,167,0.199999809265137,0,0,1,1),(714,169,8,0,0,0,1),(715,50,4,0,0,0,1),(716,160,18,0,0,0,1),(717,170,0,0,0,0,1),(718,170,2,0,0,0,1),(719,170,1,0,0,0,1),(720,43,14,0,0,0,1),(721,46,45,0,0,0,1),(722,45,44,0,0,0,1),(723,23,21,0,0,0,1),(725,45,0,0,0,0,1),(726,43,0,0,0,0,1),(727,45,1,0,0,0,1),(728,45,1,0,0,0,1),(729,45,1,0,0,0,1),(730,43,1,0,0,0,1),(731,43,2,0,0,0,1),(732,43,1,0,0,0,1),(733,171,1,0,0,1,1),(734,13,11,0,0,0,1),(735,167,0.199999809265137,0,0,1,1);
/*!40000 ALTER TABLE ElPam.`productocom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `subproducto`
--

LOCK TABLES ElPam.`subproducto` WRITE;
/*!40000 ALTER TABLE ElPam.`subproducto` DISABLE KEYS */;
INSERT INTO ElPam.`subproducto` VALUES (514,513),(515,513),(516,513),(517,513),(518,513),(519,513),(520,513),(521,513),(522,513),(524,513),(525,513),(526,513),(527,513),(528,513),(532,513),(533,513),(534,513),(535,513),(538,513),(544,513),(530,529);
/*!40000 ALTER TABLE ElPam.`subproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `movimiento`
--

LOCK TABLES ElPam.`movimiento` WRITE;
/*!40000 ALTER TABLE ElPam.`movimiento` DISABLE KEYS */;
INSERT INTO ElPam.`movimiento` VALUES (1,'j','2011-06-10 10:15:29','','l',1,210,513),(2,'romina','2011-06-10 16:33:05','','abasto',1,315,513),(3,'romina','2011-06-10 16:33:54','','pampita',1,4,708),(4,'romina','2011-06-10 16:35:15','','pampita',1,4,59),(5,'romina','2011-06-10 16:35:51','','pampita',1,5,324),(6,'romina','2011-06-10 16:36:41','Sub Producto (churrasco)','pampita',0,8.39999961853027,513),(7,'romina','2011-06-10 16:44:44','','pampita',1,4,536),(8,'romina','2011-06-10 16:45:48','','pampita',1,10,539),(9,'romina','2011-06-10 16:47:07','','pampita',1,3,707),(10,'romina','2011-06-10 16:49:27','','pampita',1,5,565),(11,'romina','2011-06-10 16:50:27','','pampita',0,8,562),(12,'romina','2011-06-10 16:51:52','','pampita',1,2,562),(13,'romina','2011-06-10 16:54:05','','pampita',1,10,340),(14,'romina','2011-06-10 16:58:22','','pampita',1,4,707),(15,'romina','2011-06-10 17:06:44','','pampita',0,1,559),(16,'romina','2011-06-10 17:07:27','','m',0,2,558),(17,'romi','2011-06-10 17:38:25','','h',0,1,663),(18,'g','2011-06-10 18:15:32','','t',1,6,536),(19,'romina','2011-06-11 08:20:28','','limpieza',0,1,562),(20,'romi','2011-06-11 08:21:11','','limpieza',0,1,210),(21,'romi','2011-06-11 16:29:38','','pam',1,5,707),(22,'rpmi','2011-06-11 16:35:22','','pam',1,2,707),(23,'romi','2011-06-11 16:35:57','','pam',1,6,708),(24,'romi','2011-06-11 17:08:47','','pam',1,8.39999961853027,539),(25,'romi','2011-06-11 17:09:48','Sub Producto (churrasco)','pam',0,5.40000009536743,513),(26,'romi','2011-06-11 17:11:34','','pam',1,75,513),(27,'romi','2011-06-11 18:29:20','','pam',1,20,541),(28,'hgf','2011-06-11 18:39:06','','gukdf',1,7.5,539),(29,'k','2011-06-12 11:06:03','','yu',1,7500,539),(30,'g','2011-06-13 09:03:34','','g',1,1,61),(31,'ju','2011-06-13 09:32:09','','h',1,2,202),(32,'df','2011-06-13 10:14:10','','sd',0,6.90000009536743,539),(33,'g','2011-06-13 10:14:43','','g',0,6.90299987792969,539),(34,'romi','2011-06-13 11:04:20','','abasto',1,330,513),(35,'romi','2011-06-13 11:07:55','','pam',0,5,539),(36,'romi','2011-06-13 11:08:26','','pam',0,100,539),(37,'gfh','2011-06-13 11:08:53','','bgdf',0,6.5,539),(38,'romi','2011-06-13 11:09:31','','pam',0,35,539),(39,'romi','2011-06-13 11:10:02','','pam',0,85,539),(40,'romi','2011-06-13 11:10:41','','pam',0,655,539),(41,'romi','2011-06-13 11:11:29','','pam',0,6,539),(42,'romi','2011-06-13 11:12:45','','pam',0,6.00400018692017,539),(43,'romi','2011-06-13 11:13:22','','pam',0,5.9980001449585,539),(44,'romi','2011-06-13 11:14:08','','pam',0,5.99200010299683,539),(45,'vbxgf','2011-06-13 11:14:49','','dfbd',0,986.302978515625,539),(46,'bn','2011-06-13 11:15:14','','sdhjty',0,5,539),(47,'vn','2011-06-13 11:15:48','','hgj y',0,4.99499988555908,539),(48,'hj78ef','2011-06-13 11:16:17','',',kjfg',0,990.005004882813,539),(49,'bnjty','2011-06-13 11:18:55','','sdfzdr',0,4,539),(50,'f','2011-06-13 11:19:37','','ghh',0,0.995999991893768,539),(51,'ty34576 o','2011-06-13 11:20:15','','er, l',0,995.004028320313,539),(52,'rt7il','2011-06-13 11:20:49','','gfcse.',0,1,539),(53,'fryo','2011-06-13 11:21:17','','fhuxk',0,2.99900007247925,539),(54,'sdthjj','2011-06-13 11:21:41','','xftjl',0,996.0009765625,539),(55,'vhkt','2011-06-13 11:22:21','','hilur',0,0.899999976158142,539),(56,'klhfg','2011-06-13 11:25:45','','hjhfrvkr',0,999.099975585938,539),(57,'dfhy7i','2011-06-13 11:26:06','','hjyutr',0,1,539),(58,'445','2011-06-13 11:26:27','','y6y',0,0.999000012874603,539),(59,'hjr6','2011-06-13 11:26:50','','hyijfg',0,998.0009765625,539),(60,'romi','2011-06-13 15:55:55','','pam',1,2,213),(61,'romi','2011-06-13 15:56:44','','pam',1,3,627),(62,'romi','2011-06-13 15:57:17','','pam',1,2,137),(63,'romi','2011-06-13 15:58:40','','pam',1,4,30),(64,'romi','2011-06-13 15:59:14','','pam',1,2,708),(65,'romi','2011-06-13 16:00:02','','pam',0,5,80),(66,'romi','2011-06-13 16:01:01','','pam',0,12,362),(67,'romi','2011-06-13 16:01:33','','pam',1,1,78),(68,'romi','2011-06-13 16:05:07','','pam',0,163,704),(69,'romi','2011-06-14 10:26:22','','pam',1,20,709),(70,'romi','2011-06-14 10:28:52','','pam',1,20,650),(71,'ROMI','2011-06-14 10:44:00','','PAM',1,20,121),(72,'ROMI','2011-06-14 10:46:17','','PAM',1,20,710),(73,'ROMI','2011-06-14 11:46:08','','PAM',0,16.1499996185303,513),(74,'ROMI','2011-06-14 17:04:59','','PAM',1,8.10000038146973,539),(75,'NMN','2011-06-14 17:08:40','','PAM',1,4.45499992370606,711),(76,'G','2011-06-14 17:16:33','','HY',1,18,356),(77,'HT','2011-06-14 17:17:05','','SEFRE',1,18,357),(78,'romi','2011-06-15 16:23:19','','pam',1,15,289),(79,'romi','2011-06-15 16:23:37','','pam',1,15,340),(80,'romi','2011-06-15 16:27:10','','pam',1,7,30),(81,'gfgh','2011-06-15 16:36:21','','ddf',0,158,665),(82,'hngf','2011-06-15 16:36:43','','fghgf',1,142,665),(83,'nhjfo','2011-06-15 16:43:35','','vgfylp',0,117,704),(84,'piokngh','2011-06-15 16:44:00','','ppmhfg',0,138,665),(85,'romi','2011-06-15 18:21:20','','pam',1,8,539),(86,'fggfh','2011-06-15 18:27:48','','drfgth',0,1,664),(87,'romi','2011-06-16 10:20:13','','pam',1,20,541),(88,'romi','2011-06-16 10:21:11','','pam',1,7,536),(89,'gfgrf','2011-06-16 10:23:38','','dfsdf',1,5,713),(90,'gsdfg','2011-06-16 10:32:43','','sefwe',1,4,60),(91,'romi','2011-06-16 10:55:25','','pam',1,10,351),(92,'ghyg','2011-06-16 11:35:15','','thrh',1,4,708),(93,'romi','2011-06-16 11:42:51','','pam',1,3,76),(94,'romi','2011-06-16 16:37:50','','pam',0,161,513),(95,'romina','2011-06-16 16:38:14','','abasto',1,320,513),(96,'dar','2011-06-16 16:58:36','Sub Producto (Parrillada)','gyert',1,7.40000009536743,513),(97,'the','2011-06-16 17:41:21','','<gsge',1,8,714),(98,'gh','2011-06-16 17:42:08','','dry',1,4,715),(99,'ggr','2011-06-17 10:06:51','','gaweg',0,3.09999990463257,539),(100,'sfs','2011-06-17 11:58:07','','<degf',1,6,400),(101,'scdasf','2011-06-17 11:58:21','','gfwrg',1,6,403),(102,'fvxdfb','2011-06-17 11:58:45','','<sdb',1,12,402),(103,'romina','2011-06-17 16:17:04','','pam 1',1,24,80),(104,'nh','2011-06-17 16:18:34','','shj',0,1,396),(105,'rhy','2011-06-17 16:34:23','','hr',1,3,711),(106,'romi','2011-06-17 18:49:21','','pam',1,340,513),(107,'romi','2011-06-18 09:07:02','','pam',1,19,541),(108,'fsdf','2011-06-18 09:07:44','','sf',1,3.79999995231628,711),(109,'romi','2011-06-18 09:44:30','','para chori',0,15,513),(110,'jkhuisd','2011-06-18 09:45:14','','gfg',1,15,707),(111,'dfhf','2011-06-18 09:45:44','','hyukg',1,4,549),(112,'vfsd','2011-06-18 09:46:21','','gtr',1,180,704),(113,'dv','2011-06-18 10:27:47','','fb',1,22,716),(114,'bzdf','2011-06-18 10:28:49','','dafb',1,9,236),(115,'<gggg','2011-06-18 10:31:50','','geh',1,1,191),(116,'vfbf','2011-06-18 11:15:26','','sdb',1,1,717),(117,'gh','2011-06-18 11:18:08','','jjs',1,2,718),(118,'vbf','2011-06-18 11:19:20','','bf',1,2,719),(119,'dzghzdf','2011-06-18 11:42:54','','try',1,24,720),(120,'ghjk','2011-06-18 11:43:24','','drtj',1,48,721),(121,'u6','2011-06-18 11:43:55','','ryu',1,48,722),(122,'efe','2011-06-18 16:30:08','','gerg',1,7,539),(123,'kkhy','2011-06-18 17:19:42','','lkbg',1,7,539),(124,'bgng','2011-06-18 17:26:50','','nfhxn',0,1,663),(125,'vgffgs','2011-06-18 17:27:18','','gsg',0,1,661),(126,'gh','2011-06-18 20:04:58','','fhj',0,1,210),(127,'h','2011-06-19 09:01:51','','j',1,12.8999996185303,539),(128,'k','2011-06-19 09:03:07','','o',1,5.46000003814697,536),(129,'yj','2011-06-20 09:10:17','','cfh',0,1,611),(130,'ghhuf','2011-06-20 09:38:10','','iohy',1,300,513),(131,'romi','2011-06-20 09:46:32','Sub Producto (churrasco)','para milanesa',0,5,513),(132,'fgr','2011-06-20 16:33:22','','erg',0,1,400),(133,'ftey','2011-06-20 16:34:02','','ryuu',1,4,319),(134,'dtgfr','2011-06-20 16:34:49','','gr',1,2,324),(135,'fwea','2011-06-20 16:35:26','','ewgt',1,4,323),(136,'ggfrg','2011-06-20 16:36:44','','hsdej',1,4,321),(137,'romu','2011-06-20 16:37:48','','pam',1,2,688),(138,'sdfe','2011-06-20 16:38:12','','vfe',1,9,611),(139,'fwe','2011-06-20 16:38:38','','wegfw',1,4,51),(140,'srg','2011-06-20 16:38:54','','deg',1,5,565),(141,'dsfcgt','2011-06-20 16:39:12','','th',1,4,60),(142,'bhnmcgh','2011-06-20 16:40:51','','yjdr',1,24,723),(143,'gn','2011-06-20 16:44:31','','gf',0,3.90000009536743,539),(144,'frg','2011-06-20 16:49:22','','servgrrrrrrrrrrr',0,1,356),(145,'THY','2011-06-20 19:11:11','','YY',1,4.19999980926514,536),(146,'UIY9U8','2011-06-21 08:50:15','','OPU0Y89',0,100,513),(147,'HHJFH','2011-06-21 09:28:50','','DFH',1,5.19999980926514,713),(149,'BVGDF','2011-06-21 11:02:44','','DFGH',1,1,725),(150,'BHGH','2011-06-21 11:06:22','','TH',1,1,726),(151,'FGJ','2011-06-21 11:37:39','','JTR',1,1,727),(152,'TH','2011-06-21 11:38:39','','TYYJ',1,1,728),(153,'HJ','2011-06-21 11:39:38','','JR',1,1,729),(154,'OJUH','2011-06-21 11:43:12','','JKH',1,1,730),(155,'G—','2011-06-21 11:43:59','','IYT',1,1,731),(156,'BC','2011-06-21 11:44:54','','JGIP7I',1,1,732),(157,'MARIA','2011-06-21 11:49:53','','PAMPITA',0,1,679),(158,'MARIA','2011-06-21 12:03:00','','PAMPITA',1,1,731),(159,'TRR','2011-06-21 16:17:50','','RGV',1,360,704),(160,'romi','2011-06-22 11:01:41','','pampita 1',1,4.40000009536743,536),(161,'TERGT','2011-06-23 08:22:07','','GHTEH',0,0,513),(162,'TH','2011-06-23 08:22:53','','H',0,140,513),(163,'ROMI','2011-06-23 09:57:00','','ABASTO',1,80,513),(164,'SAQT5','2011-06-23 16:29:20','','Q6TQ',1,4,536),(165,'HNJF','2011-06-23 17:08:16','','JFJ',1,210,513),(166,'GGGGGGG','2011-06-23 17:32:52','','RGT',1,11,91),(167,'ROMINA','2011-06-24 10:19:45','','TITO',1,10,350),(168,'ROMINA','2011-06-24 16:20:19','','PAM',1,19,541),(169,'NJU','2011-06-24 16:21:57','','J4U6J',0,2,541),(170,'ROMINA','2011-06-24 16:23:38','','ABASTO',1,118,513),(171,'HBVG','2011-06-24 16:29:40','','UHGP',1,60,513),(172,'ROMINA','2011-06-24 16:31:02','Sub Producto (churrasco)','MILAS',0,4,513),(173,'FHYNJ','2011-06-24 16:42:51','','XFJ',0,2.05999994277954,536),(174,'ROMINA','2011-06-24 19:03:49','','PARA CHORIZO',0,11.5,513),(175,'ROMINA','2011-06-24 19:04:14','','ABASTO',1,200,513),(176,'romina','2011-06-25 09:26:18','','butifarra',0,10,513),(177,'romina','2011-06-25 09:29:40','','pam 1',1,6,733),(178,'romina','2011-06-25 10:33:38','','pam 1',1,8.30000019073486,536),(179,'romina','2011-06-25 11:24:38','','limpieza',0,1,210),(180,'ROMINA','2011-06-25 16:26:57','','PAM 1',1,10,539),(181,'XDFVG','2011-06-25 16:27:19','','RSDGH',1,19,541),(182,'YUFYL','2011-06-25 16:29:36','','90U',0,2,713),(183,'TY','2011-06-25 16:44:58','','DRTX',0,0.720000028610229,539),(184,'ROMINA','2011-06-25 18:06:40','Sub Producto (churrasco)','MILAS',0,7,513),(185,'maria','2011-06-27 08:49:01','','pampita',1,5,627),(186,'maria','2011-06-27 08:51:53','','pampita',1,12,66),(187,'maria','2011-06-27 08:55:32','','pampita',1,13,626),(188,'maria','2011-06-27 08:57:31','','pampita',1,5,312),(189,'maria','2011-06-27 08:57:47','','pampita',1,6,310),(190,'maria','2011-06-27 08:58:37','','pampita',1,6,309),(191,'maria','2011-06-27 10:49:41','','pampita',1,2,61),(192,'maria','2011-06-27 16:16:06','','pampita',1,250,513),(193,'maria','2011-06-27 17:45:07','churrasco para milanesa','pampita 2',0,6.1399998664856,513),(194,'maria','2011-06-27 19:24:57','Sub Producto (Picada)','bordenave',0,0.529999971389771,513),(195,'maria','2011-06-27 19:25:48','','bordenave',0,0.949999988079071,513),(196,'maria','2011-06-28 08:59:47','','limpiesa',0,0,209),(197,'maria','2011-06-28 09:00:11','','limieza',0,1,209),(198,'maria','2011-06-28 10:25:42','','pampita',1,6.60500001907349,536),(199,'maria','2011-06-28 11:44:53','','pampita',1,8,734),(200,'maria','2011-06-28 12:14:09','chorizo','pampita2',0,18,513),(201,'maria','2011-06-28 16:53:44','','pampita',1,4,687),(202,'maria','2011-06-28 16:57:14','','pampita',1,3,688),(203,'maria','2011-06-28 17:07:28','','pampita',1,3,137),(204,'maria','2011-06-28 17:33:09','','pampita',1,3,337),(205,'maria','2011-06-28 17:34:27','','pampita',1,6,707),(206,'maria','2011-06-28 17:35:20','','pampita',1,2,209),(207,'maria','2011-06-28 17:35:32','','pampita',1,3,210),(208,'maria','2011-06-28 17:37:27','','pampita',1,2,321),(209,'maria','2011-06-28 17:50:34','','pampita',1,4,539),(210,'maria','2011-06-28 17:52:58','','pampita',1,5.19000005722046,711),(211,'maria','2011-06-28 18:18:44','','salida',0,4,541),(212,'maria','2011-06-29 09:36:54','','pampita',1,5.55499982833862,539),(213,'maria','2011-06-29 16:12:51','','pampita',1,8.19999980926514,735),(214,'m','2011-06-30 10:23:33','','p',1,57,513),(215,'maria','2011-06-30 15:58:36','','pampita',1,219,513),(216,'maria','2011-07-01 16:16:58','','pampita',1,100,513),(217,'maria','2011-07-04 14:12:56','','pampita',1,8,734),(218,'maria','2011-07-04 15:13:49','','pampita',1,4,51),(219,'maria','2011-07-04 15:26:21','','pampita',1,12,91),(220,'maria1','2011-07-04 21:48:39','','pampita',1,6,707),(221,'maria','2011-07-04 21:49:33','','pampita',1,9,362),(222,'maria','2011-07-04 21:59:15','','pampita',1,3,734);
/*!40000 ALTER TABLE ElPam.`movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `factura`
--

LOCK TABLES ElPam.`factura` WRITE;
/*!40000 ALTER TABLE ElPam.`factura` DISABLE KEYS */;
INSERT INTO ElPam.`factura` VALUES (0,'A',1,'2011-06-08',25.9600005507469,0,0,22,118.000002503395,118.000002503395),(1,'A',1,'2011-06-08',31.9000005245209,0,0,22,145.000002384186,145.000002384186),(2,'A',1,'2011-06-08',12.1,0,0,22,55,55),(3,'A',1,'2011-06-08',28.05,0,0,22,127.5,127.5),(4,'A',1,'2011-06-08',24.090000629425,0,0,22,109.500002861023,109.500002861023),(5,'A',1,'2011-06-08',8.78899997770786,0,0,22,39.9499998986721,39.9499998986721),(6,'A',1,'2011-06-08',13.2,0,0,22,60,60),(7,'A',1,'2011-06-08',13.2,0,0,22,60,60),(8,'A',1,'2011-06-08',107.458997702599,0,0,22,488.449989557266,488.449989557266),(9,'A',1,'2011-06-08',36.1900004982948,0,0,22,164.500002264977,164.500002264977),(10,'A',1,'2011-06-08',12.1,0,0,22,55,55),(11,'A',1,'2011-06-08',19.7999994754791,0,0,22,89.9999976158142,89.9999976158142),(12,'A',1,'2011-06-08',4.84000007212162,0,0,22,22.0000003278256,22.0000003278256),(13,'A',1,'2011-06-08',12.1,0,0,22,55,55),(14,'A',1,'2011-06-08',13.2,0,0,22,60,60),(15,'A',1,'2011-06-08',29.5019992184639,0,0,22,134.099996447563,134.099996447563),(16,'A',1,'2011-06-08',12.1,0,0,22,55,55),(17,'A',1,'2011-06-08',18.4799996852875,0,0,22,83.9999985694885,83.9999985694885),(18,'A',1,'2011-06-08',13.0899997770786,0,0,22,59.499998986721,59.499998986721),(19,'A',1,'2011-06-08',19.3049992918968,0,0,22,87.7499967813492,87.7499967813492),(20,'A',1,'2011-06-08',13.2,0,0,22,60,60),(21,'A',1,'2011-06-08',5.44499985575676,0,0,22,24.7499993443489,24.7499993443489),(22,'A',1,'2011-06-08',26.4,0,0,22,120,120),(23,'A',1,'2011-06-08',12.1,0,0,22,55,55),(24,'A',1,'2011-06-08',1.54,0,0,22,7,7),(25,'A',1,'2011-06-08',13.007500576973,0,0,22,59.1250026226044,59.1250026226044),(26,'A',1,'2011-06-08',19.7999994754791,0,0,22,89.9999976158142,89.9999976158142),(27,'A',1,'2011-06-08',18.7,0,0,22,85,85),(28,'A',1,'2011-06-08',18.7,0,0,22,85,85),(29,'A',1,'2011-06-08',10.4499998688698,0,0,22,47.4999994039535,47.4999994039535),(30,'A',1,'2011-06-08',9.581000238657,0,0,22,43.5500010848045,43.5500010848045),(31,'A',1,'2011-06-08',34.5950004458428,0,0,22,157.250002026558,157.250002026558),(32,'A',1,'2011-06-08',11.4070002675056,0,0,22,51.8500012159348,51.8500012159348),(33,'A',1,'2011-06-08',14.8665003120899,0,0,22,67.5750014185905,67.5750014185905),(34,'A',1,'2011-06-08',6.05,0,0,22,27.5,27.5),(35,'A',1,'2011-06-08',24.3375003933907,0,0,22,110.625001788139,110.625001788139),(36,'A',1,'2011-06-08',74.6350008130074,0,0,22,339.250003695488,339.250003695488),(37,'A',1,'2011-06-08',28.1984995961189,0,0,22,128.174998164177,128.174998164177),(38,'A',1,'2011-06-08',46.3980004668236,0,0,22,210.900002121925,210.900002121925),(39,'A',1,'2011-06-08',8.36,0,0,22,38,38),(40,'A',1,'2011-06-08',48.6200007867813,0,0,22,221.000003576279,221.000003576279),(41,'A',1,'2011-06-08',23.7600004196167,0,0,22,108.000001907349,108.000001907349),(42,'A',1,'2011-06-08',26.4,0,0,22,120,120),(43,'A',1,'2011-06-08',24.2,0,0,22,110,110),(44,'A',1,'2011-06-08',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(45,'A',1,'2011-06-08',13.2000001966953,0,0,22,60.0000008940697,60.0000008940697),(46,'A',1,'2011-06-08',46.0129981327057,0,0,22,209.149991512299,209.149991512299),(47,'A',1,'2011-06-08',24.9699997901917,0,0,22,113.499999046326,113.499999046326),(48,'A',1,'2011-06-08',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(49,'A',1,'2011-06-08',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(50,'A',1,'2011-06-08',26.2570009231567,0,0,22,119.350004196167,119.350004196167),(51,'A',1,'2011-06-08',8.71200034618378,0,0,22,39.6000015735626,39.6000015735626),(52,'A',1,'2011-06-08',20.9,0,0,22,95,95),(53,'A',1,'2011-06-08',26.4,0,0,22,120,120),(54,'A',1,'2011-06-08',24.2,0,0,22,110,110),(55,'A',1,'2011-06-08',12.1,0,0,22,55,55),(56,'A',1,'2011-06-08',37.4000005245209,0,0,22,170.000002384186,170.000002384186),(57,'A',1,'2011-06-08',1.1,0,0,22,5,5),(58,'A',1,'2011-06-08',36.3660000681877,0,0,22,165.300000309944,165.300000309944),(59,'A',1,'2011-06-08',1.54,0,0,22,7,7),(60,'A',1,'2011-06-08',6.07200011014938,0,0,22,27.600000500679,27.600000500679),(61,'A',1,'2011-06-08',25.7399993181229,0,0,22,116.999996900558,116.999996900558),(62,'A',1,'2011-06-08',5.14250014424324,0,0,22,23.3750006556511,23.3750006556511),(63,'A',1,'2011-06-08',22.3630010962486,0,0,22,101.650004982948,101.650004982948),(64,'A',1,'2011-06-08',11.2530000865459,0,0,22,51.1500003933907,51.1500003933907),(65,'A',1,'2011-06-08',35.0900011539459,0,0,22,159.500005245209,159.500005245209),(66,'A',1,'2011-06-08',14.7399997770786,0,0,22,66.999998986721,66.999998986721),(67,'A',1,'2011-06-08',39.38,0,0,22,179,179),(68,'A',1,'2011-06-08',6.16,0,0,22,28,28),(69,'A',1,'2011-06-08',17.6000002622604,0,0,22,80.0000011920929,80.0000011920929),(70,'A',1,'2011-06-08',40.9200000524521,0,0,22,186.000000238419,186.000000238419),(71,'A',1,'2011-06-08',25.3,0,0,22,115,115),(72,'A',1,'2011-06-08',37.8455007553101,0,0,22,172.025003433228,172.025003433228),(73,'A',1,'2011-06-08',39.6,0,0,22,180,180),(74,'A',1,'2011-06-08',13.112000195384,0,0,22,59.6000008881092,59.6000008881092),(75,'A',1,'2011-06-08',12.0120003461838,0,0,22,54.6000015735626,54.6000015735626),(76,'A',1,'2011-06-08',79.7939989089966,0,0,22,362.699995040894,362.699995040894),(77,'A',1,'2011-06-08',32.12,0,0,22,146,146),(78,'A',1,'2011-06-09',24.2,0,0,22,110,110),(79,'A',1,'2011-06-09',26.4,0,0,22,120,120),(80,'A',1,'2011-06-09',27.5,0,0,22,125,125),(81,'A',1,'2011-06-09',34.6896003031731,0,0,22,157.680001378059,157.680001378059),(82,'A',1,'2011-06-09',24.2,0,0,22,110,110),(83,'A',1,'2011-06-09',37.4440001547337,0,0,22,170.200000703335,170.200000703335),(84,'A',1,'2011-06-09',19.58,0,0,22,89,89),(85,'A',1,'2011-06-09',6.6,0,0,22,30,30),(86,'A',1,'2011-06-09',26.4,0,0,22,120,120),(87,'A',1,'2011-06-09',24.2,0,0,22,110,110),(88,'A',1,'2011-06-09',121.385000681877,0,0,22,551.750003099442,551.750003099442),(89,'A',1,'2011-06-09',39.6055009126663,0,0,22,180.025004148483,180.025004148483),(90,'A',1,'2011-06-09',26.0700012588501,0,0,22,118.500005722046,118.500005722046),(91,'A',1,'2011-06-09',7.26,0,0,22,33,33),(92,'A',1,'2011-06-09',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(93,'A',1,'2011-06-09',16.3019997954369,0,0,22,74.0999990701675,74.0999990701675),(94,'A',1,'2011-06-09',5.5,0,0,22,25,25),(95,'A',1,'2011-06-09',29.04,0,0,22,132,132),(96,'A',1,'2011-06-09',32.78,0,0,22,149,149),(97,'A',1,'2011-06-09',18.92,0,0,22,86,86),(98,'A',1,'2011-06-09',33,0,0,22,150,150),(99,'A',1,'2011-06-09',7.92,0,0,22,36,36),(100,'A',1,'2011-06-09',22.0000003278256,0,0,22,100.000001490116,100.000001490116),(101,'A',1,'2011-06-09',13.2,0,0,22,60,60),(102,'A',1,'2011-06-09',231.110004878044,0,0,22,1050.50002217293,1050.50002217293),(103,'A',1,'2011-06-09',19.8,0,0,22,90,90),(104,'A',1,'2011-06-09',5.28,0,0,22,24,24),(105,'A',1,'2011-06-09',3.52,0,0,22,16,16),(106,'A',1,'2011-06-09',5.94,0,0,22,27,27),(107,'A',1,'2011-06-10',199.627998919487,0,0,22,907.399995088577,907.399995088577),(108,'A',1,'2011-06-10',208.929598224759,0,0,22,949.679991930723,949.679991930723),(109,'A',1,'2011-06-10',218.988001358509,0,0,22,995.400006175041,995.400006175041),(110,'A',1,'2011-06-10',255.475004825592,0,0,22,1161.25002193451,1161.25002193451),(111,'A',1,'2011-06-10',518.839200396538,0,0,22,2358.36000180244,2358.36000180244),(112,'A',1,'2011-06-10',449.229003223181,0,0,22,2041.95001465082,2041.95001465082),(113,'A',1,'2011-06-10',295.32799417913,0,0,22,1342.3999735415,1342.3999735415),(114,'A',1,'2011-06-10',37.4,0,0,22,170,170),(115,'A',1,'2011-06-10',19.6350003540516,0,0,22,89.2500016093254,89.2500016093254),(116,'A',1,'2011-06-10',9.9,0,0,22,45,45),(117,'A',1,'2011-06-10',84.2599996852875,0,0,22,382.999998569489,382.999998569489),(118,'A',1,'2011-06-10',22.726000841856,0,0,22,103.300003826618,103.300003826618),(119,'A',1,'2011-06-10',12.98,0,0,22,59,59),(120,'A',1,'2011-06-10',59.5320009231567,0,0,22,270.600004196167,270.600004196167),(121,'A',1,'2011-06-10',26.620000576973,0,0,22,121.000002622604,121.000002622604),(122,'A',1,'2011-06-10',99.0714980435371,0,0,22,450.324991106987,450.324991106987),(123,'A',1,'2011-06-10',9.625,0,0,22,43.75,43.75),(124,'A',1,'2011-06-10',10.8679998636246,0,0,22,49.3999993801117,49.3999993801117),(125,'A',1,'2011-06-10',21.5600004196167,0,0,22,98.0000019073486,98.0000019073486),(126,'A',1,'2011-06-10',73.4667989373207,0,0,22,333.93999516964,333.93999516964),(127,'A',1,'2011-06-10',45.8699995279312,0,0,22,208.499997854233,208.499997854233),(128,'A',1,'2011-06-10',41.4040010988712,0,0,22,188.200004994869,188.200004994869),(129,'A',1,'2011-06-10',132.010998153687,0,0,22,600.049991607666,600.049991607666),(130,'A',1,'2011-06-10',19.9649997115135,0,0,22,90.7499986886978,90.7499986886978),(131,'A',1,'2011-06-10',57.200000629425,0,0,22,260.000002861023,260.000002861023),(132,'A',1,'2011-06-10',25.718000125885,0,0,22,116.900000572205,116.900000572205),(133,'A',1,'2011-06-10',16.1589999318123,0,0,22,73.4499996900558,73.4499996900558),(134,'A',1,'2011-06-10',12.1,0,0,22,55,55),(135,'A',1,'2011-06-10',3.3,0,0,22,15,15),(136,'A',1,'2011-06-10',65.56,0,0,22,298,298),(137,'A',1,'2011-06-10',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(138,'A',1,'2011-06-10',10.5600001573563,0,0,22,48.0000007152557,48.0000007152557),(139,'A',1,'2011-06-10',13.595999622345,0,0,22,61.7999982833862,61.7999982833862),(140,'A',1,'2011-06-10',17.16,0,0,22,78,78),(141,'A',1,'2011-06-10',26.4,0,0,22,120,120),(142,'A',1,'2011-06-10',50.599999423027,0,0,22,229.999997377396,229.999997377396),(143,'A',1,'2011-06-10',16.7199996328354,0,0,22,75.99999833107,75.99999833107),(144,'A',1,'2011-06-10',56.1000015735626,0,0,22,255.000007152557,255.000007152557),(145,'A',1,'2011-06-10',29.0400011539459,0,0,22,132.000005245209,132.000005245209),(146,'A',1,'2011-06-10',30.8,0,0,22,140,140),(147,'A',1,'2011-06-10',20.3279993653297,0,0,22,92.3999971151352,92.3999971151352),(148,'A',1,'2011-06-10',1.54,0,0,22,7,7),(149,'A',1,'2011-06-10',60.3350011014938,0,0,22,274.25000500679,274.25000500679),(150,'A',1,'2011-06-10',111.096698718071,0,0,22,504.98499417305,504.98499417305),(151,'A',1,'2011-06-10',21.4401005601883,0,0,22,97.4550025463104,97.4550025463104),(152,'A',1,'2011-06-10',9.075,0,0,22,41.25,41.25),(153,'A',1,'2011-06-10',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(154,'A',1,'2011-06-10',149.071996307373,0,0,22,677.599983215332,677.599983215332),(155,'A',1,'2011-06-10',21.964800453186,0,0,22,99.8400020599365,99.8400020599365),(156,'A',1,'2011-06-10',40.9584998846054,0,0,22,186.174999475479,186.174999475479),(157,'A',1,'2011-06-10',14.1900002360344,0,0,22,64.5000010728836,64.5000010728836),(158,'A',1,'2011-06-10',61.9630004668236,0,0,22,281.650002121925,281.650002121925),(159,'A',1,'2011-06-10',58.87200050354,0,0,22,267.600002288818,267.600002288818),(160,'A',1,'2011-06-10',57.8600006818771,0,0,22,263.000003099442,263.000003099442),(161,'A',1,'2011-06-10',3.08,0,0,22,14,14),(162,'A',1,'2011-06-10',45.0009997665882,0,0,22,204.549998939037,204.549998939037),(163,'A',1,'2011-06-10',47.7180004668236,0,0,22,216.900002121925,216.900002121925),(164,'A',1,'2011-06-10',33.8800005245209,0,0,22,154.000002384186,154.000002384186),(165,'A',1,'2011-06-10',17.6000002622604,0,0,22,80.0000011920929,80.0000011920929),(166,'A',1,'2011-06-10',87.2575020194054,0,0,22,396.625009179115,396.625009179115),(167,'A',1,'2011-06-10',7.65599977970123,0,0,22,34.799998998642,34.799998998642),(168,'A',1,'2011-06-10',17.9850005507469,0,0,22,81.7500025033951,81.7500025033951),(169,'A',1,'2011-06-10',6.16,0,0,22,28,28),(170,'A',1,'2011-06-10',19.8769997954369,0,0,22,90.3499990701675,90.3499990701675),(171,'A',1,'2011-06-10',28.7760008811951,0,0,22,130.800004005432,130.800004005432),(172,'A',1,'2011-06-10',19.58,0,0,22,89,89),(173,'A',1,'2011-06-10',119.789996013641,0,0,22,544.499981880188,544.499981880188),(174,'A',1,'2011-06-10',2.42,0,0,22,11,11),(175,'A',1,'2011-06-11',34.265,0,0,22,155.75,155.75),(176,'A',1,'2011-06-11',52.8,0,0,22,240,240),(177,'A',1,'2011-06-11',22.9294997692108,0,0,22,104.224998950958,104.224998950958),(178,'A',1,'2011-06-11',104.357000398636,0,0,22,474.350001811981,474.350001811981),(179,'A',1,'2011-06-11',48.4,0,0,22,220,220),(180,'A',1,'2011-06-11',27.4119995331764,0,0,22,124.599997878075,124.599997878075),(181,'A',1,'2011-06-11',6.16,0,0,22,28,28),(182,'A',1,'2011-06-11',24.2000005245209,0,0,22,110.000002384186,110.000002384186),(183,'A',1,'2011-06-11',55.5004991030693,0,0,22,252.274995923042,252.274995923042),(184,'A',1,'2011-06-11',23.6500010490417,0,0,22,107.500004768372,107.500004768372),(185,'A',1,'2011-06-11',49.7199997901917,0,0,22,225.999999046326,225.999999046326),(186,'A',1,'2011-06-11',24.1340006923676,0,0,22,109.700003147125,109.700003147125),(187,'A',1,'2011-06-11',42.4886014938354,0,0,22,193.130006790161,193.130006790161),(188,'A',1,'2011-06-11',30.3159983634949,0,0,22,137.79999256134,137.79999256134),(189,'A',1,'2011-06-11',26.4,0,0,22,120,120),(190,'A',1,'2011-06-11',63.7450018882752,0,0,22,289.750008583069,289.750008583069),(191,'A',1,'2011-06-11',52.9979993391037,0,0,22,240.899996995926,240.899996995926),(192,'A',1,'2011-06-11',5.5,0,0,22,25,25),(193,'A',1,'2011-06-11',6.6,0,0,22,30,30),(194,'A',1,'2011-06-11',39.7925001442432,0,0,22,180.875000655651,180.875000655651),(195,'A',1,'2011-06-11',34.32,0,0,22,156,156),(196,'A',1,'2011-06-11',7.7,0,0,22,35,35),(197,'A',1,'2011-06-11',67.8150022029877,0,0,22,308.25001001358,308.25001001358),(198,'A',1,'2011-06-11',14.4265006923676,0,0,22,65.5750031471252,65.5750031471252),(199,'A',1,'2011-06-11',9.90000039339066,0,0,22,45.0000017881393,45.0000017881393),(200,'A',1,'2011-06-11',80.7894988775253,0,0,22,367.224994897842,367.224994897842),(201,'A',1,'2011-06-11',61.7671998667717,0,0,22,280.759999394417,280.759999394417),(202,'A',1,'2011-06-11',61.7539998662472,0,0,22,280.699999392033,280.699999392033),(203,'A',1,'2011-06-11',14.52,0,0,22,66,66),(204,'A',1,'2011-06-11',43.5599988460541,0,0,22,197.999994754791,197.999994754791),(205,'A',1,'2011-06-11',160.665999622345,0,0,22,730.299998283386,730.299998283386),(206,'A',1,'2011-06-11',54.5644009923935,0,0,22,248.020004510879,248.020004510879),(207,'A',1,'2011-06-11',9.24,0,0,22,42,42),(208,'A',1,'2011-06-11',78.9800023078918,0,0,22,359.000010490417,359.000010490417),(209,'A',1,'2011-06-11',115.629798879623,0,0,22,525.589994907379,525.589994907379),(210,'A',1,'2011-06-11',132.626997894049,0,0,22,602.849990427494,602.849990427494),(211,'A',1,'2011-06-11',416.765807812214,0,0,22,1894.39003551006,1894.39003551006),(212,'A',1,'2011-06-11',143.829402303696,0,0,22,653.770010471344,653.770010471344),(213,'A',1,'2011-06-11',210.517995903492,0,0,22,956.899981379509,956.899981379509),(214,'A',1,'2011-06-11',264.494999790192,0,0,22,1202.24999904633,1202.24999904633),(215,'A',1,'2011-06-11',23.32,0,0,22,106,106),(216,'A',1,'2011-06-11',219.714006252289,0,0,22,998.700028419495,998.700028419495),(217,'A',1,'2011-06-11',24.64,0,0,22,112,112),(218,'A',1,'2011-06-11',12.7599996328354,0,0,22,57.99999833107,57.99999833107),(219,'A',1,'2011-06-11',97.020002412796,0,0,22,441.000010967255,441.000010967255),(220,'A',1,'2011-06-11',27.417499423027,0,0,22,124.624997377396,124.624997377396),(221,'A',1,'2011-06-11',9.9,0,0,22,45,45),(222,'A',1,'2011-06-11',3.52,0,0,22,16,16),(223,'A',1,'2011-06-11',16.94,0,0,22,77,77),(224,'A',1,'2011-06-11',50.137999522686,0,0,22,227.899997830391,227.899997830391),(225,'A',1,'2011-06-11',24.1999998426437,0,0,22,109.999999284744,109.999999284744),(226,'A',1,'2011-06-11',27.719999370575,0,0,22,125.999997138977,125.999997138977),(227,'A',1,'2011-06-11',27.2799991607666,0,0,22,123.999996185303,123.999996185303),(228,'A',1,'2011-06-11',25.0799996852875,0,0,22,113.999998569489,113.999998569489),(229,'A',1,'2011-06-11',27.2799991607666,0,0,22,123.999996185303,123.999996185303),(230,'A',1,'2011-06-11',56.9140002727509,0,0,22,258.700001239777,258.700001239777),(231,'A',1,'2011-06-11',58.0800023078918,0,0,22,264.000010490417,264.000010490417),(232,'A',1,'2011-06-11',24.7499993443489,0,0,22,112.499997019768,112.499997019768),(233,'A',1,'2011-06-11',174.873602267504,0,0,22,794.880010306835,794.880010306835),(234,'A',1,'2011-06-11',124.190000839233,0,0,22,564.500003814697,564.500003814697),(235,'A',1,'2011-06-11',348.546003818512,0,0,22,1584.30001735687,1584.30001735687),(236,'A',1,'2011-06-11',182.725403184891,0,0,22,830.570014476776,830.570014476776),(237,'A',1,'2011-06-11',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(238,'A',1,'2011-06-11',21.5380004668236,0,0,22,97.9000021219254,97.9000021219254),(239,'A',1,'2011-06-11',95.2159982323646,0,0,22,432.799991965294,432.799991965294),(240,'A',1,'2011-06-11',43.56,0,0,22,198,198),(241,'A',1,'2011-06-11',47.1899993181229,0,0,22,214.499996900558,214.499996900558),(242,'A',1,'2011-06-11',19.8,0,0,22,90,90),(243,'A',1,'2011-06-12',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(244,'A',1,'2011-06-12',3.3,0,0,22,15,15),(245,'A',1,'2011-06-12',41.9407998919487,0,0,22,190.639999508858,190.639999508858),(246,'A',1,'2011-06-12',20.02,0,0,22,91,91),(247,'A',1,'2011-06-12',19.7042993307114,0,0,22,89.5649969577789,89.5649969577789),(248,'A',1,'2011-06-12',5.72,0,0,22,26,26),(249,'A',1,'2011-06-12',20.625,0,0,22,93.75,93.75),(250,'A',1,'2011-06-12',17.38,0,0,22,79,79),(251,'A',1,'2011-06-12',1.76,0,0,22,8,8),(252,'A',1,'2011-06-12',6.6,0,0,22,30,30),(253,'A',1,'2011-06-12',530.099473778009,0,0,22,2409.54306262732,2409.54306262732),(254,'A',1,'2011-06-12',16868.6414950395,0,0,22,76675.6431592703,76675.6431592703),(255,'A',1,'2011-06-12',341.410304303169,0,0,22,1551.86501955986,1551.86501955986),(256,'A',1,'2011-06-12',255.44750099659,0,0,22,1161.12500452995,1161.12500452995),(257,'A',1,'2011-06-12',187.861297552586,0,0,22,853.914988875389,853.914988875389),(258,'A',1,'2011-06-12',977.899989876747,0,0,22,4444.99995398521,4444.99995398521),(259,'A',1,'2011-06-13',17.1214995384216,0,0,22,77.8249979019165,77.8249979019165),(260,'A',1,'2011-06-13',21.8317001867294,0,0,22,99.2350008487701,99.2350008487701),(261,'A',1,'2011-06-13',40.3270997524262,0,0,22,183.304998874664,183.304998874664),(262,'A',1,'2011-06-13',20.0859995961189,0,0,22,91.299998164177,91.299998164177),(263,'A',1,'2011-06-13',18.0785001993179,0,0,22,82.1750009059906,82.1750009059906),(264,'A',1,'2011-06-13',26.4,0,0,22,120,120),(265,'A',1,'2011-06-13',24.5629996538162,0,0,22,111.649998426437,111.649998426437),(266,'A',1,'2011-06-13',21.9626005470753,0,0,22,99.8300024867058,99.8300024867058),(267,'A',1,'2011-06-13',35.0812007033825,0,0,22,159.460003197193,159.460003197193),(268,'A',1,'2011-06-13',41.3941000592709,0,0,22,188.155000269413,188.155000269413),(269,'A',1,'2011-06-13',33.3959998846054,0,0,22,151.799999475479,151.799999475479),(270,'A',1,'2011-06-13',37.4219992184639,0,0,22,170.099996447563,170.099996447563),(271,'A',1,'2011-06-13',25.1679990768433,0,0,22,114.399995803833,114.399995803833),(272,'A',1,'2011-06-13',24.6707998132706,0,0,22,112.13999915123,112.13999915123),(273,'A',1,'2011-06-13',26.4,0,0,22,120,120),(274,'A',1,'2011-06-13',195.590998442173,0,0,22,889.049992918968,889.049992918968),(275,'A',1,'2011-06-13',19.8549997508526,0,0,22,90.2499988675117,90.2499988675117),(276,'A',1,'2011-06-13',31.3499996066093,0,0,22,142.499998211861,142.499998211861),(277,'A',1,'2011-06-13',11.1605998599529,0,0,22,50.7299993634224,50.7299993634224),(278,'A',1,'2011-06-13',16.5,0,0,22,75,75),(279,'A',1,'2011-06-13',26.4000010490417,0,0,22,120.000004768372,120.000004768372),(280,'A',1,'2011-06-13',38.5,0,0,22,175,175),(281,'A',1,'2011-06-13',172.1741994524,0,0,22,782.60999751091,782.60999751091),(282,'A',1,'2011-06-13',6.41299965381622,0,0,22,29.1499984264374,29.1499984264374),(283,'A',1,'2011-06-13',61.8221983194351,0,0,22,281.009992361069,281.009992361069),(284,'A',1,'2011-06-13',21.8317001867294,0,0,22,99.2350008487701,99.2350008487701),(285,'A',1,'2011-06-13',19.9980005323887,0,0,22,90.9000024199486,90.9000024199486),(286,'A',1,'2011-06-13',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(287,'A',1,'2011-06-13',6.65500014424324,0,0,22,30.2500006556511,30.2500006556511),(288,'A',1,'2011-06-13',27.94,0,0,22,127,127),(289,'A',1,'2011-06-13',36.6300004720688,0,0,22,166.500002145767,166.500002145767),(290,'A',1,'2011-06-13',22.1759998977184,0,0,22,100.799999535084,100.799999535084),(291,'A',1,'2011-06-13',43.4995003461838,0,0,22,197.725001573563,197.725001573563),(292,'A',1,'2011-06-13',4.50340008169413,0,0,22,20.4700003713369,20.4700003713369),(293,'A',1,'2011-06-13',7.26000015735626,0,0,22,33.0000007152557,33.0000007152557),(294,'A',1,'2011-06-13',51.5570000576973,0,0,22,234.35000026226,234.35000026226),(295,'A',1,'2011-06-13',35.7499986886978,0,0,22,162.499994039536,162.499994039536),(296,'A',1,'2011-06-13',15.3999997901916,0,0,22,69.9999990463257,69.9999990463257),(297,'A',1,'2011-06-13',6.6,0,0,22,30,30),(298,'A',1,'2011-06-13',70.84,0,0,22,322,322),(299,'A',1,'2011-06-13',29.4800007343292,0,0,22,134.00000333786,134.00000333786),(300,'A',1,'2011-06-13',12.1,0,0,22,55,55),(301,'A',1,'2011-06-13',23.1825000786781,0,0,22,105.375000357628,105.375000357628),(302,'A',1,'2011-06-13',50.8199976921082,0,0,22,230.999989509583,230.999989509583),(303,'A',1,'2011-06-13',25.5199997901917,0,0,22,115.999999046326,115.999999046326),(304,'A',1,'2011-06-13',78.4080002307892,0,0,22,356.400001049042,356.400001049042),(305,'A',1,'2011-06-13',19.3600001966953,0,0,22,88.0000008940697,88.0000008940697),(306,'A',1,'2011-06-13',10.7690002334118,0,0,22,48.9500010609627,48.9500010609627),(307,'A',1,'2011-06-13',12.1,0,0,22,55,55),(308,'A',1,'2011-06-13',10.9648000466824,0,0,22,49.8400002121925,49.8400002121925),(309,'A',1,'2011-06-13',14.74,0,0,22,67,67),(310,'A',1,'2011-06-13',11.2860004484653,0,0,22,51.3000020384789,51.3000020384789),(311,'A',1,'2011-06-13',44.5500007867813,0,0,22,202.500003576279,202.500003576279),(312,'A',1,'2011-06-13',52.8,0,0,22,240,240),(313,'A',1,'2011-06-13',9.3720001167059,0,0,22,42.6000005304813,42.6000005304813),(314,'A',1,'2011-06-13',27.3899994492531,0,0,22,124.499997496605,124.499997496605),(315,'A',1,'2011-06-13',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(316,'A',1,'2011-06-13',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(317,'A',1,'2011-06-13',26.0700007081032,0,0,22,118.500003218651,118.500003218651),(318,'A',1,'2011-06-13',19.8,0,0,22,90,90),(319,'A',1,'2011-06-13',24.7499993443489,0,0,22,112.499997019768,112.499997019768),(320,'A',1,'2011-06-13',23.9799996852875,0,0,22,108.999998569489,108.999998569489),(321,'A',1,'2011-06-13',9.20259997665882,0,0,22,41.8299998939037,41.8299998939037),(322,'A',1,'2011-06-13',23.7600009441376,0,0,22,108.000004291534,108.000004291534),(323,'A',1,'2011-06-13',20.9549996852875,0,0,22,95.2499985694885,95.2499985694885),(324,'A',1,'2011-06-13',20.4159994125366,0,0,22,92.7999973297119,92.7999973297119),(325,'A',1,'2011-06-13',71.770598692894,0,0,22,326.229994058609,326.229994058609),(326,'A',1,'2011-06-13',224.334011077881,0,0,22,1019.700050354,1019.700050354),(327,'A',1,'2011-06-13',26.620000576973,0,0,22,121.000002622604,121.000002622604),(328,'A',1,'2011-06-13',1.54,0,0,22,7,7),(329,'A',1,'2011-06-14',3.3,0,0,22,15,15),(330,'A',1,'2011-06-14',12.6444994807243,0,0,22,57.4749976396561,57.4749976396561),(331,'A',1,'2011-06-14',6.86399974822998,0,0,22,31.1999988555908,31.1999988555908),(332,'A',1,'2011-06-14',30.1531992530823,0,0,22,137.059996604919,137.059996604919),(333,'A',1,'2011-06-14',108.377496957779,0,0,22,492.624986171722,492.624986171722),(334,'A',1,'2011-06-14',175.862500786781,0,0,22,799.375003576279,799.375003576279),(335,'A',1,'2011-06-14',30.095999622345,0,0,22,136.799998283386,136.799998283386),(336,'A',1,'2011-06-14',38.5561002087593,0,0,22,175.255000948906,175.255000948906),(337,'A',1,'2011-06-14',13.3100002884865,0,0,22,60.5000013113022,60.5000013113022),(338,'A',1,'2011-06-14',6.71550008654594,0,0,22,30.5250003933907,30.5250003933907),(339,'A',1,'2011-06-14',38.1479994177818,0,0,22,173.399997353554,173.399997353554),(340,'A',1,'2011-06-14',106.842999076843,0,0,22,485.649995803833,485.649995803833),(341,'A',1,'2011-06-14',26.9609992027283,0,0,22,122.549996376038,122.549996376038),(342,'A',1,'2011-06-14',144.76,0,0,22,658,658),(343,'A',1,'2011-06-14',70.7025,0,0,22,321.375,321.375),(344,'A',1,'2011-06-14',22.082500576973,0,0,22,100.375002622604,100.375002622604),(345,'A',1,'2011-06-14',62.7000007081032,0,0,22,285.000003218651,285.000003218651),(346,'A',1,'2011-06-14',24.7720009231567,0,0,22,112.600004196167,112.600004196167),(347,'A',1,'2011-06-14',147.111800091267,0,0,22,668.690000414848,668.690000414848),(348,'A',1,'2011-06-14',11.4949998557568,0,0,22,52.2499993443489,52.2499993443489),(349,'A',1,'2011-06-14',26.237200653553,0,0,22,119.260002970695,119.260002970695),(350,'A',1,'2011-06-14',43.1199997901916,0,0,22,195.999999046326,195.999999046326),(351,'A',1,'2011-06-14',4.18,0,0,22,19,19),(352,'A',1,'2011-06-14',23.4332999837399,0,0,22,106.51499992609,106.51499992609),(353,'A',1,'2011-06-14',430.055984503031,0,0,22,1954.79992955923,1954.79992955923),(354,'A',1,'2011-06-14',95.0400026226044,0,0,22,432.000011920929,432.000011920929),(355,'A',1,'2011-06-14',13.3859003734589,0,0,22,60.8450016975403,60.8450016975403),(356,'A',1,'2011-06-14',11.2530000865459,0,0,22,51.1500003933907,51.1500003933907),(357,'A',1,'2011-06-14',24.2,0,0,22,110,110),(358,'A',1,'2011-06-14',11.4950002491474,0,0,22,52.2500011324883,52.2500011324883),(359,'A',1,'2011-06-14',11.7370003461838,0,0,22,53.3500015735626,53.3500015735626),(360,'A',1,'2011-06-14',22.769999396801,0,0,22,103.499997258186,103.499997258186),(361,'A',1,'2011-06-14',33.1649985969067,0,0,22,150.749993622303,150.749993622303),(362,'A',1,'2011-06-14',12.1,0,0,22,55,55),(363,'A',1,'2011-06-14',9.23999979346991,0,0,22,41.9999990612268,41.9999990612268),(364,'A',1,'2011-06-14',38.3515007972717,0,0,22,174.325003623962,174.325003623962),(365,'A',1,'2011-06-14',22.99,0,0,22,104.5,104.5),(366,'A',1,'2011-06-14',11.3520001888275,0,0,22,51.6000008583069,51.6000008583069),(367,'A',1,'2011-06-14',30.3599998950958,0,0,22,137.999999523163,137.999999523163),(368,'A',1,'2011-06-14',38.5,0,0,22,175,175),(369,'A',1,'2011-06-14',26.4,0,0,22,120,120),(370,'A',1,'2011-06-14',11.1605998599529,0,0,22,50.7299993634224,50.7299993634224),(371,'A',1,'2011-06-14',31.9000010490417,0,0,22,145.000004768372,145.000004768372),(372,'A',1,'2011-06-14',15.6749998033047,0,0,22,71.2499991059303,71.2499991059303),(373,'A',1,'2011-06-14',69.7015007972717,0,0,22,316.825003623962,316.825003623962),(374,'A',1,'2011-06-14',11.4542995798588,0,0,22,52.0649980902672,52.0649980902672),(375,'A',1,'2011-06-14',13.2,0,0,22,60,60),(376,'A',1,'2011-06-14',22.1539988040924,0,0,22,100.699994564056,100.699994564056),(377,'A',1,'2011-06-14',14.3,0,0,22,65,65),(378,'A',1,'2011-06-14',29.5899995148182,0,0,22,134.499997794628,134.499997794628),(379,'A',1,'2011-06-14',53.9494996905327,0,0,22,245.22499859333,245.22499859333),(380,'A',1,'2011-06-14',11.3563996732235,0,0,22,51.6199985146523,51.6199985146523),(381,'A',1,'2011-06-14',174.756996202469,0,0,22,794.349982738495,794.349982738495),(382,'A',1,'2011-06-15',54.779999423027,0,0,22,248.999997377396,248.999997377396),(383,'A',1,'2011-06-15',26.4000010490417,0,0,22,120.000004768372,120.000004768372),(384,'A',1,'2011-06-15',57.7060014057159,0,0,22,262.300006389618,262.300006389618),(385,'A',1,'2011-06-15',21.5380004668236,0,0,22,97.9000021219254,97.9000021219254),(386,'A',1,'2011-06-15',27.4119995331764,0,0,22,124.599997878075,124.599997878075),(387,'A',1,'2011-06-15',13.2,0,0,22,60,60),(388,'A',1,'2011-06-15',22.962499409914,0,0,22,104.374997317791,104.374997317791),(389,'A',1,'2011-06-15',63.8000002229214,0,0,22,290.000001013279,290.000001013279),(390,'A',1,'2011-06-15',15.5044997036457,0,0,22,70.474998652935,70.474998652935),(391,'A',1,'2011-06-15',31.68,0,0,22,144,144),(392,'A',1,'2011-06-15',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(393,'A',1,'2011-06-15',62.2335993695259,0,0,22,282.879997134209,282.879997134209),(394,'A',1,'2011-06-15',113.255995845795,0,0,22,514.799981117249,514.799981117249),(395,'A',1,'2011-06-15',33,0,0,22,150,150),(396,'A',1,'2011-06-15',17.16,0,0,22,78,78),(397,'A',1,'2011-06-15',12.8259993076324,0,0,22,58.2999968528748,58.2999968528748),(398,'A',1,'2011-06-15',16.5,0,0,22,75,75),(399,'A',1,'2011-06-15',19.1455002045631,0,0,22,87.0250009298325,87.0250009298325),(400,'A',1,'2011-06-15',87.5380017781258,0,0,22,397.90000808239,397.90000808239),(401,'A',1,'2011-06-15',39.083000099659,0,0,22,177.650000452995,177.650000452995),(402,'A',1,'2011-06-15',12.4079999685287,0,0,22,56.3999998569488,56.3999998569488),(403,'A',1,'2011-06-15',52.6680010962486,0,0,22,239.400004982948,239.400004982948),(404,'A',1,'2011-06-15',11.8800004720688,0,0,22,54.0000021457672,54.0000021457672),(405,'A',1,'2011-06-15',47.2230020403862,0,0,22,214.650009274483,214.650009274483),(406,'A',1,'2011-06-15',22.7810006976128,0,0,22,103.550003170967,103.550003170967),(407,'A',1,'2011-06-15',20.265299346447,0,0,22,92.1149970293045,92.1149970293045),(408,'A',1,'2011-06-15',67.5179990768433,0,0,22,306.899995803833,306.899995803833),(409,'A',1,'2011-06-15',23.9800001573563,0,0,22,109.000000715256,109.000000715256),(410,'A',1,'2011-06-15',24.804999423027,0,0,22,112.749997377396,112.749997377396),(411,'A',1,'2011-06-15',20.9,0,0,22,95,95),(412,'A',1,'2011-06-15',25.7399989509583,0,0,22,116.999995231628,116.999995231628),(413,'A',1,'2011-06-15',8.95400011539459,0,0,22,40.7000005245209,40.7000005245209),(414,'A',1,'2011-06-15',15.62,0,0,22,71,71),(415,'A',1,'2011-06-15',6.6,0,0,22,30,30),(416,'A',1,'2011-06-15',25.7399990558624,0,0,22,116.999995708466,116.999995708466),(417,'A',1,'2011-06-15',48.795998442173,0,0,22,221.799992918968,221.799992918968),(418,'A',1,'2011-06-15',75.57,0,0,22,343.5,343.5),(419,'A',1,'2011-06-15',23.2825992226601,0,0,22,105.829996466637,105.829996466637),(420,'A',1,'2011-06-15',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(421,'A',1,'2011-06-15',21.1464008402824,0,0,22,96.1200038194656,96.1200038194656),(422,'A',1,'2011-06-15',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(423,'A',1,'2011-06-15',64.2488012504578,0,0,22,292.040005683899,292.040005683899),(424,'A',1,'2011-06-15',12.7269995331764,0,0,22,57.8499978780746,57.8499978780746),(425,'A',1,'2011-06-15',39.07200050354,0,0,22,177.600002288818,177.600002288818),(426,'A',1,'2011-06-15',34.979999423027,0,0,22,158.999997377396,158.999997377396),(427,'A',1,'2011-06-15',13.2,0,0,22,60,60),(428,'A',1,'2011-06-15',31.5919998806715,0,0,22,143.599999457598,143.599999457598),(429,'A',1,'2011-06-15',10.7800002098084,0,0,22,49.0000009536743,49.0000009536743),(430,'A',1,'2011-06-15',26.62,0,0,22,121,121),(431,'A',1,'2011-06-15',66,0,0,22,300,300),(432,'A',1,'2011-06-15',63.2830002307892,0,0,22,287.650001049042,287.650001049042),(433,'A',1,'2011-06-15',22.5169995331764,0,0,22,102.349997878075,102.349997878075),(434,'A',1,'2011-06-15',6.6,0,0,22,30,30),(435,'A',1,'2011-06-15',45.4520001888275,0,0,22,206.600000858307,206.600000858307),(436,'A',1,'2011-06-15',8.83300023078919,0,0,22,40.1500010490417,40.1500010490417),(437,'A',1,'2011-06-15',28.159999370575,0,0,22,127.999997138977,127.999997138977),(438,'A',1,'2011-06-15',29.4800003409386,0,0,22,134.000001549721,134.000001549721),(439,'A',1,'2011-06-15',11.4949998557568,0,0,22,52.2499993443489,52.2499993443489),(440,'A',1,'2011-06-15',30.3159983634949,0,0,22,137.79999256134,137.79999256134),(441,'A',1,'2011-06-15',40.7109999239445,0,0,22,185.049999654293,185.049999654293),(442,'A',1,'2011-06-15',37.7519986152649,0,0,22,171.59999370575,171.59999370575),(443,'A',1,'2011-06-15',11.7370003461838,0,0,22,53.3500015735626,53.3500015735626),(444,'A',1,'2011-06-15',19.6459999501705,0,0,22,89.2999997735023,89.2999997735023),(445,'A',1,'2011-06-15',22.3630010962486,0,0,22,101.650004982948,101.650004982948),(446,'A',1,'2011-06-15',16.3019994020462,0,0,22,74.0999972820282,74.0999972820282),(447,'A',1,'2011-06-15',16.7200003802776,0,0,22,76.0000017285347,76.0000017285347),(448,'A',1,'2011-06-15',38.7750007212162,0,0,22,176.250003278255,176.250003278255),(449,'A',1,'2011-06-15',26.4,0,0,22,120,120),(450,'A',1,'2011-06-15',14.520000576973,0,0,22,66.0000026226044,66.0000026226044),(451,'A',1,'2011-06-15',13.2,0,0,22,60,60),(452,'A',1,'2011-06-15',7.15,0,0,22,32.5,32.5),(453,'A',1,'2011-06-15',12.1,0,0,22,55,55),(454,'A',1,'2011-06-15',12.1,0,0,22,55,55),(455,'A',1,'2011-06-15',74.0739975452423,0,0,22,336.699988842011,336.699988842011),(456,'A',1,'2011-06-15',38.5,0,0,22,175,175),(457,'A',1,'2011-06-15',35.1119989037514,0,0,22,159.599995017052,159.599995017052),(458,'A',1,'2011-06-15',17.8200000524521,0,0,22,81.0000002384186,81.0000002384186),(459,'A',1,'2011-06-15',18.8760007500649,0,0,22,85.8000034093857,85.8000034093857),(460,'A',1,'2011-06-15',8.95400011539459,0,0,22,40.7000005245209,40.7000005245209),(461,'A',1,'2011-06-15',11.44,0,0,22,52,52),(462,'A',1,'2011-06-15',22.4399995803833,0,0,22,101.999998092651,101.999998092651),(463,'A',1,'2011-06-15',15.6640002334118,0,0,22,71.2000010609627,71.2000010609627),(464,'A',1,'2011-06-15',19.7120000839233,0,0,22,89.6000003814697,89.6000003814697),(465,'A',1,'2011-06-15',19.1399994492531,0,0,22,86.9999974966049,86.9999974966049),(466,'A',1,'2011-06-15',35.7169995331764,0,0,22,162.349997878075,162.349997878075),(467,'A',1,'2011-06-15',134.243997755051,0,0,22,610.199989795685,610.199989795685),(468,'A',1,'2011-06-15',26.4,0,0,22,120,120),(469,'A',1,'2011-06-15',8.36,0,0,22,38,38),(470,'A',1,'2011-06-15',18.2159999370575,0,0,22,82.7999997138977,82.7999997138977),(471,'A',1,'2011-06-15',12.7269995331764,0,0,22,57.8499978780746,57.8499978780746),(472,'A',1,'2011-06-15',7.92,0,0,22,36,36),(473,'A',1,'2011-06-15',28.82,0,0,22,131,131),(474,'A',1,'2011-06-15',20.8780005455017,0,0,22,94.9000024795532,94.9000024795532),(475,'A',1,'2011-06-15',7.26,0,0,22,33,33),(476,'A',1,'2011-06-15',17.07200050354,0,0,22,77.6000022888184,77.6000022888184),(477,'A',1,'2011-06-16',12.1,0,0,22,55,55),(478,'A',1,'2011-06-16',11.2530000865459,0,0,22,51.1500003933907,51.1500003933907),(479,'A',1,'2011-06-16',15.4,0,0,22,70,70),(480,'A',1,'2011-06-16',6.29199976921082,0,0,22,28.5999989509583,28.5999989509583),(481,'A',1,'2011-06-16',26.4495003461838,0,0,22,120.225001573563,120.225001573563),(482,'A',1,'2011-06-16',42.768000125885,0,0,22,194.400000572205,194.400000572205),(483,'A',1,'2011-06-16',35.2385015630722,0,0,22,160.175007104874,160.175007104874),(484,'A',1,'2011-06-16',18.8099997639656,0,0,22,85.4999989271164,85.4999989271164),(485,'A',1,'2011-06-16',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(486,'A',1,'2011-06-16',13.2,0,0,22,60,60),(487,'A',1,'2011-06-16',7.92,0,0,22,36,36),(488,'A',1,'2011-06-16',16.06,0,0,22,73,73),(489,'A',1,'2011-06-16',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(490,'A',1,'2011-06-16',13.2,0,0,22,60,60),(491,'A',1,'2011-06-16',14.520000576973,0,0,22,66.0000026226044,66.0000026226044),(492,'A',1,'2011-06-16',26.4,0,0,22,120,120),(493,'A',1,'2011-06-16',3.96000015735626,0,0,22,18.0000007152557,18.0000007152557),(494,'A',1,'2011-06-16',4.75200018882751,0,0,22,21.6000008583069,21.6000008583069),(495,'A',1,'2011-06-16',12.1,0,0,22,55,55),(496,'A',1,'2011-06-16',4.48800004720688,0,0,22,20.4000002145767,20.4000002145767),(497,'A',1,'2011-06-16',20.6513998436928,0,0,22,93.8699992895126,93.8699992895126),(498,'A',1,'2011-06-16',42.0695009887218,0,0,22,191.22500449419,191.22500449419),(499,'A',1,'2011-06-16',12.1,0,0,22,55,55),(500,'A',1,'2011-06-16',1.76,0,0,22,8,8),(501,'A',1,'2011-06-16',29.3149994492531,0,0,22,133.249997496605,133.249997496605),(502,'A',1,'2011-06-16',16.631999874115,0,0,22,75.5999994277954,75.5999994277954),(503,'A',1,'2011-06-16',35.2,0,0,22,160,160),(504,'A',1,'2011-06-16',42.6778002381325,0,0,22,193.99000108242,193.99000108242),(505,'A',1,'2011-06-16',53.9725981211662,0,0,22,245.329991459847,245.329991459847),(506,'A',1,'2011-06-16',6.53400025963783,0,0,22,29.700001180172,29.700001180172),(507,'A',1,'2011-06-16',3.30000013113022,0,0,22,15.0000005960464,15.0000005960464),(508,'A',1,'2011-06-16',7.14999973773956,0,0,22,32.4999988079071,32.4999988079071),(509,'A',1,'2011-06-16',22.22,0,0,22,101,101),(510,'A',1,'2011-06-16',6.65500014424324,0,0,22,30.2500006556511,30.2500006556511),(511,'A',1,'2011-06-16',13.2,0,0,22,60,60),(512,'A',1,'2011-06-16',13.2,0,0,22,60,60),(513,'A',1,'2011-06-16',7.04,0,0,22,32,32),(514,'A',1,'2011-06-16',28.6,0,0,22,130,130),(515,'A',1,'2011-06-16',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(516,'A',1,'2011-06-16',19.2499996721745,0,0,22,87.4999985098839,87.4999985098839),(517,'A',1,'2011-06-16',3.96000015735626,0,0,22,18.0000007152557,18.0000007152557),(518,'A',1,'2011-06-16',23.759999370575,0,0,22,107.999997138977,107.999997138977),(519,'A',1,'2011-06-16',6.6,0,0,22,30,30),(520,'A',1,'2011-06-16',157.959997062683,0,0,22,717.999986648559,717.999986648559),(521,'A',1,'2011-06-16',97.5260050773621,0,0,22,443.300023078919,443.300023078919),(522,'A',1,'2011-06-16',10.9648000466824,0,0,22,49.8400002121925,49.8400002121925),(523,'A',1,'2011-06-16',35.2,0,0,22,160,160),(524,'A',1,'2011-06-16',100.04609947443,0,0,22,454.754997611046,454.754997611046),(525,'A',1,'2011-06-16',8.77250028848648,0,0,22,39.8750013113022,39.8750013113022),(526,'A',1,'2011-06-16',22.1649997115135,0,0,22,100.749998688698,100.749998688698),(527,'A',1,'2011-06-16',40.1719991922379,0,0,22,182.599996328354,182.599996328354),(528,'A',1,'2011-06-16',4.84000007212162,0,0,22,22.0000003278256,22.0000003278256),(529,'A',1,'2011-06-16',22.3299997508526,0,0,22,101.499998867512,101.499998867512),(530,'A',1,'2011-06-16',26.4,0,0,22,120,120),(531,'A',1,'2011-06-16',62.04,0,0,22,282,282),(532,'A',1,'2011-06-16',21.5600004196167,0,0,22,98.0000019073486,98.0000019073486),(533,'A',1,'2011-06-16',81.0370000839233,0,0,22,368.35000038147,368.35000038147),(534,'A',1,'2011-06-16',35.2879996538162,0,0,22,160.399998426437,160.399998426437),(535,'A',1,'2011-06-16',13.4310001730919,0,0,22,61.0500007867813,61.0500007867813),(536,'A',1,'2011-06-16',8.46999985575676,0,0,22,38.4999993443489,38.4999993443489),(537,'A',1,'2011-06-16',26.4330004668236,0,0,22,120.150002121925,120.150002121925),(538,'A',1,'2011-06-16',15.18,0,0,22,69,69),(539,'A',1,'2011-06-16',24.2,0,0,22,110,110),(540,'A',1,'2011-06-16',27.829999423027,0,0,22,126.499997377396,126.499997377396),(541,'A',1,'2011-06-16',5.14800020456314,0,0,22,23.4000009298325,23.4000009298325),(542,'A',1,'2011-06-16',23.4960009336472,0,0,22,106.800004243851,106.800004243851),(543,'A',1,'2011-06-16',41.7780005717277,0,0,22,189.900002598763,189.900002598763),(544,'A',1,'2011-06-16',47.4319988250733,0,0,22,215.599994659424,215.599994659424),(545,'A',1,'2011-06-16',12.4574999213219,0,0,22,56.6249996423721,56.6249996423721),(546,'A',1,'2011-06-16',9.9,0,0,22,45,45),(547,'A',1,'2011-06-16',10.56,0,0,22,48,48),(548,'A',1,'2011-06-16',33.1077996873856,0,0,22,150.489998579025,150.489998579025),(549,'A',1,'2011-06-16',26.4,0,0,22,120,120),(550,'A',1,'2011-06-16',17.6880004405975,0,0,22,80.4000020027161,80.4000020027161),(551,'A',1,'2011-06-16',16.9399997115135,0,0,22,76.9999986886978,76.9999986886978),(552,'A',1,'2011-06-16',26.2900011539459,0,0,22,119.500005245209,119.500005245209),(553,'A',1,'2011-06-16',12.979999423027,0,0,22,58.9999973773956,58.9999973773956),(554,'A',1,'2011-06-16',13.2,0,0,22,60,60),(555,'A',1,'2011-06-16',18.4800001573563,0,0,22,84.0000007152557,84.0000007152557),(556,'A',1,'2011-06-16',6.60000026226044,0,0,22,30.0000011920929,30.0000011920929),(557,'A',1,'2011-06-16',35.3100002884865,0,0,22,160.500001311302,160.500001311302),(558,'A',1,'2011-06-16',60.6264996957779,0,0,22,275.574998617172,275.574998617172),(559,'A',1,'2011-06-16',45.1329991817474,0,0,22,205.14999628067,205.14999628067),(560,'A',1,'2011-06-16',28.8111999297142,0,0,22,130.959999680519,130.959999680519),(561,'A',1,'2011-06-16',23.495999622345,0,0,22,106.799998283386,106.799998283386),(562,'A',1,'2011-06-16',45.979999423027,0,0,22,208.999997377396,208.999997377396),(563,'A',1,'2011-06-16',43.8899980068207,0,0,22,199.499990940094,199.499990940094),(564,'A',1,'2011-06-17',20.5039998531342,0,0,22,93.199999332428,93.199999332428),(565,'A',1,'2011-06-17',13.2,0,0,22,60,60),(566,'A',1,'2011-06-17',120.917499947548,0,0,22,549.624999761581,549.624999761581),(567,'A',1,'2011-06-17',20.5865002989769,0,0,22,93.5750013589859,93.5750013589859),(568,'A',1,'2011-06-17',21.78,0,0,22,99,99),(569,'A',1,'2011-06-17',80.570598974824,0,0,22,366.229995340109,366.229995340109),(570,'A',1,'2011-06-17',12.1,0,0,22,55,55),(571,'A',1,'2011-06-17',43.8899980068207,0,0,22,199.499990940094,199.499990940094),(572,'A',1,'2011-06-17',24.3429993391037,0,0,22,110.649996995926,110.649996995926),(573,'A',1,'2011-06-17',13.2,0,0,22,60,60),(574,'A',1,'2011-06-17',67.8480016469956,0,0,22,308.400007486343,308.400007486343),(575,'A',1,'2011-06-17',51.6999986886978,0,0,22,234.999994039536,234.999994039536),(576,'A',1,'2011-06-17',55.241999900341,0,0,22,251.099999547005,251.099999547005),(577,'A',1,'2011-06-17',18.4051999533176,0,0,22,83.6599997878075,83.6599997878075),(578,'A',1,'2011-06-17',17.5560005664825,0,0,22,79.8000025749207,79.8000025749207),(579,'A',1,'2011-06-17',34.7985007762909,0,0,22,158.175003528595,158.175003528595),(580,'A',1,'2011-06-17',22.5169995331764,0,0,22,102.349997878075,102.349997878075),(581,'A',1,'2011-06-17',12.1,0,0,22,55,55),(582,'A',1,'2011-06-17',11.3563996732235,0,0,22,51.6199985146523,51.6199985146523),(583,'A',1,'2011-06-17',16.7200002491474,0,0,22,76.0000011324883,76.0000011324883),(584,'A',1,'2011-06-17',44.0879988670349,0,0,22,200.399994850159,200.399994850159),(585,'A',1,'2011-06-17',105.555999923944,0,0,22,479.799999654293,479.799999654293),(586,'A',1,'2011-06-17',42.3334994387627,0,0,22,192.424997448921,192.424997448921),(587,'A',1,'2011-06-17',64.2301008486748,0,0,22,291.955003857613,291.955003857613),(588,'A',1,'2011-06-17',26.4,0,0,22,120,120),(589,'A',1,'2011-06-17',126.516496443748,0,0,22,575.07498383522,575.07498383522),(590,'A',1,'2011-06-17',24.4529991030693,0,0,22,111.149995923042,111.149995923042),(591,'A',1,'2011-06-17',261.310501201153,0,0,22,1187.77500545979,1187.77500545979),(592,'A',1,'2011-06-17',22.5169995331764,0,0,22,102.349997878075,102.349997878075),(593,'A',1,'2011-06-17',21.9626005470753,0,0,22,99.8300024867058,99.8300024867058),(594,'A',1,'2011-06-17',110.022001552582,0,0,22,500.10000705719,500.10000705719),(595,'A',1,'2011-06-17',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(596,'A',1,'2011-06-17',33.995500099659,0,0,22,154.525000452995,154.525000452995),(597,'A',1,'2011-06-17',10.5600001573563,0,0,22,48.0000007152557,48.0000007152557),(598,'A',1,'2011-06-17',14.6299997508526,0,0,22,66.4999988675117,66.4999988675117),(599,'A',1,'2011-06-17',26.5100002884865,0,0,22,120.500001311302,120.500001311302),(600,'A',1,'2011-06-17',17.6,0,0,22,80,80),(601,'A',1,'2011-06-17',26.9500005245209,0,0,22,122.500002384186,122.500002384186),(602,'A',1,'2011-06-17',22.9900004982948,0,0,22,104.500002264977,104.500002264977),(603,'A',1,'2011-06-17',26.4,0,0,22,120,120),(604,'A',1,'2011-06-17',7.92000031471252,0,0,22,36.0000014305115,36.0000014305115),(605,'A',1,'2011-06-17',14.5200003147125,0,0,22,66.0000014305115,66.0000014305115),(606,'A',1,'2011-06-17',139.040002307892,0,0,22,632.000010490418,632.000010490418),(607,'A',1,'2011-06-17',46.64,0,0,22,212,212),(608,'A',1,'2011-06-17',18.2490001022816,0,0,22,82.9500004649162,82.9500004649162),(609,'A',1,'2011-06-17',37.8730013847351,0,0,22,172.15000629425,172.15000629425),(610,'A',1,'2011-06-17',10.339999973774,0,0,22,46.9999998807907,46.9999998807907),(611,'A',1,'2011-06-17',8.58000012785196,0,0,22,39.0000005811453,39.0000005811453),(612,'A',1,'2011-06-17',6.6,0,0,22,30,30),(613,'A',1,'2011-06-17',19.9100005507469,0,0,22,90.5000025033951,90.5000025033951),(614,'A',1,'2011-06-17',99.9261988544464,0,0,22,454.209994792938,454.209994792938),(615,'A',1,'2011-06-17',11.2200001180172,0,0,22,51.0000005364418,51.0000005364418),(616,'A',1,'2011-06-17',61.3909998059273,0,0,22,279.049999117851,279.049999117851),(617,'A',1,'2011-06-17',84.6890002727509,0,0,22,384.950001239777,384.950001239777),(618,'A',1,'2011-06-17',14.3880005717278,0,0,22,65.4000025987625,65.4000025987625),(619,'A',1,'2011-06-17',8.71200034618378,0,0,22,39.6000015735626,39.6000015735626),(620,'A',1,'2011-06-17',12.1,0,0,22,55,55),(621,'A',1,'2011-06-17',45.0120002150536,0,0,22,204.600000977516,204.600000977516),(622,'A',1,'2011-06-17',59.9829998111725,0,0,22,272.649999141693,272.649999141693),(623,'A',1,'2011-06-17',15.784999423027,0,0,22,71.7499973773956,71.7499973773956),(624,'A',1,'2011-06-17',11.5499998033047,0,0,22,52.4999991059303,52.4999991059303),(625,'A',1,'2011-06-17',18.183000099659,0,0,22,82.6500004529953,82.6500004529953),(626,'A',1,'2011-06-17',121.440001678467,0,0,22,552.000007629395,552.000007629395),(627,'A',1,'2011-06-17',13.7675995701551,0,0,22,62.5799980461597,62.5799980461597),(628,'A',1,'2011-06-17',35.3694006252289,0,0,22,160.770002841949,160.770002841949),(629,'A',1,'2011-06-17',25.409999370575,0,0,22,115.499997138977,115.499997138977),(630,'A',1,'2011-06-17',12.1,0,0,22,55,55),(631,'A',1,'2011-06-17',48.6750007867813,0,0,22,221.250003576279,221.250003576279),(632,'A',1,'2011-06-17',28.3799991607666,0,0,22,128.999996185303,128.999996185303),(633,'A',1,'2011-06-17',81.147002863884,0,0,22,368.850013017654,368.850013017654),(634,'A',1,'2011-06-17',17.4460004091263,0,0,22,79.3000018596649,79.3000018596649),(635,'A',1,'2011-06-17',35.6400006294251,0,0,22,162.000002861023,162.000002861023),(636,'A',1,'2011-06-17',28.5999989509583,0,0,22,129.999995231628,129.999995231628),(637,'A',1,'2011-06-17',21.779999423027,0,0,22,98.9999973773956,98.9999973773956),(638,'A',1,'2011-06-17',67.7599988460541,0,0,22,307.999994754791,307.999994754791),(639,'A',1,'2011-06-17',30.2499990034103,0,0,22,137.499995470047,137.499995470047),(640,'A',1,'2011-06-17',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(641,'A',1,'2011-06-17',2.2,0,0,22,10,10),(642,'A',1,'2011-06-17',27.5879988670349,0,0,22,125.399994850159,125.399994850159),(643,'A',1,'2011-06-17',33,0,0,22,150,150),(644,'A',1,'2011-06-17',2.2,0,0,22,10,10),(645,'A',1,'2011-06-18',17.8695003986359,0,0,22,81.2250018119812,81.2250018119812),(646,'A',1,'2011-06-18',26.4,0,0,22,120,120),(647,'A',1,'2011-06-18',38.0665996265411,0,0,22,173.02999830246,173.02999830246),(648,'A',1,'2011-06-18',80.5860023498535,0,0,22,366.300010681152,366.300010681152),(649,'A',1,'2011-06-18',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(650,'A',1,'2011-06-18',39.6,0,0,22,180,180),(651,'A',1,'2011-06-18',24.232999509573,0,0,22,110.149997770786,110.149997770786),(652,'A',1,'2011-06-18',58.8389988303185,0,0,22,267.449994683266,267.449994683266),(653,'A',1,'2011-06-18',37.5979996538162,0,0,22,170.899998426437,170.899998426437),(654,'A',1,'2011-06-18',33.4399995803833,0,0,22,151.999998092651,151.999998092651),(655,'A',1,'2011-06-18',76.4720020771027,0,0,22,347.600009441376,347.600009441376),(656,'A',1,'2011-06-18',32.12,0,0,22,146,146),(657,'A',1,'2011-06-18',31.6799996852875,0,0,22,143.999998569489,143.999998569489),(658,'A',1,'2011-06-18',88.2101018452644,0,0,22,400.955008387566,400.955008387566),(659,'A',1,'2011-06-18',36.9665996265411,0,0,22,168.02999830246,168.02999830246),(660,'A',1,'2011-06-18',23.3199987411499,0,0,22,105.999994277954,105.999994277954),(661,'A',1,'2011-06-18',394.81750659585,0,0,22,1794.62502998114,1794.62502998114),(662,'A',1,'2011-06-18',385.388299918175,0,0,22,1751.76499962807,1751.76499962807),(663,'A',1,'2011-06-18',88.6952018022537,0,0,22,403.160008192062,403.160008192062),(664,'A',1,'2011-06-18',152.129997115135,0,0,22,691.499986886978,691.499986886978),(665,'A',1,'2011-06-18',100.254000666142,0,0,22,455.700003027916,455.700003027916),(666,'A',1,'2011-06-18',54.2080002307892,0,0,22,246.400001049042,246.400001049042),(667,'A',1,'2011-06-18',19.8000001049042,0,0,22,90.0000004768372,90.0000004768372),(668,'A',1,'2011-06-18',13.2,0,0,22,60,60),(669,'A',1,'2011-06-18',92.3559985470772,0,0,22,419.799993395805,419.799993395805),(670,'A',1,'2011-06-18',33.4400006294251,0,0,22,152.000002861023,152.000002861023),(671,'A',1,'2011-06-18',52.8,0,0,22,240,240),(672,'A',1,'2011-06-18',10.5600004196167,0,0,22,48.0000019073486,48.0000019073486),(673,'A',1,'2011-06-18',12.1,0,0,22,55,55),(674,'A',1,'2011-06-18',245.145993013382,0,0,22,1114.29996824265,1114.29996824265),(675,'A',1,'2011-06-18',228.046495184898,0,0,22,1036.57497811317,1036.57497811317),(676,'A',1,'2011-06-18',81.4330002307892,0,0,22,370.150001049042,370.150001049042),(677,'A',1,'2011-06-18',19.1400007605553,0,0,22,87.0000034570694,87.0000034570694),(678,'A',1,'2011-06-18',89.5180032730103,0,0,22,406.900014877319,406.900014877319),(679,'A',1,'2011-06-18',101.639995384216,0,0,22,461.999979019165,461.999979019165),(680,'A',1,'2011-06-18',69.0360016155243,0,0,22,313.800007343292,313.800007343292),(681,'A',1,'2011-06-18',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(682,'A',1,'2011-06-18',6.6,0,0,22,30,30),(683,'A',1,'2011-06-18',24.2,0,0,22,110,110),(684,'A',1,'2011-06-18',26.4,0,0,22,120,120),(685,'A',1,'2011-06-18',24.3100006818771,0,0,22,110.500003099442,110.500003099442),(686,'A',1,'2011-06-18',8.80000013113022,0,0,22,40.0000005960465,40.0000005960465),(687,'A',1,'2011-06-18',24.2,0,0,22,110,110),(688,'A',1,'2011-06-18',28.7760005533695,0,0,22,130.800002515316,130.800002515316),(689,'A',1,'2011-06-18',152.460004615784,0,0,22,693.000020980835,693.000020980835),(690,'A',1,'2011-06-18',52.2720020771027,0,0,22,237.600009441376,237.600009441376),(691,'A',1,'2011-06-18',10.9648000466824,0,0,22,49.8400002121925,49.8400002121925),(692,'A',1,'2011-06-18',66.4290014266968,0,0,22,301.950006484985,301.950006484985),(693,'A',1,'2011-06-18',13.2000005245209,0,0,22,60.0000023841858,60.0000023841858),(694,'A',1,'2011-06-18',39.8090008234978,0,0,22,180.950003743172,180.950003743172),(695,'A',1,'2011-06-18',60.0599972724915,0,0,22,272.999987602234,272.999987602234),(696,'A',1,'2011-06-18',81.5539972305298,0,0,22,370.699987411499,370.699987411499),(697,'A',1,'2011-06-18',26.4,0,0,22,120,120),(698,'A',1,'2011-06-18',26.13600025177,0,0,22,118.800001144409,118.800001144409),(699,'A',1,'2011-06-18',23.759999370575,0,0,22,107.999997138977,107.999997138977),(700,'A',1,'2011-06-18',109.560001993179,0,0,22,498.000009059906,498.000009059906),(701,'A',1,'2011-06-18',84.9530006504059,0,0,22,386.15000295639,386.15000295639),(702,'A',1,'2011-06-18',449.748197731972,0,0,22,2044.30998969078,2044.30998969078),(703,'A',1,'2011-06-18',560.581997461319,0,0,22,2548.09998846054,2548.09998846054),(704,'A',1,'2011-06-18',106.755,0,0,22,485.25,485.25),(705,'A',1,'2011-06-18',10.12,0,0,22,46,46),(706,'A',1,'2011-06-18',37.1799999475479,0,0,22,168.999999761581,168.999999761581),(707,'A',1,'2011-06-19',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(708,'A',1,'2011-06-19',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(709,'A',1,'2011-06-19',52.8,0,0,22,240,240),(710,'A',1,'2011-06-19',14.7400003671646,0,0,22,67.00000166893,67.00000166893),(711,'A',1,'2011-06-19',10.3455001586676,0,0,22,47.0250007212162,47.0250007212162),(712,'A',1,'2011-06-19',40.0411014938354,0,0,22,182.005006790161,182.005006790161),(713,'A',1,'2011-06-19',53.5919992446899,0,0,22,243.599996566772,243.599996566772),(714,'A',1,'2011-06-19',9.37199971675873,0,0,22,42.5999987125397,42.5999987125397),(715,'A',1,'2011-06-19',6.71550008654594,0,0,22,30.5250003933907,30.5250003933907),(716,'A',1,'2011-06-19',12.1,0,0,22,55,55),(717,'A',1,'2011-06-19',17.159999370575,0,0,22,77.9999971389771,77.9999971389771),(718,'A',1,'2011-06-19',12.8259993076324,0,0,22,58.2999968528748,58.2999968528748),(719,'A',1,'2011-06-19',3.30000013113022,0,0,22,15.0000005960464,15.0000005960464),(720,'A',1,'2011-06-19',66.7920008182526,0,0,22,303.60000371933,303.60000371933),(721,'A',1,'2011-06-19',23.1439999318123,0,0,22,105.199999690056,105.199999690056),(722,'A',1,'2011-06-19',58.74,0,0,22,267,267),(723,'A',1,'2011-06-19',38.0160015106201,0,0,22,172.800006866455,172.800006866455),(724,'A',1,'2011-06-19',17.16,0,0,22,78,78),(725,'A',1,'2011-06-19',6.89699991345406,0,0,22,31.3499996066093,31.3499996066093),(726,'A',1,'2011-06-19',43.4719994544983,0,0,22,197.599997520447,197.599997520447),(727,'A',1,'2011-06-19',37.7586010217667,0,0,22,171.630004644394,171.630004644394),(728,'A',1,'2011-06-19',12.3640001416206,0,0,22,56.2000006437302,56.2000006437302),(729,'A',1,'2011-06-19',71.1039998531341,0,0,22,323.199999332428,323.199999332428),(730,'A',1,'2011-06-19',34.9249994754791,0,0,22,158.749997615814,158.749997615814),(731,'A',1,'2011-06-19',8.72300020456314,0,0,22,39.6500009298325,39.6500009298325),(732,'A',1,'2011-06-19',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(733,'A',1,'2011-06-19',40.5570001363754,0,0,22,184.350000619888,184.350000619888),(734,'A',1,'2011-06-19',11.3025000393391,0,0,22,51.3750001788139,51.3750001788139),(735,'A',1,'2011-06-19',13.2,0,0,22,60,60),(736,'A',1,'2011-06-19',13.2,0,0,22,60,60),(737,'A',1,'2011-06-19',6.6,0,0,22,30,30),(738,'A',1,'2011-06-19',52.5470006346703,0,0,22,238.850002884865,238.850002884865),(739,'A',1,'2011-06-19',8.8,0,0,22,40,40),(740,'A',1,'2011-06-19',22.1760008811951,0,0,22,100.800004005432,100.800004005432),(741,'A',1,'2011-06-19',10.0836997199059,0,0,22,45.8349987268448,45.8349987268448),(742,'A',1,'2011-06-19',28.7760008811951,0,0,22,130.800004005432,130.800004005432),(743,'A',1,'2011-06-19',23.5125005245209,0,0,22,106.875002384186,106.875002384186),(744,'A',1,'2011-06-19',1.76,0,0,22,8,8),(745,'A',1,'2011-06-19',13.2,0,0,22,60,60),(746,'A',1,'2011-06-19',13.2880002832413,0,0,22,60.4000012874603,60.4000012874603),(747,'A',1,'2011-06-19',48.2680003356934,0,0,22,219.400001525879,219.400001525879),(748,'A',1,'2011-06-19',49.6330991387367,0,0,22,225.604996085167,225.604996085167),(749,'A',1,'2011-06-19',43.4543991303444,0,0,22,197.51999604702,197.51999604702),(750,'A',1,'2011-06-19',9.19599988460541,0,0,22,41.7999994754791,41.7999994754791),(751,'A',1,'2011-06-19',33.4355993747711,0,0,22,151.979997158051,151.979997158051),(752,'A',1,'2011-06-19',39.16,0,0,22,178,178),(753,'A',1,'2011-06-19',11.7675802147388,0,0,22,53.4890009760857,53.4890009760857),(754,'A',1,'2011-06-19',41.9099991083145,0,0,22,190.499995946884,190.499995946884),(755,'A',1,'2011-06-19',24.2,0,0,22,110,110),(756,'A',1,'2011-06-19',36.596998667717,0,0,22,166.349993944168,166.349993944168),(757,'A',1,'2011-06-19',6.86399974822998,0,0,22,31.1999988555908,31.1999988555908),(758,'A',1,'2011-06-19',88.3080005192757,0,0,22,401.400002360344,401.400002360344),(759,'A',1,'2011-06-19',60.2227996087074,0,0,22,273.739998221397,273.739998221397),(760,'A',1,'2011-06-19',132.924002790451,0,0,22,604.200012683868,604.200012683868),(761,'A',1,'2011-06-19',91.2702995562553,0,0,22,414.864997982979,414.864997982979),(762,'A',1,'2011-06-19',6.16,0,0,22,28,28),(763,'A',1,'2011-06-19',31.1849999475479,0,0,22,141.749999761581,141.749999761581),(764,'A',1,'2011-06-19',142.835000891685,0,0,22,649.250004053116,649.250004053116),(765,'A',1,'2011-06-19',26.4,0,0,22,120,120),(766,'A',1,'2011-06-19',59.0039984369278,0,0,22,268.199992895126,268.199992895126),(767,'A',1,'2011-06-20',21.5380004668236,0,0,22,97.9000021219254,97.9000021219254),(768,'A',1,'2011-06-20',35.2439990663528,0,0,22,160.199995756149,160.199995756149),(769,'A',1,'2011-06-20',45.1549998164177,0,0,22,205.249999165535,205.249999165535),(770,'A',1,'2011-06-20',22.659999370575,0,0,22,102.999997138977,102.999997138977),(771,'A',1,'2011-06-20',39.16,0,0,22,178,178),(772,'A',1,'2011-06-20',25.3,0,0,22,115,115),(773,'A',1,'2011-06-20',42.8999984264374,0,0,22,194.999992847443,194.999992847443),(774,'A',1,'2011-06-20',22.8800003409386,0,0,22,104.000001549721,104.000001549721),(775,'A',1,'2011-06-20',12.1,0,0,22,55,55),(776,'A',1,'2011-06-20',15.0765996265411,0,0,22,68.5299983024597,68.5299983024597),(777,'A',1,'2011-06-20',11.0715002596378,0,0,22,50.325001180172,50.325001180172),(778,'A',1,'2011-06-20',62.2665984201431,0,0,22,283.029992818832,283.029992818832),(779,'A',1,'2011-06-20',21.779999423027,0,0,22,98.9999973773956,98.9999973773956),(780,'A',1,'2011-06-20',45.9799981117249,0,0,22,208.999991416931,208.999991416931),(781,'A',1,'2011-06-20',7.92000031471252,0,0,22,36.0000014305115,36.0000014305115),(782,'A',1,'2011-06-20',18.4051999533176,0,0,22,83.6599997878075,83.6599997878075),(783,'A',1,'2011-06-20',95.3424989247322,0,0,22,433.374995112419,433.374995112419),(784,'A',1,'2011-06-20',5.58029992997646,0,0,22,25.3649996817112,25.3649996817112),(785,'A',1,'2011-06-20',26.4,0,0,22,120,120),(786,'A',1,'2011-06-20',22.2232998132706,0,0,22,101.01499915123,101.01499915123),(787,'A',1,'2011-06-20',12.1,0,0,22,55,55),(788,'A',1,'2011-06-20',7.26000028848648,0,0,22,33.0000013113022,33.0000013113022),(789,'A',1,'2011-06-20',3.52,0,0,22,16,16),(790,'A',1,'2011-06-20',49.76399974823,0,0,22,226.199998855591,226.199998855591),(791,'A',1,'2011-06-20',26.4,0,0,22,120,120),(792,'A',1,'2011-06-20',11.6159997403622,0,0,22,52.799998819828,52.799998819828),(793,'A',1,'2011-06-20',24.2572003126144,0,0,22,110.260001420975,110.260001420975),(794,'A',1,'2011-06-20',43.3400009703636,0,0,22,197.000004410744,197.000004410744),(795,'A',1,'2011-06-20',124.387996768951,0,0,22,565.399985313416,565.399985313416),(796,'A',1,'2011-06-20',7.01799979805947,0,0,22,31.8999990820885,31.8999990820885),(797,'A',1,'2011-06-20',13.2,0,0,22,60,60),(798,'A',1,'2011-06-20',15.1854999423027,0,0,22,69.0249997377395,69.0249997377395),(799,'A',1,'2011-06-20',9.79,0,0,22,44.5,44.5),(800,'A',1,'2011-06-20',27.4999994754791,0,0,22,124.999997615814,124.999997615814),(801,'A',1,'2011-06-20',13.2714998006821,0,0,22,60.3249990940094,60.3249990940094),(802,'A',1,'2011-06-20',30.6020015001297,0,0,22,139.100006818771,139.100006818771),(803,'A',1,'2011-06-20',6.05,0,0,22,27.5,27.5),(804,'A',1,'2011-06-20',7.92,0,0,22,36,36),(805,'A',1,'2011-06-20',14.8939998269081,0,0,22,67.6999992132187,67.6999992132187),(806,'A',1,'2011-06-20',35.5300002098084,0,0,22,161.500000953674,161.500000953674),(807,'A',1,'2011-06-20',23.1109995961189,0,0,22,105.049998164177,105.049998164177),(808,'A',1,'2011-06-20',66.4620013952255,0,0,22,302.100006341934,302.100006341934),(809,'A',1,'2011-06-20',1.54,0,0,22,7,7),(810,'A',1,'2011-06-20',23.0999989509583,0,0,22,104.999995231628,104.999995231628),(811,'A',1,'2011-06-20',21.9119995594025,0,0,22,99.599997997284,99.599997997284),(812,'A',1,'2011-06-20',40.4799999475479,0,0,22,183.999999761581,183.999999761581),(813,'A',1,'2011-06-20',34.7600009441376,0,0,22,158.000004291534,158.000004291534),(814,'A',1,'2011-06-20',20.1739999711514,0,0,22,91.6999998688698,91.6999998688698),(815,'A',1,'2011-06-20',13.7059997665882,0,0,22,62.2999989390373,62.2999989390373),(816,'A',1,'2011-06-20',38.4560006713867,0,0,22,174.800003051758,174.800003051758),(817,'A',1,'2011-06-20',22.9900004982948,0,0,22,104.500002264977,104.500002264977),(818,'A',1,'2011-06-20',10.56,0,0,22,48,48),(819,'A',1,'2011-06-20',42.7822988796234,0,0,22,194.464994907379,194.464994907379),(820,'A',1,'2011-06-20',15.0480005979538,0,0,22,68.4000027179718,68.4000027179718),(821,'A',1,'2011-06-20',12.1,0,0,22,55,55),(822,'A',1,'2011-06-20',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(823,'A',1,'2011-06-20',22.8855005979538,0,0,22,104.025002717972,104.025002717972),(824,'A',1,'2011-06-20',16.28,0,0,22,74,74),(825,'A',1,'2011-06-20',22.5225001573563,0,0,22,102.375000715256,102.375000715256),(826,'A',1,'2011-06-20',28.5999989509583,0,0,22,129.999995231628,129.999995231628),(827,'A',1,'2011-06-20',12.1,0,0,22,55,55),(828,'A',1,'2011-06-20',15.18,0,0,22,69,69),(829,'A',1,'2011-06-20',11.7480004668236,0,0,22,53.4000021219254,53.4000021219254),(830,'A',1,'2011-06-20',25.2999994754791,0,0,22,114.999997615814,114.999997615814),(831,'A',1,'2011-06-20',22.3850002884865,0,0,22,101.750001311302,101.750001311302),(832,'A',1,'2011-06-20',29.3040006923676,0,0,22,133.200003147125,133.200003147125),(833,'A',1,'2011-06-20',17.6880004405975,0,0,22,80.4000020027161,80.4000020027161),(834,'A',1,'2011-06-20',19.58,0,0,22,89,89),(835,'A',1,'2011-06-20',25.4099988460541,0,0,22,115.499994754791,115.499994754791),(836,'A',1,'2011-06-20',10.5600001573563,0,0,22,48.0000007152557,48.0000007152557),(837,'A',1,'2011-06-20',12.4299997115135,0,0,22,56.4999986886978,56.4999986886978),(838,'A',1,'2011-06-20',13.9920002937317,0,0,22,63.600001335144,63.600001335144),(839,'A',1,'2011-06-20',12.1,0,0,22,55,55),(840,'A',1,'2011-06-20',6.6,0,0,22,30,30),(841,'A',1,'2011-06-20',31.3280004668236,0,0,22,142.400002121925,142.400002121925),(842,'A',1,'2011-06-20',59.8125,0,0,22,271.875,271.875),(843,'A',1,'2011-06-20',11.1452001172304,0,0,22,50.6600005328655,50.6600005328655),(844,'A',1,'2011-06-20',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(845,'A',1,'2011-06-20',7.37,0,0,22,33.5,33.5),(846,'A',1,'2011-06-20',5.5,0,0,22,25,25),(847,'A',1,'2011-06-20',20.7899998426437,0,0,22,94.4999992847443,94.4999992847443),(848,'A',1,'2011-06-20',71.9620013952255,0,0,22,327.100006341934,327.100006341934),(849,'A',1,'2011-06-20',15.9280004668236,0,0,22,72.4000021219254,72.4000021219254),(850,'A',1,'2011-06-20',20.4600003147125,0,0,22,93.0000014305115,93.0000014305115),(851,'A',1,'2011-06-20',17.16,0,0,22,78,78),(852,'A',1,'2011-06-20',27.8630007815361,0,0,22,126.650003552437,126.650003552437),(853,'A',1,'2011-06-20',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(854,'A',1,'2011-06-20',11.8800004720688,0,0,22,54.0000021457672,54.0000021457672),(855,'A',1,'2011-06-20',10.5732004201412,0,0,22,48.0600019097328,48.0600019097328),(856,'A',1,'2011-06-20',24.2,0,0,22,110,110),(857,'A',1,'2011-06-21',132,0,0,22,600,600),(858,'A',1,'2011-06-21',41.1400011539459,0,0,22,187.000005245209,187.000005245209),(859,'A',1,'2011-06-21',25.525500702858,0,0,22,116.025003194809,116.025003194809),(860,'A',1,'2011-06-21',13.2,0,0,22,60,60),(861,'A',1,'2011-06-21',28.9960006713867,0,0,22,131.800003051758,131.800003051758),(862,'A',1,'2011-06-21',27.94,0,0,22,127,127),(863,'A',1,'2011-06-21',41.4666995310783,0,0,22,188.484997868538,188.484997868538),(864,'A',1,'2011-06-21',48.1799997377396,0,0,22,218.999998807907,218.999998807907),(865,'A',1,'2011-06-21',8.97600009441376,0,0,22,40.8000004291534,40.8000004291534),(866,'A',1,'2011-06-21',34.0559989929199,0,0,22,154.799995422363,154.799995422363),(867,'A',1,'2011-06-21',11.2530000865459,0,0,22,51.1500003933907,51.1500003933907),(868,'A',1,'2011-06-21',84.5680009651184,0,0,22,384.400004386902,384.400004386902),(869,'A',1,'2011-06-21',5.28000007867813,0,0,22,24.0000003576279,24.0000003576279),(870,'A',1,'2011-06-21',70.1492034387589,0,0,22,318.860015630722,318.860015630722),(871,'A',1,'2011-06-21',21.5380004668236,0,0,22,97.9000021219254,97.9000021219254),(872,'A',1,'2011-06-21',1.76,0,0,22,8,8),(873,'A',1,'2011-06-21',24.2,0,0,22,110,110),(874,'A',1,'2011-06-21',25.9160001993179,0,0,22,117.800000905991,117.800000905991),(875,'A',1,'2011-06-21',23.7600009441376,0,0,22,108.000004291534,108.000004291534),(876,'A',1,'2011-06-21',16.9454991817474,0,0,22,77.0249962806702,77.0249962806702),(877,'A',1,'2011-06-21',12.1,0,0,22,55,55),(878,'A',1,'2011-06-21',14.0030003488064,0,0,22,63.6500015854835,63.6500015854835),(879,'A',1,'2011-06-21',20.7547988796234,0,0,22,94.3399949073792,94.3399949073792),(880,'A',1,'2011-06-21',15.0864992499352,0,0,22,68.5749965906143,68.5749965906143),(881,'A',1,'2011-06-21',6.6,0,0,22,30,30),(882,'A',1,'2011-06-20',12.1,0,0,22,55,55),(883,'A',1,'2011-06-21',263.551198749542,0,0,22,1197.9599943161,1197.9599943161),(884,'A',1,'2011-06-21',3.96000015735626,0,0,22,18.0000007152557,18.0000007152557),(885,'A',1,'2011-06-21',40.3919992446899,0,0,22,183.599996566772,183.599996566772),(886,'A',1,'2011-06-21',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(887,'A',1,'2011-06-21',174.811997251511,0,0,22,794.599987506866,794.599987506866),(888,'A',1,'2011-06-21',23.1,0,0,22,105,105),(889,'A',1,'2011-06-21',19.8,0,0,22,90,90),(890,'A',1,'2011-06-21',6.6,0,0,22,30,30),(891,'A',1,'2011-06-21',1.76,0,0,22,8,8),(892,'A',1,'2011-06-21',13.2,0,0,22,60,60),(893,'A',1,'2011-06-21',32.8899993181229,0,0,22,149.499996900558,149.499996900558),(894,'A',1,'2011-06-21',52.6680003881455,0,0,22,239.400001764297,239.400001764297),(895,'A',1,'2011-06-21',16.895999622345,0,0,22,76.7999982833862,76.7999982833862),(896,'A',1,'2011-06-21',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(897,'A',1,'2011-06-21',15.84,0,0,22,72,72),(898,'A',1,'2011-06-21',5.72,0,0,22,26,26),(899,'A',1,'2011-06-21',20.8527011203766,0,0,22,94.7850050926209,94.7850050926209),(900,'A',1,'2011-06-21',6.38,0,0,22,29,29),(901,'A',1,'2011-06-21',14.5200003147125,0,0,22,66.0000014305115,66.0000014305115),(902,'A',1,'2011-06-21',37.07,0,0,22,168.5,168.5),(903,'A',1,'2011-06-21',41.8000016784668,0,0,22,190.000007629395,190.000007629395),(904,'A',1,'2011-06-21',13.1890004038811,0,0,22,59.950001835823,59.950001835823),(905,'A',1,'2011-06-21',22.7810006976128,0,0,22,103.550003170967,103.550003170967),(906,'A',1,'2011-06-21',24.090000629425,0,0,22,109.500002861023,109.500002861023),(907,'A',1,'2011-06-21',26.4,0,0,22,120,120),(908,'A',1,'2011-06-21',2.86,0,0,22,13,13),(909,'A',1,'2011-06-21',18.2599996328354,0,0,22,82.99999833107,82.99999833107),(910,'A',1,'2011-06-21',13.2,0,0,22,60,60),(911,'A',1,'2011-06-21',22.9899997115135,0,0,22,104.499998688698,104.499998688698),(912,'A',1,'2011-06-21',13.2,0,0,22,60,60),(913,'A',1,'2011-06-21',6.6,0,0,22,30,30),(914,'A',1,'2011-06-21',34.5950011014938,0,0,22,157.25000500679,157.25000500679),(915,'A',1,'2011-06-21',18.4469994544983,0,0,22,83.8499975204468,83.8499975204468),(916,'A',1,'2011-06-21',21.9119995594025,0,0,22,99.599997997284,99.599997997284),(917,'A',1,'2011-06-21',9.49630028009415,0,0,22,43.1650012731552,43.1650012731552),(918,'A',1,'2011-06-21',17.4240006923676,0,0,22,79.2000031471252,79.2000031471252),(919,'A',1,'2011-06-21',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(920,'A',1,'2011-06-21',13.2,0,0,22,60,60),(921,'A',1,'2011-06-21',9.9,0,0,22,45,45),(922,'A',1,'2011-06-21',15.729999423027,0,0,22,71.4999973773956,71.4999973773956),(923,'A',1,'2011-06-21',16.39,0,0,22,74.5,74.5),(924,'A',1,'2011-06-21',39.6,0,0,22,180,180),(925,'A',1,'2011-06-22',14.74,0,0,22,67,67),(926,'A',1,'2011-06-22',16.72,0,0,22,76,76),(927,'A',1,'2011-06-22',48.4,0,0,22,220,220),(928,'A',1,'2011-06-22',28.7760008811951,0,0,22,130.800004005432,130.800004005432),(929,'A',1,'2011-06-22',31.7020001888275,0,0,22,144.100000858307,144.100000858307),(930,'A',1,'2011-06-22',6.82,0,0,22,31,31),(931,'A',1,'2011-06-22',26.399999409914,0,0,22,119.999997317791,119.999997317791),(932,'A',1,'2011-06-22',29.4140004038811,0,0,22,133.700001835823,133.700001835823),(933,'A',1,'2011-06-22',25.5749992132187,0,0,22,116.249996423721,116.249996423721),(934,'A',1,'2011-06-22',5.28,0,0,22,24,24),(935,'A',1,'2011-06-22',19.5470006346703,0,0,22,88.8500028848648,88.8500028848648),(936,'A',1,'2011-06-22',79.2550008654594,0,0,22,360.250003933907,360.250003933907),(937,'A',1,'2011-06-22',51.484400703907,0,0,22,234.020003199577,234.020003199577),(938,'A',1,'2011-06-22',44.659999370575,0,0,22,202.999997138977,202.999997138977),(939,'A',1,'2011-06-22',9.46000015735626,0,0,22,43.0000007152557,43.0000007152557),(940,'A',1,'2011-06-22',39.5890004038811,0,0,22,179.950001835823,179.950001835823),(941,'A',1,'2011-06-22',26.4,0,0,22,120,120),(942,'A',1,'2011-06-22',13.2,0,0,22,60,60),(943,'A',1,'2011-06-22',8.80000013113022,0,0,22,40.0000005960465,40.0000005960465),(944,'A',1,'2011-06-22',24.6707998132706,0,0,22,112.13999915123,112.13999915123),(945,'A',1,'2011-06-22',22.6181999218464,0,0,22,102.809999644756,102.809999644756),(946,'A',1,'2011-06-22',13.2,0,0,22,60,60),(947,'A',1,'2011-06-22',5.0159999370575,0,0,22,22.7999997138977,22.7999997138977),(948,'A',1,'2011-06-22',13.3100002884865,0,0,22,60.5000013113022,60.5000013113022),(949,'A',1,'2011-06-22',15.0479998111725,0,0,22,68.3999991416931,68.3999991416931),(950,'A',1,'2011-06-22',11.1320002019405,0,0,22,50.6000009179115,50.6000009179115),(951,'A',1,'2011-06-22',11.1320002019405,0,0,22,50.6000009179115,50.6000009179115),(952,'A',1,'2011-06-22',47.0800002098083,0,0,22,214.000000953674,214.000000953674),(953,'A',1,'2011-06-22',19.58,0,0,22,89,89),(954,'A',1,'2011-06-22',28.0060004353523,0,0,22,127.300001978874,127.300001978874),(955,'A',1,'2011-06-22',34.0527011203766,0,0,22,154.785005092621,154.785005092621),(956,'A',1,'2011-06-22',15.4439994335175,0,0,22,70.1999974250793,70.1999974250793),(957,'A',1,'2011-06-22',57.5299998164177,0,0,22,261.499999165535,261.499999165535),(958,'A',1,'2011-06-22',12.1,0,0,22,55,55),(959,'A',1,'2011-06-22',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(960,'A',1,'2011-06-22',10.1200001835823,0,0,22,46.000000834465,46.000000834465),(961,'A',1,'2011-06-22',24.0834003734589,0,0,22,109.47000169754,109.47000169754),(962,'A',1,'2011-06-22',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(963,'A',1,'2011-06-22',14.9335998153687,0,0,22,67.8799991607666,67.8799991607666),(964,'A',1,'2011-06-22',24.9699995148182,0,0,22,113.499997794628,113.499997794628),(965,'A',1,'2011-06-22',28.7540007054806,0,0,22,130.70000320673,130.70000320673),(966,'A',1,'2011-06-22',22.2640004038811,0,0,22,101.200001835823,101.200001835823),(967,'A',1,'2011-06-22',16.39,0,0,22,74.5,74.5),(968,'A',1,'2011-06-22',15.2899998426437,0,0,22,69.4999992847442,69.4999992847442),(969,'A',1,'2011-06-22',7.92,0,0,22,36,36),(970,'A',1,'2011-06-22',9.59420018672943,0,0,22,43.6100008487701,43.6100008487701),(971,'A',1,'2011-06-22',13.3100002884865,0,0,22,60.5000013113022,60.5000013113022),(972,'A',1,'2011-06-22',38.8388002800941,0,0,22,176.540001273155,176.540001273155),(973,'A',1,'2011-06-22',12.958000099659,0,0,22,58.9000004529953,58.9000004529953),(974,'A',1,'2011-06-22',5.67819983661175,0,0,22,25.8099992573261,25.8099992573261),(975,'A',1,'2011-06-22',12.1,0,0,22,55,55),(976,'A',1,'2011-06-22',39.16,0,0,22,178,178),(977,'A',1,'2011-06-22',29.6999995803833,0,0,22,134.999998092651,134.999998092651),(978,'A',1,'2011-06-22',51.48,0,0,22,234,234),(979,'A',1,'2011-06-22',20.9,0,0,22,95,95),(980,'A',1,'2011-06-22',317.460007762909,0,0,22,1443.00003528595,1443.00003528595),(981,'A',1,'2011-06-22',13.903999774456,0,0,22,63.1999989748001,63.1999989748001),(982,'A',1,'2011-06-22',18.2599996328354,0,0,22,82.99999833107,82.99999833107),(983,'A',1,'2011-06-22',8.36,0,0,22,38,38),(984,'A',1,'2011-06-22',6.6,0,0,22,30,30),(985,'A',1,'2011-06-22',12.7688002800941,0,0,22,58.0400012731552,58.0400012731552),(986,'A',1,'2011-06-22',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(987,'A',1,'2011-06-22',63.8000010490417,0,0,22,290.000004768372,290.000004768372),(988,'A',1,'2011-06-22',38.0600004196167,0,0,22,173.000001907349,173.000001907349),(989,'A',1,'2011-06-22',22.3850002884865,0,0,22,101.750001311302,101.750001311302),(990,'A',1,'2011-06-22',12.1,0,0,22,55,55),(991,'A',1,'2011-06-22',59.1799976921082,0,0,22,268.999989509583,268.999989509583),(992,'A',1,'2011-06-22',3.96,0,0,22,18,18),(993,'A',1,'2011-06-22',66.0880009257793,0,0,22,300.400004208088,300.400004208088),(994,'A',1,'2011-06-22',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(995,'A',1,'2011-06-22',41.5800012588501,0,0,22,189.000005722046,189.000005722046),(996,'A',1,'2011-06-22',28.3800012588501,0,0,22,129.000005722046,129.000005722046),(997,'A',1,'2011-06-22',21.342200653553,0,0,22,97.0100029706955,97.0100029706955),(998,'A',1,'2011-06-22',18.2159999370575,0,0,22,82.7999997138977,82.7999997138977),(999,'A',1,'2011-06-22',14.2560005664825,0,0,22,64.8000025749207,64.8000025749207),(1000,'A',1,'2011-06-22',8.65920005232096,0,0,22,39.3600002378225,39.3600002378225),(1001,'A',1,'2011-06-22',6.16,0,0,22,28,28),(1002,'A',1,'2011-06-22',13.112000195384,0,0,22,59.6000008881092,59.6000008881092),(1003,'A',1,'2011-06-22',52.58,0,0,22,239,239),(1004,'A',1,'2011-06-22',20.6910001993179,0,0,22,94.0500009059906,94.0500009059906),(1005,'A',1,'2011-06-22',16.39,0,0,22,74.5,74.5),(1006,'A',1,'2011-06-22',54.8239990663528,0,0,22,249.199995756149,249.199995756149),(1007,'A',1,'2011-06-22',27.5,0,0,22,125,125),(1008,'A',1,'2011-06-22',12.495999622345,0,0,22,56.7999982833862,56.7999982833862),(1009,'A',1,'2011-06-22',13.3979995816946,0,0,22,60.8999980986118,60.8999980986118),(1010,'A',1,'2011-06-22',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(1011,'A',1,'2011-06-22',22.3299996197224,0,0,22,101.499998271465,101.499998271465),(1012,'A',1,'2011-06-22',12.1,0,0,22,55,55),(1013,'A',1,'2011-06-22',23.2319994807243,0,0,22,105.599997639656,105.599997639656),(1014,'A',1,'2011-06-22',13.7059997665882,0,0,22,62.2999989390373,62.2999989390373),(1015,'A',1,'2011-06-22',13.2,0,0,22,60,60),(1016,'A',1,'2011-06-22',23.3750006556511,0,0,22,106.250002980232,106.250002980232),(1017,'A',1,'2011-06-22',31.9,0,0,22,145,145),(1018,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1019,'A',1,'2011-06-23',4.4,0,0,22,20,20),(1020,'A',1,'2011-06-23',44.2530007815361,0,0,22,201.150003552437,201.150003552437),(1021,'A',1,'2011-06-23',21.3070001363754,0,0,22,96.8500006198883,96.8500006198883),(1022,'A',1,'2011-06-23',96.8,0,0,22,440,440),(1023,'A',1,'2011-06-23',85.1839995384216,0,0,22,387.199997901917,387.199997901917),(1024,'A',1,'2011-06-23',26.4,0,0,22,120,120),(1025,'A',1,'2011-06-23',12.1,0,0,22,55,55),(1026,'A',1,'2011-06-23',27.829999423027,0,0,22,126.499997377396,126.499997377396),(1027,'A',1,'2011-06-23',24.6839995384216,0,0,22,112.199997901917,112.199997901917),(1028,'A',1,'2011-06-23',41.20820089221,0,0,22,187.3100040555,187.3100040555),(1029,'A',1,'2011-06-23',13.3759997010231,0,0,22,60.7999986410141,60.7999986410141),(1030,'A',1,'2011-06-23',57.6466004395485,0,0,22,262.030001997948,262.030001997948),(1031,'A',1,'2011-06-23',45.1000001311302,0,0,22,205.000000596046,205.000000596046),(1032,'A',1,'2011-06-23',13.1890004038811,0,0,22,59.950001835823,59.950001835823),(1033,'A',1,'2011-06-23',11,0,0,22,50,50),(1034,'A',1,'2011-06-23',21.3179996013641,0,0,22,96.8999981880188,96.8999981880188),(1035,'A',1,'2011-06-23',22.3850002884865,0,0,22,101.750001311302,101.750001311302),(1036,'A',1,'2011-06-23',12.4079999685287,0,0,22,56.3999998569488,56.3999998569488),(1037,'A',1,'2011-06-23',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(1038,'A',1,'2011-06-23',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(1039,'A',1,'2011-06-23',34.4960001468658,0,0,22,156.800000667572,156.800000667572),(1040,'A',1,'2011-06-23',12.979999423027,0,0,22,58.9999973773956,58.9999973773956),(1041,'A',1,'2011-06-23',46.6730005979538,0,0,22,212.150002717972,212.150002717972),(1042,'A',1,'2011-06-23',17.3029993653297,0,0,22,78.6499971151352,78.6499971151352),(1043,'A',1,'2011-06-23',28.9784003734589,0,0,22,131.72000169754,131.72000169754),(1044,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1045,'A',1,'2011-06-23',61.9190017938614,0,0,22,281.450008153915,281.450008153915),(1046,'A',1,'2011-06-23',31.2136003267765,0,0,22,141.880001485348,141.880001485348),(1047,'A',1,'2011-06-23',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(1048,'A',1,'2011-06-23',57.3991000723839,0,0,22,260.905000329018,260.905000329018),(1049,'A',1,'2011-06-23',13.2000001966953,0,0,22,60.0000008940697,60.0000008940697),(1050,'A',1,'2011-06-23',29.534999370575,0,0,22,134.249997138977,134.249997138977),(1051,'A',1,'2011-06-23',4.48800004720688,0,0,22,20.4000002145767,20.4000002145767),(1052,'A',1,'2011-06-23',14.74,0,0,22,67,67),(1053,'A',1,'2011-06-23',11.2200001180172,0,0,22,51.0000005364418,51.0000005364418),(1054,'A',1,'2011-06-23',1.76,0,0,22,8,8),(1055,'A',1,'2011-06-23',12.1,0,0,22,55,55),(1056,'A',1,'2011-06-23',24.2,0,0,22,110,110),(1057,'A',1,'2011-06-23',22.3850002884865,0,0,22,101.750001311302,101.750001311302),(1058,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1059,'A',1,'2011-06-23',23.6016009378433,0,0,22,107.280004262924,107.280004262924),(1060,'A',1,'2011-06-23',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(1061,'A',1,'2011-06-23',14.74,0,0,22,67,67),(1062,'A',1,'2011-06-23',16.8794997692108,0,0,22,76.7249989509583,76.7249989509583),(1063,'A',1,'2011-06-23',22.8799991607666,0,0,22,103.999996185303,103.999996185303),(1064,'A',1,'2011-06-23',7.69999986886978,0,0,22,34.9999994039535,34.9999994039535),(1065,'A',1,'2011-06-23',6.6,0,0,22,30,30),(1066,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1067,'A',1,'2011-06-23',15.84,0,0,22,72,72),(1068,'A',1,'2011-06-23',73.4799988460541,0,0,22,333.999994754791,333.999994754791),(1069,'A',1,'2011-06-23',38.3900007605553,0,0,22,174.500003457069,174.500003457069),(1070,'A',1,'2011-06-23',43.6699986886978,0,0,22,198.499994039536,198.499994039536),(1071,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1072,'A',1,'2011-06-23',32.5159999370575,0,0,22,147.799999713898,147.799999713898),(1073,'A',1,'2011-06-23',22.8800001442432,0,0,22,104.000000655651,104.000000655651),(1074,'A',1,'2011-06-23',13.2,0,0,22,60,60),(1075,'A',1,'2011-06-23',32.7140006005764,0,0,22,148.700002729893,148.700002729893),(1076,'A',1,'2011-06-23',20.9506010270119,0,0,22,95.2300046682358,95.2300046682358),(1077,'A',1,'2011-06-23',24.9865006923676,0,0,22,113.575003147125,113.575003147125),(1078,'A',1,'2011-06-23',4.62,0,0,22,21,21),(1079,'A',1,'2011-06-23',16.2800002098084,0,0,22,74.0000009536743,74.0000009536743),(1080,'A',1,'2011-06-23',144.232003126144,0,0,22,655.600014209747,655.600014209747),(1081,'A',1,'2011-06-23',1.54,0,0,22,7,7),(1082,'A',1,'2011-06-23',32.670000576973,0,0,22,148.500002622604,148.500002622604),(1083,'A',1,'2011-06-23',21.45,0,0,22,97.5,97.5),(1084,'A',1,'2011-06-23',6.6,0,0,22,30,30),(1085,'A',1,'2011-06-23',24.7224995017052,0,0,22,112.374997735023,112.374997735023),(1086,'A',1,'2011-06-23',56.9909999370575,0,0,22,259.049999713898,259.049999713898),(1087,'A',1,'2011-06-23',9.90000039339066,0,0,22,45.0000017881393,45.0000017881393),(1088,'A',1,'2011-06-23',137.565999596119,0,0,22,625.299998164177,625.299998164177),(1089,'A',1,'2011-06-23',51.6450018882751,0,0,22,234.750008583069,234.750008583069),(1090,'A',1,'2011-06-23',1.54,0,0,22,7,7),(1091,'A',1,'2011-06-23',39.16,0,0,22,178,178),(1092,'A',1,'2011-06-23',27.1040001153946,0,0,22,123.200000524521,123.200000524521),(1093,'A',1,'2011-06-23',6.65500014424324,0,0,22,30.2500006556511,30.2500006556511),(1094,'A',1,'2011-06-23',16.6099998950958,0,0,22,75.4999995231628,75.4999995231628),(1095,'A',1,'2011-06-23',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1096,'A',1,'2011-06-23',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1097,'A',1,'2011-06-23',23.3991994917393,0,0,22,106.359997689724,106.359997689724),(1098,'A',1,'2011-06-23',42.4600011539459,0,0,22,193.000005245209,193.000005245209),(1099,'A',1,'2011-06-23',37.5099988460541,0,0,22,170.499994754791,170.499994754791),(1100,'A',1,'2011-06-23',12.1626999533176,0,0,22,55.2849997878075,55.2849997878075),(1101,'A',1,'2011-06-23',27.1040001153946,0,0,22,123.200000524521,123.200000524521),(1102,'A',1,'2011-06-23',28.2480013847351,0,0,22,128.40000629425,128.40000629425),(1103,'A',1,'2011-06-23',22.8106992530823,0,0,22,103.684996604919,103.684996604919),(1104,'A',1,'2011-06-23',12.4629996538162,0,0,22,56.6499984264374,56.6499984264374),(1105,'A',1,'2011-06-23',13.5849995017052,0,0,22,61.7499977350235,61.7499977350235),(1106,'A',1,'2011-06-23',22.3630010962486,0,0,22,101.650004982948,101.650004982948),(1107,'A',1,'2011-06-23',12.1,0,0,22,55,55),(1108,'A',1,'2011-06-23',22.2200002098084,0,0,22,101.000000953674,101.000000953674),(1109,'A',1,'2011-06-23',21.1200003147125,0,0,22,96.0000014305115,96.0000014305115),(1110,'A',1,'2011-06-23',52.0080012273788,0,0,22,236.400005578995,236.400005578995),(1111,'A',1,'2011-06-23',14.52,0,0,22,66,66),(1112,'A',1,'2011-06-23',58.3880008864403,0,0,22,265.400004029274,265.400004029274),(1113,'A',1,'2011-06-24',61.6549998950958,0,0,22,280.249999523163,280.249999523163),(1114,'A',1,'2011-06-24',9.43799965381622,0,0,22,42.8999984264374,42.8999984264374),(1115,'A',1,'2011-06-24',11.6159999370575,0,0,22,52.7999997138977,52.7999997138977),(1116,'A',1,'2011-06-24',59.9500013113022,0,0,22,272.500005960464,272.500005960464),(1117,'A',1,'2011-06-24',2.64,0,0,22,12,12),(1118,'A',1,'2011-06-24',35.6840006923676,0,0,22,162.200003147125,162.200003147125),(1119,'A',1,'2011-06-24',45.2540001153946,0,0,22,205.700000524521,205.700000524521),(1120,'A',1,'2011-06-24',8.71200034618378,0,0,22,39.6000015735626,39.6000015735626),(1121,'A',1,'2011-06-24',90.640000629425,0,0,22,412.000002861023,412.000002861023),(1122,'A',1,'2011-06-24',20.1300004720688,0,0,22,91.5000021457672,91.5000021457672),(1123,'A',1,'2011-06-24',26.4330004668236,0,0,22,120.150002121925,120.150002121925),(1124,'A',1,'2011-06-24',5.94,0,0,22,27,27),(1125,'A',1,'2011-06-24',20.9506010270119,0,0,22,95.2300046682358,95.2300046682358),(1126,'A',1,'2011-06-24',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(1127,'A',1,'2011-06-24',13.0680005192757,0,0,22,59.4000023603439,59.4000023603439),(1128,'A',1,'2011-06-24',30.25,0,0,22,137.5,137.5),(1129,'A',1,'2011-06-24',16.5,0,0,22,75,75),(1130,'A',1,'2011-06-24',25.9269995331764,0,0,22,117.849997878075,117.849997878075),(1131,'A',1,'2011-06-24',46.7500013113022,0,0,22,212.500005960464,212.500005960464),(1132,'A',1,'2011-06-24',33.2860009336472,0,0,22,151.300004243851,151.300004243851),(1133,'A',1,'2011-06-24',12.5400004982948,0,0,22,57.0000022649765,57.0000022649765),(1134,'A',1,'2011-06-24',15.729999423027,0,0,22,71.4999973773956,71.4999973773956),(1135,'A',1,'2011-06-24',11.1605998599529,0,0,22,50.7299993634224,50.7299993634224),(1136,'A',1,'2011-06-24',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(1137,'A',1,'2011-06-24',22.972399610281,0,0,22,104.41999822855,104.41999822855),(1138,'A',1,'2011-06-24',17.6660004615784,0,0,22,80.3000020980835,80.3000020980835),(1139,'A',1,'2011-06-24',15.3119995594025,0,0,22,69.599997997284,69.599997997284),(1140,'A',1,'2011-06-24',16.5,0,0,22,75,75),(1141,'A',1,'2011-06-24',70.1800023078918,0,0,22,319.000010490417,319.000010490417),(1142,'A',1,'2011-06-24',8.44799981117249,0,0,22,38.3999991416931,38.3999991416931),(1143,'A',1,'2011-06-24',1.54,0,0,22,7,7),(1144,'A',1,'2011-06-24',43.0759993076324,0,0,22,195.799996852875,195.799996852875),(1145,'A',1,'2011-06-24',6.6,0,0,22,30,30),(1146,'A',1,'2011-06-24',42.8449990034103,0,0,22,194.749995470047,194.749995470047),(1147,'A',1,'2011-06-24',59.9830014109612,0,0,22,272.65000641346,272.65000641346),(1148,'A',1,'2011-06-24',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(1149,'A',1,'2011-06-24',22.1759993076324,0,0,22,100.799996852875,100.799996852875),(1150,'A',1,'2011-06-24',5.0159999370575,0,0,22,22.7999997138977,22.7999997138977),(1151,'A',1,'2011-06-24',17.9520001888275,0,0,22,81.6000008583069,81.6000008583069),(1152,'A',1,'2011-06-24',21.284999370575,0,0,22,96.7499971389771,96.7499971389771),(1153,'A',1,'2011-06-24',19.58,0,0,22,89,89),(1154,'A',1,'2011-06-24',9.79,0,0,22,44.5,44.5),(1155,'A',1,'2011-06-24',12.1440002202988,0,0,22,55.200001001358,55.200001001358),(1156,'A',1,'2011-06-24',21.6348008596897,0,0,22,98.3400039076805,98.3400039076805),(1157,'A',1,'2011-06-24',5.28000007867813,0,0,22,24.0000003576279,24.0000003576279),(1158,'A',1,'2011-06-24',1.54,0,0,22,7,7),(1159,'A',1,'2011-06-24',39.6,0,0,22,180,180),(1160,'A',1,'2011-06-24',22.1759993076324,0,0,22,100.799996852875,100.799996852875),(1161,'A',1,'2011-06-24',22.1759993076324,0,0,22,100.799996852875,100.799996852875),(1162,'A',1,'2011-06-24',12.704999423027,0,0,22,57.7499973773956,57.7499973773956),(1163,'A',1,'2011-06-24',26.4,0,0,22,120,120),(1164,'A',1,'2011-06-24',24.2,0,0,22,110,110),(1165,'A',1,'2011-06-24',54.8239990663528,0,0,22,249.199995756149,249.199995756149),(1166,'A',1,'2011-06-24',24.9127996873856,0,0,22,113.239998579025,113.239998579025),(1167,'A',1,'2011-06-24',29.0400006294251,0,0,22,132.000002861023,132.000002861023),(1168,'A',1,'2011-06-24',13.2,0,0,22,60,60),(1169,'A',1,'2011-06-24',37.84,0,0,22,172,172),(1170,'A',1,'2011-06-24',80.3439983844757,0,0,22,365.199992656708,365.199992656708),(1171,'A',1,'2011-06-24',43.8845004379749,0,0,22,199.475001990795,199.475001990795),(1172,'A',1,'2011-06-24',97.7679990768432,0,0,22,444.399995803833,444.399995803833),(1173,'A',1,'2011-06-24',43.4114988565445,0,0,22,197.324994802475,197.324994802475),(1174,'A',1,'2011-06-24',36.4209994912148,0,0,22,165.54999768734,165.54999768734),(1175,'A',1,'2011-06-24',34.3695001363754,0,0,22,156.225000619888,156.225000619888),(1176,'A',1,'2011-06-24',31.9000006294251,0,0,22,145.000002861023,145.000002861023),(1177,'A',1,'2011-06-24',9.68,0,0,22,44,44),(1178,'A',1,'2011-06-24',44.9129988670349,0,0,22,204.149994850159,204.149994850159),(1179,'A',1,'2011-06-24',92.1579988670349,0,0,22,418.899994850159,418.899994850159),(1180,'A',1,'2011-06-24',44.1650003671646,0,0,22,200.75000166893,200.75000166893),(1181,'A',1,'2011-06-24',22,0,0,22,100,100),(1182,'A',1,'2011-06-24',13.2,0,0,22,60,60),(1183,'A',1,'2011-06-24',31.4599988460541,0,0,22,142.999994754791,142.999994754791),(1184,'A',1,'2011-06-24',12.1,0,0,22,55,55),(1185,'A',1,'2011-06-24',69.8939981746674,0,0,22,317.699991703034,317.699991703034),(1186,'A',1,'2011-06-24',11.5499998033047,0,0,22,52.4999991059303,52.4999991059303),(1187,'A',1,'2011-06-24',46.2505993747711,0,0,22,210.229997158051,210.229997158051),(1188,'A',1,'2011-06-24',29.5459996092319,0,0,22,134.299998223782,134.299998223782),(1189,'A',1,'2011-06-24',22.2860006451607,0,0,22,101.300002932549,101.300002932549),(1190,'A',1,'2011-06-24',17.2590002596378,0,0,22,78.450001180172,78.450001180172),(1191,'A',1,'2011-06-24',44.0440019249916,0,0,22,200.200008749962,200.200008749962),(1192,'A',1,'2011-06-24',13.2,0,0,22,60,60),(1193,'A',1,'2011-06-24',62.4359981536865,0,0,22,283.799991607666,283.799991607666),(1194,'A',1,'2011-06-24',8.91000035405159,0,0,22,40.5000016093254,40.5000016093254),(1195,'A',1,'2011-06-24',26.1800012588501,0,0,22,119.000005722046,119.000005722046),(1196,'A',1,'2011-06-24',16.8079996538162,0,0,22,76.3999984264374,76.3999984264374),(1197,'A',1,'2011-06-24',22.2904002344608,0,0,22,101.320001065731,101.320001065731),(1198,'A',1,'2011-06-24',58.74,0,0,22,267,267),(1199,'A',1,'2011-06-24',20.9549996852875,0,0,22,95.2499985694885,95.2499985694885),(1200,'A',1,'2011-06-24',7.92000031471252,0,0,22,36.0000014305115,36.0000014305115),(1201,'A',1,'2011-06-24',36.2999994754791,0,0,22,164.999997615814,164.999997615814),(1202,'A',1,'2011-06-24',26.4,0,0,22,120,120),(1203,'A',1,'2011-06-24',26.729999423027,0,0,22,121.499997377396,121.499997377396),(1204,'A',1,'2011-06-24',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1205,'A',1,'2011-06-24',37.5099988460541,0,0,22,170.499994754791,170.499994754791),(1206,'A',1,'2011-06-24',28.5956001156569,0,0,22,129.980000525713,129.980000525713),(1207,'A',1,'2011-06-24',6.16,0,0,22,28,28),(1208,'A',1,'2011-06-24',19.7120000839233,0,0,22,89.6000003814697,89.6000003814697),(1209,'A',1,'2011-06-24',9.89999973773956,0,0,22,44.9999988079071,44.9999988079071),(1210,'A',1,'2011-06-24',7.13899968266487,0,0,22,32.4499985575676,32.4499985575676),(1211,'A',1,'2011-06-24',32.340000629425,0,0,22,147.000002861023,147.000002861023),(1212,'A',1,'2011-06-24',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1213,'A',1,'2011-06-24',22.4400006294251,0,0,22,102.000002861023,102.000002861023),(1214,'A',1,'2011-06-24',50.6,0,0,22,230,230),(1215,'A',1,'2011-06-24',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1216,'A',1,'2011-06-24',35.8599998950958,0,0,22,162.999999523163,162.999999523163),(1217,'A',1,'2011-06-24',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1218,'A',1,'2011-06-24',65.4170023918152,0,0,22,297.350010871887,297.350010871887),(1219,'A',1,'2011-06-25',59.5980002307892,0,0,22,270.900001049042,270.900001049042),(1220,'A',1,'2011-06-25',21.6700003147125,0,0,22,98.5000014305115,98.5000014305115),(1221,'A',1,'2011-06-25',39.929999423027,0,0,22,181.499997377396,181.499997377396),(1222,'A',1,'2011-06-25',79.2,0,0,22,360,360),(1223,'A',1,'2011-06-25',42.3906992530823,0,0,22,192.684996604919,192.684996604919),(1224,'A',1,'2011-06-25',9.20259997665882,0,0,22,41.8299998939037,41.8299998939037),(1225,'A',1,'2011-06-25',9.24000036716461,0,0,22,42.0000016689301,42.0000016689301),(1226,'A',1,'2011-06-25',6.82,0,0,22,31,31),(1227,'A',1,'2011-06-25',39.6,0,0,22,180,180),(1228,'A',1,'2011-06-25',12.5311997199059,0,0,22,56.9599987268448,56.9599987268448),(1229,'A',1,'2011-06-25',52.8,0,0,22,240,240),(1230,'A',1,'2011-06-25',106.323800384998,0,0,22,483.290001749992,483.290001749992),(1231,'A',1,'2011-06-25',9.79,0,0,22,44.5,44.5),(1232,'A',1,'2011-06-25',33.2860009336472,0,0,22,151.300004243851,151.300004243851),(1233,'A',1,'2011-06-25',27.7969994544983,0,0,22,126.349997520447,126.349997520447),(1234,'A',1,'2011-06-25',63.2280021190643,0,0,22,287.400009632111,287.400009632111),(1235,'A',1,'2011-06-25',53.2400011539459,0,0,22,242.000005245209,242.000005245209),(1236,'A',1,'2011-06-25',65.5599988460541,0,0,22,297.999994754791,297.999994754791),(1237,'A',1,'2011-06-25',22.1759993076324,0,0,22,100.799996852875,100.799996852875),(1238,'A',1,'2011-06-25',22.1759993076324,0,0,22,100.799996852875,100.799996852875),(1239,'A',1,'2011-06-25',15.840000629425,0,0,22,72.0000028610229,72.0000028610229),(1240,'A',1,'2011-06-25',1.54,0,0,22,7,7),(1241,'A',1,'2011-06-25',16.1567998158932,0,0,22,73.4399991631508,73.4399991631508),(1242,'A',1,'2011-06-25',20.9,0,0,22,95,95),(1243,'A',1,'2011-06-25',13.2,0,0,22,60,60),(1244,'A',1,'2011-06-25',70.1800023078918,0,0,22,319.000010490417,319.000010490417),(1245,'A',1,'2011-06-25',80.6739984369278,0,0,22,366.699992895126,366.699992895126),(1246,'A',1,'2011-06-25',67.9095977592468,0,0,22,308.679989814758,308.679989814758),(1247,'A',1,'2011-06-25',31.3280004668236,0,0,22,142.400002121925,142.400002121925),(1248,'A',1,'2011-06-25',28.9080007553101,0,0,22,131.400003433228,131.400003433228),(1249,'A',1,'2011-06-25',13.2,0,0,22,60,60),(1250,'A',1,'2011-06-25',72.0444994807243,0,0,22,327.474997639656,327.474997639656),(1251,'A',1,'2011-06-25',6.6,0,0,22,30,30),(1252,'A',1,'2011-06-25',23.7600009441376,0,0,22,108.000004291534,108.000004291534),(1253,'A',1,'2011-06-25',4.75200018882751,0,0,22,21.6000008583069,21.6000008583069),(1254,'A',1,'2011-06-25',13.2,0,0,22,60,60),(1255,'A',1,'2011-06-25',11.1320002019405,0,0,22,50.6000009179115,50.6000009179115),(1256,'A',1,'2011-06-25',14.0976005601883,0,0,22,64.0800025463104,64.0800025463104),(1257,'A',1,'2011-06-25',156.992002077103,0,0,22,713.600009441376,713.600009441376),(1258,'A',1,'2011-06-25',16.28,0,0,22,74,74),(1259,'A',1,'2011-06-25',48.0699990034103,0,0,22,218.499995470047,218.499995470047),(1260,'A',1,'2011-06-25',33.2144986152649,0,0,22,150.97499370575,150.97499370575),(1261,'A',1,'2011-06-25',43.8592001867294,0,0,22,199.36000084877,199.36000084877),(1262,'A',1,'2011-06-25',32.56,0,0,22,148,148),(1263,'A',1,'2011-06-25',31.9,0,0,22,145,145),(1264,'A',1,'2011-06-25',52.0849995017052,0,0,22,236.749997735024,236.749997735024),(1265,'A',1,'2011-06-25',21.8404991030693,0,0,22,99.2749959230423,99.2749959230423),(1266,'A',1,'2011-06-25',22.7479999423027,0,0,22,103.39999973774,103.39999973774),(1267,'A',1,'2011-06-25',23.32,0,0,22,106,106),(1268,'A',1,'2011-06-25',49.94,0,0,22,227,227),(1269,'A',1,'2011-06-25',53.1080002307892,0,0,22,241.400001049042,241.400001049042),(1270,'A',1,'2011-06-25',11.3739999711514,0,0,22,51.6999998688698,51.6999998688698),(1271,'A',1,'2011-06-25',27.4559989929199,0,0,22,124.799995422363,124.799995422363),(1272,'A',1,'2011-06-25',15.3064998269081,0,0,22,69.5749992132187,69.5749992132187),(1273,'A',1,'2011-06-25',11.8800004720688,0,0,22,54.0000021457672,54.0000021457672),(1274,'A',1,'2011-06-25',4.75200018882751,0,0,22,21.6000008583069,21.6000008583069),(1275,'A',1,'2011-06-25',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(1276,'A',1,'2011-06-25',6.6,0,0,22,30,30),(1277,'A',1,'2011-06-25',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1278,'A',1,'2011-06-25',26.4,0,0,22,120,120),(1279,'A',1,'2011-06-25',2.2,0,0,22,10,10),(1280,'A',1,'2011-06-25',6.6,0,0,22,30,30),(1281,'A',1,'2011-06-25',28.1952011203766,0,0,22,128.160005092621,128.160005092621),(1282,'A',1,'2011-06-25',6.6,0,0,22,30,30),(1283,'A',1,'2011-06-25',26.4,0,0,22,120,120),(1284,'A',1,'2011-06-25',12.32,0,0,22,56,56),(1285,'A',1,'2011-06-25',17.6,0,0,22,80,80),(1286,'A',1,'2011-06-25',6.16,0,0,22,28,28),(1287,'A',1,'2011-06-25',13.3100002884865,0,0,22,60.5000013113022,60.5000013113022),(1288,'A',1,'2011-06-25',17.1379998505115,0,0,22,77.899999320507,77.899999320507),(1289,'A',1,'2011-06-25',22.7479999423027,0,0,22,103.39999973774,103.39999973774),(1290,'A',1,'2011-06-25',4.18,0,0,22,19,19),(1291,'A',1,'2011-06-25',22.8799991607666,0,0,22,103.999996185303,103.999996185303),(1292,'A',1,'2011-06-25',32.0650011539459,0,0,22,145.750005245209,145.750005245209),(1293,'A',1,'2011-06-25',22.44,0,0,22,102,102),(1294,'A',1,'2011-06-25',31.0969991922379,0,0,22,141.349996328354,141.349996328354),(1295,'A',1,'2011-06-25',20.2730005979538,0,0,22,92.1500027179718,92.1500027179718),(1296,'A',1,'2011-06-25',19.8,0,0,22,90,90),(1297,'A',1,'2011-06-25',26.4,0,0,22,120,120),(1298,'A',1,'2011-06-25',18.1929002344608,0,0,22,82.695001065731,82.695001065731),(1299,'A',1,'2011-06-25',66.2200029373169,0,0,22,301.00001335144,301.00001335144),(1300,'A',1,'2011-06-25',49.4823997020721,0,0,22,224.919998645782,224.919998645782),(1301,'A',1,'2011-06-25',41.1179981327057,0,0,22,186.899991512299,186.899991512299),(1302,'A',1,'2011-06-25',39.6879996538162,0,0,22,180.399998426437,180.399998426437),(1303,'A',1,'2011-06-25',28.5120011329651,0,0,22,129.600005149841,129.600005149841),(1304,'A',1,'2011-06-25',22.6050000786781,0,0,22,102.750000357628,102.750000357628),(1305,'A',1,'2011-06-25',22.6181999218464,0,0,22,102.809999644756,102.809999644756),(1306,'A',1,'2011-06-25',14.52,0,0,22,66,66),(1307,'A',1,'2011-06-25',21.6039995908737,0,0,22,98.1999981403351,98.1999981403351),(1308,'A',1,'2011-06-25',2.2,0,0,22,10,10),(1309,'A',1,'2011-06-25',26.0601005470753,0,0,22,118.455002486706,118.455002486706),(1310,'A',1,'2011-06-25',60.1040000629425,0,0,22,273.200000286102,273.200000286102),(1311,'A',1,'2011-06-25',211.040497319698,0,0,22,959.274987816811,959.274987816811),(1312,'A',1,'2011-06-25',6.16,0,0,22,28,28),(1313,'A',1,'2011-06-25',26.4000010490417,0,0,22,120.000004768372,120.000004768372),(1314,'A',1,'2011-06-25',97.3235986483097,0,0,22,442.379993855953,442.379993855953),(1315,'A',1,'2011-06-25',54.5710027694702,0,0,22,248.050012588501,248.050012588501),(1316,'A',1,'2011-06-25',4.84000007212162,0,0,22,22.0000003278256,22.0000003278256),(1317,'A',1,'2011-06-25',26.4,0,0,22,120,120),(1318,'A',1,'2011-06-25',13.2,0,0,22,60,60),(1319,'A',1,'2011-06-25',11.8800004720688,0,0,22,54.0000021457672,54.0000021457672),(1320,'A',1,'2011-06-25',11.4400001704693,0,0,22,52.0000007748604,52.0000007748604),(1321,'A',1,'2011-06-25',72.1160004615784,0,0,22,327.800002098084,327.800002098084),(1322,'A',1,'2011-06-25',20.79,0,0,22,94.5,94.5),(1323,'A',1,'2011-06-25',40.7879988670349,0,0,22,185.399994850159,185.399994850159),(1324,'A',1,'2011-06-25',59.5320009231567,0,0,22,270.600004196167,270.600004196167),(1325,'A',1,'2011-06-25',18.2160005271435,0,0,22,82.8000023961067,82.8000023961067),(1326,'A',1,'2011-06-25',77.6710025072098,0,0,22,353.050011396408,353.050011396408),(1327,'A',1,'2011-06-25',64.1300003409386,0,0,22,291.500001549721,291.500001549721),(1328,'A',1,'2011-06-25',10.8899997115135,0,0,22,49.4999986886978,49.4999986886978),(1329,'A',1,'2011-06-25',59.2129996538162,0,0,22,269.149998426437,269.149998426437),(1330,'A',1,'2011-06-25',18.479999423027,0,0,22,83.9999973773956,83.9999973773956),(1331,'A',1,'2011-06-25',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1332,'A',1,'2011-06-25',41.623999774456,0,0,22,189.1999989748,189.1999989748),(1333,'A',1,'2011-06-25',21.7359992027283,0,0,22,98.7999963760376,98.7999963760376),(1334,'A',1,'2011-06-25',24.2550004720688,0,0,22,110.250002145767,110.250002145767),(1335,'A',1,'2011-06-25',40.590000629425,0,0,22,184.500002861023,184.500002861023),(1336,'A',1,'2011-06-25',24.0185001730919,0,0,22,109.175000786781,109.175000786781),(1337,'A',1,'2011-06-25',36.9655008077621,0,0,22,168.025003671646,168.025003671646),(1338,'A',1,'2011-06-25',20.8780005455017,0,0,22,94.9000024795532,94.9000024795532),(1339,'A',1,'2011-06-25',120.040801544189,0,0,22,545.640007019043,545.640007019043),(1340,'A',1,'2011-06-25',71.216201581955,0,0,22,323.710007190704,323.710007190704),(1341,'A',1,'2011-06-25',14.685,0,0,22,66.75,66.75),(1342,'A',1,'2011-06-25',16.5879996538162,0,0,22,75.3999984264374,75.3999984264374),(1343,'A',1,'2011-06-25',62.8319990873337,0,0,22,285.599995851517,285.599995851517),(1344,'A',1,'2011-06-25',5.94000023603439,0,0,22,27.0000010728836,27.0000010728836),(1345,'A',1,'2011-06-25',14.08,0,0,22,64,64),(1346,'A',1,'2011-06-26',53.0969994544983,0,0,22,241.349997520447,241.349997520447),(1347,'A',1,'2011-06-26',80.6069003367424,0,0,22,366.395001530647,366.395001530647),(1348,'A',1,'2011-06-26',92.758596714139,0,0,22,421.629985064268,421.629985064268),(1349,'A',1,'2011-06-26',135.465002202988,0,0,22,615.75001001358,615.75001001358),(1350,'A',1,'2011-06-26',96.5360027694702,0,0,22,438.800012588501,438.800012588501),(1351,'A',1,'2011-06-26',25.1679990768433,0,0,22,114.399995803833,114.399995803833),(1352,'A',1,'2011-06-26',39.7705002307892,0,0,22,180.775001049042,180.775001049042),(1353,'A',1,'2011-06-26',176.435599794388,0,0,22,801.979999065399,801.979999065399),(1354,'A',1,'2011-06-26',30.3159999370575,0,0,22,137.799999713898,137.799999713898),(1355,'A',1,'2011-06-26',48.6969988775253,0,0,22,221.349994897842,221.349994897842),(1356,'A',1,'2011-06-26',37.6199997901916,0,0,22,170.999999046326,170.999999046326),(1357,'A',1,'2011-06-26',7.12800028324127,0,0,22,32.4000012874603,32.4000012874603),(1358,'A',1,'2011-06-26',26.5594991922379,0,0,22,120.724996328354,120.724996328354),(1359,'A',1,'2011-06-26',39.16,0,0,22,178,178),(1360,'A',1,'2011-06-26',38.2800012588501,0,0,22,174.000005722046,174.000005722046),(1361,'A',1,'2011-06-26',43.9009997665882,0,0,22,199.549998939037,199.549998939037),(1362,'A',1,'2011-06-26',43.46100081563,0,0,22,197.550003707409,197.550003707409),(1363,'A',1,'2011-06-26',13.2,0,0,22,60,60),(1364,'A',1,'2011-06-26',88.7535009336472,0,0,22,403.425004243851,403.425004243851),(1365,'A',1,'2011-06-26',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(1366,'A',1,'2011-06-26',19.1234995961189,0,0,22,86.924998164177,86.924998164177),(1367,'A',1,'2011-06-26',31.2179990768433,0,0,22,141.899995803833,141.899995803833),(1368,'A',1,'2011-06-26',26.4,0,0,22,120,120),(1369,'A',1,'2011-06-26',53.4049991607666,0,0,22,242.749996185303,242.749996185303),(1370,'A',1,'2011-06-26',21.5159999370575,0,0,22,97.7999997138977,97.7999997138977),(1371,'A',1,'2011-06-26',26.4,0,0,22,120,120),(1372,'A',1,'2011-06-26',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1373,'A',1,'2011-06-26',16.631999874115,0,0,22,75.5999994277954,75.5999994277954),(1374,'A',1,'2011-06-26',7.92,0,0,22,36,36),(1375,'A',1,'2011-06-26',35.0239994335175,0,0,22,159.199997425079,159.199997425079),(1376,'A',1,'2011-06-26',32.8217999339104,0,0,22,149.189999699593,149.189999699593),(1377,'A',1,'2011-06-26',70.8411014938355,0,0,22,322.005006790161,322.005006790161),(1378,'A',1,'2011-06-26',79.5575000786781,0,0,22,361.625000357628,361.625000357628),(1379,'A',1,'2011-06-26',51.3865006923675,0,0,22,233.575003147125,233.575003147125),(1380,'A',1,'2011-06-26',38.846500980854,0,0,22,176.575004458427,176.575004458427),(1381,'A',1,'2011-06-26',13.3100002884865,0,0,22,60.5000013113022,60.5000013113022),(1382,'A',1,'2011-06-26',23.3200008392334,0,0,22,106.000003814697,106.000003814697),(1383,'A',1,'2011-06-26',12.6444994807243,0,0,22,57.4749976396561,57.4749976396561),(1384,'A',1,'2011-06-27',70.3999989509582,0,0,22,319.999995231628,319.999995231628),(1385,'A',1,'2011-06-27',50.4900027275085,0,0,22,229.500012397766,229.500012397766),(1386,'A',1,'2011-06-27',39.2699992656708,0,0,22,178.49999666214,178.49999666214),(1387,'A',1,'2011-06-27',39.6,0,0,22,180,180),(1388,'A',1,'2011-06-27',18.4250004589558,0,0,22,83.7500020861626,83.7500020861626),(1389,'A',1,'2011-06-27',12.1,0,0,22,55,55),(1390,'A',1,'2011-06-27',44.2199987411499,0,0,22,200.999994277954,200.999994277954),(1391,'A',1,'2011-06-27',86.0937000608444,0,0,22,391.335000276566,391.335000276566),(1392,'A',1,'2011-06-27',12.3200000524521,0,0,22,56.0000002384186,56.0000002384186),(1393,'A',1,'2011-06-27',13.2,0,0,22,60,60),(1394,'A',1,'2011-06-27',2.48049997836351,0,0,22,11.2749999016523,11.2749999016523),(1395,'A',1,'2011-06-27',13.595999622345,0,0,22,61.7999982833862,61.7999982833862),(1396,'A',1,'2011-06-27',16.7144997954369,0,0,22,75.9749990701675,75.9749990701675),(1397,'A',1,'2011-06-27',11.3563996732235,0,0,22,51.6199985146523,51.6199985146523),(1398,'A',1,'2011-06-27',54.5930008077621,0,0,22,248.150003671646,248.150003671646),(1399,'A',1,'2011-06-27',9.20259997665882,0,0,22,41.8299998939037,41.8299998939037),(1400,'A',1,'2011-06-27',49.2271986079216,0,0,22,223.759993672371,223.759993672371),(1401,'A',1,'2011-06-27',7.92,0,0,22,36,36),(1402,'A',1,'2011-06-27',10.34,0,0,22,47,47),(1403,'A',1,'2011-06-27',22.712799346447,0,0,22,103.239997029305,103.239997029305),(1404,'A',1,'2011-06-27',44.1209983110428,0,0,22,200.549992322922,200.549992322922),(1405,'A',1,'2011-06-27',50.8596000933647,0,0,22,231.180000424385,231.180000424385),(1406,'A',1,'2011-06-27',12.2209998846054,0,0,22,55.5499994754791,55.5499994754791),(1407,'A',1,'2011-06-27',58.4011987495422,0,0,22,265.459994316101,265.459994316101),(1408,'A',1,'2011-06-27',11.4949998557568,0,0,22,52.2499993443489,52.2499993443489),(1409,'A',1,'2011-06-27',10.7690002334118,0,0,22,48.9500010609627,48.9500010609627),(1410,'A',1,'2011-06-27',30.6899995803833,0,0,22,139.499998092651,139.499998092651),(1411,'A',1,'2011-06-27',41.963021979332,0,0,22,190.741008996963,190.741008996963),(1412,'A',1,'2011-06-27',41.8550000786781,0,0,22,190.250000357628,190.250000357628),(1413,'A',1,'2011-06-27',16.94,0,0,22,77,77),(1414,'A',1,'2011-06-27',24.8159999370575,0,0,22,112.799999713898,112.799999713898),(1415,'A',1,'2011-06-27',447.7,0,0,22,2035,2035),(1416,'A',1,'2011-06-27',73.5328004610539,0,0,22,334.240002095699,334.240002095699),(1417,'A',1,'2011-06-27',104.505502092838,0,0,22,475.025009512901,475.025009512901),(1418,'A',1,'2011-06-27',24.6400001049042,0,0,22,112.000000476837,112.000000476837),(1419,'A',1,'2011-06-27',13.2,0,0,22,60,60),(1420,'A',1,'2011-06-27',37.62,0,0,22,171,171),(1421,'A',1,'2011-06-27',23.398098692894,0,0,22,106.354994058609,106.354994058609),(1422,'A',1,'2011-06-27',3.52,0,0,22,16,16),(1423,'A',1,'2011-06-27',6.38,0,0,22,29,29),(1424,'A',1,'2011-06-27',22.1188003587723,0,0,22,100.540001630783,100.540001630783),(1425,'A',1,'2011-06-27',82.0490012693405,0,0,22,372.95000576973,372.95000576973),(1426,'A',1,'2011-06-27',82.2249983346462,0,0,22,373.74999243021,373.74999243021),(1427,'A',1,'2011-06-27',11.7370003461838,0,0,22,53.3500015735626,53.3500015735626),(1428,'A',1,'2011-06-27',22.3850002884865,0,0,22,101.750001311302,101.750001311302),(1429,'A',1,'2011-06-27',195.778002250195,0,0,22,889.900010228157,889.900010228157),(1430,'A',1,'2011-06-27',76.0265026330948,0,0,22,345.575011968613,345.575011968613),(1431,'A',1,'2011-06-27',48.4,0,0,22,220,220),(1432,'A',1,'2011-06-27',24.5861002087593,0,0,22,111.755000948906,111.755000948906),(1433,'A',1,'2011-06-27',6.85299988329411,0,0,22,31.1499994695187,31.1499994695187),(1434,'A',1,'2011-06-27',19.9044997692108,0,0,22,90.4749989509583,90.4749989509583),(1435,'A',1,'2011-06-27',17.6880004405975,0,0,22,80.4000020027161,80.4000020027161),(1436,'A',1,'2011-06-27',44.7479996800423,0,0,22,203.399998545647,203.399998545647),(1437,'A',1,'2011-06-27',38.720000576973,0,0,22,176.000002622604,176.000002622604),(1438,'A',1,'2011-06-27',6.77599983215332,0,0,22,30.7999992370605,30.7999992370605),(1439,'A',1,'2011-06-27',12.4629996538162,0,0,22,56.6499984264374,56.6499984264374),(1440,'A',1,'2011-06-27',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1441,'A',1,'2011-06-27',26.290000629425,0,0,22,119.500002861023,119.500002861023),(1442,'A',1,'2011-06-27',29.911198592186,0,0,22,135.959993600845,135.959993600845),(1443,'A',1,'2011-06-27',9.23999984264374,0,0,22,41.9999992847443,41.9999992847443),(1444,'A',1,'2011-06-28',61.0939993023872,0,0,22,277.699996829033,277.699996829033),(1445,'A',1,'2011-06-28',18.590000629425,0,0,22,84.5000028610229,84.5000028610229),(1446,'A',1,'2011-06-28',85.8780995583534,0,0,22,390.354997992516,390.354997992516),(1447,'A',1,'2011-06-28',186.324593222141,0,0,22,846.929969191551,846.929969191551),(1448,'A',1,'2011-06-28',40.6559991896153,0,0,22,184.799996316433,184.799996316433),(1449,'A',1,'2011-06-28',26.1799996852875,0,0,22,118.999998569489,118.999998569489),(1450,'A',1,'2011-06-28',32.4522003126144,0,0,22,147.510001420975,147.510001420975),(1451,'A',1,'2011-06-28',36.3439989089966,0,0,22,165.199995040894,165.199995040894),(1452,'A',1,'2011-06-28',17.6869002826512,0,0,22,80.3950012847781,80.3950012847781),(1453,'A',1,'2011-06-28',125.131599626541,0,0,22,568.77999830246,568.77999830246),(1454,'A',1,'2011-06-28',25.580500125885,0,0,22,116.275000572205,116.275000572205),(1455,'A',1,'2011-06-28',33.5631992530823,0,0,22,152.559996604919,152.559996604919),(1456,'A',1,'2011-06-28',15.4274997115135,0,0,22,70.1249986886978,70.1249986886978),(1457,'A',1,'2011-06-28',85.0354968738556,0,0,22,386.524985790253,386.524985790253),(1458,'A',1,'2011-06-28',13.2,0,0,22,60,60),(1459,'A',1,'2011-06-28',46.8875,0,0,22,213.125,213.125),(1460,'A',1,'2011-06-28',93.8079951167107,0,0,22,426.39997780323,426.39997780323),(1461,'A',1,'2011-06-28',60.7089989483356,0,0,22,275.949995219707,275.949995219707),(1462,'A',1,'2011-06-28',11.0626999533176,0,0,22,50.2849997878075,50.2849997878075),(1463,'A',1,'2011-06-28',10.12,0,0,22,46,46),(1464,'A',1,'2011-06-28',63.7846012604237,0,0,22,289.930005729198,289.930005729198),(1465,'A',1,'2011-06-28',55.07699868083,0,0,22,250.349994003773,250.349994003773),(1466,'A',1,'2011-06-28',8.84400022029877,0,0,22,40.200001001358,40.200001001358),(1467,'A',1,'2011-06-28',2.2,0,0,22,10,10),(1468,'A',1,'2011-06-28',14.5859997272491,0,0,22,66.2999987602234,66.2999987602234),(1469,'A',1,'2011-06-28',74.2060010910034,0,0,22,337.300004959106,337.300004959106),(1470,'A',1,'2011-06-28',49.560499548912,0,0,22,225.2749979496,225.2749979496),(1471,'A',1,'2011-06-28',19.8736997199059,0,0,22,90.3349987268448,90.3349987268448),(1472,'A',1,'2011-06-28',4.48800004720688,0,0,22,20.4000002145767,20.4000002145767),(1473,'A',1,'2011-06-28',25.7125000655651,0,0,22,116.875000298023,116.875000298023),(1474,'A',1,'2011-06-28',152.95280005455,0,0,22,695.240000247955,695.240000247955),(1475,'A',1,'2011-06-28',24.9919992446899,0,0,22,113.599996566772,113.599996566772),(1476,'A',1,'2011-06-28',10.9559997797012,0,0,22,49.799998998642,49.799998998642),(1477,'A',1,'2011-06-28',21.9296000933647,0,0,22,99.6800004243851,99.6800004243851),(1478,'A',1,'2011-06-28',50.2919992446899,0,0,22,228.599996566772,228.599996566772),(1479,'A',1,'2011-06-28',21.4115002989769,0,0,22,97.3250013589859,97.3250013589859),(1480,'A',1,'2011-06-28',32.5050004720688,0,0,22,147.750002145767,147.750002145767),(1481,'A',1,'2011-06-28',52.8,0,0,22,240,240),(1482,'A',1,'2011-06-28',23.4960009336472,0,0,22,106.800004243851,106.800004243851),(1483,'A',1,'2011-06-29',22.0275,0,0,22,100.125,100.125),(1484,'A',1,'2011-06-29',100.016398925781,0,0,22,454.619995117188,454.619995117188),(1485,'A',1,'2011-06-29',19.7757998132706,0,0,22,89.8899991512299,89.8899991512299),(1486,'A',1,'2011-06-29',131.054000377655,0,0,22,595.700001716614,595.700001716614),(1487,'A',1,'2011-06-29',87.1617988586426,0,0,22,396.189994812012,396.189994812012),(1488,'A',1,'2011-06-29',38.59899918437,0,0,22,175.449996292591,175.449996292591),(1489,'A',1,'2011-06-29',108.382999201417,0,0,22,492.649996370077,492.649996370077),(1490,'A',1,'2011-06-29',98.8130013847351,0,0,22,449.15000629425,449.15000629425),(1491,'A',1,'2011-06-29',73.9310016155243,0,0,22,336.050007343292,336.050007343292),(1492,'A',1,'2011-06-29',144.089006003141,0,0,22,654.950027287006,654.950027287006),(1493,'A',1,'2011-06-29',17.6330002045631,0,0,22,80.1500009298325,80.1500009298325),(1494,'A',1,'2011-06-29',62.3776993763447,0,0,22,283.534997165203,283.534997165203),(1495,'A',1,'2011-06-29',11.0879996538162,0,0,22,50.3999984264374,50.3999984264374),(1496,'A',1,'2011-06-29',59.4660009205341,0,0,22,270.300004184246,270.300004184246),(1497,'A',1,'2011-06-29',59.66399974823,0,0,22,271.199998855591,271.199998855591),(1498,'A',1,'2011-06-29',150.667000792027,0,0,22,684.850003600121,684.850003600121),(1499,'A',1,'2011-06-29',87.8504021883011,0,0,22,399.320009946823,399.320009946823),(1500,'A',1,'2011-06-29',169.014999947548,0,0,22,768.249999761581,768.249999761581),(1501,'A',1,'2011-06-29',131.178300783634,0,0,22,596.265003561974,596.265003561974),(1502,'A',1,'2011-06-29',46.64,0,0,22,212,212),(1503,'A',1,'2011-06-29',15.4440006136894,0,0,22,70.2000027894974,70.2000027894974),(1504,'A',1,'2011-06-29',72.7276006388664,0,0,22,330.580002903938,330.580002903938),(1505,'A',1,'2011-06-29',61.4295008838177,0,0,22,279.225004017353,279.225004017353),(1506,'A',1,'2011-06-29',20.157499396801,0,0,22,91.6249972581863,91.6249972581863),(1507,'A',1,'2011-06-29',22.57200050354,0,0,22,102.600002288818,102.600002288818),(1508,'A',1,'2011-06-29',12.5839995384216,0,0,22,57.1999979019165,57.1999979019165),(1509,'A',1,'2011-06-29',124.432000398636,0,0,22,565.600001811981,565.600001811981),(1510,'A',1,'2011-06-29',89.9250013113022,0,0,22,408.750005960464,408.750005960464),(1511,'A',1,'2011-06-29',34.3640006923676,0,0,22,156.200003147125,156.200003147125),(1512,'A',1,'2011-06-29',3.52,0,0,22,16,16),(1513,'A',1,'2011-06-29',7.13899968266487,0,0,22,32.4499985575676,32.4499985575676),(1514,'A',1,'2011-06-29',22.0439994335175,0,0,22,100.199997425079,100.199997425079),(1515,'A',1,'2011-06-29',10.34,0,0,22,47,47),(1516,'A',1,'2011-06-29',120.623800293207,0,0,22,548.29000133276,548.29000133276),(1517,'A',1,'2011-06-29',13.4310001730919,0,0,22,61.0500007867813,61.0500007867813),(1518,'A',1,'2011-06-29',112.984300642014,0,0,22,513.565002918243,513.565002918243),(1519,'A',1,'2011-06-29',94.1556023776531,0,0,22,427.980010807514,427.980010807514),(1520,'A',1,'2011-06-29',28.6439994335175,0,0,22,130.199997425079,130.199997425079),(1521,'A',1,'2011-06-29',123.139499087334,0,0,22,559.724995851517,559.724995851517),(1522,'A',1,'2011-06-29',34.4519996643066,0,0,22,156.599998474121,156.599998474121),(1523,'A',1,'2011-06-30',11.8799996852875,0,0,22,53.9999985694885,53.9999985694885),(1524,'A',1,'2011-06-30',10.3399999475479,0,0,22,46.9999997615814,46.9999997615814),(1525,'A',1,'2011-06-30',70.2789984107017,0,0,22,319.449992775917,319.449992775917),(1526,'A',1,'2011-06-30',76.9031999349594,0,0,22,349.559999704361,349.559999704361),(1527,'A',1,'2011-06-30',38.1479998111725,0,0,22,173.399999141693,173.399999141693),(1528,'A',1,'2011-06-30',47.2559995174408,0,0,22,214.799997806549,214.799997806549),(1529,'A',1,'2011-06-30',70.0424999475479,0,0,22,318.374999761581,318.374999761581),(1530,'A',1,'2011-06-30',111.373017494678,0,0,22,506.240988612175,506.240988612175),(1531,'A',1,'2011-06-30',12.4299999475479,0,0,22,56.4999997615814,56.4999997615814),(1532,'A',1,'2011-06-30',9.9,0,0,22,45,45),(1533,'A',1,'2011-06-30',89.8480026960373,0,0,22,408.400012254715,408.400012254715),(1534,'A',1,'2011-06-30',65.2300002098084,0,0,22,296.500000953674,296.500000953674),(1535,'A',1,'2011-06-30',100.922799713612,0,0,22,458.739998698235,458.739998698235),(1536,'A',1,'2011-06-30',45.2430003225803,0,0,22,205.650001466274,205.650001466274),(1537,'A',1,'2011-06-30',48.9225001311302,0,0,22,222.375000596046,222.375000596046),(1538,'A',1,'2011-06-30',44.1759998321533,0,0,22,200.799999237061,200.799999237061),(1539,'A',1,'2011-06-30',41.4204991030693,0,0,22,188.274995923042,188.274995923042),(1540,'A',1,'2011-06-30',44.7315016627312,0,0,22,203.325007557869,203.325007557869),(1541,'A',1,'2011-06-30',131.361999166012,0,0,22,597.099996209145,597.099996209145),(1542,'A',1,'2011-06-30',21.7799996852875,0,0,22,98.9999985694885,98.9999985694885),(1543,'A',1,'2011-06-30',22.5720008969307,0,0,22,102.600004076958,102.600004076958),(1544,'A',1,'2011-06-30',42.35,0,0,22,192.5,192.5),(1545,'A',1,'2011-06-30',49.3899990558624,0,0,22,224.499995708466,224.499995708466),(1546,'A',1,'2011-06-30',27.72,0,0,22,126,126),(1547,'A',1,'2011-06-30',33.6654993653297,0,0,22,153.024997115135,153.024997115135),(1548,'A',1,'2011-06-30',43.5654993653297,0,0,22,198.024997115135,198.024997115135),(1549,'A',1,'2011-06-30',8.36,0,0,22,38,38),(1550,'A',1,'2011-06-30',164.823998987675,0,0,22,749.199995398521,749.199995398521),(1551,'A',1,'2011-06-30',30.8000000917912,0,0,22,140.000000417233,140.000000417233),(1552,'A',1,'2011-06-30',62.7769995987415,0,0,22,285.349998176098,285.349998176098),(1553,'A',1,'2011-06-30',38.6594991266727,0,0,22,175.724996030331,175.724996030331),(1554,'A',1,'2011-06-30',39.7122005486488,0,0,22,180.510002493858,180.510002493858),(1555,'A',1,'2011-06-30',168.706997251511,0,0,22,766.849987506866,766.849987506866),(1556,'A',1,'2011-06-30',60.2800002098083,0,0,22,274.000000953674,274.000000953674),(1557,'A',1,'2011-06-30',44.1374992132187,0,0,22,200.624996423721,200.624996423721),(1558,'A',1,'2011-06-30',10.5600001573563,0,0,22,48.0000007152557,48.0000007152557),(1559,'A',1,'2011-06-30',169.377995628119,0,0,22,769.899980127811,769.899980127811),(1560,'A',1,'2011-06-30',113.541995573044,0,0,22,516.099979877472,516.099979877472),(1561,'A',1,'2011-06-30',87.9163985323906,0,0,22,399.619993329048,399.619993329048),(1562,'A',1,'2011-06-30',154.553300206661,0,0,22,702.515000939369,702.515000939369),(1563,'A',1,'2011-06-30',173.397404921055,0,0,22,788.170022368431,788.170022368431),(1564,'A',1,'2011-06-30',17.68799949646,0,0,22,80.3999977111816,80.3999977111816),(1565,'A',1,'2011-06-30',45.924998819828,0,0,22,208.749994635582,208.749994635582),(1566,'A',1,'2011-06-30',43.8625,0,0,22,199.375,199.375),(1567,'A',1,'2011-07-01',40.8980013847351,0,0,22,185.90000629425,185.90000629425),(1568,'A',1,'2011-07-01',22.57200050354,0,0,22,102.600002288818,102.600002288818),(1569,'A',1,'2011-07-01',63.5800046157837,0,0,22,289.000020980835,289.000020980835),(1570,'A',1,'2011-07-01',334.289999265671,0,0,22,1519.49999666214,1519.49999666214),(1571,'A',1,'2011-07-01',48.0259988158941,0,0,22,218.299994617701,218.299994617701),(1572,'A',1,'2011-07-01',53.8010012745857,0,0,22,244.550005793571,244.550005793571),(1573,'A',1,'2011-07-01',75.02,0,0,22,341,341),(1574,'A',1,'2011-07-01',98.3751989173889,0,0,22,447.159995079041,447.159995079041),(1575,'A',1,'2011-07-01',42.6030009388924,0,0,22,193.650004267693,193.650004267693),(1576,'A',1,'2011-07-01',45.4630004405975,0,0,22,206.650002002716,206.650002002716),(1577,'A',1,'2011-07-01',14.9434993863106,0,0,22,67.9249972105026,67.9249972105026),(1578,'A',1,'2011-07-01',126.088598005772,0,0,22,573.129990935326,573.129990935326),(1579,'A',1,'2011-07-01',131.631497991085,0,0,22,598.324990868568,598.324990868568),(1580,'A',1,'2011-07-01',11.5554997980595,0,0,22,52.5249990820885,52.5249990820885),(1581,'A',1,'2011-07-01',6.16,0,0,22,28,28),(1582,'A',1,'2011-07-01',40.0510007500649,0,0,22,182.050003409386,182.050003409386),(1583,'A',1,'2011-07-01',129.728496265411,0,0,22,589.674983024597,589.674983024597),(1584,'A',1,'2011-07-01',62.6890004366636,0,0,22,284.950001984835,284.950001984835),(1585,'A',1,'2011-07-01',88.0792008161545,0,0,22,400.360003709793,400.360003709793),(1586,'A',1,'2011-07-01',21.7382001447678,0,0,22,98.8100006580353,98.8100006580353),(1587,'A',1,'2011-07-01',33.6534010028839,0,0,22,152.970004558563,152.970004558563),(1588,'A',1,'2011-07-01',39.7452013170719,0,0,22,180.660005986691,180.660005986691),(1589,'A',1,'2011-07-01',179.575001049042,0,0,22,816.250004768372,816.250004768372),(1590,'A',1,'2011-07-01',107.150999307632,0,0,22,487.049996852875,487.049996852875),(1591,'A',1,'2011-07-01',23.0021005129814,0,0,22,104.555002331734,104.555002331734),(1592,'A',1,'2011-07-02',8.14000010490418,0,0,22,37.0000004768372,37.0000004768372),(1593,'A',1,'2011-07-02',74.0244985103607,0,0,22,336.474993228912,336.474993228912),(1594,'A',1,'2011-07-02',56.9030003488064,0,0,22,258.650001585484,258.650001585484),(1595,'A',1,'2011-07-04',608.326398768425,0,0,22,2765.11999440193,2765.11999440193),(1596,'A',1,'2011-07-04',412.884115172625,0,0,22,1876.74597805738,1876.74597805738),(1597,'A',1,'2011-07-04',107.05639941752,0,0,22,486.619997352362,486.619997352362),(1598,'A',1,'2011-07-04',694.990985879898,0,0,22,3159.04993581772,3159.04993581772),(1599,'A',1,'2011-07-04',264.731499984264,0,0,22,1203.32499992847,1203.32499992847),(1600,'A',1,'2011-07-04',12.5839995384216,0,0,22,57.1999979019165,57.1999979019165),(1601,'A',1,'2011-07-04',16.23600025177,0,0,22,73.8000011444092,73.8000011444092),(1602,'A',1,'2011-07-04',87.7546998274326,0,0,22,398.884999215603,398.884999215603),(1603,'A',1,'2011-07-04',132.065999674797,0,0,22,600.299998521805,600.299998521805),(1604,'A',1,'2011-07-04',261.132966384888,0,0,22,1186.96802902222,1186.96802902222),(1605,'A',1,'2011-07-04',19.58,0,0,22,89,89),(1606,'A',1,'2011-07-04',59.8785001993179,0,0,22,272.175000905991,272.175000905991),(1607,'A',1,'2011-07-04',20.7240006923676,0,0,22,94.2000031471252,94.2000031471252),(1608,'A',1,'2011-07-04',6.38,0,0,22,29,29),(1609,'A',1,'2011-07-04',259.726502056122,0,0,22,1180.57500934601,1180.57500934601),(1610,'A',1,'2011-07-04',32.0759998321533,0,0,22,145.799999237061,145.799999237061),(1611,'A',1,'2011-07-04',33.66,0,0,22,153,153),(1612,'A',1,'2011-07-04',28.6,0,0,22,130,130),(1613,'A',1,'2011-07-04',62.9035001993179,0,0,22,285.925000905991,285.925000905991),(1614,'A',1,'2011-07-04',36.1844995594025,0,0,22,164.474997997284,164.474997997284),(1615,'A',1,'2011-07-04',40.9650992554426,0,0,22,186.204996615648,186.204996615648),(1616,'A',1,'2011-07-04',44.8800012588501,0,0,22,204.000005722046,204.000005722046),(1617,'A',1,'2011-07-04',14.8225002884865,0,0,22,67.3750013113022,67.3750013113022),(1618,'A',1,'2011-07-04',36.7840005874634,0,0,22,167.200002670288,167.200002670288),(1619,'A',1,'2011-07-05',61.7979987621307,0,0,22,280.899994373322,280.899994373322),(1620,'A',1,'2011-07-05',23.2099988460541,0,0,22,105.499994754791,105.499994754791);
/*!40000 ALTER TABLE ElPam.`factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facturaven`
--

LOCK TABLES ElPam.`facturaven` WRITE;
/*!40000 ALTER TABLE ElPam.`facturaven` DISABLE KEYS */;
INSERT INTO ElPam.`facturaven` VALUES (0,'A',1,NULL),(1,'A',1,NULL),(2,'A',1,NULL),(3,'A',1,NULL),(4,'A',1,NULL),(5,'A',1,NULL),(6,'A',1,NULL),(7,'A',1,NULL),(8,'A',1,NULL),(9,'A',1,NULL),(10,'A',1,NULL),(11,'A',1,NULL),(12,'A',1,NULL),(13,'A',1,NULL),(14,'A',1,NULL),(15,'A',1,NULL),(16,'A',1,NULL),(17,'A',1,NULL),(18,'A',1,NULL),(19,'A',1,NULL),(20,'A',1,NULL),(21,'A',1,NULL),(22,'A',1,NULL),(23,'A',1,NULL),(24,'A',1,NULL),(25,'A',1,NULL),(26,'A',1,NULL),(27,'A',1,NULL),(28,'A',1,NULL),(29,'A',1,NULL),(30,'A',1,NULL),(31,'A',1,NULL),(32,'A',1,NULL),(33,'A',1,NULL),(34,'A',1,NULL),(35,'A',1,NULL),(36,'A',1,NULL),(37,'A',1,NULL),(38,'A',1,NULL),(39,'A',1,NULL),(40,'A',1,NULL),(41,'A',1,NULL),(42,'A',1,NULL),(43,'A',1,NULL),(44,'A',1,NULL),(45,'A',1,NULL),(46,'A',1,NULL),(47,'A',1,NULL),(48,'A',1,NULL),(49,'A',1,NULL),(50,'A',1,NULL),(51,'A',1,NULL),(52,'A',1,NULL),(53,'A',1,NULL),(54,'A',1,NULL),(55,'A',1,NULL),(56,'A',1,NULL),(57,'A',1,NULL),(58,'A',1,NULL),(59,'A',1,NULL),(60,'A',1,NULL),(61,'A',1,NULL),(62,'A',1,NULL),(63,'A',1,NULL),(64,'A',1,NULL),(65,'A',1,NULL),(66,'A',1,NULL),(67,'A',1,NULL),(68,'A',1,NULL),(69,'A',1,NULL),(70,'A',1,NULL),(71,'A',1,NULL),(72,'A',1,NULL),(73,'A',1,NULL),(74,'A',1,NULL),(75,'A',1,NULL),(76,'A',1,NULL),(77,'A',1,NULL),(78,'A',1,NULL),(79,'A',1,NULL),(80,'A',1,NULL),(81,'A',1,NULL),(82,'A',1,NULL),(83,'A',1,NULL),(84,'A',1,NULL),(85,'A',1,NULL),(86,'A',1,NULL),(87,'A',1,NULL),(88,'A',1,NULL),(89,'A',1,NULL),(90,'A',1,NULL),(91,'A',1,NULL),(92,'A',1,NULL),(93,'A',1,NULL),(94,'A',1,NULL),(95,'A',1,NULL),(96,'A',1,NULL),(97,'A',1,NULL),(98,'A',1,NULL),(99,'A',1,NULL),(100,'A',1,NULL),(101,'A',1,NULL),(102,'A',1,NULL),(103,'A',1,NULL),(104,'A',1,NULL),(105,'A',1,NULL),(106,'A',1,NULL),(107,'A',1,NULL),(108,'A',1,NULL),(109,'A',1,NULL),(110,'A',1,NULL),(111,'A',1,NULL),(112,'A',1,NULL),(113,'A',1,NULL),(114,'A',1,NULL),(115,'A',1,NULL),(116,'A',1,NULL),(117,'A',1,NULL),(118,'A',1,NULL),(119,'A',1,NULL),(120,'A',1,NULL),(121,'A',1,NULL),(122,'A',1,NULL),(123,'A',1,NULL),(124,'A',1,NULL),(125,'A',1,NULL),(126,'A',1,NULL),(127,'A',1,NULL),(128,'A',1,NULL),(129,'A',1,NULL),(130,'A',1,NULL),(131,'A',1,NULL),(132,'A',1,NULL),(133,'A',1,NULL),(134,'A',1,NULL),(135,'A',1,NULL),(136,'A',1,NULL),(137,'A',1,NULL),(138,'A',1,NULL),(139,'A',1,NULL),(140,'A',1,NULL),(141,'A',1,NULL),(142,'A',1,NULL),(143,'A',1,NULL),(144,'A',1,NULL),(145,'A',1,NULL),(146,'A',1,NULL),(147,'A',1,NULL),(148,'A',1,NULL),(149,'A',1,NULL),(150,'A',1,NULL),(151,'A',1,NULL),(152,'A',1,NULL),(153,'A',1,NULL),(154,'A',1,NULL),(155,'A',1,NULL),(156,'A',1,NULL),(157,'A',1,NULL),(158,'A',1,NULL),(159,'A',1,NULL),(160,'A',1,NULL),(161,'A',1,NULL),(162,'A',1,NULL),(163,'A',1,NULL),(164,'A',1,NULL),(165,'A',1,NULL),(166,'A',1,NULL),(167,'A',1,NULL),(168,'A',1,NULL),(169,'A',1,NULL),(170,'A',1,NULL),(171,'A',1,NULL),(172,'A',1,NULL),(173,'A',1,NULL),(174,'A',1,NULL),(175,'A',1,NULL),(176,'A',1,NULL),(177,'A',1,NULL),(178,'A',1,NULL),(179,'A',1,NULL),(180,'A',1,NULL),(181,'A',1,NULL),(182,'A',1,NULL),(183,'A',1,NULL),(184,'A',1,NULL),(185,'A',1,NULL),(186,'A',1,NULL),(187,'A',1,NULL),(188,'A',1,NULL),(189,'A',1,NULL),(190,'A',1,NULL),(191,'A',1,NULL),(192,'A',1,NULL),(193,'A',1,NULL),(194,'A',1,NULL),(195,'A',1,NULL),(196,'A',1,NULL),(197,'A',1,NULL),(198,'A',1,NULL),(199,'A',1,NULL),(200,'A',1,NULL),(201,'A',1,NULL),(202,'A',1,NULL),(203,'A',1,NULL),(204,'A',1,NULL),(205,'A',1,NULL),(206,'A',1,NULL),(207,'A',1,NULL),(208,'A',1,NULL),(209,'A',1,NULL),(210,'A',1,NULL),(211,'A',1,NULL),(212,'A',1,NULL),(213,'A',1,NULL),(214,'A',1,NULL),(215,'A',1,NULL),(216,'A',1,NULL),(217,'A',1,NULL),(218,'A',1,NULL),(219,'A',1,NULL),(220,'A',1,NULL),(221,'A',1,NULL),(222,'A',1,NULL),(223,'A',1,NULL),(224,'A',1,NULL),(225,'A',1,NULL),(226,'A',1,NULL),(227,'A',1,NULL),(228,'A',1,NULL),(229,'A',1,NULL),(230,'A',1,NULL),(231,'A',1,NULL),(232,'A',1,NULL),(233,'A',1,NULL),(234,'A',1,NULL),(235,'A',1,NULL),(236,'A',1,NULL),(237,'A',1,NULL),(238,'A',1,NULL),(239,'A',1,NULL),(240,'A',1,NULL),(241,'A',1,NULL),(242,'A',1,NULL),(243,'A',1,NULL),(244,'A',1,NULL),(245,'A',1,NULL),(246,'A',1,NULL),(247,'A',1,NULL),(248,'A',1,NULL),(249,'A',1,NULL),(250,'A',1,NULL),(251,'A',1,NULL),(252,'A',1,NULL),(253,'A',1,NULL),(254,'A',1,NULL),(255,'A',1,NULL),(256,'A',1,NULL),(257,'A',1,NULL),(258,'A',1,NULL),(259,'A',1,NULL),(260,'A',1,NULL),(261,'A',1,NULL),(262,'A',1,NULL),(263,'A',1,NULL),(264,'A',1,NULL),(265,'A',1,NULL),(266,'A',1,NULL),(267,'A',1,NULL),(268,'A',1,NULL),(269,'A',1,NULL),(270,'A',1,NULL),(271,'A',1,NULL),(272,'A',1,NULL),(273,'A',1,NULL),(274,'A',1,NULL),(275,'A',1,NULL),(276,'A',1,NULL),(277,'A',1,NULL),(278,'A',1,NULL),(279,'A',1,NULL),(280,'A',1,NULL),(281,'A',1,NULL),(282,'A',1,NULL),(283,'A',1,NULL),(284,'A',1,NULL),(285,'A',1,NULL),(286,'A',1,NULL),(287,'A',1,NULL),(288,'A',1,NULL),(289,'A',1,NULL),(290,'A',1,NULL),(291,'A',1,NULL),(292,'A',1,NULL),(293,'A',1,NULL),(294,'A',1,NULL),(295,'A',1,NULL),(296,'A',1,NULL),(297,'A',1,NULL),(298,'A',1,NULL),(299,'A',1,NULL),(300,'A',1,NULL),(301,'A',1,NULL),(302,'A',1,NULL),(303,'A',1,NULL),(304,'A',1,NULL),(305,'A',1,NULL),(306,'A',1,NULL),(307,'A',1,NULL),(308,'A',1,NULL),(309,'A',1,NULL),(310,'A',1,NULL),(311,'A',1,NULL),(312,'A',1,NULL),(313,'A',1,NULL),(314,'A',1,NULL),(315,'A',1,NULL),(316,'A',1,NULL),(317,'A',1,NULL),(318,'A',1,NULL),(319,'A',1,NULL),(320,'A',1,NULL),(321,'A',1,NULL),(322,'A',1,NULL),(323,'A',1,NULL),(324,'A',1,NULL),(325,'A',1,NULL),(326,'A',1,NULL),(327,'A',1,NULL),(328,'A',1,NULL),(329,'A',1,NULL),(330,'A',1,NULL),(331,'A',1,NULL),(332,'A',1,NULL),(333,'A',1,NULL),(334,'A',1,NULL),(335,'A',1,NULL),(336,'A',1,NULL),(337,'A',1,NULL),(338,'A',1,NULL),(339,'A',1,NULL),(340,'A',1,NULL),(341,'A',1,NULL),(342,'A',1,NULL),(343,'A',1,NULL),(344,'A',1,NULL),(345,'A',1,NULL),(346,'A',1,NULL),(347,'A',1,NULL),(348,'A',1,NULL),(349,'A',1,NULL),(350,'A',1,NULL),(351,'A',1,NULL),(352,'A',1,NULL),(353,'A',1,NULL),(354,'A',1,NULL),(355,'A',1,NULL),(356,'A',1,NULL),(357,'A',1,NULL),(358,'A',1,NULL),(359,'A',1,NULL),(360,'A',1,NULL),(361,'A',1,NULL),(362,'A',1,NULL),(363,'A',1,NULL),(364,'A',1,NULL),(365,'A',1,NULL),(366,'A',1,NULL),(367,'A',1,NULL),(368,'A',1,NULL),(369,'A',1,NULL),(370,'A',1,NULL),(371,'A',1,NULL),(372,'A',1,NULL),(373,'A',1,NULL),(374,'A',1,NULL),(375,'A',1,NULL),(376,'A',1,NULL),(377,'A',1,NULL),(378,'A',1,NULL),(379,'A',1,NULL),(380,'A',1,NULL),(381,'A',1,NULL),(382,'A',1,NULL),(383,'A',1,NULL),(384,'A',1,NULL),(385,'A',1,NULL),(386,'A',1,NULL),(387,'A',1,NULL),(388,'A',1,NULL),(389,'A',1,NULL),(390,'A',1,NULL),(391,'A',1,NULL),(392,'A',1,NULL),(393,'A',1,NULL),(394,'A',1,NULL),(395,'A',1,NULL),(396,'A',1,NULL),(397,'A',1,NULL),(398,'A',1,NULL),(399,'A',1,NULL),(400,'A',1,NULL),(401,'A',1,NULL),(402,'A',1,NULL),(403,'A',1,NULL),(404,'A',1,NULL),(405,'A',1,NULL),(406,'A',1,NULL),(407,'A',1,NULL),(408,'A',1,NULL),(409,'A',1,NULL),(410,'A',1,NULL),(411,'A',1,NULL),(412,'A',1,NULL),(413,'A',1,NULL),(414,'A',1,NULL),(415,'A',1,NULL),(416,'A',1,NULL),(417,'A',1,NULL),(418,'A',1,NULL),(419,'A',1,NULL),(420,'A',1,NULL),(421,'A',1,NULL),(422,'A',1,NULL),(423,'A',1,NULL),(424,'A',1,NULL),(425,'A',1,NULL),(426,'A',1,NULL),(427,'A',1,NULL),(428,'A',1,NULL),(429,'A',1,NULL),(430,'A',1,NULL),(431,'A',1,NULL),(432,'A',1,NULL),(433,'A',1,NULL),(434,'A',1,NULL),(435,'A',1,NULL),(436,'A',1,NULL),(437,'A',1,NULL),(438,'A',1,NULL),(439,'A',1,NULL),(440,'A',1,NULL),(441,'A',1,NULL),(442,'A',1,NULL),(443,'A',1,NULL),(444,'A',1,NULL),(445,'A',1,NULL),(446,'A',1,NULL),(447,'A',1,NULL),(448,'A',1,NULL),(449,'A',1,NULL),(450,'A',1,NULL),(451,'A',1,NULL),(452,'A',1,NULL),(453,'A',1,NULL),(454,'A',1,NULL),(455,'A',1,NULL),(456,'A',1,NULL),(457,'A',1,NULL),(458,'A',1,NULL),(459,'A',1,NULL),(460,'A',1,NULL),(461,'A',1,NULL),(462,'A',1,NULL),(463,'A',1,NULL),(464,'A',1,NULL),(465,'A',1,NULL),(466,'A',1,NULL),(467,'A',1,NULL),(468,'A',1,NULL),(469,'A',1,NULL),(470,'A',1,NULL),(471,'A',1,NULL),(472,'A',1,NULL),(473,'A',1,NULL),(474,'A',1,NULL),(475,'A',1,NULL),(476,'A',1,NULL),(477,'A',1,NULL),(478,'A',1,NULL),(479,'A',1,NULL),(480,'A',1,NULL),(481,'A',1,NULL),(482,'A',1,NULL),(483,'A',1,NULL),(484,'A',1,NULL),(485,'A',1,NULL),(486,'A',1,NULL),(487,'A',1,NULL),(488,'A',1,NULL),(489,'A',1,NULL),(490,'A',1,NULL),(491,'A',1,NULL),(492,'A',1,NULL),(493,'A',1,NULL),(494,'A',1,NULL),(495,'A',1,NULL),(496,'A',1,NULL),(497,'A',1,NULL),(498,'A',1,NULL),(499,'A',1,NULL),(500,'A',1,NULL),(501,'A',1,NULL),(502,'A',1,NULL),(503,'A',1,NULL),(504,'A',1,NULL),(505,'A',1,NULL),(506,'A',1,NULL),(507,'A',1,NULL),(508,'A',1,NULL),(509,'A',1,NULL),(510,'A',1,NULL),(511,'A',1,NULL),(512,'A',1,NULL),(513,'A',1,NULL),(514,'A',1,NULL),(515,'A',1,NULL),(516,'A',1,NULL),(517,'A',1,NULL),(518,'A',1,NULL),(519,'A',1,NULL),(520,'A',1,NULL),(521,'A',1,NULL),(522,'A',1,NULL),(523,'A',1,NULL),(524,'A',1,NULL),(525,'A',1,NULL),(526,'A',1,NULL),(527,'A',1,NULL),(528,'A',1,NULL),(529,'A',1,NULL),(530,'A',1,NULL),(531,'A',1,NULL),(532,'A',1,NULL),(533,'A',1,NULL),(534,'A',1,NULL),(535,'A',1,NULL),(536,'A',1,NULL),(537,'A',1,NULL),(538,'A',1,NULL),(539,'A',1,NULL),(540,'A',1,NULL),(541,'A',1,NULL),(542,'A',1,NULL),(543,'A',1,NULL),(544,'A',1,NULL),(545,'A',1,NULL),(546,'A',1,NULL),(547,'A',1,NULL),(548,'A',1,NULL),(549,'A',1,NULL),(550,'A',1,NULL),(551,'A',1,NULL),(552,'A',1,NULL),(553,'A',1,NULL),(554,'A',1,NULL),(555,'A',1,NULL),(556,'A',1,NULL),(557,'A',1,NULL),(558,'A',1,NULL),(559,'A',1,NULL),(560,'A',1,NULL),(561,'A',1,NULL),(562,'A',1,NULL),(563,'A',1,NULL),(564,'A',1,NULL),(565,'A',1,NULL),(566,'A',1,NULL),(567,'A',1,NULL),(568,'A',1,NULL),(569,'A',1,NULL),(570,'A',1,NULL),(571,'A',1,NULL),(572,'A',1,NULL),(573,'A',1,NULL),(574,'A',1,NULL),(575,'A',1,NULL),(576,'A',1,NULL),(577,'A',1,NULL),(578,'A',1,NULL),(579,'A',1,NULL),(580,'A',1,NULL),(581,'A',1,NULL),(582,'A',1,NULL),(583,'A',1,NULL),(584,'A',1,NULL),(585,'A',1,NULL),(586,'A',1,NULL),(587,'A',1,NULL),(588,'A',1,NULL),(589,'A',1,NULL),(590,'A',1,NULL),(591,'A',1,NULL),(592,'A',1,NULL),(593,'A',1,NULL),(594,'A',1,NULL),(595,'A',1,NULL),(596,'A',1,NULL),(597,'A',1,NULL),(598,'A',1,NULL),(599,'A',1,NULL),(600,'A',1,NULL),(601,'A',1,NULL),(602,'A',1,NULL),(603,'A',1,NULL),(604,'A',1,NULL),(605,'A',1,NULL),(606,'A',1,NULL),(607,'A',1,NULL),(608,'A',1,NULL),(609,'A',1,NULL),(610,'A',1,NULL),(611,'A',1,NULL),(612,'A',1,NULL),(613,'A',1,NULL),(614,'A',1,NULL),(615,'A',1,NULL),(616,'A',1,NULL),(617,'A',1,NULL),(618,'A',1,NULL),(619,'A',1,NULL),(620,'A',1,NULL),(621,'A',1,NULL),(622,'A',1,NULL),(623,'A',1,NULL),(624,'A',1,NULL),(625,'A',1,NULL),(626,'A',1,NULL),(627,'A',1,NULL),(628,'A',1,NULL),(629,'A',1,NULL),(630,'A',1,NULL),(631,'A',1,NULL),(632,'A',1,NULL),(633,'A',1,NULL),(634,'A',1,NULL),(635,'A',1,NULL),(636,'A',1,NULL),(637,'A',1,NULL),(638,'A',1,NULL),(639,'A',1,NULL),(640,'A',1,NULL),(641,'A',1,NULL),(642,'A',1,NULL),(643,'A',1,NULL),(644,'A',1,NULL),(645,'A',1,NULL),(646,'A',1,NULL),(647,'A',1,NULL),(648,'A',1,NULL),(649,'A',1,NULL),(650,'A',1,NULL),(651,'A',1,NULL),(652,'A',1,NULL),(653,'A',1,NULL),(654,'A',1,NULL),(655,'A',1,NULL),(656,'A',1,NULL),(657,'A',1,NULL),(658,'A',1,NULL),(659,'A',1,NULL),(660,'A',1,NULL),(661,'A',1,NULL),(662,'A',1,NULL),(663,'A',1,NULL),(664,'A',1,NULL),(665,'A',1,NULL),(666,'A',1,NULL),(667,'A',1,NULL),(668,'A',1,NULL),(669,'A',1,NULL),(670,'A',1,NULL),(671,'A',1,NULL),(672,'A',1,NULL),(673,'A',1,NULL),(674,'A',1,NULL),(675,'A',1,NULL),(676,'A',1,NULL),(677,'A',1,NULL),(678,'A',1,NULL),(679,'A',1,NULL),(680,'A',1,NULL),(681,'A',1,NULL),(682,'A',1,NULL),(683,'A',1,NULL),(684,'A',1,NULL),(685,'A',1,NULL),(686,'A',1,NULL),(687,'A',1,NULL),(688,'A',1,NULL),(689,'A',1,NULL),(690,'A',1,NULL),(691,'A',1,NULL),(692,'A',1,NULL),(693,'A',1,NULL),(694,'A',1,NULL),(695,'A',1,NULL),(696,'A',1,NULL),(697,'A',1,NULL),(698,'A',1,NULL),(699,'A',1,NULL),(700,'A',1,NULL),(701,'A',1,NULL),(702,'A',1,NULL),(703,'A',1,NULL),(704,'A',1,NULL),(705,'A',1,NULL),(706,'A',1,NULL),(707,'A',1,NULL),(708,'A',1,NULL),(709,'A',1,NULL),(710,'A',1,NULL),(711,'A',1,NULL),(712,'A',1,NULL),(713,'A',1,NULL),(714,'A',1,NULL),(715,'A',1,NULL),(716,'A',1,NULL),(717,'A',1,NULL),(718,'A',1,NULL),(719,'A',1,NULL),(720,'A',1,NULL),(721,'A',1,NULL),(722,'A',1,NULL),(723,'A',1,NULL),(724,'A',1,NULL),(725,'A',1,NULL),(726,'A',1,NULL),(727,'A',1,NULL),(728,'A',1,NULL),(729,'A',1,NULL),(730,'A',1,NULL),(731,'A',1,NULL),(732,'A',1,NULL),(733,'A',1,NULL),(734,'A',1,NULL),(735,'A',1,NULL),(736,'A',1,NULL),(737,'A',1,NULL),(738,'A',1,NULL),(739,'A',1,NULL),(740,'A',1,NULL),(741,'A',1,NULL),(742,'A',1,NULL),(743,'A',1,NULL),(744,'A',1,NULL),(745,'A',1,NULL),(746,'A',1,NULL),(747,'A',1,NULL),(748,'A',1,NULL),(749,'A',1,NULL),(750,'A',1,NULL),(751,'A',1,NULL),(752,'A',1,NULL),(753,'A',1,NULL),(754,'A',1,NULL),(755,'A',1,NULL),(756,'A',1,NULL),(757,'A',1,NULL),(758,'A',1,NULL),(759,'A',1,NULL),(760,'A',1,NULL),(761,'A',1,NULL),(762,'A',1,NULL),(763,'A',1,NULL),(764,'A',1,NULL),(765,'A',1,NULL),(766,'A',1,NULL),(767,'A',1,NULL),(768,'A',1,NULL),(769,'A',1,NULL),(770,'A',1,NULL),(771,'A',1,NULL),(772,'A',1,NULL),(773,'A',1,NULL),(774,'A',1,NULL),(775,'A',1,NULL),(776,'A',1,NULL),(777,'A',1,NULL),(778,'A',1,NULL),(779,'A',1,NULL),(780,'A',1,NULL),(781,'A',1,NULL),(782,'A',1,NULL),(783,'A',1,NULL),(784,'A',1,NULL),(785,'A',1,NULL),(786,'A',1,NULL),(787,'A',1,NULL),(788,'A',1,NULL),(789,'A',1,NULL),(790,'A',1,NULL),(791,'A',1,NULL),(792,'A',1,NULL),(793,'A',1,NULL),(794,'A',1,NULL),(795,'A',1,NULL),(796,'A',1,NULL),(797,'A',1,NULL),(798,'A',1,NULL),(799,'A',1,NULL),(800,'A',1,NULL),(801,'A',1,NULL),(802,'A',1,NULL),(803,'A',1,NULL),(804,'A',1,NULL),(805,'A',1,NULL),(806,'A',1,NULL),(807,'A',1,NULL),(808,'A',1,NULL),(809,'A',1,NULL),(810,'A',1,NULL),(811,'A',1,NULL),(812,'A',1,NULL),(813,'A',1,NULL),(814,'A',1,NULL),(815,'A',1,NULL),(816,'A',1,NULL),(817,'A',1,NULL),(818,'A',1,NULL),(819,'A',1,NULL),(820,'A',1,NULL),(821,'A',1,NULL),(822,'A',1,NULL),(823,'A',1,NULL),(824,'A',1,NULL),(825,'A',1,NULL),(826,'A',1,NULL),(827,'A',1,NULL),(828,'A',1,NULL),(829,'A',1,NULL),(830,'A',1,NULL),(831,'A',1,NULL),(832,'A',1,NULL),(833,'A',1,NULL),(834,'A',1,NULL),(835,'A',1,NULL),(836,'A',1,NULL),(837,'A',1,NULL),(838,'A',1,NULL),(839,'A',1,NULL),(840,'A',1,NULL),(841,'A',1,NULL),(842,'A',1,NULL),(843,'A',1,NULL),(844,'A',1,NULL),(845,'A',1,NULL),(846,'A',1,NULL),(847,'A',1,NULL),(848,'A',1,NULL),(849,'A',1,NULL),(850,'A',1,NULL),(851,'A',1,NULL),(852,'A',1,NULL),(853,'A',1,NULL),(854,'A',1,NULL),(855,'A',1,NULL),(856,'A',1,NULL),(857,'A',1,NULL),(858,'A',1,NULL),(859,'A',1,NULL),(860,'A',1,NULL),(861,'A',1,NULL),(862,'A',1,NULL),(863,'A',1,NULL),(864,'A',1,NULL),(865,'A',1,NULL),(866,'A',1,NULL),(867,'A',1,NULL),(868,'A',1,NULL),(869,'A',1,NULL),(870,'A',1,NULL),(871,'A',1,NULL),(872,'A',1,NULL),(873,'A',1,NULL),(874,'A',1,NULL),(875,'A',1,NULL),(876,'A',1,NULL),(877,'A',1,NULL),(878,'A',1,NULL),(879,'A',1,NULL),(880,'A',1,NULL),(881,'A',1,NULL),(882,'A',1,NULL),(883,'A',1,NULL),(884,'A',1,NULL),(885,'A',1,NULL),(886,'A',1,NULL),(887,'A',1,NULL),(888,'A',1,NULL),(889,'A',1,NULL),(890,'A',1,NULL),(891,'A',1,NULL),(892,'A',1,NULL),(893,'A',1,NULL),(894,'A',1,NULL),(895,'A',1,NULL),(896,'A',1,NULL),(897,'A',1,NULL),(898,'A',1,NULL),(899,'A',1,NULL),(900,'A',1,NULL),(901,'A',1,NULL),(902,'A',1,NULL),(903,'A',1,NULL),(904,'A',1,NULL),(905,'A',1,NULL),(906,'A',1,NULL),(907,'A',1,NULL),(908,'A',1,NULL),(909,'A',1,NULL),(910,'A',1,NULL),(911,'A',1,NULL),(912,'A',1,NULL),(913,'A',1,NULL),(914,'A',1,NULL),(915,'A',1,NULL),(916,'A',1,NULL),(917,'A',1,NULL),(918,'A',1,NULL),(919,'A',1,NULL),(920,'A',1,NULL),(921,'A',1,NULL),(922,'A',1,NULL),(923,'A',1,NULL),(924,'A',1,NULL),(925,'A',1,NULL),(926,'A',1,NULL),(927,'A',1,NULL),(928,'A',1,NULL),(929,'A',1,NULL),(930,'A',1,NULL),(931,'A',1,NULL),(932,'A',1,NULL),(933,'A',1,NULL),(934,'A',1,NULL),(935,'A',1,NULL),(936,'A',1,NULL),(937,'A',1,NULL),(938,'A',1,NULL),(939,'A',1,NULL),(940,'A',1,NULL),(941,'A',1,NULL),(942,'A',1,NULL),(943,'A',1,NULL),(944,'A',1,NULL),(945,'A',1,NULL),(946,'A',1,NULL),(947,'A',1,NULL),(948,'A',1,NULL),(949,'A',1,NULL),(950,'A',1,NULL),(951,'A',1,NULL),(952,'A',1,NULL),(953,'A',1,NULL),(954,'A',1,NULL),(955,'A',1,NULL),(956,'A',1,NULL),(957,'A',1,NULL),(958,'A',1,NULL),(959,'A',1,NULL),(960,'A',1,NULL),(961,'A',1,NULL),(962,'A',1,NULL),(963,'A',1,NULL),(964,'A',1,NULL),(965,'A',1,NULL),(966,'A',1,NULL),(967,'A',1,NULL),(968,'A',1,NULL),(969,'A',1,NULL),(970,'A',1,NULL),(971,'A',1,NULL),(972,'A',1,NULL),(973,'A',1,NULL),(974,'A',1,NULL),(975,'A',1,NULL),(976,'A',1,NULL),(977,'A',1,NULL),(978,'A',1,NULL),(979,'A',1,NULL),(980,'A',1,NULL),(981,'A',1,NULL),(982,'A',1,NULL),(983,'A',1,NULL),(984,'A',1,NULL),(985,'A',1,NULL),(986,'A',1,NULL),(987,'A',1,NULL),(988,'A',1,NULL),(989,'A',1,NULL),(990,'A',1,NULL),(991,'A',1,NULL),(992,'A',1,NULL),(993,'A',1,NULL),(994,'A',1,NULL),(995,'A',1,NULL),(996,'A',1,NULL),(997,'A',1,NULL),(998,'A',1,NULL),(999,'A',1,NULL),(1000,'A',1,NULL),(1001,'A',1,NULL),(1002,'A',1,NULL),(1003,'A',1,NULL),(1004,'A',1,NULL),(1005,'A',1,NULL),(1006,'A',1,NULL),(1007,'A',1,NULL),(1008,'A',1,NULL),(1009,'A',1,NULL),(1010,'A',1,NULL),(1011,'A',1,NULL),(1012,'A',1,NULL),(1013,'A',1,NULL),(1014,'A',1,NULL),(1015,'A',1,NULL),(1016,'A',1,NULL),(1017,'A',1,NULL),(1018,'A',1,NULL),(1019,'A',1,NULL),(1020,'A',1,NULL),(1021,'A',1,NULL),(1022,'A',1,NULL),(1023,'A',1,NULL),(1024,'A',1,NULL),(1025,'A',1,NULL),(1026,'A',1,NULL),(1027,'A',1,NULL),(1028,'A',1,NULL),(1029,'A',1,NULL),(1030,'A',1,NULL),(1031,'A',1,NULL),(1032,'A',1,NULL),(1033,'A',1,NULL),(1034,'A',1,NULL),(1035,'A',1,NULL),(1036,'A',1,NULL),(1037,'A',1,NULL),(1038,'A',1,NULL),(1039,'A',1,NULL),(1040,'A',1,NULL),(1041,'A',1,NULL),(1042,'A',1,NULL),(1043,'A',1,NULL),(1044,'A',1,NULL),(1045,'A',1,NULL),(1046,'A',1,NULL),(1047,'A',1,NULL),(1048,'A',1,NULL),(1049,'A',1,NULL),(1050,'A',1,NULL),(1051,'A',1,NULL),(1052,'A',1,NULL),(1053,'A',1,NULL),(1054,'A',1,NULL),(1055,'A',1,NULL),(1056,'A',1,NULL),(1057,'A',1,NULL),(1058,'A',1,NULL),(1059,'A',1,NULL),(1060,'A',1,NULL),(1061,'A',1,NULL),(1062,'A',1,NULL),(1063,'A',1,NULL),(1064,'A',1,NULL),(1065,'A',1,NULL),(1066,'A',1,NULL),(1067,'A',1,NULL),(1068,'A',1,NULL),(1069,'A',1,NULL),(1070,'A',1,NULL),(1071,'A',1,NULL),(1072,'A',1,NULL),(1073,'A',1,NULL),(1074,'A',1,NULL),(1075,'A',1,NULL),(1076,'A',1,NULL),(1077,'A',1,NULL),(1078,'A',1,NULL),(1079,'A',1,NULL),(1080,'A',1,NULL),(1081,'A',1,NULL),(1082,'A',1,NULL),(1083,'A',1,NULL),(1084,'A',1,NULL),(1085,'A',1,NULL),(1086,'A',1,NULL),(1087,'A',1,NULL),(1088,'A',1,NULL),(1089,'A',1,NULL),(1090,'A',1,NULL),(1091,'A',1,NULL),(1092,'A',1,NULL),(1093,'A',1,NULL),(1094,'A',1,NULL),(1095,'A',1,NULL),(1096,'A',1,NULL),(1097,'A',1,NULL),(1098,'A',1,NULL),(1099,'A',1,NULL),(1100,'A',1,NULL),(1101,'A',1,NULL),(1102,'A',1,NULL),(1103,'A',1,NULL),(1104,'A',1,NULL),(1105,'A',1,NULL),(1106,'A',1,NULL),(1107,'A',1,NULL),(1108,'A',1,NULL),(1109,'A',1,NULL),(1110,'A',1,NULL),(1111,'A',1,NULL),(1112,'A',1,NULL),(1113,'A',1,NULL),(1114,'A',1,NULL),(1115,'A',1,NULL),(1116,'A',1,NULL),(1117,'A',1,NULL),(1118,'A',1,NULL),(1119,'A',1,NULL),(1120,'A',1,NULL),(1121,'A',1,NULL),(1122,'A',1,NULL),(1123,'A',1,NULL),(1124,'A',1,NULL),(1125,'A',1,NULL),(1126,'A',1,NULL),(1127,'A',1,NULL),(1128,'A',1,NULL),(1129,'A',1,NULL),(1130,'A',1,NULL),(1131,'A',1,NULL),(1132,'A',1,NULL),(1133,'A',1,NULL),(1134,'A',1,NULL),(1135,'A',1,NULL),(1136,'A',1,NULL),(1137,'A',1,NULL),(1138,'A',1,NULL),(1139,'A',1,NULL),(1140,'A',1,NULL),(1141,'A',1,NULL),(1142,'A',1,NULL),(1143,'A',1,NULL),(1144,'A',1,NULL),(1145,'A',1,NULL),(1146,'A',1,NULL),(1147,'A',1,NULL),(1148,'A',1,NULL),(1149,'A',1,NULL),(1150,'A',1,NULL),(1151,'A',1,NULL),(1152,'A',1,NULL),(1153,'A',1,NULL),(1154,'A',1,NULL),(1155,'A',1,NULL),(1156,'A',1,NULL),(1157,'A',1,NULL),(1158,'A',1,NULL),(1159,'A',1,NULL),(1160,'A',1,NULL),(1161,'A',1,NULL),(1162,'A',1,NULL),(1163,'A',1,NULL),(1164,'A',1,NULL),(1165,'A',1,NULL),(1166,'A',1,NULL),(1167,'A',1,NULL),(1168,'A',1,NULL),(1169,'A',1,NULL),(1170,'A',1,NULL),(1171,'A',1,NULL),(1172,'A',1,NULL),(1173,'A',1,NULL),(1174,'A',1,NULL),(1175,'A',1,NULL),(1176,'A',1,NULL),(1177,'A',1,NULL),(1178,'A',1,NULL),(1179,'A',1,NULL),(1180,'A',1,NULL),(1181,'A',1,NULL),(1182,'A',1,NULL),(1183,'A',1,NULL),(1184,'A',1,NULL),(1185,'A',1,NULL),(1186,'A',1,NULL),(1187,'A',1,NULL),(1188,'A',1,NULL),(1189,'A',1,NULL),(1190,'A',1,NULL),(1191,'A',1,NULL),(1192,'A',1,NULL),(1193,'A',1,NULL),(1194,'A',1,NULL),(1195,'A',1,NULL),(1196,'A',1,NULL),(1197,'A',1,NULL),(1198,'A',1,NULL),(1199,'A',1,NULL),(1200,'A',1,NULL),(1201,'A',1,NULL),(1202,'A',1,NULL),(1203,'A',1,NULL),(1204,'A',1,NULL),(1205,'A',1,NULL),(1206,'A',1,NULL),(1207,'A',1,NULL),(1208,'A',1,NULL),(1209,'A',1,NULL),(1210,'A',1,NULL),(1211,'A',1,NULL),(1212,'A',1,NULL),(1213,'A',1,NULL),(1214,'A',1,NULL),(1215,'A',1,NULL),(1216,'A',1,NULL),(1217,'A',1,NULL),(1218,'A',1,NULL),(1219,'A',1,NULL),(1220,'A',1,NULL),(1221,'A',1,NULL),(1222,'A',1,NULL),(1223,'A',1,NULL),(1224,'A',1,NULL),(1225,'A',1,NULL),(1226,'A',1,NULL),(1227,'A',1,NULL),(1228,'A',1,NULL),(1229,'A',1,NULL),(1230,'A',1,NULL),(1231,'A',1,NULL),(1232,'A',1,NULL),(1233,'A',1,NULL),(1234,'A',1,NULL),(1235,'A',1,NULL),(1236,'A',1,NULL),(1237,'A',1,NULL),(1238,'A',1,NULL),(1239,'A',1,NULL),(1240,'A',1,NULL),(1241,'A',1,NULL),(1242,'A',1,NULL),(1243,'A',1,NULL),(1244,'A',1,NULL),(1245,'A',1,NULL),(1246,'A',1,NULL),(1247,'A',1,NULL),(1248,'A',1,NULL),(1249,'A',1,NULL),(1250,'A',1,NULL),(1251,'A',1,NULL),(1252,'A',1,NULL),(1253,'A',1,NULL),(1254,'A',1,NULL),(1255,'A',1,NULL),(1256,'A',1,NULL),(1257,'A',1,NULL),(1258,'A',1,NULL),(1259,'A',1,NULL),(1260,'A',1,NULL),(1261,'A',1,NULL),(1262,'A',1,NULL),(1263,'A',1,NULL),(1264,'A',1,NULL),(1265,'A',1,NULL),(1266,'A',1,NULL),(1267,'A',1,NULL),(1268,'A',1,NULL),(1269,'A',1,NULL),(1270,'A',1,NULL),(1271,'A',1,NULL),(1272,'A',1,NULL),(1273,'A',1,NULL),(1274,'A',1,NULL),(1275,'A',1,NULL),(1276,'A',1,NULL),(1277,'A',1,NULL),(1278,'A',1,NULL),(1279,'A',1,NULL),(1280,'A',1,NULL),(1281,'A',1,NULL),(1282,'A',1,NULL),(1283,'A',1,NULL),(1284,'A',1,NULL),(1285,'A',1,NULL),(1286,'A',1,NULL),(1287,'A',1,NULL),(1288,'A',1,NULL),(1289,'A',1,NULL),(1290,'A',1,NULL),(1291,'A',1,NULL),(1292,'A',1,NULL),(1293,'A',1,NULL),(1294,'A',1,NULL),(1295,'A',1,NULL),(1296,'A',1,NULL),(1297,'A',1,NULL),(1298,'A',1,NULL),(1299,'A',1,NULL),(1300,'A',1,NULL),(1301,'A',1,NULL),(1302,'A',1,NULL),(1303,'A',1,NULL),(1304,'A',1,NULL),(1305,'A',1,NULL),(1306,'A',1,NULL),(1307,'A',1,NULL),(1308,'A',1,NULL),(1309,'A',1,NULL),(1310,'A',1,NULL),(1311,'A',1,NULL),(1312,'A',1,NULL),(1313,'A',1,NULL),(1314,'A',1,NULL),(1315,'A',1,NULL),(1316,'A',1,NULL),(1317,'A',1,NULL),(1318,'A',1,NULL),(1319,'A',1,NULL),(1320,'A',1,NULL),(1321,'A',1,NULL),(1322,'A',1,NULL),(1323,'A',1,NULL),(1324,'A',1,NULL),(1325,'A',1,NULL),(1326,'A',1,NULL),(1327,'A',1,NULL),(1328,'A',1,NULL),(1329,'A',1,NULL),(1330,'A',1,NULL),(1331,'A',1,NULL),(1332,'A',1,NULL),(1333,'A',1,NULL),(1334,'A',1,NULL),(1335,'A',1,NULL),(1336,'A',1,NULL),(1337,'A',1,NULL),(1338,'A',1,NULL),(1339,'A',1,NULL),(1340,'A',1,NULL),(1341,'A',1,NULL),(1342,'A',1,NULL),(1343,'A',1,NULL),(1344,'A',1,NULL),(1345,'A',1,NULL),(1346,'A',1,NULL),(1347,'A',1,NULL),(1348,'A',1,NULL),(1349,'A',1,NULL),(1350,'A',1,NULL),(1351,'A',1,NULL),(1352,'A',1,NULL),(1353,'A',1,NULL),(1354,'A',1,NULL),(1355,'A',1,NULL),(1356,'A',1,NULL),(1357,'A',1,NULL),(1358,'A',1,NULL),(1359,'A',1,NULL),(1360,'A',1,NULL),(1361,'A',1,NULL),(1362,'A',1,NULL),(1363,'A',1,NULL),(1364,'A',1,NULL),(1365,'A',1,NULL),(1366,'A',1,NULL),(1367,'A',1,NULL),(1368,'A',1,NULL),(1369,'A',1,NULL),(1370,'A',1,NULL),(1371,'A',1,NULL),(1372,'A',1,NULL),(1373,'A',1,NULL),(1374,'A',1,NULL),(1375,'A',1,NULL),(1376,'A',1,NULL),(1377,'A',1,NULL),(1378,'A',1,NULL),(1379,'A',1,NULL),(1380,'A',1,NULL),(1381,'A',1,NULL),(1382,'A',1,NULL),(1383,'A',1,NULL),(1384,'A',1,NULL),(1385,'A',1,NULL),(1386,'A',1,NULL),(1387,'A',1,NULL),(1388,'A',1,NULL),(1389,'A',1,NULL),(1390,'A',1,NULL),(1391,'A',1,NULL),(1392,'A',1,NULL),(1393,'A',1,NULL),(1394,'A',1,NULL),(1395,'A',1,NULL),(1396,'A',1,NULL),(1397,'A',1,NULL),(1398,'A',1,NULL),(1399,'A',1,NULL),(1400,'A',1,NULL),(1401,'A',1,NULL),(1402,'A',1,NULL),(1403,'A',1,NULL),(1404,'A',1,NULL),(1405,'A',1,NULL),(1406,'A',1,NULL),(1407,'A',1,NULL),(1408,'A',1,NULL),(1409,'A',1,NULL),(1410,'A',1,NULL),(1411,'A',1,NULL),(1412,'A',1,NULL),(1413,'A',1,NULL),(1414,'A',1,NULL),(1415,'A',1,NULL),(1416,'A',1,NULL),(1417,'A',1,NULL),(1418,'A',1,NULL),(1419,'A',1,NULL),(1420,'A',1,NULL),(1421,'A',1,NULL),(1422,'A',1,NULL),(1423,'A',1,NULL),(1424,'A',1,NULL),(1425,'A',1,NULL),(1426,'A',1,NULL),(1427,'A',1,NULL),(1428,'A',1,NULL),(1429,'A',1,NULL),(1430,'A',1,NULL),(1431,'A',1,NULL),(1432,'A',1,NULL),(1433,'A',1,NULL),(1434,'A',1,NULL),(1435,'A',1,NULL),(1436,'A',1,NULL),(1437,'A',1,NULL),(1438,'A',1,NULL),(1439,'A',1,NULL),(1440,'A',1,NULL),(1441,'A',1,NULL),(1442,'A',1,NULL),(1443,'A',1,NULL),(1444,'A',1,NULL),(1445,'A',1,NULL),(1446,'A',1,NULL),(1447,'A',1,NULL),(1448,'A',1,NULL),(1449,'A',1,NULL),(1450,'A',1,NULL),(1451,'A',1,NULL),(1452,'A',1,NULL),(1453,'A',1,NULL),(1454,'A',1,NULL),(1455,'A',1,NULL),(1456,'A',1,NULL),(1457,'A',1,NULL),(1458,'A',1,NULL),(1459,'A',1,NULL),(1460,'A',1,NULL),(1461,'A',1,NULL),(1462,'A',1,NULL),(1463,'A',1,NULL),(1464,'A',1,NULL),(1465,'A',1,NULL),(1466,'A',1,NULL),(1467,'A',1,NULL),(1468,'A',1,NULL),(1469,'A',1,NULL),(1470,'A',1,NULL),(1471,'A',1,NULL),(1472,'A',1,NULL),(1473,'A',1,NULL),(1474,'A',1,NULL),(1475,'A',1,NULL),(1476,'A',1,NULL),(1477,'A',1,NULL),(1478,'A',1,NULL),(1479,'A',1,NULL),(1480,'A',1,NULL),(1481,'A',1,NULL),(1482,'A',1,NULL),(1483,'A',1,NULL),(1484,'A',1,NULL),(1485,'A',1,NULL),(1486,'A',1,NULL),(1487,'A',1,NULL),(1488,'A',1,NULL),(1489,'A',1,NULL),(1490,'A',1,NULL),(1491,'A',1,NULL),(1492,'A',1,NULL),(1493,'A',1,NULL),(1494,'A',1,NULL),(1495,'A',1,NULL),(1496,'A',1,NULL),(1497,'A',1,NULL),(1498,'A',1,NULL),(1499,'A',1,NULL),(1500,'A',1,NULL),(1501,'A',1,NULL),(1502,'A',1,NULL),(1503,'A',1,NULL),(1504,'A',1,NULL),(1505,'A',1,NULL),(1506,'A',1,NULL),(1507,'A',1,NULL),(1508,'A',1,NULL),(1509,'A',1,NULL),(1510,'A',1,NULL),(1511,'A',1,NULL),(1512,'A',1,NULL),(1513,'A',1,NULL),(1514,'A',1,NULL),(1515,'A',1,NULL),(1516,'A',1,NULL),(1517,'A',1,NULL),(1518,'A',1,NULL),(1519,'A',1,NULL),(1520,'A',1,NULL),(1521,'A',1,NULL),(1522,'A',1,NULL),(1523,'A',1,NULL),(1524,'A',1,NULL),(1525,'A',1,NULL),(1526,'A',1,NULL),(1527,'A',1,NULL),(1528,'A',1,NULL),(1529,'A',1,NULL),(1530,'A',1,NULL),(1531,'A',1,NULL),(1532,'A',1,NULL),(1533,'A',1,NULL),(1534,'A',1,NULL),(1535,'A',1,NULL),(1536,'A',1,NULL),(1537,'A',1,NULL),(1538,'A',1,NULL),(1539,'A',1,NULL),(1540,'A',1,NULL),(1541,'A',1,NULL),(1542,'A',1,NULL),(1543,'A',1,NULL),(1544,'A',1,NULL),(1545,'A',1,NULL),(1546,'A',1,NULL),(1547,'A',1,NULL),(1548,'A',1,NULL),(1549,'A',1,NULL),(1550,'A',1,NULL),(1551,'A',1,NULL),(1552,'A',1,NULL),(1553,'A',1,NULL),(1554,'A',1,NULL),(1555,'A',1,NULL),(1556,'A',1,NULL),(1557,'A',1,NULL),(1558,'A',1,NULL),(1559,'A',1,NULL),(1560,'A',1,NULL),(1561,'A',1,NULL),(1562,'A',1,NULL),(1563,'A',1,NULL),(1564,'A',1,NULL),(1565,'A',1,NULL),(1566,'A',1,NULL),(1567,'A',1,NULL),(1568,'A',1,NULL),(1569,'A',1,NULL),(1570,'A',1,NULL),(1571,'A',1,NULL),(1572,'A',1,NULL),(1573,'A',1,NULL),(1574,'A',1,NULL),(1575,'A',1,NULL),(1576,'A',1,NULL),(1577,'A',1,NULL),(1578,'A',1,NULL),(1579,'A',1,NULL),(1580,'A',1,NULL),(1581,'A',1,NULL),(1582,'A',1,NULL),(1583,'A',1,NULL),(1584,'A',1,NULL),(1585,'A',1,NULL),(1586,'A',1,NULL),(1587,'A',1,NULL),(1588,'A',1,NULL),(1589,'A',1,NULL),(1590,'A',1,NULL),(1591,'A',1,NULL),(1592,'A',1,NULL),(1593,'A',1,NULL),(1594,'A',1,NULL),(1595,'A',1,NULL),(1596,'A',1,NULL),(1597,'A',1,NULL),(1598,'A',1,NULL),(1599,'A',1,NULL),(1600,'A',1,NULL),(1601,'A',1,NULL),(1602,'A',1,NULL),(1603,'A',1,NULL),(1604,'A',1,NULL),(1605,'A',1,NULL),(1606,'A',1,NULL),(1607,'A',1,NULL),(1608,'A',1,NULL),(1609,'A',1,NULL),(1610,'A',1,NULL),(1611,'A',1,NULL),(1612,'A',1,NULL),(1613,'A',1,NULL),(1614,'A',1,NULL),(1615,'A',1,NULL),(1616,'A',1,NULL),(1617,'A',1,NULL),(1618,'A',1,NULL),(1619,'A',1,NULL),(1620,'A',1,NULL);
/*!40000 ALTER TABLE ElPam.`facturaven` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lineafactura`
--

LOCK TABLES ElPam.`lineafactura` WRITE;
/*!40000 ALTER TABLE ElPam.`lineafactura` DISABLE KEYS */;
INSERT INTO ElPam.`lineafactura` VALUES (1,522,'A',0,1,55,22,1.60000002384186,0),(2,516,'A',0,1,100,22,0.300000011920929,0),(3,83,'A',1,1,10,22,1,0),(4,516,'A',1,1,100,22,1.35000002384186,0),(5,522,'A',2,1,55,22,1,0),(6,513,'A',3,1,85,22,1.5,0),(7,516,'A',4,1,100,22,1.09500002861023,0),(8,513,'A',5,1,85,22,0.469999998807907,0),(9,525,'A',6,1,120,22,0.5,0),(10,525,'A',7,1,120,22,0.5,0),(11,516,'A',8,1,100,22,3.18499994277954,0),(12,522,'A',8,1,55,22,3.08999991416931,0),(13,517,'A',9,1,95,22,1.10000002384186,0),(14,525,'A',9,1,120,22,0.5,0),(15,522,'A',10,1,55,22,1,0),(16,516,'A',11,1,100,22,0.899999976158142,0),(17,522,'A',12,1,55,22,0.400000005960465,0),(18,522,'A',13,1,55,22,1,0),(19,525,'A',14,1,120,22,0.5,0),(20,515,'A',15,1,149,22,0.899999976158142,0),(21,522,'A',16,1,55,22,1,0),(22,525,'A',17,1,120,22,0.699999988079071,0),(23,513,'A',18,1,85,22,0.699999988079071,0),(24,528,'A',19,1,75,22,1.16999995708466,0),(25,525,'A',20,1,120,22,0.5,0),(26,522,'A',21,1,55,22,0.449999988079071,0),(27,154,'A',22,1,22,22,2,0),(28,30,'A',22,1,36,22,1,0),(29,626,'A',22,1,20,22,1,0),(30,433,'A',22,1,1,22,20,0),(31,522,'A',23,1,55,22,1,0),(32,356,'A',24,1,7,22,1,0),(33,522,'A',25,1,55,22,1.07500004768372,0),(34,516,'A',26,1,100,22,0.899999976158142,0),(35,513,'A',27,1,85,22,1,0),(36,513,'A',28,1,85,22,1,0),(37,534,'A',29,1,50,22,0.949999988079071,0),(38,539,'A',30,1,130,22,0.33500000834465,0),(39,513,'A',31,1,85,22,1.85000002384186,0),(40,513,'A',32,1,85,22,0.610000014305115,0),(41,513,'A',33,1,85,22,0.7950000166893,0),(42,522,'A',34,1,55,22,0.5,0),(43,527,'A',35,1,75,22,1.47500002384186,0),(44,518,'A',36,1,110,22,1.86000001430511,0),(45,539,'A',36,1,130,22,0.625,0),(46,513,'A',36,1,89,22,0.600000023841858,0),(47,525,'A',37,1,120,22,0.25,0),(48,522,'A',37,1,55,22,1.7849999666214,0),(49,620,'A',38,1,19,22,1,0),(50,580,'A',38,1,18,22,1,0),(51,80,'A',38,1,32,22,1,0),(52,214,'A',38,1,20,22,1,0),(53,235,'A',38,1,24,22,1,0),(54,513,'A',38,1,89,22,1.10000002384186,0),(55,51,'A',39,1,31,22,1,0),(56,689,'A',39,1,7,22,1,0),(57,36,'A',40,1,56,22,1,0),(58,528,'A',40,1,75,22,2.20000004768372,0),(59,535,'A',41,1,160,22,0.675000011920929,0),(60,536,'A',42,1,120,22,1,0),(61,522,'A',43,1,55,22,2,0),(62,522,'A',44,1,55,22,0.899999976158142,0),(63,535,'A',45,1,150,22,0.400000005960465,0),(64,513,'A',46,1,89,22,2.34999990463257,0),(65,516,'A',47,1,100,22,1.13499999046326,0),(66,522,'A',48,1,55,22,1.89999997615814,0),(67,525,'A',49,1,120,22,0.349999994039535,0),(68,522,'A',50,1,55,22,2.17000007629395,0),(69,525,'A',51,1,120,22,0.330000013113022,0),(70,517,'A',52,1,95,22,1,0),(71,536,'A',53,1,120,22,1,0),(72,522,'A',54,1,55,22,2,0),(73,518,'A',55,1,110,22,0.5,0),(74,522,'A',56,1,55,22,2,0),(75,516,'A',56,1,100,22,0.600000023841858,0),(76,170,'A',57,1,5,22,1,0),(77,525,'A',58,1,120,22,0.5,0),(78,524,'A',58,1,65,22,1.62000000476837,0),(79,356,'A',59,1,7,22,1,0),(80,525,'A',60,1,120,22,0.230000004172325,0),(81,539,'A',61,1,130,22,0.899999976158142,0),(82,522,'A',62,1,55,22,0.425000011920929,0),(83,517,'A',63,1,95,22,1.07000005245209,0),(84,522,'A',64,1,55,22,0.930000007152557,0),(85,518,'A',65,1,110,22,1.45000004768372,0),(86,539,'A',66,1,130,22,0.219999998807907,0),(87,525,'A',66,1,120,22,0.319999992847443,0),(88,525,'A',67,1,120,22,0.5,0),(89,78,'A',67,1,44,22,1,0),(90,535,'A',67,1,150,22,0.5,0),(91,707,'A',68,1,28,22,1,0),(92,516,'A',69,1,100,22,0.800000011920929,0),(93,516,'A',70,1,100,22,0.839999973773956,0),(94,525,'A',70,1,120,22,0.850000023841858,0),(95,522,'A',71,1,55,22,1,0),(96,525,'A',71,1,120,22,0.5,0),(97,517,'A',72,1,95,22,1.19500005245209,0),(98,539,'A',72,1,130,22,0.449999988079071,0),(99,525,'A',73,1,120,22,1.5,0),(100,515,'A',74,1,149,22,0.400000005960465,0),(101,525,'A',75,1,120,22,0.455000013113022,0),(102,539,'A',76,1,130,22,2.78999996185303,0),(103,559,'A',77,1,32,22,1,0),(104,235,'A',77,1,24,22,1,0),(105,589,'A',77,1,64,22,1,0),(106,687,'A',77,1,26,22,1,0),(107,522,'A',78,1,55,22,2,0),(108,525,'A',79,1,120,22,1,0),(109,521,'A',80,1,125,22,1,0),(110,516,'A',81,1,100,22,0.490000009536743,0),(111,513,'A',81,1,89,22,1.12000000476837,0),(112,704,'A',81,1,3,22,3,0),(113,522,'A',82,1,55,22,2,0),(114,518,'A',83,1,110,22,0.980000019073486,0),(115,539,'A',83,1,130,22,0.479999989271164,0),(116,513,'A',84,1,89,22,1,0),(117,708,'A',85,1,30,22,1,0),(118,525,'A',86,1,120,22,1,0),(119,522,'A',87,1,55,22,2,0),(120,524,'A',88,1,65,22,2.95000004768372,0),(121,665,'A',88,1,3,22,120,0),(122,522,'A',89,1,55,22,2.09500002861023,0),(123,525,'A',89,1,120,22,0.540000021457672,0),(124,703,'A',90,1,12,22,1,0),(125,516,'A',90,1,100,22,1.06500005722046,0),(126,137,'A',91,1,21,22,1,0),(127,650,'A',91,1,6,22,1,0),(128,645,'A',91,1,6,22,1,0),(129,525,'A',92,1,120,22,0.850000023841858,0),(130,524,'A',93,1,65,22,1.13999998569489,0),(131,570,'A',94,1,15,22,1,0),(132,170,'A',94,1,5,22,2,0),(133,525,'A',95,1,120,22,1,0),(134,557,'A',95,1,12,22,1,0),(135,513,'A',96,1,89,22,1,0),(136,525,'A',96,1,120,22,0.5,0),(137,525,'A',97,1,120,22,0.5,0),(138,563,'A',97,1,13,22,2,0),(139,535,'A',98,1,150,22,1,0),(140,665,'A',99,1,3,22,12,0),(141,521,'A',100,1,125,22,0.800000011920929,0),(142,525,'A',101,1,120,22,0.5,0),(143,539,'A',102,1,130,22,5.40000009536743,0),(144,528,'A',102,1,75,22,2.40000009536743,0),(145,522,'A',102,1,55,22,1.70000004768372,0),(146,516,'A',102,1,100,22,0.75,0),(147,403,'A',103,1,45,22,2,0),(148,29,'A',104,1,10,22,1,0),(149,655,'A',104,1,7,22,2,0),(150,144,'A',105,1,16,22,1,0),(151,621,'A',106,1,18,22,1,0),(152,672,'A',106,1,9,22,1,0),(153,525,'A',107,1,120,22,2.60999989509582,0),(154,528,'A',107,1,75,22,2.90000009536743,0),(155,516,'A',107,1,100,22,0.625,0),(156,356,'A',107,1,7,22,5,0),(157,30,'A',107,1,36,22,1,0),(158,522,'A',107,1,55,22,1.74000000953674,0),(159,513,'A',107,1,89,22,1.5,0),(160,357,'A',107,1,7,22,2,0),(161,525,'A',108,1,120,22,2.59999990463257,0),(162,524,'A',108,1,65,22,0.759999990463257,0),(163,539,'A',108,1,130,22,1.39000010490417,0),(164,559,'A',108,1,32,22,1,0),(165,568,'A',108,1,15,22,1,0),(166,689,'A',108,1,7,22,1,0),(167,144,'A',108,1,16,22,1,0),(168,433,'A',108,1,1,22,5,0),(169,513,'A',108,1,89,22,0.519999980926514,0),(170,518,'A',108,1,110,22,2.32999992370605,0),(171,528,'A',108,1,75,22,0.400000005960465,0),(172,707,'A',109,1,28,22,1,0),(173,522,'A',109,1,55,22,1,0),(174,513,'A',109,1,89,22,1.60000002384186,0),(175,525,'A',109,1,120,22,0.649999976158142,0),(176,541,'A',109,1,60,22,2.29999995231628,0),(177,671,'A',109,1,10,22,1,0),(178,566,'A',109,1,7,22,1,0),(179,539,'A',109,1,130,22,1,0),(180,518,'A',109,1,110,22,2.20000004768372,0),(181,517,'A',109,1,95,22,1.20000004768372,0),(182,571,'A',109,1,15,22,1,0),(183,580,'A',109,1,18,22,2,0),(184,522,'A',110,1,55,22,5.80000019073486,0),(185,539,'A',110,1,130,22,1.5,0),(186,528,'A',110,1,75,22,0.75,0),(187,525,'A',110,1,120,22,2.5,0),(188,516,'A',110,1,100,22,2.38000011444092,0),(189,357,'A',110,1,7,22,2,0),(190,562,'A',110,1,20,22,1,0),(191,617,'A',110,1,19,22,1,0),(192,528,'A',111,1,75,22,2.70000004768372,0),(193,525,'A',111,1,120,22,2.62000012397766,0),(194,522,'A',111,1,55,22,2,0),(195,80,'A',111,1,32,22,1,0),(196,515,'A',111,1,149,22,2,0),(197,517,'A',111,1,95,22,1.20000004768372,0),(198,29,'A',111,1,10,22,1,0),(199,541,'A',111,1,60,22,1,0),(200,516,'A',111,1,100,22,2.34999990463257,0),(201,518,'A',111,1,110,22,7.19999980926514,0),(202,513,'A',111,1,89,22,2.14000010490418,0),(203,516,'A',112,1,100,22,1.98000001907349,0),(204,539,'A',112,1,130,22,2.5,0),(205,534,'A',112,1,50,22,4,0),(206,525,'A',112,1,120,22,1.95000004768372,0),(207,522,'A',112,1,55,22,0.600000023841858,0),(208,117,'A',112,1,10,22,2,0),(209,340,'A',112,1,8,22,3,0),(210,704,'A',112,1,3,22,4,0),(211,535,'A',112,1,150,22,0.699999988079071,0),(212,528,'A',112,1,75,22,3.16000008583069,0),(213,513,'A',112,1,89,22,0.550000011920929,0),(214,518,'A',112,1,110,22,5.5,0),(215,517,'A',113,1,95,22,3.07999992370605,0),(216,535,'A',113,1,150,22,2.02999997138977,0),(217,324,'A',113,1,30,22,5,0),(218,525,'A',113,1,120,22,0.529999971389771,0),(219,528,'A',113,1,75,22,0.479999989271164,0),(220,539,'A',113,1,130,22,2.28999996185303,0),(221,541,'A',113,1,60,22,3.09999990463257,0),(222,650,'A',113,1,6,22,1,0),(223,648,'A',113,1,6,22,1,0),(224,626,'A',114,1,20,22,1,0),(225,541,'A',114,1,60,22,2.5,0),(226,535,'A',115,1,150,22,0.395000010728836,0),(227,708,'A',115,1,30,22,1,0),(228,400,'A',116,1,45,22,1,0),(229,516,'A',117,1,100,22,1.13999998569489,0),(230,515,'A',117,1,149,22,1,0),(231,525,'A',117,1,120,22,1,0),(232,539,'A',118,1,130,22,0.330000013113022,0),(233,513,'A',118,1,89,22,0.600000023841858,0),(234,689,'A',118,1,7,22,1,0),(235,657,'A',119,1,59,22,1,0),(236,518,'A',120,1,110,22,2.46000003814697,0),(237,522,'A',121,1,55,22,2.20000004768372,0),(238,528,'A',122,1,75,22,2.0699999332428,0),(239,533,'A',122,1,35,22,0.884999990463257,0),(240,515,'A',122,1,149,22,0.899999976158142,0),(241,549,'A',122,1,25,22,4,0),(242,708,'A',122,1,30,22,1,0),(243,533,'A',123,1,35,22,1.25,0),(244,539,'A',124,1,130,22,0.379999995231628,0),(245,538,'A',125,1,40,22,2.45000004768372,0),(246,513,'A',126,1,89,22,3.05999994277954,0),(247,522,'A',126,1,55,22,1.12000000476837,0),(248,526,'A',127,1,75,22,2.77999997138977,0),(249,541,'A',128,1,60,22,2.67000007629395,0),(250,533,'A',128,1,35,22,0.800000011920929,0),(251,518,'A',129,1,110,22,5.45499992370606,0),(252,522,'A',130,1,55,22,1.64999997615814,0),(253,71,'A',131,1,79,22,2,0),(254,536,'A',131,1,120,22,0.850000023841858,0),(255,538,'A',132,1,40,22,0.860000014305115,0),(256,518,'A',132,1,110,22,0.75,0),(257,524,'A',133,1,65,22,1.12999999523163,0),(258,522,'A',134,1,55,22,1,0),(259,663,'A',135,1,15,22,1,0),(260,515,'A',136,1,149,22,2,0),(261,536,'A',137,1,120,22,0.850000023841858,0),(262,525,'A',138,1,120,22,0.400000005960465,0),(263,536,'A',139,1,120,22,0.514999985694885,0),(264,311,'A',140,1,78,22,1,0),(265,536,'A',141,1,120,22,1,0),(266,541,'A',142,1,60,22,1,0),(267,57,'A',142,1,71,22,1,0),(268,518,'A',142,1,110,22,0.899999976158142,0),(269,580,'A',143,1,18,22,1,0),(270,516,'A',143,1,100,22,0.5799999833107,0),(271,528,'A',144,1,75,22,3.40000009536743,0),(272,522,'A',145,1,55,22,2.40000009536743,0),(273,334,'A',146,1,140,22,1,0),(274,522,'A',147,1,55,22,1.67999994754791,0),(275,566,'A',148,1,7,22,1,0),(276,522,'A',149,1,55,22,1.95000004768372,0),(277,357,'A',149,1,7,22,1,0),(278,516,'A',149,1,100,22,1.60000002384186,0),(279,704,'A',150,1,3,22,18,0),(280,516,'A',150,1,100,22,1.67999994754791,0),(281,513,'A',150,1,89,22,0.865000009536743,0),(282,525,'A',150,1,120,22,0.449999988079071,0),(283,122,'A',150,1,3,22,1,0),(284,515,'A',150,1,149,22,1,0),(285,513,'A',151,1,89,22,1.09500002861023,0),(286,522,'A',152,1,55,22,0.75,0),(287,522,'A',153,1,55,22,0.899999976158142,0),(288,518,'A',154,1,110,22,6.15999984741211,0),(289,536,'A',155,1,120,22,0.832000017166138,0),(290,522,'A',156,1,55,22,3.38499999046326,0),(291,528,'A',157,1,75,22,0.860000014305115,0),(292,60,'A',158,1,19,22,2,0),(293,83,'A',158,1,11,22,1,0),(294,703,'A',158,1,12,22,1,0),(295,513,'A',158,1,89,22,1.85000002384186,0),(296,707,'A',158,1,28,22,2,0),(297,536,'A',159,1,120,22,0.980000019073486,0),(298,516,'A',159,1,100,22,1.5,0),(299,525,'A',160,1,120,22,1,0),(300,539,'A',160,1,130,22,1.10000002384186,0),(301,356,'A',161,1,7,22,2,0),(302,513,'A',162,1,89,22,0.949999988079071,0),(303,525,'A',162,1,120,22,1,0),(304,261,'A',163,1,29,22,1,0),(305,541,'A',163,1,60,22,1.5,0),(306,513,'A',163,1,89,22,1.10000002384186,0),(307,516,'A',164,1,100,22,1.10000002384186,0),(308,201,'A',164,1,44,22,1,0),(309,516,'A',165,1,100,22,0.800000011920929,0),(310,534,'A',166,1,50,22,3.40000009536743,0),(311,514,'A',166,1,185,22,1.22500002384186,0),(312,536,'A',167,1,120,22,0.28999999165535,0),(313,528,'A',168,1,75,22,1.0900000333786,0),(314,707,'A',169,1,28,22,1,0),(315,539,'A',170,1,130,22,0.694999992847443,0),(316,536,'A',171,1,120,22,1.0900000333786,0),(317,513,'A',172,1,89,22,1,0),(318,539,'A',173,1,130,22,2.0699999332428,0),(319,518,'A',173,1,110,22,2.33999991416931,0),(320,704,'A',173,1,3,22,6,0),(321,83,'A',174,1,11,22,1,0),(322,513,'A',175,1,89,22,1.75,0),(323,525,'A',176,1,120,22,2,0),(324,522,'A',177,1,55,22,1.89499998092651,0),(325,525,'A',178,1,120,22,1,0),(326,517,'A',178,1,95,22,3.73000001907349,0),(327,565,'A',179,1,26,22,1,0),(328,522,'A',179,1,55,22,2,0),(329,707,'A',179,1,28,22,3,0),(330,513,'A',180,1,89,22,1.39999997615814,0),(331,707,'A',181,1,28,22,1,0),(332,516,'A',182,1,100,22,1.10000002384186,0),(333,517,'A',183,1,95,22,1.04499995708466,0),(334,525,'A',183,1,120,22,0.5,0),(335,76,'A',183,1,38,22,1,0),(336,522,'A',183,1,55,22,1,0),(337,516,'A',184,1,100,22,1.07500004768372,0),(338,516,'A',185,1,100,22,2.25999999046326,0),(339,708,'A',186,1,30,22,1,0),(340,541,'A',186,1,60,22,1.19500005245209,0),(341,340,'A',186,1,8,22,1,0),(342,513,'A',187,1,89,22,2.17000007629395,0),(343,539,'A',188,1,130,22,1.05999994277954,0),(344,525,'A',189,1,120,22,1,0),(345,514,'A',190,1,185,22,1.19000005722046,0),(346,525,'A',190,1,120,22,0.5799999833107,0),(347,513,'A',191,1,89,22,1,0),(348,522,'A',191,1,55,22,1.02999997138977,0),(349,528,'A',191,1,75,22,1.26999998092651,0),(350,549,'A',192,1,25,22,1,0),(351,708,'A',193,1,30,22,1,0),(352,539,'A',194,1,130,22,1,0),(353,522,'A',194,1,55,22,0.925000011920929,0),(354,704,'A',195,1,3,22,12,0),(355,536,'A',195,1,120,22,1,0),(356,35,'A',196,1,35,22,1,0),(357,535,'A',197,1,150,22,2.0550000667572,0),(358,522,'A',198,1,55,22,1.06500005722046,0),(359,357,'A',198,1,7,22,1,0),(360,528,'A',199,1,75,22,0.600000023841858,0),(361,518,'A',200,1,110,22,2.29999995231628,0),(362,522,'A',200,1,55,22,1.09500002861023,0),(363,525,'A',200,1,120,22,0.449999988079071,0),(364,528,'A',201,1,75,22,2.04999995231628,0),(365,513,'A',201,1,89,22,1.0900000333786,0),(366,525,'A',201,1,120,22,0.25,0),(367,525,'A',202,1,120,22,1,0),(368,563,'A',202,1,13,22,2,0),(369,535,'A',202,1,150,22,0.699999988079071,0),(370,522,'A',202,1,55,22,0.540000021457672,0),(371,340,'A',203,1,8,22,1,0),(372,356,'A',203,1,7,22,1,0),(373,525,'A',203,1,120,22,0.25,0),(374,122,'A',203,1,3,22,1,0),(375,704,'A',203,1,3,22,6,0),(376,518,'A',204,1,110,22,1.79999995231628,0),(377,513,'A',205,1,89,22,2.20000004768372,0),(378,539,'A',205,1,130,22,1,0),(379,521,'A',205,1,125,22,1.29999995231628,0),(380,122,'A',205,1,3,22,5,0),(381,652,'A',205,1,3,22,5,0),(382,191,'A',205,1,212,22,1,0),(383,513,'A',206,1,89,22,2.1800000667572,0),(384,525,'A',206,1,120,22,0.449999988079071,0),(385,350,'A',207,1,30,22,1,0),(386,645,'A',207,1,6,22,1,0),(387,648,'A',207,1,6,22,1,0),(388,83,'A',208,1,11,22,2,0),(389,580,'A',208,1,18,22,1,0),(390,518,'A',208,1,110,22,2.90000009536743,0),(391,513,'A',209,1,89,22,1.05999994277954,0),(392,525,'A',209,1,120,22,1.25,0),(393,528,'A',209,1,75,22,3.75,0),(394,536,'A',210,1,120,22,0.939999997615814,0),(395,524,'A',210,1,65,22,2,0),(396,522,'A',210,1,55,22,0.660000026226044,0),(397,521,'A',210,1,125,22,2.58999991416931,0),(398,539,'A',211,1,130,22,3.42000007629395,0),(399,525,'A',211,1,120,22,3.89000010490418,0),(400,541,'A',211,1,60,22,0.555000007152557,0),(401,515,'A',211,1,149,22,1.75999999046326,0),(402,522,'A',211,1,55,22,2.13000011444092,0),(403,516,'A',211,1,100,22,1.94000005722046,0),(404,513,'A',211,1,89,22,2.20000004768372,0),(405,517,'A',211,1,95,22,1.89999997615814,0),(406,513,'A',212,1,89,22,2.13000011444092,0),(407,522,'A',212,1,55,22,4,0),(408,154,'A',212,1,25,22,1,0),(409,339,'A',212,1,8,22,1,0),(410,626,'A',212,1,20,22,1,0),(411,86,'A',212,1,19,22,2,0),(412,83,'A',212,1,11,22,1,0),(413,525,'A',212,1,120,22,1,0),(414,541,'A',212,1,60,22,0.370000004768372,0),(415,83,'A',213,1,11,22,2,0),(416,528,'A',213,1,75,22,1.14999997615814,0),(417,522,'A',213,1,55,22,4.46999979019165,0),(418,357,'A',213,1,7,22,2,0),(419,86,'A',213,1,19,22,2,0),(420,704,'A',213,1,3,22,3,0),(421,525,'A',213,1,120,22,1.5,0),(422,535,'A',213,1,150,22,0.620000004768372,0),(423,517,'A',213,1,95,22,1.03999996185303,0),(424,708,'A',213,1,30,22,1,0),(425,516,'A',213,1,100,22,1.39999997615814,0),(426,515,'A',214,1,149,22,3.25,0),(427,525,'A',214,1,120,22,0.800000011920929,0),(428,536,'A',214,1,120,22,1,0),(429,516,'A',214,1,100,22,1.20000004768372,0),(430,522,'A',214,1,55,22,3.59999990463257,0),(431,538,'A',214,1,40,22,3.04999995231628,0),(432,289,'A',214,1,8,22,1,0),(433,143,'A',214,1,18,22,1,0),(434,202,'A',214,1,24,22,1,0),(435,645,'A',214,1,6,22,1,0),(436,648,'A',214,1,6,22,1,0),(437,324,'A',215,1,30,22,1,0),(438,51,'A',215,1,31,22,1,0),(439,704,'A',215,1,3,22,6,0),(440,586,'A',215,1,27,22,1,0),(441,515,'A',216,1,149,22,6.30000019073486,0),(442,350,'A',216,1,30,22,2,0),(443,707,'A',217,1,28,22,4,0),(444,516,'A',218,1,100,22,0.5799999833107,0),(445,518,'A',219,1,110,22,2.70000004768372,0),(446,541,'A',219,1,60,22,2.40000009536743,0),(447,525,'A',220,1,120,22,0.5,0),(448,522,'A',220,1,55,22,1.17499995231628,0),(449,403,'A',221,1,45,22,1,0),(450,340,'A',222,1,8,22,1,0),(451,289,'A',222,1,8,22,1,0),(452,525,'A',223,1,120,22,0.5,0),(453,627,'A',223,1,17,22,1,0),(454,525,'A',224,1,120,22,1,0),(455,539,'A',224,1,130,22,0.8299999833107,0),(456,525,'A',225,1,120,22,0.349999994039535,0),(457,76,'A',225,1,38,22,1,0),(458,565,'A',225,1,26,22,1,0),(459,433,'A',225,1,1,22,4,0),(460,525,'A',226,1,120,22,0.899999976158142,0),(461,704,'A',226,1,3,22,6,0),(462,538,'A',227,1,40,22,3.09999990463257,0),(463,516,'A',228,1,100,22,1.13999998569489,0),(464,538,'A',229,1,40,22,3.09999990463257,0),(465,539,'A',230,1,130,22,1.99000000953674,0),(466,518,'A',231,1,110,22,2.40000009536743,0),(467,520,'A',232,1,125,22,0.899999976158142,0),(468,525,'A',233,1,120,22,2.90000009536743,0),(469,541,'A',233,1,60,22,2,0),(470,704,'A',233,1,3,22,12,0),(471,518,'A',233,1,110,22,1.89999997615814,0),(472,513,'A',233,1,89,22,0.9200000166893,0),(473,539,'A',234,1,130,22,1.70000004768372,0),(474,516,'A',234,1,100,22,0.899999976158142,0),(475,515,'A',234,1,149,22,1.5,0),(476,525,'A',234,1,120,22,0.25,0),(477,433,'A',235,1,1,22,10,0),(478,522,'A',235,1,55,22,1.51999998092651,0),(479,539,'A',235,1,130,22,5.40000009536743,0),(480,517,'A',235,1,95,22,3.96000003814697,0),(481,528,'A',235,1,75,22,1.79999995231628,0),(482,520,'A',235,1,125,22,1.70000004768372,0),(483,701,'A',235,1,40,22,1,0),(484,128,'A',235,1,25,22,1,0),(485,433,'A',236,1,1,22,10,0),(486,525,'A',236,1,120,22,0.5,0),(487,704,'A',236,1,3,22,6,0),(488,535,'A',236,1,150,22,0.600000023841858,0),(489,522,'A',236,1,55,22,3,0),(490,513,'A',236,1,89,22,2.13000011444092,0),(491,539,'A',236,1,130,22,1,0),(492,528,'A',236,1,75,22,2.24000000953674,0),(493,525,'A',237,1,120,22,0.439999997615814,0),(494,513,'A',238,1,89,22,1.10000002384186,0),(495,518,'A',239,1,110,22,2.79999995231628,0),(496,539,'A',239,1,130,22,0.959999978542328,0),(497,525,'A',240,1,120,22,1,0),(498,311,'A',240,1,78,22,1,0),(499,539,'A',241,1,130,22,1.64999997615814,0),(500,704,'A',242,1,3,22,30,0),(501,525,'A',243,1,120,22,0.449999988079071,0),(502,340,'A',244,1,8,22,1,0),(503,359,'A',244,1,7,22,1,0),(504,516,'A',245,1,100,22,0.8299999833107,0),(505,539,'A',245,1,130,22,0.828000009059906,0),(506,127,'A',246,1,25,22,1,0),(507,30,'A',246,1,36,22,1,0),(508,708,'A',246,1,30,22,1,0),(509,522,'A',247,1,55,22,1.08299994468689,0),(510,61,'A',247,1,30,22,1,0),(511,660,'A',248,1,26,22,1,0),(512,535,'A',249,1,150,22,0.625,0),(513,246,'A',250,1,79,22,1,0),(514,288,'A',251,1,8,22,1,0),(515,61,'A',252,1,30,22,1,0),(516,520,'A',253,1,125,22,1.37300002574921,0),(517,535,'A',253,1,150,22,0.504999995231628,0),(518,525,'A',253,1,120,22,4.07400035858154,0),(519,522,'A',253,1,55,22,2.53699994087219,0),(520,541,'A',253,1,60,22,8,0),(521,513,'A',253,1,89,22,2.83200025558472,0),(522,707,'A',253,1,28,22,1,0),(523,518,'A',253,1,110,22,3.75,0),(524,527,'A',253,1,75,22,1.89699995517731,0),(525,53,'A',253,1,40,22,1,0),(526,154,'A',253,1,25,22,1,0),(527,616,'A',253,1,23,22,2,0),(528,611,'A',253,1,22,22,2,0),(529,708,'A',253,1,30,22,1,0),(530,539,'A',253,1,130,22,0.261000007390976,0),(531,517,'A',254,1,95,22,1.49500000476837,0),(532,539,'A',254,1,130,22,581.997985839844,0),(533,525,'A',254,1,120,22,3.29999995231628,0),(534,522,'A',254,1,55,22,1.02999997138977,0),(535,541,'A',254,1,60,22,1.10500001907349,0),(536,519,'A',254,1,125,22,1.08000004291534,0),(537,513,'A',254,1,89,22,1.37000000476837,0),(538,704,'A',254,1,3,22,6,0),(539,312,'A',254,1,80,22,1,0),(540,513,'A',255,1,89,22,3.82500004768372,0),(541,525,'A',255,1,120,22,5.5,0),(542,539,'A',255,1,130,22,3.28800010681152,0),(543,708,'A',255,1,30,22,1,0),(544,356,'A',255,1,7,22,1,0),(545,541,'A',255,1,60,22,1.10000002384186,0),(546,137,'A',255,1,21,22,1,0),(547,525,'A',256,1,120,22,2.72499990463257,0),(548,356,'A',256,1,7,22,4,0),(549,513,'A',256,1,89,22,1.56500005722046,0),(550,539,'A',256,1,130,22,2.67300009727478,0),(551,91,'A',256,1,18,22,1,0),(552,522,'A',256,1,55,22,2.49000000953674,0),(553,645,'A',256,1,6,22,1,0),(554,648,'A',256,1,6,22,1,0),(555,541,'A',256,1,60,22,2.53999996185303,0),(556,513,'A',257,1,89,22,1.6599999666214,0),(557,525,'A',257,1,120,22,1.02999997138977,0),(558,522,'A',257,1,55,22,2.46499991416931,0),(559,129,'A',257,1,33,22,1,0),(560,518,'A',257,1,110,22,1,0),(561,130,'A',257,1,45,22,1,0),(562,30,'A',257,1,36,22,1,0),(563,91,'A',257,1,18,22,1,0),(564,403,'A',257,1,45,22,1,0),(565,202,'A',257,1,24,22,1,0),(566,127,'A',257,1,25,22,1,0),(567,704,'A',257,1,3,22,6,0),(568,676,'A',257,1,79,22,1,0),(569,357,'A',257,1,7,22,2,0),(570,539,'A',258,1,130,22,6.72499990463257,0),(571,513,'A',258,1,89,22,5.375,0),(572,525,'A',258,1,120,22,7.28999996185303,0),(573,517,'A',258,1,95,22,6.24499988555908,0),(574,535,'A',258,1,150,22,1.0699999332428,0),(575,665,'A',258,1,3,22,3,0),(576,626,'A',258,1,20,22,2,0),(577,312,'A',258,1,80,22,1,0),(578,311,'A',258,1,78,22,1,0),(579,627,'A',258,1,17,22,2,0),(580,541,'A',258,1,60,22,4.31999969482422,0),(581,516,'A',258,1,100,22,3.9300000667572,0),(582,522,'A',258,1,55,22,4.01999998092651,0),(583,704,'A',258,1,3,22,16,0),(584,524,'A',258,1,65,22,1.10000002384186,0),(585,708,'A',258,1,30,22,1,0),(586,521,'A',258,1,125,22,1.60000002384186,0),(587,522,'A',259,1,55,22,1.41499996185303,0),(588,513,'A',260,1,89,22,1.11500000953674,0),(589,513,'A',261,1,89,22,1.02999997138977,0),(590,515,'A',261,1,149,22,0.615000009536743,0),(591,522,'A',262,1,55,22,1.6599999666214,0),(592,517,'A',263,1,95,22,0.865000009536743,0),(593,525,'A',264,1,120,22,1,0),(594,522,'A',265,1,55,22,2.02999997138977,0),(595,515,'A',266,1,149,22,0.6700000166893,0),(596,515,'A',267,1,149,22,0.540000021457672,0),(597,525,'A',267,1,120,22,0.5,0),(598,84,'A',267,1,19,22,1,0),(599,524,'A',268,1,65,22,2.11500000953674,0),(600,525,'A',268,1,120,22,0.185000002384186,0),(601,513,'A',268,1,89,22,0.319999992847443,0),(602,522,'A',269,1,55,22,2.75999999046326,0),(603,513,'A',270,1,89,22,0.899999976158142,0),(604,525,'A',270,1,120,22,0.449999988079071,0),(605,704,'A',270,1,3,22,12,0),(606,522,'A',271,1,55,22,2.07999992370605,0),(607,513,'A',272,1,89,22,1.25999999046326,0),(608,525,'A',273,1,120,22,1,0),(609,522,'A',274,1,55,22,3.34999990463257,0),(610,517,'A',274,1,95,22,1.0900000333786,0),(611,521,'A',274,1,125,22,1.52999997138977,0),(612,513,'A',274,1,89,22,3,0),(613,525,'A',274,1,120,22,0.449999988079071,0),(614,609,'A',274,1,20,22,1,0),(615,137,'A',274,1,21,22,1,0),(616,101,'A',274,1,34,22,1,0),(617,689,'A',274,1,7,22,2,0),(618,517,'A',275,1,95,22,0.949999988079071,0),(619,535,'A',276,1,150,22,0.949999988079071,0),(620,513,'A',277,1,89,22,0.569999992847443,0),(621,535,'A',278,1,150,22,0.5,0),(622,516,'A',279,1,100,22,1.20000004768372,0),(623,525,'A',280,1,120,22,1,0),(624,522,'A',280,1,55,22,1,0),(625,289,'A',281,1,8,22,1,0),(626,340,'A',281,1,8,22,1,0),(627,191,'A',281,1,212,22,1,0),(628,516,'A',281,1,100,22,0.5,0),(629,525,'A',281,1,120,22,0.5,0),(630,513,'A',281,1,89,22,1.13999998569489,0),(631,213,'A',281,1,25,22,1,0),(632,517,'A',281,1,95,22,0.899999976158142,0),(633,518,'A',281,1,110,22,2.11500000953674,0),(634,522,'A',282,1,55,22,0.529999971389771,0),(635,513,'A',283,1,89,22,2.08999991416931,0),(636,517,'A',283,1,95,22,1,0),(637,513,'A',284,1,89,22,1.11500000953674,0),(638,524,'A',285,1,65,22,0.660000026226044,0),(639,525,'A',285,1,120,22,0.400000005960465,0),(640,525,'A',286,1,120,22,0.850000023841858,0),(641,522,'A',287,1,55,22,0.550000011920929,0),(642,525,'A',288,1,120,22,1,0),(643,566,'A',288,1,7,22,1,0),(644,528,'A',289,1,75,22,2.22000002861023,0),(645,522,'A',290,1,55,22,0.959999978542328,0),(646,525,'A',290,1,120,22,0.400000005960465,0),(647,522,'A',291,1,55,22,3.59500002861023,0),(648,513,'A',292,1,89,22,0.230000004172325,0),(649,525,'A',293,1,120,22,0.275000005960465,0),(650,209,'A',294,1,39,22,1,0),(651,525,'A',294,1,120,22,1,0),(652,522,'A',294,1,55,22,1.37000000476837,0),(653,517,'A',295,1,95,22,1.29999995231628,0),(654,516,'A',295,1,100,22,0.389999985694885,0),(655,538,'A',296,1,40,22,1.39999997615814,0),(656,566,'A',296,1,7,22,2,0),(657,664,'A',297,1,30,22,1,0),(658,513,'A',298,1,89,22,3,0),(659,522,'A',298,1,55,22,1,0),(660,516,'A',299,1,100,22,1.3400000333786,0),(661,522,'A',300,1,55,22,1,0),(662,528,'A',301,1,75,22,1.24500000476837,0),(663,645,'A',301,1,6,22,1,0),(664,648,'A',301,1,6,22,1,0),(665,518,'A',302,1,110,22,2.09999990463257,0),(666,310,'A',303,1,80,22,1,0),(667,538,'A',303,1,40,22,0.899999976158142,0),(668,518,'A',304,1,110,22,3.24000000953674,0),(669,707,'A',305,1,28,22,1,0),(670,535,'A',305,1,150,22,0.400000005960465,0),(671,513,'A',306,1,89,22,0.550000011920929,0),(672,522,'A',307,1,55,22,1,0),(673,513,'A',308,1,89,22,0.560000002384186,0),(674,54,'A',309,1,60,22,1,0),(675,357,'A',309,1,7,22,1,0),(676,517,'A',310,1,95,22,0.540000021457672,0),(677,528,'A',311,1,75,22,2.70000004768372,0),(678,704,'A',312,1,3,22,30,0),(679,528,'A',312,1,75,22,2,0),(680,357,'A',313,1,7,22,1,0),(681,513,'A',313,1,89,22,0.400000005960465,0),(682,528,'A',314,1,75,22,1.6599999666214,0),(683,525,'A',315,1,120,22,0.349999994039535,0),(684,525,'A',316,1,120,22,0.449999988079071,0),(685,535,'A',317,1,150,22,0.790000021457672,0),(686,663,'A',318,1,15,22,1,0),(687,528,'A',318,1,75,22,1,0),(688,520,'A',319,1,125,22,0.899999976158142,0),(689,522,'A',320,1,55,22,1,0),(690,525,'A',320,1,120,22,0.449999988079071,0),(691,513,'A',321,1,89,22,0.469999998807907,0),(692,516,'A',322,1,100,22,1.08000004291534,0),(693,535,'A',323,1,150,22,0.634999990463257,0),(694,535,'A',324,1,160,22,0.5799999833107,0),(695,321,'A',325,1,53,22,1,0),(696,513,'A',325,1,89,22,3.0699999332428,0),(697,518,'A',326,1,110,22,9.27000045776367,0),(698,518,'A',327,1,110,22,1.10000002384186,0),(699,356,'A',328,1,7,22,1,0),(700,289,'A',329,1,8,22,1,0),(701,357,'A',329,1,7,22,1,0),(702,522,'A',330,1,55,22,1.04499995708466,0),(703,525,'A',331,1,120,22,0.259999990463257,0),(704,513,'A',332,1,89,22,1.53999996185303,0),(705,522,'A',333,1,55,22,2.08999991416931,0),(706,525,'A',333,1,120,22,0.5,0),(707,516,'A',333,1,100,22,1.03999996185303,0),(708,514,'A',333,1,185,22,1.15499997138977,0),(709,525,'A',334,1,120,22,5,0),(710,520,'A',334,1,125,22,1.59500002861023,0),(711,525,'A',335,1,120,22,1.13999998569489,0),(712,524,'A',336,1,65,22,1.05999994277954,0),(713,513,'A',336,1,89,22,1.19500005245209,0),(714,522,'A',337,1,55,22,1.10000002384186,0),(715,522,'A',338,1,55,22,0.555000007152557,0),(716,516,'A',339,1,100,22,0.28999999165535,0),(717,517,'A',339,1,95,22,1.51999998092651,0),(718,518,'A',340,1,110,22,4.41499996185303,0),(719,517,'A',341,1,95,22,1.28999996185303,0),(720,66,'A',342,1,19,22,2,0),(721,30,'A',342,1,36,22,4,0),(722,573,'A',342,1,15,22,1,0),(723,571,'A',342,1,15,22,1,0),(724,568,'A',342,1,15,22,2,0),(725,640,'A',342,1,15,22,1,0),(726,678,'A',342,1,76,22,1,0),(727,51,'A',342,1,31,22,4,0),(728,60,'A',342,1,19,22,2,0),(729,627,'A',342,1,17,22,2,0),(730,558,'A',342,1,66,22,1,0),(731,707,'A',342,1,28,22,1,0),(732,35,'A',342,1,35,22,1,0),(733,288,'A',343,1,8,22,1,0),(734,340,'A',343,1,8,22,1,0),(735,339,'A',343,1,8,22,1,0),(736,650,'A',343,1,6,22,5,0),(737,91,'A',343,1,18,22,1,0),(738,518,'A',343,1,110,22,0.899999976158142,0),(739,618,'A',343,1,26,22,1,0),(740,684,'A',343,1,24,22,1,0),(741,522,'A',343,1,55,22,1.82500004768372,0),(742,522,'A',344,1,55,22,1.82500004768372,0),(743,522,'A',345,1,55,22,0.899999976158142,0),(744,517,'A',345,1,95,22,1.70000004768372,0),(745,525,'A',345,1,120,22,0.5,0),(746,356,'A',345,1,7,22,2,0),(747,535,'A',346,1,160,22,0.660000026226044,0),(748,356,'A',346,1,7,22,1,0),(749,704,'A',347,1,3,22,18,0),(750,518,'A',347,1,110,22,0.939999997615814,0),(751,522,'A',347,1,55,22,2.87000012397766,0),(752,517,'A',347,1,95,22,1.03999996185303,0),(753,525,'A',347,1,120,22,0.540000021457672,0),(754,513,'A',347,1,89,22,1.55999994277954,0),(755,66,'A',347,1,19,22,1,0),(756,556,'A',347,1,32,22,1,0),(757,522,'A',348,1,55,22,0.949999988079071,0),(758,513,'A',349,1,89,22,1.3400000333786,0),(759,525,'A',350,1,120,22,1,0),(760,516,'A',350,1,100,22,0.759999990463257,0),(761,100,'A',351,1,19,22,1,0),(762,570,'A',352,1,15,22,1,0),(763,513,'A',352,1,89,22,0.435000002384186,0),(764,525,'A',352,1,120,22,0.439999997615814,0),(765,522,'A',353,1,55,22,0.560000002384186,0),(766,514,'A',353,1,185,22,10.3999996185303,0),(767,520,'A',354,1,125,22,3.40000009536743,0),(768,357,'A',354,1,7,22,1,0),(769,513,'A',355,1,89,22,0.605000019073486,0),(770,689,'A',355,1,7,22,1,0),(771,522,'A',356,1,55,22,0.930000007152557,0),(772,522,'A',357,1,55,22,2,0),(773,517,'A',358,1,95,22,0.550000011920929,0),(774,522,'A',359,1,55,22,0.970000028610229,0),(775,525,'A',360,1,120,22,0.449999988079071,0),(776,522,'A',360,1,55,22,0.899999976158142,0),(777,525,'A',361,1,120,22,1.04999995231628,0),(778,522,'A',361,1,55,22,0.449999988079071,0),(779,522,'A',362,1,55,22,1,0),(780,539,'A',363,1,130,22,0.119999997317791,0),(781,522,'A',363,1,55,22,0.479999989271164,0),(782,522,'A',364,1,55,22,1.34500002861023,0),(783,539,'A',364,1,130,22,0.495000004768372,0),(784,525,'A',364,1,120,22,0.300000011920929,0),(785,515,'A',365,1,149,22,0.5,0),(786,708,'A',365,1,30,22,1,0),(787,525,'A',366,1,120,22,0.430000007152557,0),(788,516,'A',367,1,100,22,1.37999999523163,0),(789,539,'A',368,1,130,22,1,0),(790,403,'A',368,1,45,22,1,0),(791,525,'A',369,1,120,22,1,0),(792,513,'A',370,1,89,22,0.569999992847443,0),(793,516,'A',371,1,100,22,1.45000004768372,0),(794,528,'A',372,1,75,22,0.949999988079071,0),(795,517,'A',373,1,95,22,3.33500003814697,0),(796,513,'A',374,1,89,22,0.584999978542328,0),(797,525,'A',375,1,120,22,0.5,0),(798,517,'A',376,1,95,22,1.05999994277954,0),(799,539,'A',377,1,130,22,0.5,0),(800,516,'A',378,1,100,22,0.889999985694885,0),(801,539,'A',378,1,130,22,0.349999994039535,0),(802,516,'A',379,1,100,22,1.74000000953674,0),(803,522,'A',379,1,55,22,1.29499995708466,0),(804,513,'A',380,1,89,22,0.5799999833107,0),(805,522,'A',381,1,55,22,2.73000001907349,0),(806,516,'A',381,1,100,22,3.36999988555908,0),(807,525,'A',381,1,120,22,2.55999994277954,0),(808,288,'A',382,1,8,22,1,0),(809,289,'A',382,1,8,22,1,0),(810,518,'A',382,1,110,22,1.39999997615814,0),(811,247,'A',382,1,79,22,1,0),(812,534,'A',383,1,50,22,2.40000009536743,0),(813,522,'A',384,1,55,22,1.28999996185303,0),(814,513,'A',384,1,89,22,2.15000009536743,0),(815,513,'A',385,1,89,22,1.10000002384186,0),(816,513,'A',386,1,89,22,1.39999997615814,0),(817,525,'A',387,1,120,22,0.5,0),(818,521,'A',388,1,125,22,0.834999978542328,0),(819,525,'A',389,1,120,22,0.600000023841858,0),(820,517,'A',389,1,95,22,1.03999996185303,0),(821,515,'A',389,1,149,22,0.800000011920929,0),(822,524,'A',390,1,65,22,0.714999973773956,0),(823,525,'A',390,1,120,22,0.200000002980232,0),(824,513,'A',391,1,89,22,1,0),(825,522,'A',391,1,55,22,1,0),(826,525,'A',392,1,120,22,0.850000023841858,0),(827,513,'A',393,1,89,22,1.41999995708466,0),(828,516,'A',393,1,100,22,1.11500000953674,0),(829,699,'A',393,1,45,22,1,0),(830,518,'A',394,1,110,22,4.67999982833862,0),(831,541,'A',395,1,60,22,2.5,0),(832,704,'A',396,1,3,22,6,0),(833,525,'A',396,1,120,22,0.5,0),(834,522,'A',397,1,55,22,1.05999994277954,0),(835,528,'A',398,1,75,22,1,0),(836,524,'A',399,1,65,22,0.985000014305115,0),(837,615,'A',399,1,23,22,1,0),(838,515,'A',400,1,149,22,1.10000002384186,0),(839,525,'A',400,1,120,22,1,0),(840,517,'A',400,1,95,22,1.20000004768372,0),(841,517,'A',401,1,95,22,1.87000000476837,0),(842,525,'A',402,1,120,22,0.469999998807907,0),(843,516,'A',403,1,100,22,1.34500002861023,0),(844,513,'A',403,1,89,22,1.10000002384186,0),(845,357,'A',403,1,7,22,1,0),(846,516,'A',404,1,100,22,0.540000021457672,0),(847,522,'A',405,1,55,22,1.0900000333786,0),(848,539,'A',405,1,130,22,1.19000005722046,0),(849,517,'A',406,1,95,22,1.0900000333786,0),(850,513,'A',407,1,89,22,1.0349999666214,0),(851,518,'A',408,1,110,22,2.78999996185303,0),(852,137,'A',409,1,21,22,1,0),(853,340,'A',409,1,8,22,1,0),(854,645,'A',409,1,6,22,2,0),(855,516,'A',409,1,100,22,0.680000007152557,0),(856,522,'A',410,1,55,22,2.04999995231628,0),(857,517,'A',411,1,95,22,1,0),(858,516,'A',412,1,100,22,1.04999995231628,0),(859,704,'A',412,1,3,22,4,0),(860,522,'A',413,1,55,22,0.740000009536743,0),(861,31,'A',414,1,38,22,1,0),(862,693,'A',414,1,33,22,1,0),(863,664,'A',415,1,30,22,1,0),(864,516,'A',416,1,100,22,1.16999995708466,0),(865,525,'A',417,1,120,22,1.55499994754791,0),(866,522,'A',417,1,55,22,0.639999985694885,0),(867,525,'A',418,1,120,22,1,0),(868,515,'A',418,1,149,22,1.5,0),(869,517,'A',419,1,95,22,1.1139999628067,0),(870,525,'A',420,1,120,22,0.850000023841858,0),(871,513,'A',421,1,89,22,1.08000004291534,0),(872,522,'A',422,1,55,22,1.89999997615814,0),(873,515,'A',423,1,149,22,1.96000003814697,0),(874,513,'A',424,1,89,22,0.649999976158142,0),(875,535,'A',425,1,160,22,1.11000001430511,0),(876,518,'A',426,1,110,22,1.14999997615814,0),(877,539,'A',426,1,130,22,0.25,0),(878,541,'A',427,1,60,22,1,0),(879,525,'A',428,1,120,22,0.699999988079071,0),(880,515,'A',428,1,149,22,0.400000005960465,0),(881,711,'A',429,1,100,22,0.490000009536743,0),(882,117,'A',430,1,10,22,1,0),(883,652,'A',430,1,3,22,1,0),(884,688,'A',430,1,14,22,1,0),(885,626,'A',430,1,20,22,1,0),(886,356,'A',430,1,7,22,2,0),(887,525,'A',430,1,120,22,0.5,0),(888,665,'A',431,1,75,22,4,0),(889,518,'A',432,1,110,22,2.61500000953674,0),(890,513,'A',433,1,89,22,1.14999997615814,0),(891,525,'A',434,1,120,22,0.25,0),(892,525,'A',435,1,120,22,0.680000007152557,0),(893,71,'A',435,1,79,22,1,0),(894,708,'A',435,1,30,22,1,0),(895,69,'A',435,1,16,22,1,0),(896,522,'A',436,1,55,22,0.730000019073486,0),(897,516,'A',437,1,100,22,1.27999997138977,0),(898,539,'A',438,1,130,22,0.800000011920929,0),(899,525,'A',438,1,120,22,0.25,0),(900,522,'A',439,1,55,22,0.949999988079071,0),(901,539,'A',440,1,130,22,1.05999994277954,0),(902,528,'A',441,1,75,22,1.26999998092651,0),(903,539,'A',441,1,130,22,0.46000000834465,0),(904,640,'A',441,1,15,22,2,0),(905,522,'A',442,1,55,22,3.11999988555908,0),(906,522,'A',443,1,55,22,0.970000028610229,0),(907,517,'A',444,1,95,22,0.939999997615814,0),(908,517,'A',445,1,95,22,1.07000005245209,0),(909,517,'A',446,1,95,22,0.779999971389771,0),(910,517,'A',447,1,95,22,0.540000021457672,0),(911,539,'A',447,1,130,22,0.189999997615814,0),(912,521,'A',448,1,125,22,0.930000007152557,0),(913,516,'A',448,1,100,22,0.600000023841858,0),(914,525,'A',449,1,120,22,1,0),(915,522,'A',450,1,55,22,1.20000004768372,0),(916,525,'A',451,1,120,22,0.5,0),(917,539,'A',452,1,130,22,0.25,0),(918,522,'A',453,1,55,22,1,0),(919,522,'A',454,1,55,22,1,0),(920,539,'A',455,1,130,22,2.58999991416931,0),(921,522,'A',456,1,55,22,1,0),(922,525,'A',456,1,120,22,1,0),(923,517,'A',457,1,95,22,1.67999994754791,0),(924,516,'A',458,1,100,22,0.810000002384186,0),(925,539,'A',459,1,130,22,0.660000026226044,0),(926,522,'A',460,1,55,22,0.740000009536743,0),(927,319,'A',461,1,52,22,1,0),(928,516,'A',462,1,100,22,1.01999998092651,0),(929,513,'A',463,1,89,22,0.800000011920929,0),(930,535,'A',464,1,160,22,0.560000002384186,0),(931,528,'A',465,1,75,22,1.1599999666214,0),(932,513,'A',466,1,89,22,1.14999997615814,0),(933,525,'A',466,1,120,22,0.5,0),(934,515,'A',467,1,149,22,2.79999995231628,0),(935,539,'A',467,1,130,22,0.899999976158142,0),(936,458,'A',467,1,76,22,1,0),(937,708,'A',468,1,30,22,4,0),(938,401,'A',469,1,19,22,2,0),(939,525,'A',470,1,120,22,0.689999997615814,0),(940,513,'A',471,1,89,22,0.649999976158142,0),(941,123,'A',472,1,3,22,1,0),(942,646,'A',472,1,6,22,1,0),(943,647,'A',472,1,10,22,1,0),(944,649,'A',472,1,7,22,1,0),(945,651,'A',472,1,10,22,1,0),(946,525,'A',473,1,120,22,1,0),(947,83,'A',473,1,11,22,1,0),(948,539,'A',474,1,130,22,0.730000019073486,0),(949,696,'A',475,1,33,22,1,0),(950,535,'A',476,1,160,22,0.485000014305115,0),(951,522,'A',477,1,55,22,1,0),(952,522,'A',478,1,55,22,0.930000007152557,0),(953,403,'A',479,1,45,22,1,0),(954,210,'A',479,1,25,22,1,0),(955,522,'A',480,1,55,22,0.519999980926514,0),(956,525,'A',481,1,120,22,0.5,0),(957,522,'A',481,1,55,22,1.09500002861023,0),(958,525,'A',482,1,120,22,0.870000004768372,0),(959,522,'A',482,1,55,22,1,0),(960,598,'A',482,1,35,22,1,0),(961,515,'A',483,1,149,22,1.07500004768372,0),(962,528,'A',484,1,75,22,1.13999998569489,0),(963,525,'A',485,1,120,22,0.449999988079071,0),(964,525,'A',486,1,120,22,0.5,0),(965,704,'A',487,1,3,22,12,0),(966,60,'A',488,1,19,22,1,0),(967,632,'A',488,1,54,22,1,0),(968,525,'A',489,1,120,22,0.349999994039535,0),(969,525,'A',490,1,120,22,0.5,0),(970,522,'A',491,1,55,22,1.20000004768372,0),(971,525,'A',492,1,120,22,1,0),(972,525,'A',493,1,120,22,0.150000005960464,0),(973,525,'A',494,1,120,22,0.180000007152557,0),(974,522,'A',495,1,55,22,1,0),(975,525,'A',496,1,120,22,0.170000001788139,0),(976,515,'A',497,1,149,22,0.629999995231628,0),(977,525,'A',498,1,120,22,0.5,0),(978,522,'A',498,1,55,22,0.9200000166893,0),(979,528,'A',498,1,75,22,1.07500004768372,0),(980,522,'A',499,1,55,22,1,0),(981,340,'A',500,1,8,22,1,0),(982,711,'A',501,1,100,22,0.699999988079071,0),(983,522,'A',501,1,55,22,1.14999997615814,0),(984,536,'A',502,1,120,22,0.629999995231628,0),(985,535,'A',503,1,160,22,1,0),(986,515,'A',504,1,149,22,1.11000001430511,0),(987,522,'A',504,1,55,22,0.519999980926514,0),(988,515,'A',505,1,149,22,1.16999995708466,0),(989,711,'A',505,1,100,22,0.709999978542328,0),(990,522,'A',506,1,55,22,0.540000021457672,0),(991,711,'A',507,1,100,22,0.150000005960464,0),(992,711,'A',508,1,100,22,0.324999988079071,0),(993,586,'A',509,1,27,22,1,0),(994,357,'A',509,1,7,22,2,0),(995,525,'A',509,1,120,22,0.5,0),(996,522,'A',510,1,55,22,0.550000011920929,0),(997,525,'A',511,1,120,22,0.5,0),(998,525,'A',512,1,120,22,0.5,0),(999,289,'A',513,1,8,22,1,0),(1000,339,'A',513,1,8,22,1,0),(1001,340,'A',513,1,8,22,2,0),(1002,539,'A',514,1,130,22,1,0),(1003,525,'A',515,1,120,22,0.419999986886978,0),(1004,521,'A',516,1,125,22,0.699999988079071,0),(1005,525,'A',517,1,120,22,0.150000005960464,0),(1006,525,'A',518,1,120,22,0.899999976158142,0),(1007,525,'A',519,1,120,22,0.25,0),(1008,538,'A',520,1,40,22,12.8999996185303,0),(1009,535,'A',520,1,160,22,0.800000011920929,0),(1010,77,'A',520,1,74,22,1,0),(1011,518,'A',521,1,110,22,4.03000020980835,0),(1012,513,'A',522,1,89,22,0.560000002384186,0),(1013,538,'A',523,1,40,22,4,0),(1014,525,'A',524,1,120,22,0.5,0),(1015,524,'A',524,1,65,22,1.79999995231628,0),(1016,522,'A',524,1,55,22,1,0),(1017,515,'A',524,1,149,22,1.49500000476837,0),(1018,522,'A',525,1,55,22,0.725000023841858,0),(1019,112,'A',526,1,10,22,1,0),(1020,522,'A',526,1,55,22,1.64999997615814,0),(1021,522,'A',527,1,55,22,3.3199999332428,0),(1022,522,'A',528,1,55,22,0.400000005960465,0),(1023,534,'A',529,1,50,22,1.25999999046326,0),(1024,522,'A',529,1,55,22,0.699999988079071,0),(1025,525,'A',530,1,120,22,1,0),(1026,80,'A',531,1,32,22,1,0),(1027,29,'A',531,1,10,22,1,0),(1028,210,'A',531,1,25,22,1,0),(1029,518,'A',531,1,110,22,1,0),(1030,522,'A',531,1,55,22,1,0),(1031,91,'A',531,1,18,22,1,0),(1032,121,'A',531,1,10,22,1,0),(1033,710,'A',531,1,10,22,1,0),(1034,433,'A',531,1,1,22,5,0),(1035,357,'A',531,1,7,22,1,0),(1036,516,'A',532,1,100,22,0.980000019073486,0),(1037,539,'A',533,1,130,22,1.23000001907349,0),(1038,518,'A',533,1,110,22,1.89499998092651,0),(1039,518,'A',534,1,110,22,1,0),(1040,525,'A',534,1,120,22,0.419999986886978,0),(1041,522,'A',535,1,55,22,1.11000001430511,0),(1042,522,'A',536,1,55,22,0.699999988079071,0),(1043,513,'A',537,1,89,22,1.35000002384186,0),(1044,522,'A',538,1,55,22,1,0),(1045,356,'A',538,1,7,22,1,0),(1046,357,'A',538,1,7,22,1,0),(1047,518,'A',539,1,110,22,1,0),(1048,518,'A',540,1,110,22,1.14999997615814,0),(1049,539,'A',541,1,130,22,0.180000007152557,0),(1050,513,'A',542,1,89,22,1.20000004768372,0),(1051,524,'A',543,1,65,22,0.600000023841858,0),(1052,513,'A',543,1,89,22,0.5,0),(1053,541,'A',543,1,60,22,1.3400000333786,0),(1054,711,'A',543,1,100,22,0.259999990463257,0),(1055,538,'A',544,1,40,22,5.3899998664856,0),(1056,528,'A',545,1,75,22,0.754999995231628,0),(1057,396,'A',546,1,45,22,1,0),(1058,316,'A',547,1,48,22,1,0),(1059,515,'A',548,1,149,22,1.00999999046326,0),(1060,536,'A',549,1,120,22,1,0),(1061,541,'A',550,1,60,22,1.3400000333786,0),(1062,522,'A',551,1,55,22,1.39999997615814,0),(1063,516,'A',552,1,100,22,1.19500005245209,0),(1064,711,'A',553,1,100,22,0.589999973773956,0),(1065,525,'A',554,1,120,22,0.5,0),(1066,536,'A',555,1,120,22,0.400000005960465,0),(1067,708,'A',555,1,30,22,1,0),(1068,704,'A',555,1,3,22,2,0),(1069,711,'A',556,1,100,22,0.300000011920929,0),(1070,536,'A',557,1,120,22,0.850000023841858,0),(1071,539,'A',557,1,130,22,0.449999988079071,0),(1072,528,'A',558,1,75,22,1.83500003814697,0),(1073,513,'A',558,1,89,22,1.54999995231628,0),(1074,539,'A',559,1,130,22,0.654999971389771,0),(1075,525,'A',559,1,120,22,1,0),(1076,516,'A',560,1,100,22,0.740000009536743,0),(1077,513,'A',560,1,89,22,0.639999985694885,0),(1078,536,'A',561,1,120,22,0.889999985694885,0),(1079,518,'A',562,1,110,22,1.89999997615814,0),(1080,517,'A',563,1,95,22,2.09999990463257,0),(1081,522,'A',564,1,55,22,1.03999996185303,0),(1082,525,'A',564,1,120,22,0.300000011920929,0),(1083,525,'A',565,1,120,22,0.5,0),(1084,526,'A',566,1,75,22,2.59500002861023,0),(1085,525,'A',566,1,120,22,2,0),(1086,534,'A',566,1,50,22,2.29999995231628,0),(1087,517,'A',567,1,95,22,0.985000014305115,0),(1088,121,'A',568,1,10,22,1,0),(1089,513,'A',568,1,89,22,1,0),(1090,565,'A',569,1,26,22,1,0),(1091,522,'A',569,1,55,22,2.07999992370605,0),(1092,688,'A',569,1,14,22,1,0),(1093,513,'A',569,1,89,22,1.12000000476837,0),(1094,515,'A',569,1,149,22,0.349999994039535,0),(1095,525,'A',569,1,120,22,0.5,0),(1096,522,'A',570,1,55,22,1,0),(1097,517,'A',571,1,95,22,2.09999990463257,0),(1098,522,'A',572,1,55,22,1.02999997138977,0),(1099,525,'A',572,1,120,22,0.449999988079071,0),(1100,525,'A',573,1,120,22,0.5,0),(1101,541,'A',574,1,60,22,3.64000010490418,0),(1102,525,'A',574,1,120,22,0.5,0),(1103,711,'A',574,1,100,22,0.300000011920929,0),(1104,520,'A',575,1,125,22,1.79999995231628,0),(1105,671,'A',575,1,10,22,1,0),(1106,525,'A',576,1,120,22,1,0),(1107,517,'A',576,1,95,22,1.37999999523163,0),(1108,513,'A',577,1,89,22,0.939999997615814,0),(1109,525,'A',578,1,120,22,0.665000021457672,0),(1110,514,'A',579,1,185,22,0.855000019073486,0),(1111,513,'A',580,1,89,22,1.14999997615814,0),(1112,522,'A',581,1,55,22,1,0),(1113,513,'A',582,1,89,22,0.5799999833107,0),(1114,517,'A',583,1,95,22,0.800000011920929,0),(1115,541,'A',584,1,60,22,2.33999991416931,0),(1116,525,'A',584,1,120,22,0.5,0),(1117,517,'A',585,1,95,22,2.25,0),(1118,513,'A',585,1,89,22,1.64999997615814,0),(1119,515,'A',585,1,149,22,0.800000011920929,0),(1120,515,'A',586,1,149,22,0.944999992847443,0),(1121,513,'A',586,1,89,22,0.5799999833107,0),(1122,516,'A',587,1,100,22,0.455000013113022,0),(1123,525,'A',587,1,120,22,0.5,0),(1124,513,'A',587,1,89,22,2.09500002861023,0),(1125,525,'A',588,1,120,22,1,0),(1126,528,'A',589,1,75,22,3.13499999046326,0),(1127,525,'A',589,1,120,22,0.774999976158142,0),(1128,522,'A',589,1,55,22,4.48999977111816,0),(1129,517,'A',590,1,95,22,1.16999995708466,0),(1130,517,'A',591,1,95,22,2.36500000953674,0),(1131,711,'A',591,1,100,22,0.720000028610229,0),(1132,319,'A',591,1,52,22,1,0),(1133,515,'A',591,1,149,22,0.899999976158142,0),(1134,626,'A',591,1,20,22,1,0),(1135,532,'A',591,1,110,22,1.70000004768372,0),(1136,338,'A',591,1,159,22,1,0),(1137,538,'A',591,1,40,22,2.75,0),(1138,704,'A',591,1,3,22,11,0),(1139,541,'A',591,1,60,22,2.75,0),(1140,51,'A',591,1,31,22,1,0),(1141,513,'A',592,1,89,22,1.14999997615814,0),(1142,515,'A',593,1,149,22,0.6700000166893,0),(1143,520,'A',594,1,125,22,1.35000002384186,0),(1144,713,'A',594,1,145,22,1,0),(1145,525,'A',594,1,120,22,0.5,0),(1146,517,'A',594,1,95,22,1.33000004291534,0),(1147,525,'A',595,1,120,22,0.439999997615814,0),(1148,525,'A',596,1,120,22,0.5,0),(1149,517,'A',596,1,95,22,0.995000004768372,0),(1150,525,'A',597,1,120,22,0.400000005960465,0),(1151,517,'A',598,1,95,22,0.699999988079071,0),(1152,525,'A',599,1,120,22,0.5,0),(1153,522,'A',599,1,55,22,1.10000002384186,0),(1154,535,'A',600,1,160,22,0.5,0),(1155,520,'A',601,1,125,22,0.980000019073486,0),(1156,517,'A',602,1,95,22,1.10000002384186,0),(1157,522,'A',603,1,55,22,2,0),(1158,671,'A',603,1,10,22,1,0),(1159,525,'A',604,1,120,22,0.300000011920929,0),(1160,536,'A',605,1,120,22,0.550000011920929,0),(1161,80,'A',606,1,32,22,1,0),(1162,700,'A',606,1,25,22,1,0),(1163,30,'A',606,1,36,22,1,0),(1164,518,'A',606,1,110,22,4.90000009536743,0),(1165,289,'A',607,1,8,22,1,0),(1166,356,'A',607,1,7,22,1,0),(1167,627,'A',607,1,17,22,1,0),(1168,59,'A',607,1,60,22,1,0),(1169,525,'A',607,1,120,22,1,0),(1170,525,'A',608,1,120,22,0.430000007152557,0),(1171,522,'A',608,1,55,22,0.569999992847443,0),(1172,522,'A',609,1,55,22,3.13000011444092,0),(1173,711,'A',610,1,100,22,0.469999998807907,0),(1174,528,'A',611,1,75,22,0.200000002980232,0),(1175,536,'A',611,1,120,22,0.200000002980232,0),(1176,538,'A',612,1,40,22,0.75,0),(1177,522,'A',613,1,55,22,1.10000002384186,0),(1178,534,'A',613,1,50,22,0.600000023841858,0),(1179,541,'A',614,1,60,22,2.5550000667572,0),(1180,513,'A',614,1,89,22,2.58999991416931,0),(1181,522,'A',614,1,55,22,1.27999997138977,0),(1182,528,'A',615,1,75,22,0.680000007152557,0),(1183,522,'A',616,1,55,22,1.39999997615814,0),(1184,516,'A',616,1,100,22,0.5450000166893,0),(1185,524,'A',616,1,65,22,2.26999998092651,0),(1186,525,'A',617,1,120,22,2,0),(1187,524,'A',617,1,65,22,2.23000001907349,0),(1188,525,'A',618,1,120,22,0.270000010728836,0),(1189,522,'A',618,1,55,22,0.600000023841858,0),(1190,522,'A',619,1,55,22,0.720000028610229,0),(1191,522,'A',620,1,55,22,1,0),(1192,534,'A',621,1,50,22,1.37999999523163,0),(1193,538,'A',621,1,40,22,2.19000005722046,0),(1194,711,'A',621,1,100,22,0.479999989271164,0),(1195,538,'A',622,1,40,22,1.5900000333786,0),(1196,515,'A',622,1,149,22,0.774999976158142,0),(1197,517,'A',622,1,95,22,0.985000014305115,0),(1198,522,'A',623,1,55,22,1.04999995231628,0),(1199,357,'A',623,1,7,22,1,0),(1200,356,'A',623,1,7,22,1,0),(1201,528,'A',624,1,75,22,0.699999988079071,0),(1202,517,'A',625,1,95,22,0.870000004768372,0),(1203,538,'A',626,1,40,22,13.8000001907349,0),(1204,515,'A',627,1,149,22,0.419999986886978,0),(1205,515,'A',628,1,149,22,0.730000019073486,0),(1206,31,'A',628,1,38,22,1,0),(1207,357,'A',628,1,7,22,2,0),(1208,516,'A',629,1,100,22,1.15499997138977,0),(1209,402,'A',630,1,55,22,1,0),(1210,528,'A',631,1,75,22,2.95000004768372,0),(1211,516,'A',632,1,100,22,1.28999996185303,0),(1212,522,'A',633,1,55,22,2.67000007629395,0),(1213,514,'A',633,1,185,22,1.20000004768372,0),(1214,524,'A',634,1,65,22,1.22000002861023,0),(1215,525,'A',635,1,120,22,1.35000002384186,0),(1216,711,'A',636,1,100,22,1.29999995231628,0),(1217,522,'A',637,1,55,22,1.79999995231628,0),(1218,518,'A',638,1,110,22,2.79999995231628,0),(1219,357,'A',639,1,7,22,2,0),(1220,517,'A',639,1,95,22,1.29999995231628,0),(1221,525,'A',640,1,120,22,0.449999988079071,0),(1222,433,'A',641,1,1,22,10,0),(1223,536,'A',642,1,120,22,1.04499995708466,0),(1224,516,'A',643,1,100,22,1.5,0),(1225,29,'A',644,1,10,22,1,0),(1226,517,'A',645,1,95,22,0.855000019073486,0),(1227,525,'A',646,1,120,22,0.5,0),(1228,51,'A',646,1,31,22,1,0),(1229,83,'A',646,1,11,22,1,0),(1230,91,'A',646,1,18,22,1,0),(1231,525,'A',647,1,120,22,0.5,0),(1232,513,'A',647,1,89,22,1.26999998092651,0),(1233,518,'A',648,1,110,22,2.63000011444092,0),(1234,711,'A',648,1,100,22,0.769999980926514,0),(1235,522,'A',649,1,55,22,1.89999997615814,0),(1236,525,'A',650,1,120,22,1.5,0),(1237,534,'A',651,1,50,22,1.17999994754791,0),(1238,522,'A',651,1,55,22,0.930000007152557,0),(1239,522,'A',652,1,55,22,2.41499996185303,0),(1240,528,'A',652,1,75,22,1.79499995708466,0),(1241,518,'A',653,1,110,22,1.38999998569489,0),(1242,91,'A',653,1,18,22,1,0),(1243,535,'A',654,1,160,22,0.949999988079071,0),(1244,518,'A',655,1,110,22,3.16000008583069,0),(1245,536,'A',656,1,120,22,1,0),(1246,660,'A',656,1,26,22,1,0),(1247,516,'A',657,1,100,22,0.889999985694885,0),(1248,522,'A',657,1,55,22,1,0),(1249,525,'A',658,1,120,22,1.02999997138977,0),(1250,521,'A',658,1,125,22,1.19000005722046,0),(1251,513,'A',658,1,89,22,1.44500005245209,0),(1252,513,'A',659,1,89,22,1.26999998092651,0),(1253,522,'A',659,1,55,22,1,0),(1254,516,'A',660,1,100,22,1.05999994277954,0),(1255,525,'A',661,1,120,22,4.65000009536743,0),(1256,528,'A',661,1,75,22,0.6700000166893,0),(1257,704,'A',661,1,3,22,6,0),(1258,584,'A',661,1,22,22,1,0),(1259,522,'A',661,1,55,22,3.21000003814697,0),(1260,517,'A',661,1,95,22,2.49000000953674,0),(1261,513,'A',661,1,89,22,1.10000002384186,0),(1262,527,'A',661,1,75,22,1.97000002861023,0),(1263,518,'A',661,1,110,22,3.20000004768372,0),(1264,520,'A',661,1,125,22,1.08500003814697,0),(1265,522,'A',662,1,55,22,1,0),(1266,513,'A',662,1,89,22,2.98499989509582,0),(1267,525,'A',662,1,120,22,3.08999991416931,0),(1268,704,'A',662,1,3,22,6,0),(1269,535,'A',662,1,160,22,1.88999998569489,0),(1270,518,'A',662,1,110,22,4.09000015258789,0),(1271,711,'A',662,1,100,22,0.720000028610229,0),(1272,541,'A',662,1,60,22,2.70000004768372,0),(1273,538,'A',662,1,40,22,1.39999997615814,0),(1274,356,'A',663,1,7,22,1,0),(1275,357,'A',663,1,7,22,1,0),(1276,660,'A',663,1,26,22,1,0),(1277,515,'A',663,1,149,22,1.3400000333786,0),(1278,517,'A',663,1,95,22,1.20000004768372,0),(1279,522,'A',663,1,55,22,0.899999976158142,0),(1280,704,'A',664,1,3,22,12,0),(1281,713,'A',664,1,145,22,1,0),(1282,707,'A',664,1,28,22,1,0),(1283,520,'A',664,1,125,22,3.85999989509582,0),(1284,525,'A',665,1,120,22,0.5,0),(1285,516,'A',665,1,100,22,3.21000003814697,0),(1286,522,'A',665,1,55,22,1.13999998569489,0),(1287,122,'A',665,1,3,22,4,0),(1288,522,'A',666,1,55,22,2.48000001907349,0),(1289,648,'A',666,1,10,22,1,0),(1290,516,'A',666,1,100,22,1,0),(1291,525,'A',667,1,120,22,0.5,0),(1292,91,'A',667,1,18,22,1,0),(1293,538,'A',667,1,40,22,0.300000011920929,0),(1294,525,'A',668,1,120,22,0.5,0),(1295,517,'A',669,1,95,22,1.89999997615814,0),(1296,51,'A',669,1,31,22,1,0),(1297,60,'A',669,1,19,22,1,0),(1298,636,'A',669,1,20,22,1,0),(1299,357,'A',669,1,7,22,2,0),(1300,356,'A',669,1,7,22,1,0),(1301,525,'A',669,1,120,22,0.639999985694885,0),(1302,522,'A',669,1,55,22,1.29999995231628,0),(1303,535,'A',670,1,160,22,0.5,0),(1304,525,'A',670,1,120,22,0.600000023841858,0),(1305,516,'A',671,1,100,22,2,0),(1306,399,'A',671,1,40,22,1,0),(1307,538,'A',672,1,40,22,1.20000004768372,0),(1308,522,'A',673,1,55,22,1,0),(1309,515,'A',674,1,149,22,6.69999980926514,0),(1310,516,'A',674,1,100,22,1.1599999666214,0),(1311,539,'A',675,1,130,22,0.899999976158142,0),(1312,515,'A',675,1,149,22,4.09999990463257,0),(1313,520,'A',675,1,125,22,1.375,0),(1314,535,'A',675,1,160,22,0.529999971389771,0),(1315,319,'A',675,1,52,22,1,0),(1316,517,'A',676,1,95,22,1.98000001907349,0),(1317,539,'A',676,1,130,22,0.865000009536743,0),(1318,525,'A',676,1,120,22,0.5799999833107,0),(1319,713,'A',677,1,145,22,0.600000023841858,0),(1320,539,'A',678,1,130,22,3.13000011444092,0),(1321,518,'A',679,1,110,22,4.19999980926514,0),(1322,518,'A',680,1,110,22,2.1800000667572,0),(1323,525,'A',680,1,120,22,0.5,0),(1324,357,'A',680,1,7,22,2,0),(1325,522,'A',681,1,55,22,1.89999997615814,0),(1326,324,'A',682,1,30,22,1,0),(1327,522,'A',683,1,55,22,2,0),(1328,525,'A',684,1,120,22,1,0),(1329,524,'A',685,1,65,22,1.70000004768372,0),(1330,711,'A',686,1,100,22,0.400000005960465,0),(1331,402,'A',687,1,55,22,2,0),(1332,518,'A',688,1,110,22,0.980000019073486,0),(1333,711,'A',688,1,100,22,0.230000004172325,0),(1334,518,'A',689,1,110,22,6.30000019073486,0),(1335,518,'A',690,1,110,22,2.16000008583069,0),(1336,513,'A',691,1,89,22,0.560000002384186,0),(1337,522,'A',692,1,55,22,3.15000009536743,0),(1338,539,'A',692,1,130,22,0.990000009536743,0),(1339,711,'A',693,1,100,22,0.600000023841858,0),(1340,528,'A',694,1,75,22,1.58000004291534,0),(1341,340,'A',694,1,8,22,1,0),(1342,522,'A',694,1,55,22,0.990000009536743,0),(1343,539,'A',695,1,130,22,2.09999990463257,0),(1344,518,'A',696,1,110,22,3.36999988555908,0),(1345,525,'A',697,1,120,22,1,0),(1346,525,'A',698,1,120,22,0.990000009536743,0),(1347,525,'A',699,1,120,22,0.899999976158142,0),(1348,518,'A',700,1,110,22,2.40000009536743,0),(1349,516,'A',700,1,100,22,1.13999998569489,0),(1350,525,'A',700,1,120,22,1,0),(1351,513,'A',701,1,89,22,2,0),(1352,522,'A',701,1,55,22,1.62999999523163,0),(1353,528,'A',701,1,75,22,1.58000004291534,0),(1354,539,'A',702,1,130,22,6,0),(1355,525,'A',702,1,120,22,3,0),(1356,522,'A',702,1,55,22,2.97000002861023,0),(1357,513,'A',702,1,89,22,6.6399998664856,0),(1358,541,'A',702,1,60,22,2.5,0),(1359,532,'A',703,1,110,22,2.26999998092651,0),(1360,518,'A',703,1,110,22,11.6300001144409,0),(1361,515,'A',703,1,149,22,0.899999976158142,0),(1362,516,'A',703,1,100,22,6.69999980926514,0),(1363,535,'A',703,1,160,22,1,0),(1364,711,'A',703,1,100,22,0.400000005960465,0),(1365,663,'A',703,1,15,22,1,0),(1366,289,'A',704,1,8,22,1,0),(1367,528,'A',704,1,75,22,3.75,0),(1368,711,'A',704,1,100,22,0.5,0),(1369,321,'A',704,1,53,22,1,0),(1370,571,'A',704,1,15,22,1,0),(1371,311,'A',704,1,78,22,1,0),(1372,124,'A',705,1,46,22,1,0),(1373,528,'A',706,1,75,22,1.63999998569489,0),(1374,711,'A',706,1,100,22,0.46000000834465,0),(1375,525,'A',707,1,120,22,0.419999986886978,0),(1376,525,'A',708,1,120,22,0.449999988079071,0),(1377,525,'A',709,1,120,22,2,0),(1378,711,'A',710,1,100,22,0.6700000166893,0),(1379,522,'A',711,1,55,22,0.455000013113022,0),(1380,611,'A',711,1,22,22,1,0),(1381,513,'A',712,1,89,22,2.04500007629395,0),(1382,525,'A',713,1,120,22,2.02999997138977,0),(1383,525,'A',714,1,120,22,0.354999989271164,0),(1384,522,'A',715,1,55,22,0.555000007152557,0),(1385,522,'A',716,1,55,22,1,0),(1386,528,'A',717,1,75,22,1.03999996185303,0),(1387,522,'A',718,1,55,22,1.05999994277954,0),(1388,711,'A',719,1,100,22,0.150000005960464,0),(1389,536,'A',720,1,120,22,2.08500003814697,0),(1390,525,'A',720,1,120,22,0.444999992847443,0),(1391,91,'A',721,1,18,22,1,0),(1392,539,'A',721,1,130,22,0.439999997615814,0),(1393,350,'A',721,1,30,22,1,0),(1394,513,'A',722,1,89,22,3,0),(1395,541,'A',723,1,60,22,2.88000011444092,0),(1396,311,'A',724,1,78,22,1,0),(1397,522,'A',725,1,55,22,0.569999992847443,0),(1398,539,'A',726,1,130,22,1.51999998092651,0),(1399,525,'A',727,1,120,22,1.15400004386902,0),(1400,539,'A',727,1,130,22,0.254999995231628,0),(1401,535,'A',728,1,160,22,0.25,0),(1402,536,'A',728,1,120,22,0.135000005364418,0),(1403,525,'A',729,1,120,22,0.5,0),(1404,516,'A',729,1,100,22,1.89999997615814,0),(1405,536,'A',729,1,120,22,0.610000014305115,0),(1406,519,'A',730,1,125,22,1.26999998092651,0),(1407,539,'A',731,1,130,22,0.305000007152557,0),(1408,525,'A',732,1,120,22,0.850000023841858,0),(1409,525,'A',733,1,120,22,1,0),(1410,539,'A',733,1,130,22,0.495000004768372,0),(1411,528,'A',734,1,75,22,0.685000002384186,0),(1412,525,'A',735,1,120,22,0.5,0),(1413,525,'A',736,1,120,22,0.5,0),(1414,123,'A',737,1,3,22,10,0),(1415,522,'A',738,1,55,22,1.07000005245209,0),(1416,525,'A',738,1,120,22,1.5,0),(1417,83,'A',739,1,11,22,1,0),(1418,261,'A',739,1,29,22,1,0),(1419,525,'A',740,1,120,22,0.840000033378601,0),(1420,513,'A',741,1,89,22,0.514999985694885,0),(1421,525,'A',742,1,120,22,1.0900000333786,0),(1422,520,'A',743,1,125,22,0.855000019073486,0),(1423,289,'A',744,1,8,22,1,0),(1424,525,'A',745,1,120,22,0.5,0),(1425,707,'A',746,1,28,22,1,0),(1426,525,'A',746,1,120,22,0.270000010728836,0),(1427,522,'A',747,1,55,22,1,0),(1428,707,'A',747,1,28,22,1,0),(1429,535,'A',747,1,160,22,0.740000009536743,0),(1430,704,'A',747,1,3,22,6,0),(1431,516,'A',748,1,100,22,0.870000004768372,0),(1432,536,'A',748,1,120,22,0.379999995231628,0),(1433,513,'A',748,1,89,22,1.04499995708466,0),(1434,525,'A',749,1,120,22,0.400000005960465,0),(1435,513,'A',749,1,89,22,1.67999994754791,0),(1436,522,'A',750,1,55,22,0.759999990463257,0),(1437,515,'A',751,1,149,22,1.01999998092651,0),(1438,513,'A',752,1,89,22,2,0),(1439,513,'A',753,1,89,22,0.601000010967255,0),(1440,536,'A',754,1,120,22,0.904999971389771,0),(1441,539,'A',754,1,130,22,0.629999995231628,0),(1442,522,'A',755,1,55,22,2,0),(1443,525,'A',756,1,120,22,0.264999985694885,0),(1444,539,'A',756,1,130,22,1.0349999666214,0),(1445,525,'A',757,1,120,22,0.259999990463257,0),(1446,713,'A',758,1,145,22,1.0550000667572,0),(1447,539,'A',758,1,130,22,1.1599999666214,0),(1448,521,'A',758,1,125,22,0.524999976158142,0),(1449,559,'A',758,1,32,22,1,0),(1450,611,'A',759,1,22,22,2,0),(1451,91,'A',759,1,18,22,1,0),(1452,83,'A',759,1,11,22,1,0),(1453,525,'A',759,1,120,22,0.75,0),(1454,539,'A',759,1,130,22,0.372999995946884,0),(1455,528,'A',759,1,75,22,0.8299999833107,0),(1456,525,'A',760,1,120,22,1.08000004291534,0),(1457,522,'A',760,1,55,22,2.42000007629395,0),(1458,128,'A',760,1,25,22,1,0),(1459,516,'A',760,1,100,22,1.7150000333786,0),(1460,713,'A',760,1,145,22,1,0),(1461,210,'A',761,1,25,22,1,0),(1462,525,'A',761,1,120,22,1.0349999666214,0),(1463,539,'A',761,1,130,22,1.33500003814697,0),(1464,513,'A',761,1,89,22,1.0349999666214,0),(1465,707,'A',762,1,28,22,1,0),(1466,350,'A',763,1,30,22,1,0),(1467,122,'A',763,1,3,22,3,0),(1468,522,'A',763,1,55,22,1.10000002384186,0),(1469,539,'A',763,1,130,22,0.324999988079071,0),(1470,516,'A',764,1,100,22,2.99000000953674,0),(1471,539,'A',764,1,130,22,0.725000023841858,0),(1472,564,'A',764,1,13,22,2,0),(1473,536,'A',764,1,120,22,1.125,0),(1474,525,'A',764,1,120,22,0.5,0),(1475,340,'A',764,1,8,22,1,0),(1476,357,'A',764,1,7,22,1,0),(1477,626,'A',764,1,20,22,1,0),(1478,525,'A',765,1,120,22,1,0),(1479,515,'A',766,1,149,22,1.79999995231628,0),(1480,513,'A',767,1,89,22,1.10000002384186,0),(1481,513,'A',768,1,89,22,1.79999995231628,0),(1482,517,'A',769,1,95,22,1.14999997615814,0),(1483,525,'A',769,1,120,22,0.800000011920929,0),(1484,516,'A',770,1,100,22,1.02999997138977,0),(1485,513,'A',771,1,89,22,2,0),(1486,350,'A',772,1,30,22,1,0),(1487,700,'A',772,1,25,22,1,0),(1488,703,'A',772,1,12,22,2,0),(1489,704,'A',772,1,3,22,12,0),(1490,528,'A',773,1,75,22,2.59999990463257,0),(1491,539,'A',774,1,130,22,0.800000011920929,0),(1492,522,'A',775,1,55,22,1,0),(1493,513,'A',776,1,89,22,0.769999980926514,0),(1494,522,'A',777,1,55,22,0.915000021457672,0),(1495,513,'A',778,1,89,22,2.0699999332428,0),(1496,524,'A',778,1,65,22,1.51999998092651,0),(1497,522,'A',779,1,55,22,1.79999995231628,0),(1498,516,'A',780,1,100,22,2.08999991416931,0),(1499,525,'A',781,1,120,22,0.300000011920929,0),(1500,513,'A',782,1,89,22,0.939999997615814,0),(1501,541,'A',783,1,60,22,2.23000001907349,0),(1502,524,'A',783,1,65,22,1.55499994754791,0),(1503,60,'A',783,1,19,22,1,0),(1504,703,'A',783,1,12,22,1,0),(1505,196,'A',783,1,41,22,1,0),(1506,522,'A',783,1,55,22,1,0),(1507,516,'A',783,1,100,22,0.714999973773956,0),(1508,513,'A',784,1,89,22,0.284999996423721,0),(1509,525,'A',785,1,120,22,1,0),(1510,513,'A',786,1,89,22,1.13499999046326,0),(1511,522,'A',787,1,55,22,1,0),(1512,522,'A',788,1,55,22,0.600000023841858,0),(1513,340,'A',789,1,8,22,1,0),(1514,289,'A',789,1,8,22,1,0),(1515,525,'A',790,1,120,22,0.5,0),(1516,541,'A',790,1,60,22,2.76999998092651,0),(1517,525,'A',791,1,120,22,1,0),(1518,522,'A',792,1,55,22,0.959999978542328,0),(1519,515,'A',793,1,149,22,0.740000009536743,0),(1520,154,'A',794,1,25,22,1,0),(1521,100,'A',794,1,19,22,1,0),(1522,525,'A',794,1,120,22,0.850000023841858,0),(1523,539,'A',794,1,130,22,0.300000011920929,0),(1524,704,'A',794,1,3,22,4,0),(1525,518,'A',795,1,110,22,5.1399998664856,0),(1526,522,'A',796,1,55,22,0.5799999833107,0),(1527,525,'A',797,1,120,22,0.5,0),(1528,522,'A',798,1,55,22,1.25499999523163,0),(1529,513,'A',799,1,89,22,0.5,0),(1530,516,'A',800,1,100,22,0.649999976158142,0),(1531,525,'A',800,1,120,22,0.5,0),(1532,517,'A',801,1,95,22,0.634999990463257,0),(1533,539,'A',802,1,130,22,1.07000005245209,0),(1534,522,'A',803,1,55,22,0.5,0),(1535,704,'A',804,1,3,22,12,0),(1536,539,'A',805,1,130,22,0.25,0),(1537,522,'A',805,1,55,22,0.639999985694885,0),(1538,522,'A',806,1,55,22,1.29999995231628,0),(1539,528,'A',806,1,75,22,1.20000004768372,0),(1540,522,'A',807,1,55,22,1.9099999666214,0),(1541,517,'A',808,1,95,22,3.1800000667572,0),(1542,566,'A',809,1,7,22,1,0),(1543,516,'A',810,1,100,22,1.04999995231628,0),(1544,525,'A',811,1,120,22,0.8299999833107,0),(1545,522,'A',812,1,55,22,1.79999995231628,0),(1546,534,'A',812,1,50,22,1.70000004768372,0),(1547,516,'A',813,1,100,22,1.58000004291534,0),(1548,522,'A',814,1,55,22,0.939999997615814,0),(1549,538,'A',814,1,40,22,1,0),(1550,513,'A',815,1,89,22,0.699999988079071,0),(1551,535,'A',816,1,160,22,0.980000019073486,0),(1552,704,'A',816,1,3,22,6,0),(1553,517,'A',817,1,95,22,1.10000002384186,0),(1554,722,'A',818,1,6,22,4,0),(1555,720,'A',818,1,6,22,4,0),(1556,513,'A',819,1,89,22,2.18499994277954,0),(1557,517,'A',820,1,95,22,0.720000028610229,0),(1558,522,'A',821,1,55,22,1,0),(1559,525,'A',822,1,120,22,0.349999994039535,0),(1560,517,'A',823,1,95,22,1.09500002861023,0),(1561,707,'A',824,1,28,22,1,0),(1562,124,'A',824,1,46,22,1,0),(1563,528,'A',825,1,75,22,1.36500000953674,0),(1564,516,'A',826,1,100,22,1.29999995231628,0),(1565,522,'A',827,1,55,22,1,0),(1566,132,'A',828,1,45,22,1,0),(1567,202,'A',828,1,24,22,1,0),(1568,513,'A',829,1,89,22,0.600000023841858,0),(1569,516,'A',830,1,100,22,1.14999997615814,0),(1570,522,'A',831,1,55,22,1.85000002384186,0),(1571,687,'A',832,1,26,22,1,0),(1572,707,'A',832,1,28,22,1,0),(1573,522,'A',832,1,55,22,1.44000005722046,0),(1574,525,'A',833,1,120,22,0.6700000166893,0),(1575,513,'A',834,1,89,22,1,0),(1576,522,'A',835,1,55,22,2.09999990463257,0),(1577,525,'A',836,1,120,22,0.400000005960465,0),(1578,522,'A',837,1,55,22,0.899999976158142,0),(1579,357,'A',837,1,7,22,1,0),(1580,538,'A',838,1,40,22,1.5900000333786,0),(1581,522,'A',839,1,55,22,1,0),(1582,525,'A',840,1,120,22,0.25,0),(1583,513,'A',841,1,89,22,1.60000002384186,0),(1584,528,'A',842,1,75,22,3.625,0),(1585,515,'A',843,1,149,22,0.340000003576279,0),(1586,525,'A',844,1,120,22,0.850000023841858,0),(1587,522,'A',845,1,55,22,0.5,0),(1588,646,'A',845,1,6,22,1,0),(1589,154,'A',846,1,25,22,1,0),(1590,528,'A',847,1,75,22,1.25999999046326,0),(1591,525,'A',848,1,120,22,1,0),(1592,517,'A',848,1,95,22,2.1800000667572,0),(1593,513,'A',849,1,89,22,0.600000023841858,0),(1594,620,'A',849,1,19,22,1,0),(1595,516,'A',850,1,100,22,0.485000014305115,0),(1596,513,'A',850,1,89,22,0.5,0),(1597,91,'A',851,1,18,22,1,0),(1598,525,'A',851,1,120,22,0.5,0),(1599,515,'A',852,1,149,22,0.850000023841858,0),(1600,536,'A',853,1,120,22,0.419999986886978,0),(1601,516,'A',854,1,100,22,0.540000021457672,0),(1602,513,'A',855,1,89,22,0.540000021457672,0),(1603,39,'A',856,1,44,22,1,0),(1604,558,'A',856,1,66,22,1,0),(1605,525,'A',857,1,120,22,5,0),(1606,518,'A',858,1,110,22,1.70000004768372,0),(1607,522,'A',859,1,55,22,1.57500004768372,0),(1608,536,'A',859,1,120,22,0.245000004768372,0),(1609,525,'A',860,1,120,22,0.5,0),(1610,516,'A',861,1,100,22,0.910000026226044,0),(1611,536,'A',861,1,120,22,0.340000003576279,0),(1612,525,'A',862,1,120,22,0.5,0),(1613,60,'A',862,1,19,22,1,0),(1614,704,'A',862,1,3,22,6,0),(1615,626,'A',862,1,20,22,1,0),(1616,433,'A',862,1,1,22,10,0),(1617,515,'A',863,1,149,22,1.26499998569489,0),(1618,525,'A',864,1,120,22,0.5,0),(1619,513,'A',864,1,89,22,1,0),(1620,516,'A',864,1,100,22,0.699999988079071,0),(1621,525,'A',865,1,120,22,0.340000003576279,0),(1622,541,'A',866,1,60,22,2.57999992370605,0),(1623,522,'A',867,1,55,22,0.930000007152557,0),(1624,513,'A',868,1,89,22,1,0),(1625,516,'A',868,1,100,22,1.49000000953674,0),(1626,541,'A',868,1,60,22,2.44000005722046,0),(1627,525,'A',869,1,120,22,0.200000002980232,0),(1628,515,'A',870,1,149,22,2.14000010490418,0),(1629,513,'A',871,1,89,22,1.10000002384186,0),(1630,289,'A',872,1,8,22,1,0),(1631,522,'A',873,1,55,22,2,0),(1632,517,'A',874,1,95,22,1.24000000953674,0),(1633,516,'A',875,1,100,22,1.08000004291534,0),(1634,524,'A',876,1,65,22,1.18499994277954,0),(1635,522,'A',877,1,55,22,1,0),(1636,517,'A',878,1,95,22,0.6700000166893,0),(1637,513,'A',879,1,89,22,1.05999994277954,0),(1638,524,'A',880,1,65,22,1.05499994754791,0),(1639,525,'A',881,1,120,22,0.25,0),(1640,522,'A',882,1,55,22,1,0),(1641,515,'A',883,1,149,22,8.03999996185303,0),(1642,525,'A',884,1,120,22,0.150000005960464,0),(1643,541,'A',885,1,60,22,3.05999994277954,0),(1644,522,'A',886,1,55,22,1.89999997615814,0),(1645,713,'A',887,1,145,22,0.490000009536743,0),(1646,536,'A',887,1,120,22,0.569999992847443,0),(1647,29,'A',887,1,10,22,1,0),(1648,525,'A',887,1,120,22,0.669999957084656,0),(1649,51,'A',887,1,31,22,1,0),(1650,528,'A',887,1,75,22,2,0),(1651,518,'A',887,1,110,22,1.79999995231628,0),(1652,522,'A',887,1,55,22,2.04999995231628,0),(1653,726,'A',887,1,68,22,1,0),(1654,111,'A',887,1,5,22,1,0),(1655,688,'A',888,1,14,22,1,0),(1656,627,'A',888,1,17,22,1,0),(1657,525,'A',888,1,120,22,0.5,0),(1658,357,'A',888,1,7,22,2,0),(1659,525,'A',889,1,120,22,0.75,0),(1660,525,'A',890,1,120,22,0.25,0),(1661,340,'A',891,1,8,22,1,0),(1662,525,'A',892,1,120,22,0.5,0),(1663,524,'A',893,1,65,22,2.29999995231628,0),(1664,525,'A',894,1,120,22,0.400000005960465,0),(1665,518,'A',894,1,110,22,1.74000000953674,0),(1666,535,'A',895,1,160,22,0.479999989271164,0),(1667,525,'A',896,1,120,22,0.349999994039535,0),(1668,433,'A',897,1,1,22,5,0),(1669,556,'A',897,1,32,22,1,0),(1670,356,'A',897,1,7,22,1,0),(1671,720,'A',897,1,5,22,2,0),(1672,91,'A',897,1,18,22,1,0),(1673,660,'A',898,1,26,22,1,0),(1674,513,'A',899,1,89,22,1.06500005722046,0),(1675,261,'A',900,1,29,22,1,0),(1676,525,'A',901,1,120,22,0.550000011920929,0),(1677,541,'A',902,1,60,22,1.375,0),(1678,71,'A',902,1,79,22,1,0),(1679,566,'A',902,1,7,22,1,0),(1680,704,'A',903,1,3,22,6,0),(1681,535,'A',903,1,160,22,1.07500004768372,0),(1682,522,'A',904,1,55,22,1.0900000333786,0),(1683,517,'A',905,1,95,22,1.0900000333786,0),(1684,516,'A',906,1,100,22,1.09500002861023,0),(1685,525,'A',907,1,120,22,1,0),(1686,702,'A',908,1,13,22,1,0),(1687,534,'A',909,1,50,22,1.6599999666214,0),(1688,525,'A',910,1,120,22,0.5,0),(1689,522,'A',911,1,55,22,1.89999997615814,0),(1690,525,'A',912,1,120,22,0.5,0),(1691,525,'A',913,1,120,22,0.25,0),(1692,521,'A',914,1,125,22,0.970000028610229,0),(1693,536,'A',914,1,120,22,0.300000011920929,0),(1694,524,'A',915,1,65,22,1.28999996185303,0),(1695,525,'A',916,1,120,22,0.8299999833107,0),(1696,513,'A',917,1,89,22,0.485000014305115,0),(1697,525,'A',918,1,120,22,0.660000026226044,0),(1698,525,'A',919,1,120,22,0.449999988079071,0),(1699,525,'A',920,1,120,22,0.5,0),(1700,663,'A',921,1,15,22,3,0),(1701,522,'A',922,1,55,22,1.29999995231628,0),(1702,515,'A',923,1,149,22,0.5,0),(1703,525,'A',924,1,120,22,1.5,0),(1704,522,'A',925,1,55,22,1,0),(1705,703,'A',925,1,12,22,1,0),(1706,458,'A',926,1,76,22,1,0),(1707,518,'A',927,1,110,22,2,0),(1708,536,'A',928,1,120,22,1.0900000333786,0),(1709,517,'A',929,1,95,22,0.879999995231628,0),(1710,522,'A',929,1,55,22,1.10000002384186,0),(1711,51,'A',930,1,31,22,1,0),(1712,520,'A',931,1,125,22,0.959999978542328,0),(1713,522,'A',932,1,55,22,1.3400000333786,0),(1714,59,'A',932,1,60,22,1,0),(1715,527,'A',933,1,75,22,1.54999995231628,0),(1716,340,'A',934,1,8,22,2,0),(1717,289,'A',934,1,8,22,1,0),(1718,522,'A',935,1,55,22,1.07000005245209,0),(1719,525,'A',935,1,120,22,0.25,0),(1720,518,'A',936,1,110,22,2.73000001907349,0),(1721,522,'A',936,1,55,22,1.0900000333786,0),(1722,528,'A',937,1,75,22,0.870000004768372,0),(1723,515,'A',937,1,149,22,0.730000019073486,0),(1724,525,'A',937,1,120,22,0.5,0),(1725,516,'A',938,1,100,22,2.02999997138977,0),(1726,516,'A',939,1,100,22,0.430000007152557,0),(1727,525,'A',940,1,120,22,1,0),(1728,522,'A',940,1,55,22,1.0900000333786,0),(1729,525,'A',941,1,120,22,1,0),(1730,525,'A',942,1,120,22,0.5,0),(1731,516,'A',943,1,100,22,0.400000005960465,0),(1732,513,'A',944,1,89,22,1.25999999046326,0),(1733,515,'A',945,1,149,22,0.689999997615814,0),(1734,525,'A',946,1,120,22,0.5,0),(1735,525,'A',947,1,120,22,0.189999997615814,0),(1736,522,'A',948,1,55,22,1.10000002384186,0),(1737,536,'A',949,1,120,22,0.569999992847443,0),(1738,522,'A',950,1,55,22,0.9200000166893,0),(1739,522,'A',951,1,55,22,0.9200000166893,0),(1740,516,'A',952,1,100,22,0.490000009536743,0),(1741,518,'A',952,1,110,22,1.5,0),(1742,513,'A',953,1,89,22,1,0),(1743,541,'A',954,1,60,22,1.09500002861023,0),(1744,522,'A',954,1,55,22,1.12000000476837,0),(1745,513,'A',955,1,89,22,1.06500005722046,0),(1746,525,'A',955,1,120,22,0.5,0),(1747,536,'A',956,1,120,22,0.584999978542328,0),(1748,520,'A',957,1,125,22,0.860000014305115,0),(1749,518,'A',957,1,110,22,1.39999997615814,0),(1750,522,'A',958,1,55,22,1,0),(1751,525,'A',959,1,120,22,0.419999986886978,0),(1752,516,'A',960,1,100,22,0.46000000834465,0),(1753,513,'A',961,1,89,22,1.23000001907349,0),(1754,525,'A',962,1,120,22,0.419999986886978,0),(1755,525,'A',963,1,120,22,0.180000007152557,0),(1756,513,'A',963,1,89,22,0.519999980926514,0),(1757,513,'A',964,1,89,22,0.699999988079071,0),(1758,535,'A',964,1,160,22,0.319999992847443,0),(1759,517,'A',965,1,95,22,0.660000026226044,0),(1760,516,'A',965,1,100,22,0.680000007152557,0),(1761,522,'A',966,1,55,22,1.8400000333786,0),(1762,515,'A',967,1,149,22,0.5,0),(1763,516,'A',968,1,100,22,0.694999992847443,0),(1764,704,'A',969,1,3,22,12,0),(1765,513,'A',970,1,89,22,0.490000009536743,0),(1766,522,'A',971,1,55,22,1.10000002384186,0),(1767,525,'A',972,1,120,22,0.379999995231628,0),(1768,535,'A',972,1,160,22,0.340000003576279,0),(1769,513,'A',972,1,89,22,0.860000014305115,0),(1770,517,'A',973,1,95,22,0.620000004768372,0),(1771,513,'A',974,1,89,22,0.28999999165535,0),(1772,522,'A',975,1,55,22,1,0),(1773,707,'A',976,1,28,22,1,0),(1774,525,'A',976,1,120,22,1.25,0),(1775,516,'A',977,1,100,22,1.26999998092651,0),(1776,340,'A',977,1,8,22,1,0),(1777,400,'A',978,1,45,22,1,0),(1778,664,'A',978,1,30,22,1,0),(1779,321,'A',978,1,53,22,3,0),(1780,517,'A',979,1,95,22,1,0),(1781,514,'A',980,1,185,22,7.80000019073486,0),(1782,536,'A',981,1,120,22,0.209999993443489,0),(1783,516,'A',981,1,100,22,0.189999997615814,0),(1784,704,'A',981,1,3,22,3,0),(1785,645,'A',981,1,10,22,1,0),(1786,516,'A',982,1,100,22,0.8299999833107,0),(1787,32,'A',983,1,38,22,1,0),(1788,525,'A',984,1,120,22,0.25,0),(1789,565,'A',985,1,26,22,1,0),(1790,513,'A',985,1,89,22,0.360000014305115,0),(1791,536,'A',986,1,120,22,0.449999988079071,0),(1792,525,'A',987,1,120,22,1,0),(1793,516,'A',987,1,100,22,1.70000004768372,0),(1794,516,'A',988,1,100,22,1.73000001907349,0),(1795,522,'A',989,1,55,22,1.85000002384186,0),(1796,522,'A',990,1,55,22,1,0),(1797,518,'A',991,1,110,22,2.09999990463257,0),(1798,32,'A',991,1,38,22,1,0),(1799,579,'A',992,1,18,22,1,0),(1800,525,'A',993,1,120,22,0.479999989271164,0),(1801,513,'A',993,1,89,22,0.800000011920929,0),(1802,518,'A',993,1,110,22,1.08000004291534,0),(1803,536,'A',993,1,120,22,0.439999997615814,0),(1804,525,'A',994,1,120,22,0.439999997615814,0),(1805,536,'A',995,1,120,22,1.57500004768372,0),(1806,536,'A',996,1,120,22,1.07500004768372,0),(1807,513,'A',997,1,89,22,1.0900000333786,0),(1808,536,'A',998,1,120,22,0.689999997615814,0),(1809,525,'A',999,1,120,22,0.540000021457672,0),(1810,513,'A',1000,1,89,22,0.239999994635582,0),(1811,525,'A',1000,1,120,22,0.150000005960464,0),(1812,707,'A',1001,1,28,22,1,0),(1813,515,'A',1002,1,149,22,0.400000005960465,0),(1814,91,'A',1003,1,18,22,3,0),(1815,515,'A',1003,1,149,22,1,0),(1816,30,'A',1003,1,36,22,1,0),(1817,517,'A',1004,1,95,22,0.990000009536743,0),(1818,515,'A',1005,1,149,22,0.5,0),(1819,513,'A',1006,1,89,22,2.79999995231628,0),(1820,521,'A',1007,1,125,22,1,0),(1821,535,'A',1008,1,160,22,0.354999989271164,0),(1822,713,'A',1009,1,145,22,0.419999986886978,0),(1823,525,'A',1010,1,120,22,0.349999994039535,0),(1824,713,'A',1011,1,145,22,0.699999988079071,0),(1825,402,'A',1012,1,55,22,1,0),(1826,522,'A',1013,1,55,22,1.91999995708466,0),(1827,513,'A',1014,1,89,22,0.699999988079071,0),(1828,525,'A',1015,1,120,22,0.5,0),(1829,521,'A',1016,1,125,22,0.850000023841858,0),(1830,713,'A',1017,1,145,22,1,0),(1831,525,'A',1018,1,120,22,0.5,0),(1832,433,'A',1019,1,1,22,20,0),(1833,515,'A',1020,1,149,22,1.35000002384186,0),(1834,524,'A',1021,1,65,22,1.49000000953674,0),(1835,518,'A',1022,1,110,22,4,0),(1836,518,'A',1023,1,110,22,3.51999998092651,0),(1837,525,'A',1024,1,120,22,1,0),(1838,522,'A',1025,1,55,22,1,0),(1839,518,'A',1026,1,110,22,1.14999997615814,0),(1840,518,'A',1027,1,110,22,1.01999998092651,0),(1841,707,'A',1028,1,28,22,1,0),(1842,513,'A',1028,1,89,22,1.06500005722046,0),(1843,713,'A',1028,1,145,22,0.444999992847443,0),(1844,517,'A',1029,1,95,22,0.639999985694885,0),(1845,513,'A',1030,1,89,22,1.49500000476837,0),(1846,522,'A',1030,1,55,22,2.34500002861023,0),(1847,525,'A',1031,1,120,22,0.600000023841858,0),(1848,517,'A',1031,1,95,22,1.39999997615814,0),(1849,522,'A',1032,1,55,22,1.0900000333786,0),(1850,516,'A',1033,1,100,22,0.5,0),(1851,517,'A',1034,1,95,22,1.01999998092651,0),(1852,522,'A',1035,1,55,22,1.85000002384186,0),(1853,525,'A',1036,1,120,22,0.469999998807907,0),(1854,522,'A',1037,1,55,22,0.899999976158142,0),(1855,522,'A',1038,1,55,22,0.899999976158142,0),(1856,525,'A',1039,1,120,22,1,0),(1857,535,'A',1039,1,160,22,0.230000004172325,0),(1858,516,'A',1040,1,100,22,0.589999973773956,0),(1859,517,'A',1041,1,95,22,0.970000028610229,0),(1860,525,'A',1041,1,120,22,1,0),(1861,522,'A',1042,1,55,22,1.42999994754791,0),(1862,513,'A',1043,1,89,22,1.48000001907349,0),(1863,525,'A',1044,1,120,22,0.5,0),(1864,514,'A',1045,1,185,22,0.970000028610229,0),(1865,525,'A',1045,1,120,22,0.850000023841858,0),(1866,513,'A',1046,1,89,22,0.9200000166893,0),(1867,525,'A',1046,1,120,22,0.5,0),(1868,525,'A',1047,1,120,22,0.439999997615814,0),(1869,515,'A',1048,1,149,22,1.22000002861023,0),(1870,528,'A',1048,1,75,22,1.05499994754791,0),(1871,528,'A',1049,1,75,22,0.800000011920929,0),(1872,528,'A',1050,1,75,22,1.78999996185303,0),(1873,525,'A',1051,1,120,22,0.170000001788139,0),(1874,525,'A',1052,1,120,22,0.5,0),(1875,356,'A',1052,1,7,22,1,0),(1876,528,'A',1053,1,75,22,0.680000007152557,0),(1877,340,'A',1054,1,8,22,1,0),(1878,522,'A',1055,1,55,22,1,0),(1879,525,'A',1056,1,120,22,0.5,0),(1880,516,'A',1056,1,100,22,0.5,0),(1881,522,'A',1057,1,55,22,1.85000002384186,0),(1882,525,'A',1058,1,120,22,0.5,0),(1883,515,'A',1059,1,149,22,0.720000028610229,0),(1884,525,'A',1060,1,120,22,0.439999997615814,0),(1885,671,'A',1061,1,10,22,2,0),(1886,586,'A',1061,1,27,22,1,0),(1887,626,'A',1061,1,20,22,1,0),(1888,522,'A',1062,1,55,22,1.39499998092651,0),(1889,535,'A',1063,1,160,22,0.649999976158142,0),(1890,516,'A',1064,1,100,22,0.349999994039535,0),(1891,525,'A',1065,1,120,22,0.25,0),(1892,525,'A',1066,1,120,22,0.5,0),(1893,30,'A',1067,1,36,22,2,0),(1894,401,'A',1068,1,19,22,1,0),(1895,627,'A',1068,1,17,22,1,0),(1896,516,'A',1068,1,100,22,1.17999994754791,0),(1897,525,'A',1068,1,120,22,1.5,0),(1898,713,'A',1069,1,145,22,1.10000002384186,0),(1899,289,'A',1069,1,8,22,1,0),(1900,357,'A',1069,1,7,22,1,0),(1901,520,'A',1070,1,125,22,1.29999995231628,0),(1902,704,'A',1070,1,3,22,12,0),(1903,525,'A',1071,1,120,22,0.5,0),(1904,525,'A',1072,1,120,22,0.439999997615814,0),(1905,517,'A',1072,1,95,22,1,0),(1906,525,'A',1073,1,120,22,0.5,0),(1907,522,'A',1073,1,55,22,0.800000011920929,0),(1908,525,'A',1074,1,120,22,0.5,0),(1909,516,'A',1075,1,100,22,0.970000028610229,0),(1910,522,'A',1075,1,55,22,0.939999997615814,0),(1911,513,'A',1076,1,89,22,1.07000005245209,0),(1912,522,'A',1077,1,55,22,2.06500005722046,0),(1913,356,'A',1078,1,7,22,2,0),(1914,357,'A',1078,1,7,22,1,0),(1915,516,'A',1079,1,100,22,0.740000009536743,0),(1916,515,'A',1080,1,149,22,4.40000009536743,0),(1917,356,'A',1081,1,7,22,1,0),(1918,518,'A',1082,1,110,22,1.35000002384186,0),(1919,524,'A',1083,1,65,22,1.5,0),(1920,525,'A',1084,1,120,22,0.25,0),(1921,517,'A',1085,1,95,22,1.02499997615814,0),(1922,663,'A',1085,1,15,22,1,0),(1923,528,'A',1086,1,75,22,2.75,0),(1924,525,'A',1086,1,120,22,0.439999997615814,0),(1925,528,'A',1087,1,75,22,0.600000023841858,0),(1926,518,'A',1088,1,110,22,3.26999998092651,0),(1927,80,'A',1088,1,32,22,2,0),(1928,708,'A',1088,1,30,22,3,0),(1929,522,'A',1088,1,55,22,1.12000000476837,0),(1930,688,'A',1088,1,14,22,1,0),(1931,704,'A',1088,1,3,22,12,0),(1932,528,'A',1089,1,75,22,3.13000011444092,0),(1933,566,'A',1090,1,7,22,1,0),(1934,513,'A',1091,1,89,22,2,0),(1935,518,'A',1092,1,110,22,1.12000000476837,0),(1936,522,'A',1093,1,55,22,0.550000011920929,0),(1937,516,'A',1094,1,100,22,0.754999995231628,0),(1938,525,'A',1095,1,120,22,0.419999986886978,0),(1939,525,'A',1096,1,120,22,0.419999986886978,0),(1940,535,'A',1097,1,160,22,0.419999986886978,0),(1941,513,'A',1097,1,89,22,0.439999997615814,0),(1942,516,'A',1098,1,100,22,1.57000005245209,0),(1943,704,'A',1098,1,3,22,12,0),(1944,522,'A',1099,1,55,22,3.09999990463257,0),(1945,721,'A',1100,1,5,22,1,0),(1946,513,'A',1100,1,89,22,0.564999997615814,0),(1947,518,'A',1101,1,110,22,1.12000000476837,0),(1948,536,'A',1102,1,120,22,1.07000005245209,0),(1949,513,'A',1103,1,89,22,1.16499996185303,0),(1950,522,'A',1104,1,55,22,1.02999997138977,0),(1951,517,'A',1105,1,95,22,0.649999976158142,0),(1952,517,'A',1106,1,95,22,1.07000005245209,0),(1953,522,'A',1107,1,55,22,1,0),(1954,707,'A',1108,1,28,22,1,0),(1955,535,'A',1108,1,160,22,0.400000005960465,0),(1956,704,'A',1108,1,3,22,3,0),(1957,525,'A',1109,1,120,22,0.5,0),(1958,536,'A',1109,1,120,22,0.300000011920929,0),(1959,518,'A',1110,1,110,22,1.44000005722046,0),(1960,525,'A',1110,1,120,22,0.349999994039535,0),(1961,704,'A',1110,1,3,22,12,0),(1962,696,'A',1111,1,33,22,2,0),(1963,66,'A',1112,1,19,22,1,0),(1964,521,'A',1112,1,125,22,1.10000002384186,0),(1965,518,'A',1112,1,110,22,0.990000009536743,0),(1966,516,'A',1113,1,100,22,1.55999994277954,0),(1967,522,'A',1113,1,55,22,2.15000009536743,0),(1968,704,'A',1113,1,3,22,2,0),(1969,522,'A',1114,1,55,22,0.779999971389771,0),(1970,536,'A',1115,1,120,22,0.439999997615814,0),(1971,521,'A',1116,1,125,22,1.70000004768372,0),(1972,525,'A',1116,1,120,22,0.5,0),(1973,703,'A',1117,1,12,22,1,0),(1974,518,'A',1118,1,110,22,1.22000002861023,0),(1975,60,'A',1118,1,19,22,1,0),(1976,704,'A',1118,1,3,22,3,0),(1977,518,'A',1119,1,110,22,1.87000000476837,0),(1978,525,'A',1120,1,120,22,0.330000013113022,0),(1979,525,'A',1121,1,120,22,2,0),(1980,69,'A',1121,1,20,22,2,0),(1981,536,'A',1121,1,120,22,1.10000002384186,0),(1982,528,'A',1122,1,75,22,1.22000002861023,0),(1983,513,'A',1123,1,89,22,1.35000002384186,0),(1984,181,'A',1124,1,27,22,1,0),(1985,513,'A',1125,1,89,22,1.07000005245209,0),(1986,525,'A',1126,1,120,22,0.850000023841858,0),(1987,522,'A',1127,1,55,22,1.08000004291534,0),(1988,522,'A',1128,1,55,22,2.5,0),(1989,528,'A',1129,1,75,22,1,0),(1990,525,'A',1130,1,120,22,0.5,0),(1991,513,'A',1130,1,89,22,0.649999976158142,0),(1992,521,'A',1131,1,125,22,1.70000004768372,0),(1993,513,'A',1132,1,89,22,1.70000004768372,0),(1994,517,'A',1133,1,95,22,0.600000023841858,0),(1995,522,'A',1134,1,55,22,1.29999995231628,0),(1996,513,'A',1135,1,89,22,0.569999992847443,0),(1997,525,'A',1136,1,120,22,0.850000023841858,0),(1998,525,'A',1137,1,120,22,0.439999997615814,0),(1999,513,'A',1137,1,89,22,0.5799999833107,0),(2000,522,'A',1138,1,55,22,1.46000003814697,0),(2001,525,'A',1139,1,120,22,0.5799999833107,0),(2002,516,'A',1140,1,100,22,0.75,0),(2003,518,'A',1141,1,110,22,2.90000009536743,0),(2004,525,'A',1142,1,120,22,0.319999992847443,0),(2005,566,'A',1143,1,7,22,1,0),(2006,518,'A',1144,1,110,22,1.77999997138977,0),(2007,648,'A',1145,1,10,22,2,0),(2008,122,'A',1145,1,3,22,1,0),(2009,356,'A',1145,1,7,22,1,0),(2010,517,'A',1146,1,95,22,2.04999995231628,0),(2011,516,'A',1147,1,100,22,1.08000004291534,0),(2012,513,'A',1147,1,89,22,1.85000002384186,0),(2013,525,'A',1148,1,120,22,0.850000023841858,0),(2014,536,'A',1149,1,120,22,0.839999973773956,0),(2015,525,'A',1150,1,120,22,0.189999997615814,0),(2016,525,'A',1151,1,120,22,0.180000007152557,0),(2017,536,'A',1151,1,120,22,0.5,0),(2018,527,'A',1152,1,75,22,1.28999996185303,0),(2019,513,'A',1153,1,89,22,1,0),(2020,513,'A',1154,1,89,22,0.5,0),(2021,536,'A',1155,1,120,22,0.46000000834465,0),(2022,515,'A',1156,1,149,22,0.660000026226044,0),(2023,536,'A',1157,1,120,22,0.200000002980232,0),(2024,566,'A',1158,1,7,22,1,0),(2025,525,'A',1159,1,120,22,1.5,0),(2026,525,'A',1160,1,120,22,0.839999973773956,0),(2027,525,'A',1161,1,120,22,0.839999973773956,0),(2028,522,'A',1162,1,55,22,1.04999995231628,0),(2029,525,'A',1163,1,120,22,1,0),(2030,518,'A',1164,1,110,22,1,0),(2031,513,'A',1165,1,89,22,2.79999995231628,0),(2032,515,'A',1166,1,149,22,0.759999990463257,0),(2033,541,'A',1167,1,60,22,2.20000004768372,0),(2034,525,'A',1168,1,120,22,0.5,0),(2035,566,'A',1169,1,7,22,3,0),(2036,59,'A',1169,1,60,22,1,0),(2037,51,'A',1169,1,31,22,1,0),(2038,66,'A',1169,1,19,22,1,0),(2039,433,'A',1169,1,1,22,5,0),(2040,30,'A',1169,1,36,22,1,0),(2041,518,'A',1170,1,110,22,3.3199999332428,0),(2042,528,'A',1171,1,75,22,1.98500001430511,0),(2043,522,'A',1171,1,55,22,0.9200000166893,0),(2044,518,'A',1172,1,110,22,4.03999996185303,0),(2045,522,'A',1173,1,55,22,2.23499989509582,0),(2046,525,'A',1173,1,120,22,0.620000004768372,0),(2047,524,'A',1174,1,65,22,1.51999998092651,0),(2048,528,'A',1174,1,75,22,0.889999985694885,0),(2049,517,'A',1175,1,95,22,1.02499997615814,0),(2050,522,'A',1175,1,55,22,1.07000005245209,0),(2051,704,'A',1176,1,3,22,6,0),(2052,516,'A',1176,1,100,22,0.970000028610229,0),(2053,324,'A',1176,1,30,22,1,0),(2054,91,'A',1177,1,18,22,1,0),(2055,618,'A',1177,1,26,22,1,0),(2056,528,'A',1178,1,75,22,2.04999995231628,0),(2057,525,'A',1178,1,120,22,0.419999986886978,0),(2058,522,'A',1179,1,55,22,4,0),(2059,541,'A',1179,1,60,22,2.71499991416931,0),(2060,704,'A',1179,1,3,22,12,0),(2061,528,'A',1180,1,75,22,1.87000000476837,0),(2062,522,'A',1180,1,55,22,1.10000002384186,0),(2063,538,'A',1181,1,40,22,2.5,0),(2064,538,'A',1182,1,40,22,1.5,0),(2065,518,'A',1183,1,110,22,1.29999995231628,0),(2066,522,'A',1184,1,55,22,1,0),(2067,538,'A',1185,1,40,22,1.89999997615814,0),(2068,532,'A',1185,1,110,22,2.0699999332428,0),(2069,356,'A',1185,1,7,22,1,0),(2070,566,'A',1185,1,7,22,1,0),(2071,528,'A',1186,1,75,22,0.699999988079071,0),(2072,515,'A',1187,1,149,22,1.26999998092651,0),(2073,566,'A',1187,1,7,22,2,0),(2074,357,'A',1187,1,7,22,1,0),(2075,515,'A',1188,1,149,22,0.699999988079071,0),(2076,706,'A',1188,1,30,22,1,0),(2077,522,'A',1189,1,55,22,0.860000014305115,0),(2078,516,'A',1189,1,100,22,0.540000021457672,0),(2079,522,'A',1190,1,55,22,0.790000021457672,0),(2080,533,'A',1190,1,35,22,1,0),(2081,533,'A',1191,1,35,22,0.620000004768372,0),(2082,528,'A',1191,1,75,22,2.38000011444092,0),(2083,525,'A',1192,1,120,22,0.5,0),(2084,518,'A',1193,1,110,22,2.57999992370605,0),(2085,528,'A',1194,1,75,22,0.540000021457672,0),(2086,516,'A',1195,1,100,22,1.19000005722046,0),(2087,525,'A',1196,1,120,22,0.419999986886978,0),(2088,564,'A',1196,1,13,22,1,0),(2089,656,'A',1196,1,13,22,1,0),(2090,515,'A',1197,1,149,22,0.680000007152557,0),(2091,513,'A',1198,1,89,22,3,0),(2092,528,'A',1199,1,75,22,1.26999998092651,0),(2093,525,'A',1200,1,120,22,0.300000011920929,0),(2094,516,'A',1201,1,100,22,1.64999997615814,0),(2095,525,'A',1202,1,120,22,1,0),(2096,516,'A',1203,1,100,22,0.419999986886978,0),(2097,525,'A',1203,1,120,22,0.25,0),(2098,522,'A',1203,1,55,22,0.899999976158142,0),(2099,525,'A',1204,1,120,22,0.419999986886978,0),(2100,541,'A',1205,1,55,22,3.09999990463257,0),(2101,535,'A',1206,1,160,22,0.360000014305115,0),(2102,516,'A',1206,1,100,22,0.349999994039535,0),(2103,513,'A',1206,1,89,22,0.419999986886978,0),(2104,707,'A',1207,1,28,22,1,0),(2105,535,'A',1208,1,160,22,0.560000002384186,0),(2106,516,'A',1209,1,100,22,0.449999988079071,0),(2107,522,'A',1210,1,55,22,0.589999973773956,0),(2108,516,'A',1211,1,100,22,1.47000002861023,0),(2109,525,'A',1212,1,120,22,0.419999986886978,0),(2110,525,'A',1213,1,120,22,0.850000023841858,0),(2111,525,'A',1214,1,120,22,1,0),(2112,522,'A',1214,1,55,22,2,0),(2113,525,'A',1215,1,120,22,0.419999986886978,0),(2114,534,'A',1216,1,50,22,3.25999999046326,0),(2115,525,'A',1217,1,120,22,0.419999986886978,0),(2116,517,'A',1218,1,95,22,3.13000011444092,0),(2117,210,'A',1219,1,25,22,1,0),(2118,181,'A',1219,1,27,22,1,0),(2119,518,'A',1219,1,110,22,1.99000000953674,0),(2120,534,'A',1220,1,50,22,1.97000002861023,0),(2121,522,'A',1221,1,55,22,3.29999995231628,0),(2122,704,'A',1222,1,3,22,120,0),(2123,513,'A',1223,1,89,22,2.16499996185303,0),(2124,513,'A',1224,1,89,22,0.469999998807907,0),(2125,533,'A',1225,1,35,22,1.20000004768372,0),(2126,51,'A',1226,1,31,22,1,0),(2127,525,'A',1227,1,120,22,1,0),(2128,538,'A',1227,1,40,22,1.5,0),(2129,513,'A',1228,1,89,22,0.639999985694885,0),(2130,525,'A',1229,1,120,22,2,0),(2131,513,'A',1230,1,89,22,1.11000001430511,0),(2132,521,'A',1230,1,125,22,1.53999996185303,0),(2133,525,'A',1230,1,120,22,0.5,0),(2134,541,'A',1230,1,55,22,2.40000009536743,0),(2135,513,'A',1231,1,89,22,0.5,0),(2136,513,'A',1232,1,89,22,1.70000004768372,0),(2137,533,'A',1233,1,35,22,0.730000019073486,0),(2138,525,'A',1233,1,120,22,0.839999973773956,0),(2139,518,'A',1234,1,110,22,2.14000010490418,0),(2140,516,'A',1234,1,100,22,0.519999980926514,0),(2141,525,'A',1235,1,120,22,1.10000002384186,0),(2142,516,'A',1235,1,100,22,1.10000002384186,0),(2143,518,'A',1236,1,110,22,1.77999997138977,0),(2144,533,'A',1236,1,40,22,1.05499994754791,0),(2145,525,'A',1236,1,120,22,0.5,0),(2146,525,'A',1237,1,120,22,0.839999973773956,0),(2147,525,'A',1238,1,120,22,0.839999973773956,0),(2148,525,'A',1239,1,120,22,0.600000023841858,0),(2149,566,'A',1240,1,7,22,1,0),(2150,513,'A',1241,1,89,22,0.560000002384186,0),(2151,533,'A',1241,1,40,22,0.589999973773956,0),(2152,565,'A',1242,1,26,22,1,0),(2153,522,'A',1242,1,55,22,1,0),(2154,357,'A',1242,1,7,22,2,0),(2155,525,'A',1243,1,120,22,0.5,0),(2156,518,'A',1244,1,110,22,2.90000009536743,0),(2157,525,'A',1245,1,120,22,1,0),(2158,515,'A',1245,1,149,22,1.29999995231628,0),(2159,323,'A',1245,1,53,22,1,0),(2160,525,'A',1246,1,120,22,1,0),(2161,513,'A',1246,1,89,22,2.11999988555908,0),(2162,513,'A',1247,1,89,22,1.60000002384186,0),(2163,733,'A',1248,1,180,22,0.730000019073486,0),(2164,525,'A',1249,1,120,22,0.5,0),(2165,61,'A',1250,1,30,22,1,0),(2166,69,'A',1250,1,20,22,1,0),(2167,733,'A',1250,1,180,22,0.589999973773956,0),(2168,517,'A',1250,1,95,22,1.19500005245209,0),(2169,522,'A',1250,1,55,22,1.04999995231628,0),(2170,525,'A',1251,1,120,22,0.25,0),(2171,733,'A',1252,1,180,22,0.600000023841858,0),(2172,525,'A',1253,1,120,22,0.180000007152557,0),(2173,525,'A',1254,1,120,22,0.5,0),(2174,522,'A',1255,1,55,22,0.9200000166893,0),(2175,513,'A',1256,1,89,22,0.720000028610229,0),(2176,532,'A',1257,1,110,22,2.16000008583069,0),(2177,516,'A',1257,1,100,22,4.5,0),(2178,687,'A',1257,1,26,22,1,0),(2179,687,'A',1258,1,26,22,1,0),(2180,69,'A',1258,1,20,22,1,0),(2181,707,'A',1258,1,28,22,1,0),(2182,517,'A',1259,1,95,22,2.29999995231628,0),(2183,541,'A',1260,1,55,22,2.74499988555908,0),(2184,513,'A',1261,1,89,22,2.24000000953674,0),(2185,525,'A',1262,1,120,22,1,0),(2186,704,'A',1262,1,3,22,6,0),(2187,29,'A',1262,1,10,22,1,0),(2188,716,'A',1263,1,25,22,1,0),(2189,536,'A',1263,1,120,22,1,0),(2190,517,'A',1264,1,95,22,0.649999976158142,0),(2191,525,'A',1264,1,120,22,0.5,0),(2192,536,'A',1264,1,120,22,0.5,0),(2193,522,'A',1264,1,55,22,1,0),(2194,517,'A',1265,1,95,22,1.04499995708466,0),(2195,518,'A',1266,1,110,22,0.939999997615814,0),(2196,124,'A',1267,1,46,22,1,0),(2197,525,'A',1267,1,120,22,0.5,0),(2198,289,'A',1268,1,8,22,1,0),(2199,356,'A',1268,1,7,22,1,0),(2200,80,'A',1268,1,32,22,1,0),(2201,59,'A',1268,1,60,22,1,0),(2202,525,'A',1268,1,120,22,1,0),(2203,716,'A',1269,1,25,22,2,0),(2204,518,'A',1269,1,110,22,1.74000000953674,0),(2205,522,'A',1270,1,55,22,0.939999997615814,0),(2206,536,'A',1271,1,120,22,1.03999996185303,0),(2207,522,'A',1272,1,55,22,1.26499998569489,0),(2208,733,'A',1273,1,180,22,0.300000011920929,0),(2209,525,'A',1274,1,120,22,0.180000007152557,0),(2210,522,'A',1275,1,55,22,0.899999976158142,0),(2211,324,'A',1276,1,30,22,1,0),(2212,525,'A',1277,1,120,22,0.419999986886978,0),(2213,525,'A',1278,1,120,22,1,0),(2214,720,'A',1279,1,5,22,2,0),(2215,648,'A',1280,1,10,22,3,0),(2216,513,'A',1281,1,89,22,1.44000005722046,0),(2217,525,'A',1282,1,120,22,0.25,0),(2218,525,'A',1283,1,120,22,1,0),(2219,723,'A',1284,1,10,22,1,0),(2220,91,'A',1284,1,18,22,1,0),(2221,707,'A',1284,1,28,22,1,0),(2222,310,'A',1285,1,80,22,1,0),(2223,707,'A',1286,1,28,22,1,0),(2224,522,'A',1287,1,55,22,1.10000002384186,0),(2225,517,'A',1288,1,95,22,0.819999992847443,0),(2226,518,'A',1289,1,110,22,0.939999997615814,0),(2227,66,'A',1290,1,19,22,1,0),(2228,535,'A',1291,1,160,22,0.649999976158142,0),(2229,541,'A',1292,1,55,22,2.65000009536743,0),(2230,402,'A',1293,1,55,22,1,0),(2231,693,'A',1293,1,33,22,1,0),(2232,566,'A',1293,1,7,22,2,0),(2233,522,'A',1294,1,55,22,2.5699999332428,0),(2234,517,'A',1295,1,95,22,0.970000028610229,0),(2235,704,'A',1296,1,3,22,30,0),(2236,525,'A',1297,1,120,22,1,0),(2237,515,'A',1298,1,149,22,0.555000007152557,0),(2238,538,'A',1299,1,35,22,8.60000038146973,0),(2239,522,'A',1300,1,55,22,3.03999996185303,0),(2240,539,'A',1300,1,130,22,0.444000005722046,0),(2241,513,'A',1301,1,89,22,2.09999990463257,0),(2242,541,'A',1302,1,55,22,3.27999997138977,0),(2243,536,'A',1303,1,120,22,1.08000004291534,0),(2244,528,'A',1304,1,75,22,1.37000000476837,0),(2245,515,'A',1305,1,149,22,0.689999997615814,0),(2246,626,'A',1306,1,20,22,1,0),(2247,30,'A',1306,1,36,22,1,0),(2248,433,'A',1306,1,1,22,10,0),(2249,522,'A',1307,1,55,22,0.639999985694885,0),(2250,733,'A',1307,1,180,22,0.349999994039535,0),(2251,710,'A',1308,1,10,22,1,0),(2252,515,'A',1309,1,149,22,0.7950000166893,0),(2253,733,'A',1310,1,180,22,0.699999988079071,0),(2254,539,'A',1310,1,130,22,0.560000002384186,0),(2255,137,'A',1310,1,21,22,1,0),(2256,513,'A',1310,1,89,22,0.600000023841858,0),(2257,518,'A',1311,1,110,22,2.9300000667572,0),(2258,525,'A',1311,1,120,22,1.66499996185303,0),(2259,536,'A',1311,1,120,22,1.02999997138977,0),(2260,517,'A',1311,1,95,22,1.54499995708466,0),(2261,539,'A',1311,1,130,22,1.05999994277954,0),(2262,261,'A',1311,1,29,22,1,0),(2263,69,'A',1312,1,20,22,1,0),(2264,340,'A',1312,1,8,22,1,0),(2265,516,'A',1313,1,100,22,1.20000004768372,0),(2266,532,'A',1314,1,110,22,2.34999990463257,0),(2267,539,'A',1314,1,130,22,0.360000014305115,0),(2268,515,'A',1314,1,149,22,0.9200000166893,0),(2269,518,'A',1315,1,110,22,2.25500011444092,0),(2270,522,'A',1316,1,55,22,0.400000005960465,0),(2271,525,'A',1317,1,120,22,1,0),(2272,525,'A',1318,1,120,22,0.5,0),(2273,733,'A',1319,1,180,22,0.300000011920929,0),(2274,539,'A',1320,1,130,22,0.400000005960465,0),(2275,522,'A',1321,1,55,22,2.40000009536743,0),(2276,532,'A',1321,1,110,22,1.77999997138977,0),(2277,557,'A',1322,1,12,22,1,0),(2278,522,'A',1322,1,55,22,1.5,0),(2279,733,'A',1323,1,180,22,1.02999997138977,0),(2280,518,'A',1324,1,110,22,2.46000003814697,0),(2281,539,'A',1325,1,130,22,0.360000014305115,0),(2282,733,'A',1325,1,180,22,0.200000002980232,0),(2283,518,'A',1326,1,110,22,1.37000000476837,0),(2284,517,'A',1326,1,95,22,2.13000011444092,0),(2285,518,'A',1327,1,110,22,2,0),(2286,539,'A',1327,1,130,22,0.550000011920929,0),(2287,522,'A',1328,1,55,22,0.899999976158142,0),(2288,539,'A',1329,1,130,22,1.05499994754791,0),(2289,518,'A',1329,1,110,22,1.20000004768372,0),(2290,516,'A',1330,1,100,22,0.839999973773956,0),(2291,525,'A',1331,1,120,22,0.419999986886978,0),(2292,528,'A',1332,1,75,22,1.75999999046326,0),(2293,539,'A',1332,1,130,22,0.439999997615814,0),(2294,517,'A',1333,1,95,22,1.03999996185303,0),(2295,528,'A',1334,1,75,22,1.47000002861023,0),(2296,528,'A',1335,1,75,22,2.46000003814697,0),(2297,522,'A',1336,1,55,22,1.98500001430511,0),(2298,522,'A',1337,1,55,22,3.0550000667572,0),(2299,539,'A',1338,1,130,22,0.730000019073486,0),(2300,525,'A',1339,1,120,22,1.70000004768372,0),(2301,513,'A',1339,1,89,22,1.96000003814697,0),(2302,541,'A',1339,1,55,22,3.03999996185303,0),(2303,532,'A',1340,1,110,22,1.98000001907349,0),(2304,513,'A',1340,1,89,22,1.19000005722046,0),(2305,513,'A',1341,1,89,22,0.75,0),(2306,525,'A',1342,1,120,22,0.419999986886978,0),(2307,711,'A',1342,1,100,22,0.25,0),(2308,539,'A',1343,1,130,22,1.02499997615814,0),(2309,541,'A',1343,1,55,22,2.76999998092651,0),(2310,711,'A',1344,1,100,22,0.270000010728836,0),(2311,717,'A',1345,1,64,22,1,0),(2312,516,'A',1346,1,100,22,1.25,0),(2313,539,'A',1346,1,130,22,0.894999980926514,0),(2314,513,'A',1347,1,89,22,2.02999997138977,0),(2315,517,'A',1347,1,95,22,1.95500004291534,0),(2316,522,'A',1348,1,55,22,4.27999973297119,0),(2317,536,'A',1348,1,120,22,0.344999998807907,0),(2318,513,'A',1348,1,89,22,0.469999998807907,0),(2319,350,'A',1348,1,29,22,2,0),(2320,51,'A',1348,1,31,22,1,0),(2321,688,'A',1348,1,14,22,1,0),(2322,522,'A',1349,1,55,22,1.75999999046326,0),(2323,539,'A',1349,1,130,22,1.06500005722046,0),(2324,516,'A',1349,1,100,22,0.879999995231628,0),(2325,525,'A',1349,1,120,22,0.449999988079071,0),(2326,528,'A',1349,1,75,22,3.1800000667572,0),(2327,518,'A',1350,1,110,22,2.13000011444092,0),(2328,539,'A',1350,1,130,22,1.25,0),(2329,137,'A',1350,1,21,22,1,0),(2330,566,'A',1350,1,7,22,3,0),(2331,522,'A',1351,1,55,22,2.07999992370605,0),(2332,536,'A',1352,1,120,22,0.564999997615814,0),(2333,525,'A',1352,1,120,22,0.435000002384186,0),(2334,522,'A',1352,1,55,22,1.10500001907349,0),(2335,525,'A',1353,1,120,22,1.45000004768372,0),(2336,528,'A',1353,1,75,22,0.970000028610229,0),(2337,513,'A',1353,1,89,22,1.5699999332428,0),(2338,711,'A',1353,1,100,22,1.37999999523163,0),(2339,519,'A',1353,1,125,22,1,0),(2340,516,'A',1353,1,100,22,1.52499997615814,0),(2341,525,'A',1354,1,120,22,0.439999997615814,0),(2342,711,'A',1354,1,100,22,0.25,0),(2343,536,'A',1354,1,120,22,0.5,0),(2344,525,'A',1355,1,120,22,0.694999992847443,0),(2345,513,'A',1355,1,89,22,1.54999995231628,0),(2346,711,'A',1356,1,100,22,0.509999990463257,0),(2347,525,'A',1356,1,120,22,1,0),(2348,525,'A',1357,1,120,22,0.270000010728836,0),(2349,522,'A',1358,1,55,22,2.1949999332428,0),(2350,513,'A',1359,1,89,22,2,0),(2351,525,'A',1360,1,120,22,1.45000004768372,0),(2352,513,'A',1361,1,89,22,0.949999988079071,0),(2353,74,'A',1361,1,71,22,1,0),(2354,611,'A',1361,1,22,22,2,0),(2355,513,'A',1362,1,89,22,1.95000004768372,0),(2356,711,'A',1362,1,100,22,0.239999994635582,0),(2357,525,'A',1363,1,120,22,0.5,0),(2358,522,'A',1364,1,55,22,2.45000004768372,0),(2359,536,'A',1364,1,120,22,0.589999973773956,0),(2360,643,'A',1364,1,31,22,1,0),(2361,520,'A',1364,1,125,22,1.33500003814697,0),(2362,525,'A',1365,1,120,22,0.449999988079071,0),(2363,522,'A',1366,1,55,22,1.0349999666214,0),(2364,525,'A',1366,1,120,22,0.25,0),(2365,541,'A',1367,1,55,22,2.57999992370605,0),(2366,525,'A',1368,1,120,22,1,0),(2367,525,'A',1369,1,120,22,0.400000005960465,0),(2368,517,'A',1369,1,95,22,2.04999995231628,0),(2369,536,'A',1370,1,120,22,0.814999997615814,0),(2370,525,'A',1371,1,120,22,1,0),(2371,525,'A',1372,1,120,22,0.419999986886978,0),(2372,536,'A',1373,1,120,22,0.629999995231628,0),(2373,704,'A',1374,1,3,22,12,0),(2374,525,'A',1375,1,120,22,0.584999978542328,0),(2375,513,'A',1375,1,89,22,1,0),(2376,525,'A',1376,1,120,22,0.419999986886978,0),(2377,513,'A',1376,1,89,22,1.11000001430511,0),(2378,350,'A',1377,1,29,22,1,0),(2379,611,'A',1377,1,22,22,1,0),(2380,513,'A',1377,1,89,22,3.04500007629395,0),(2381,541,'A',1378,1,55,22,2.92000007629395,0),(2382,525,'A',1378,1,120,22,0.8299999833107,0),(2383,522,'A',1378,1,55,22,1.0349999666214,0),(2384,513,'A',1378,1,89,22,0.5,0),(2385,522,'A',1379,1,55,22,2.06500005722046,0),(2386,525,'A',1379,1,120,22,1,0),(2387,516,'A',1380,1,100,22,1.07000005245209,0),(2388,522,'A',1380,1,55,22,1.26499998569489,0),(2389,522,'A',1381,1,55,22,1.10000002384186,0),(2390,535,'A',1382,1,160,22,0.600000023841858,0),(2391,723,'A',1382,1,10,22,1,0),(2392,522,'A',1383,1,55,22,1.04499995708466,0),(2393,522,'A',1384,1,55,22,3,0),(2394,516,'A',1384,1,100,22,1.54999995231628,0),(2395,516,'A',1385,1,100,22,1.74500012397766,0),(2396,522,'A',1385,1,55,22,1,0),(2397,516,'A',1386,1,100,22,1.7849999666214,0),(2398,525,'A',1387,1,120,22,1.5,0),(2399,520,'A',1388,1,125,22,0.6700000166893,0),(2400,522,'A',1389,1,55,22,1,0),(2401,525,'A',1390,1,120,22,1.67499995231628,0),(2402,517,'A',1391,1,95,22,1.5,0),(2403,513,'A',1391,1,89,22,2.11500000953674,0),(2404,525,'A',1391,1,120,22,0.504999995231628,0),(2405,516,'A',1392,1,100,22,0.560000002384186,0),(2406,525,'A',1393,1,120,22,0.5,0),(2407,522,'A',1394,1,55,22,0.204999998211861,0),(2408,525,'A',1395,1,120,22,0.514999985694885,0),(2409,524,'A',1396,1,65,22,1.01499998569489,0),(2410,723,'A',1396,1,10,22,1,0),(2411,513,'A',1397,1,89,22,0.5799999833107,0),(2412,522,'A',1398,1,55,22,3.9300000667572,0),(2413,80,'A',1398,1,32,22,1,0),(2414,513,'A',1399,1,89,22,0.469999998807907,0),(2415,513,'A',1400,1,89,22,0.365000009536743,0),(2416,517,'A',1400,1,95,22,1.56499993801117,0),(2417,525,'A',1400,1,120,22,0.354999989271164,0),(2418,704,'A',1401,1,3,22,12,0),(2419,525,'A',1402,1,120,22,0.25,0),(2420,627,'A',1402,1,17,22,1,0),(2421,513,'A',1403,1,89,22,1.1599999666214,0),(2422,517,'A',1404,1,95,22,1.04999995231628,0),(2423,525,'A',1404,1,120,22,0.839999973773956,0),(2424,324,'A',1405,1,30,22,1,0),(2425,340,'A',1405,1,8,22,1,0),(2426,525,'A',1405,1,120,22,0.5,0),(2427,513,'A',1405,1,89,22,0.620000004768372,0),(2428,66,'A',1405,1,19,22,1,0),(2429,80,'A',1405,1,32,22,1,0),(2430,586,'A',1405,1,27,22,1,0),(2431,522,'A',1406,1,55,22,1.00999999046326,0),(2432,515,'A',1407,1,149,22,1.53999996185303,0),(2433,30,'A',1407,1,36,22,1,0),(2434,522,'A',1408,1,55,22,0.949999988079071,0),(2435,513,'A',1409,1,89,22,0.550000011920929,0),(2436,516,'A',1410,1,100,22,1.14499998092651,0),(2437,154,'A',1410,1,25,22,1,0),(2438,513,'A',1411,1,89,22,1.46900010108948,0),(2439,525,'A',1411,1,120,22,0.5,0),(2440,516,'A',1412,1,100,22,0.884999990463257,0),(2441,522,'A',1412,1,55,22,1.85000002384186,0),(2442,687,'A',1413,1,26,22,1,0),(2443,60,'A',1413,1,19,22,1,0),(2444,80,'A',1413,1,32,22,1,0),(2445,525,'A',1414,1,120,22,0.939999997615814,0),(2446,514,'A',1415,1,185,22,11,0),(2447,533,'A',1416,1,40,22,1.97500002384186,0),(2448,515,'A',1416,1,149,22,0.810000002384186,0),(2449,522,'A',1416,1,55,22,0.610000014305115,0),(2450,619,'A',1416,1,19,22,1,0),(2451,210,'A',1416,1,25,22,1,0),(2452,91,'A',1416,1,18,22,1,0),(2453,688,'A',1416,1,14,22,1,0),(2454,716,'A',1416,1,25,22,1,0),(2455,525,'A',1417,1,120,22,2.04500007629395,0),(2456,527,'A',1417,1,75,22,1.99500000476837,0),(2457,312,'A',1417,1,80,22,1,0),(2458,516,'A',1418,1,100,22,1.12000000476837,0),(2459,525,'A',1419,1,120,22,0.5,0),(2460,337,'A',1420,1,159,22,1,0),(2461,704,'A',1420,1,3,22,4,0),(2462,513,'A',1421,1,89,22,1.1949999332428,0),(2463,340,'A',1422,1,8,22,1,0),(2464,289,'A',1422,1,8,22,1,0),(2465,350,'A',1423,1,29,22,1,0),(2466,513,'A',1424,1,89,22,0.860000014305115,0),(2467,525,'A',1424,1,120,22,0.200000002980232,0),(2468,522,'A',1425,1,55,22,3.89000010490418,0),(2469,337,'A',1425,1,159,22,1,0),(2470,513,'A',1426,1,89,22,0.774999976158142,0),(2471,522,'A',1426,1,55,22,1.13499999046326,0),(2472,525,'A',1426,1,120,22,1.02999997138977,0),(2473,519,'A',1426,1,125,22,0.949999988079071,0),(2474,522,'A',1427,1,55,22,0.970000028610229,0),(2475,522,'A',1428,1,55,22,1.85000002384186,0),(2476,518,'A',1429,1,110,22,7.17000007629395,0),(2477,522,'A',1429,1,55,22,1.8400000333786,0),(2478,516,'A',1430,1,100,22,3.25500011444092,0),(2479,522,'A',1430,1,55,22,0.365000009536743,0),(2480,522,'A',1431,1,55,22,4,0),(2481,513,'A',1432,1,89,22,0.6700000166893,0),(2482,528,'A',1432,1,75,22,0.694999992847443,0),(2483,513,'A',1433,1,89,22,0.349999994039535,0),(2484,522,'A',1434,1,55,22,1.64499998092651,0),(2485,525,'A',1435,1,120,22,0.6700000166893,0),(2486,513,'A',1436,1,89,22,1.89999997615814,0),(2487,538,'A',1436,1,35,22,0.980000019073486,0),(2488,518,'A',1437,1,110,22,1.60000002384186,0),(2489,533,'A',1438,1,40,22,0.769999980926514,0),(2490,522,'A',1439,1,55,22,1.02999997138977,0),(2491,525,'A',1440,1,120,22,0.419999986886978,0),(2492,516,'A',1441,1,100,22,0.595000028610229,0),(2493,525,'A',1441,1,120,22,0.5,0),(2494,518,'A',1442,1,110,22,1.23599994182587,0),(2495,525,'A',1443,1,120,22,0.349999994039535,0),(2496,517,'A',1444,1,95,22,1.6599999666214,0),(2497,525,'A',1444,1,120,22,1,0),(2498,516,'A',1445,1,100,22,0.845000028610229,0),(2499,522,'A',1446,1,55,22,4.03499984741211,0),(2500,513,'A',1446,1,89,22,1.07000005245209,0),(2501,536,'A',1446,1,120,22,0.360000014305115,0),(2502,650,'A',1446,1,10,22,3,0),(2503,517,'A',1447,1,95,22,1.12000000476837,0),(2504,515,'A',1447,1,149,22,4.96999979019165,0),(2505,516,'A',1448,1,100,22,1.53999996185303,0),(2506,522,'A',1448,1,55,22,0.560000002384186,0),(2507,525,'A',1449,1,120,22,0.574999988079071,0),(2508,516,'A',1449,1,100,22,0.5,0),(2509,515,'A',1450,1,149,22,0.990000009536743,0),(2510,516,'A',1451,1,100,22,0.649999976158142,0),(2511,536,'A',1451,1,120,22,0.834999978542328,0),(2512,522,'A',1452,1,55,22,0.5450000166893,0),(2513,513,'A',1452,1,89,22,0.405000001192093,0),(2514,520,'A',1452,1,125,22,0.115000002086163,0),(2515,513,'A',1453,1,89,22,3.01999998092651,0),(2516,525,'A',1453,1,120,22,1.5,0),(2517,536,'A',1453,1,120,22,1,0),(2518,516,'A',1454,1,100,22,0.665000021457672,0),(2519,522,'A',1454,1,55,22,0.904999971389771,0),(2520,525,'A',1455,1,120,22,0.5,0),(2521,513,'A',1455,1,89,22,1.03999996185303,0),(2522,522,'A',1456,1,55,22,1.27499997615814,0),(2523,522,'A',1457,1,55,22,1,0),(2524,515,'A',1457,1,149,22,2.22499990463257,0),(2525,525,'A',1458,1,120,22,0.5,0),(2526,522,'A',1459,1,55,22,1,0),(2527,541,'A',1459,1,55,22,2.875,0),(2528,433,'A',1460,1,1,22,10,0),(2529,536,'A',1460,1,120,22,0.834999978542328,0),(2530,516,'A',1460,1,100,22,0.419999986886978,0),(2531,525,'A',1460,1,120,22,2.28499984741211,0),(2532,525,'A',1461,1,120,22,0.834999978542328,0),(2533,514,'A',1461,1,185,22,0.949999988079071,0),(2534,513,'A',1462,1,89,22,0.564999997615814,0),(2535,525,'A',1463,1,120,22,0.25,0),(2536,289,'A',1463,1,8,22,1,0),(2537,340,'A',1463,1,8,22,1,0),(2538,83,'A',1464,1,11,22,1,0),(2539,627,'A',1464,1,17,22,1,0),(2540,513,'A',1464,1,89,22,0.444999992847443,0),(2541,522,'A',1464,1,55,22,2.04500007629395,0),(2542,524,'A',1464,1,65,22,1.0900000333786,0),(2543,51,'A',1464,1,31,22,1,0),(2544,289,'A',1464,1,8,22,1,0),(2545,520,'A',1465,1,125,22,1.0349999666214,0),(2546,522,'A',1465,1,55,22,0.944999992847443,0),(2547,536,'A',1465,1,120,22,0.574999988079071,0),(2548,525,'A',1466,1,120,22,0.33500000834465,0),(2549,432,'A',1467,1,1,22,10,0),(2550,539,'A',1468,1,130,22,0.509999990463257,0),(2551,524,'A',1469,1,65,22,1.57500004768372,0),(2552,522,'A',1469,1,55,22,2.03500008583069,0),(2553,525,'A',1469,1,120,22,1.02499997615814,0),(2554,522,'A',1470,1,55,22,0.904999971389771,0),(2555,516,'A',1470,1,100,22,1.75499999523163,0),(2556,513,'A',1471,1,89,22,1.01499998569489,0),(2557,525,'A',1472,1,120,22,0.170000001788139,0),(2558,519,'A',1473,1,125,22,0.935000002384186,0),(2559,539,'A',1474,1,130,22,1.375,0),(2560,516,'A',1474,1,100,22,0.915000021457672,0),(2561,525,'A',1474,1,120,22,1.45000004768372,0),(2562,513,'A',1474,1,89,22,1.54999995231628,0),(2563,536,'A',1474,1,120,22,0.941999971866608,0),(2564,535,'A',1475,1,160,22,0.709999978542328,0),(2565,525,'A',1476,1,120,22,0.41499999165535,0),(2566,513,'A',1477,1,89,22,1.12000000476837,0),(2567,536,'A',1478,1,120,22,1.90499997138977,0),(2568,528,'A',1479,1,75,22,0.925000011920929,0),(2569,539,'A',1479,1,130,22,0.215000003576279,0),(2570,528,'A',1480,1,75,22,1.97000002861023,0),(2571,525,'A',1481,1,120,22,2,0),(2572,513,'A',1482,1,89,22,1.20000004768372,0),(2573,513,'A',1483,1,89,22,1.125,0),(2574,513,'A',1484,1,89,22,2.07999992370605,0),(2575,337,'A',1484,1,159,22,1,0),(2576,516,'A',1484,1,100,22,1.10500001907349,0),(2577,513,'A',1485,1,89,22,1.00999999046326,0),(2578,522,'A',1486,1,55,22,1.25,0),(2579,525,'A',1486,1,120,22,1,0),(2580,538,'A',1486,1,40,22,5.11499977111817,0),(2581,517,'A',1486,1,95,22,2.13000011444092,0),(2582,522,'A',1487,1,55,22,1.05999994277954,0),(2583,513,'A',1487,1,89,22,1.80999994277954,0),(2584,535,'A',1487,1,160,22,1.10500001907349,0),(2585,525,'A',1488,1,120,22,1.04499995708466,0),(2586,522,'A',1488,1,55,22,0.910000026226044,0),(2587,525,'A',1489,1,120,22,0.425000011920929,0),(2588,538,'A',1489,1,40,22,1.58500003814697,0),(2589,517,'A',1489,1,95,22,2.14499998092651,0),(2590,516,'A',1489,1,100,22,0.834999978542328,0),(2591,522,'A',1489,1,55,22,1.28999996185303,0),(2592,513,'A',1489,1,89,22,0.224999994039536,0),(2593,57,'A',1490,1,71,22,1,0),(2594,667,'A',1490,1,63,22,1,0),(2595,522,'A',1490,1,55,22,2.13000011444092,0),(2596,725,'A',1490,1,68,22,1,0),(2597,539,'A',1490,1,130,22,1,0),(2598,522,'A',1491,1,55,22,1,0),(2599,518,'A',1491,1,110,22,2.5550000667572,0),(2600,525,'A',1492,1,120,22,2.94500017166138,0),(2601,518,'A',1492,1,110,22,1.95000004768372,0),(2602,683,'A',1492,1,24,22,1,0),(2603,564,'A',1492,1,13,22,1,0),(2604,522,'A',1492,1,55,22,0.910000026226044,0),(2605,539,'A',1493,1,130,22,0.555000007152557,0),(2606,289,'A',1493,1,8,22,1,0),(2607,539,'A',1494,1,130,22,0.9549999833107,0),(2608,525,'A',1494,1,120,22,0.834999978542328,0),(2609,513,'A',1494,1,89,22,0.665000021457672,0),(2610,525,'A',1495,1,120,22,0.419999986886978,0),(2611,524,'A',1496,1,65,22,1.07000005245209,0),(2612,516,'A',1496,1,100,22,1.10500001907349,0),(2613,517,'A',1496,1,95,22,0.949999988079071,0),(2614,525,'A',1497,1,120,22,2.25999999046326,0),(2615,522,'A',1498,1,55,22,1,0),(2616,513,'A',1498,1,89,22,1.35000002384186,0),(2617,516,'A',1498,1,100,22,0.819999992847443,0),(2618,518,'A',1498,1,110,22,2.84500002861023,0),(2619,539,'A',1498,1,130,22,0.495000004768372,0),(2620,525,'A',1498,1,120,22,0.419999986886978,0),(2621,515,'A',1499,1,149,22,2.6800000667572,0),(2622,522,'A',1500,1,55,22,2.94000005722046,0),(2623,517,'A',1500,1,95,22,2.08999991416931,0),(2624,539,'A',1500,1,130,22,1,0),(2625,525,'A',1500,1,120,22,0.600000023841858,0),(2626,516,'A',1500,1,100,22,0.980000019073486,0),(2627,38,'A',1500,1,80,22,1,0),(2628,707,'A',1500,1,28,22,1,0),(2629,525,'A',1501,1,120,22,1.83500003814697,0),(2630,516,'A',1501,1,100,22,0.800000011920929,0),(2631,704,'A',1501,1,3,22,4,0),(2632,223,'A',1501,1,23,22,1,0),(2633,518,'A',1501,1,110,22,0.910000026226044,0),(2634,513,'A',1501,1,89,22,1.68499994277954,0),(2635,83,'A',1501,1,11,22,1,0),(2636,191,'A',1502,1,212,22,1,0),(2637,524,'A',1503,1,65,22,1.08000004291534,0),(2638,515,'A',1504,1,149,22,1.32000005245209,0),(2639,522,'A',1504,1,55,22,1.29999995231628,0),(2640,525,'A',1504,1,120,22,0.519999980926514,0),(2641,525,'A',1505,1,120,22,0.8299999833107,0),(2642,526,'A',1505,1,75,22,1.07000005245209,0),(2643,520,'A',1505,1,125,22,0.7950000166893,0),(2644,525,'A',1506,1,120,22,0.280000001192093,0),(2645,522,'A',1506,1,55,22,1.05499994754791,0),(2646,735,'A',1507,1,120,22,0.855000019073486,0),(2647,522,'A',1508,1,55,22,1.03999996185303,0),(2648,516,'A',1509,1,100,22,0.540000021457672,0),(2649,515,'A',1509,1,149,22,0.25,0),(2650,735,'A',1509,1,120,22,0.344999998807907,0),(2651,518,'A',1509,1,110,22,1.32000005245209,0),(2652,539,'A',1509,1,130,22,1.05499994754791,0),(2653,525,'A',1509,1,120,22,0.930000007152557,0),(2654,688,'A',1509,1,14,22,1,0),(2655,154,'A',1509,1,25,22,1,0),(2656,539,'A',1510,1,130,22,2.83500003814697,0),(2657,525,'A',1510,1,120,22,0.33500000834465,0),(2658,579,'A',1511,1,18,22,1,0),(2659,734,'A',1511,1,30,22,1,0),(2660,66,'A',1511,1,19,22,1,0),(2661,433,'A',1511,1,1,22,10,0),(2662,525,'A',1511,1,120,22,0.660000026226044,0),(2663,289,'A',1512,1,8,22,1,0),(2664,340,'A',1512,1,8,22,1,0),(2665,522,'A',1513,1,55,22,0.589999973773956,0),(2666,525,'A',1514,1,120,22,0.834999978542328,0),(2667,69,'A',1515,1,20,22,1,0),(2668,586,'A',1515,1,27,22,1,0),(2669,513,'A',1516,1,89,22,3.18499994277954,0),(2670,518,'A',1516,1,110,22,1.94500005245209,0),(2671,522,'A',1516,1,55,22,0.925000011920929,0),(2672,522,'A',1517,1,55,22,1.11000001430511,0),(2673,525,'A',1518,1,120,22,1.46000003814697,0),(2674,735,'A',1518,1,120,22,0.595000028610229,0),(2675,513,'A',1518,1,89,22,2.68499994277954,0),(2676,91,'A',1518,1,18,22,1,0),(2677,116,'A',1518,1,10,22,1,0),(2678,535,'A',1519,1,160,22,0.610000014305115,0),(2679,513,'A',1519,1,89,22,0.819999992847443,0),(2680,557,'A',1519,1,12,22,1,0),(2681,525,'A',1519,1,120,22,2.04500007629395,0),(2682,704,'A',1520,1,3,22,10,0),(2683,735,'A',1520,1,120,22,0.834999978542328,0),(2684,522,'A',1521,1,55,22,2,0),(2685,527,'A',1521,1,75,22,2.5550000667572,0),(2686,516,'A',1521,1,100,22,1.15499997138977,0),(2687,518,'A',1521,1,110,22,1.05999994277954,0),(2688,565,'A',1521,1,26,22,1,0),(2689,522,'A',1522,1,55,22,2.03999996185303,0),(2690,735,'A',1522,1,120,22,0.370000004768372,0),(2691,525,'A',1523,1,120,22,0.449999988079071,0),(2692,516,'A',1524,1,100,22,0.439999997615814,0),(2693,704,'A',1524,1,3,22,1,0),(2694,522,'A',1525,1,55,22,1.0900000333786,0),(2695,525,'A',1525,1,120,22,0.5,0),(2696,517,'A',1525,1,95,22,2.09999990463257,0),(2697,517,'A',1526,1,95,22,3.06299996376038,0),(2698,522,'A',1526,1,55,22,1.06500005722046,0),(2699,525,'A',1527,1,120,22,0.5799999833107,0),(2700,735,'A',1527,1,120,22,0.865000009536743,0),(2701,525,'A',1528,1,120,22,1.01499998569489,0),(2702,516,'A',1528,1,100,22,0.629999995231628,0),(2703,324,'A',1528,1,30,22,1,0),(2704,525,'A',1529,1,120,22,1,0),(2705,517,'A',1529,1,95,22,1.01999998092651,0),(2706,522,'A',1529,1,55,22,1.84500002861023,0),(2707,525,'A',1530,1,120,22,0.875,0),(2708,513,'A',1530,1,89,22,3.28399991989136,0),(2709,517,'A',1530,1,95,22,1.14699995517731,0),(2710,516,'A',1531,1,100,22,0.564999997615814,0),(2711,396,'A',1532,1,45,22,1,0),(2712,518,'A',1533,1,110,22,2.06500005722046,0),(2713,520,'A',1533,1,125,22,1.45000004768372,0),(2714,650,'A',1534,1,10,22,3,0),(2715,350,'A',1534,1,29,22,1,0),(2716,91,'A',1534,1,18,22,1,0),(2717,516,'A',1534,1,100,22,1.11500000953674,0),(2718,585,'A',1534,1,22,22,1,0),(2719,210,'A',1534,1,25,22,1,0),(2720,734,'A',1534,1,30,22,1,0),(2721,433,'A',1534,1,1,22,10,0),(2722,137,'A',1534,1,21,22,1,0),(2723,515,'A',1535,1,149,22,1.91999995708466,0),(2724,513,'A',1535,1,89,22,1.94000005722046,0),(2725,521,'A',1536,1,125,22,0.930000007152557,0),(2726,735,'A',1536,1,120,22,0.745000004768372,0),(2727,719,'A',1537,1,64,22,1,0),(2728,703,'A',1537,1,12,22,1,0),(2729,513,'A',1537,1,89,22,1.125,0),(2730,521,'A',1537,1,125,22,0.370000004768372,0),(2731,517,'A',1538,1,95,22,1.03999996185303,0),(2732,525,'A',1538,1,120,22,0.850000023841858,0),(2733,517,'A',1539,1,95,22,1.04499995708466,0),(2734,513,'A',1539,1,89,22,1,0),(2735,526,'A',1540,1,75,22,1.09500002861023,0),(2736,517,'A',1540,1,95,22,0.600000023841858,0),(2737,525,'A',1540,1,120,22,0.535000026226044,0),(2738,522,'A',1541,1,55,22,1.86000001430511,0),(2739,535,'A',1541,1,160,22,0.625,0),(2740,525,'A',1541,1,120,22,3.28999996185303,0),(2741,735,'A',1542,1,120,22,0.824999988079071,0),(2742,517,'A',1543,1,95,22,1.08000004291534,0),(2743,518,'A',1544,1,110,22,1.75,0),(2744,525,'A',1545,1,120,22,1.38499999046326,0),(2745,522,'A',1545,1,55,22,1.05999994277954,0),(2746,517,'A',1546,1,95,22,1,0),(2747,643,'A',1546,1,31,22,1,0),(2748,517,'A',1547,1,95,22,1,0),(2749,522,'A',1547,1,55,22,1.05499994754791,0),(2750,522,'A',1548,1,55,22,1.05499994754791,0),(2751,626,'A',1548,1,20,22,2,0),(2752,80,'A',1548,1,32,22,1,0),(2753,289,'A',1548,1,8,22,1,0),(2754,525,'A',1548,1,120,22,0.5,0),(2755,32,'A',1549,1,38,22,1,0),(2756,525,'A',1550,1,120,22,0.569999992847443,0),(2757,518,'A',1550,1,110,22,4.78999996185303,0),(2758,517,'A',1550,1,95,22,1.62000000476837,0),(2759,516,'A',1551,1,100,22,0.230000004172325,0),(2760,533,'A',1551,1,40,22,1,0),(2761,80,'A',1551,1,32,22,1,0),(2762,700,'A',1551,1,25,22,1,0),(2763,69,'A',1551,1,20,22,1,0),(2764,517,'A',1552,1,95,22,0.889999985694885,0),(2765,734,'A',1552,1,30,22,1,0),(2766,538,'A',1552,1,40,22,3.76999998092651,0),(2767,516,'A',1552,1,100,22,0.200000002980232,0),(2768,735,'A',1553,1,120,22,1.04499995708466,0),(2769,522,'A',1553,1,55,22,0.915000021457672,0),(2770,522,'A',1554,1,55,22,0.540000021457672,0),(2771,88,'A',1554,1,15,22,1,0),(2772,513,'A',1554,1,89,22,0.689999997615814,0),(2773,565,'A',1554,1,26,22,1,0),(2774,538,'A',1554,1,40,22,1.21000003814697,0),(2775,538,'A',1555,1,40,22,1.24000000953674,0),(2776,518,'A',1555,1,110,22,5.49499988555908,0),(2777,525,'A',1555,1,120,22,0.939999997615814,0),(2778,516,'A',1556,1,100,22,2.74000000953674,0),(2779,528,'A',1557,1,75,22,2.67499995231628,0),(2780,525,'A',1558,1,120,22,0.400000005960465,0),(2781,522,'A',1559,1,55,22,0.910000026226044,0),(2782,525,'A',1559,1,120,22,0.419999986886978,0),(2783,528,'A',1559,1,75,22,4.34999990463257,0),(2784,518,'A',1559,1,110,22,3.11999988555908,0),(2785,525,'A',1560,1,120,22,1.57999992370605,0),(2786,528,'A',1560,1,75,22,2.07999992370605,0),(2787,522,'A',1560,1,55,22,3.09999990463257,0),(2788,525,'A',1561,1,120,22,1,0),(2789,513,'A',1561,1,89,22,1.17999994754791,0),(2790,735,'A',1561,1,120,22,0.8299999833107,0),(2791,516,'A',1561,1,100,22,0.75,0),(2792,525,'A',1562,1,120,22,1.03999996185303,0),(2793,513,'A',1562,1,89,22,1.43500006198883,0),(2794,516,'A',1562,1,100,22,4.5,0),(2795,528,'A',1563,1,75,22,3.3600001335144,0),(2796,522,'A',1563,1,55,22,1.875,0),(2797,518,'A',1563,1,110,22,2.2720000743866,0),(2798,521,'A',1563,1,125,22,1.4650000333786,0),(2799,704,'A',1564,1,3,22,6,0),(2800,535,'A',1564,1,160,22,0.389999985694885,0),(2801,521,'A',1565,1,125,22,1.66999995708466,0),(2802,522,'A',1566,1,55,22,3.625,0),(2803,522,'A',1567,1,55,22,3.38000011444092,0),(2804,522,'A',1568,1,55,22,1,0),(2805,538,'A',1568,1,40,22,1.19000005722046,0),(2806,516,'A',1569,1,100,22,2.28000020980835,0),(2807,29,'A',1569,1,10,22,1,0),(2808,734,'A',1569,1,30,22,1,0),(2809,137,'A',1569,1,21,22,1,0),(2810,525,'A',1570,1,120,22,0.5,0),(2811,522,'A',1570,1,55,22,10,0),(2812,516,'A',1570,1,100,22,1.7849999666214,0),(2813,337,'A',1570,1,159,22,1,0),(2814,289,'A',1570,1,8,22,1,0),(2815,650,'A',1570,1,10,22,4,0),(2816,121,'A',1570,1,10,22,2,0),(2817,734,'A',1570,1,30,22,4,0),(2818,60,'A',1570,1,19,22,1,0),(2819,627,'A',1570,1,17,22,2,0),(2820,51,'A',1570,1,31,22,2,0),(2821,66,'A',1570,1,19,22,2,0),(2822,611,'A',1570,1,22,22,2,0),(2823,571,'A',1570,1,15,22,1,0),(2824,574,'A',1570,1,15,22,1,0),(2825,562,'A',1570,1,20,22,1,0),(2826,707,'A',1570,1,28,22,1,0),(2827,207,'A',1570,1,23,22,1,0),(2828,54,'A',1570,1,60,22,1,0),(2829,618,'A',1570,1,26,22,1,0),(2830,525,'A',1571,1,120,22,1.54999995231628,0),(2831,517,'A',1571,1,95,22,0.340000003576279,0),(2832,517,'A',1572,1,95,22,1.0900000333786,0),(2833,521,'A',1572,1,125,22,1.12800002098084,0),(2834,403,'A',1573,1,45,22,1,0),(2835,396,'A',1573,1,45,22,2,0),(2836,402,'A',1573,1,55,22,2,0),(2837,74,'A',1573,1,71,22,1,0),(2838,572,'A',1573,1,15,22,1,0),(2839,721,'A',1573,1,5,22,2,0),(2840,513,'A',1574,1,89,22,1.74000000953674,0),(2841,525,'A',1574,1,120,22,0.419999986886978,0),(2842,538,'A',1574,1,40,22,0.875,0),(2843,522,'A',1574,1,55,22,1.57999992370605,0),(2844,636,'A',1574,1,20,22,1,0),(2845,66,'A',1574,1,19,22,1,0),(2846,30,'A',1574,1,36,22,1,0),(2847,582,'A',1574,1,18,22,1,0),(2848,557,'A',1574,1,12,22,1,0),(2849,663,'A',1574,1,15,22,1,0),(2850,525,'A',1575,1,120,22,0.6700000166893,0),(2851,522,'A',1575,1,55,22,1.35000002384186,0),(2852,538,'A',1575,1,40,22,0.975000023841858,0),(2853,522,'A',1576,1,55,22,1.02999997138977,0),(2854,526,'A',1576,1,75,22,1.20000004768372,0),(2855,525,'A',1576,1,120,22,0.5,0),(2856,524,'A',1577,1,65,22,1.04499995708466,0),(2857,518,'A',1578,1,110,22,3.07999992370605,0),(2858,513,'A',1578,1,89,22,1.37000000476837,0),(2859,516,'A',1578,1,100,22,0.620000004768372,0),(2860,525,'A',1578,1,120,22,0.419999986886978,0),(2861,516,'A',1579,1,100,22,3.51999998092651,0),(2862,517,'A',1579,1,95,22,1.68499994277954,0),(2863,526,'A',1579,1,75,22,1.14999997615814,0),(2864,522,'A',1580,1,55,22,0.9549999833107,0),(2865,112,'A',1581,1,10,22,1,0),(2866,704,'A',1581,1,3,22,6,0),(2867,522,'A',1582,1,55,22,1.50999999046326,0),(2868,528,'A',1582,1,75,22,1.32000005245209,0),(2869,516,'A',1583,1,100,22,2.29999995231628,0),(2870,528,'A',1583,1,75,22,2.71499991416931,0),(2871,538,'A',1583,1,40,22,1,0),(2872,518,'A',1583,1,110,22,1.05499994754791,0),(2873,516,'A',1584,1,100,22,1.87000000476837,0),(2874,522,'A',1584,1,55,22,0.995000004768372,0),(2875,517,'A',1584,1,95,22,0.455000013113022,0),(2876,517,'A',1585,1,95,22,1.47500002384186,0),(2877,620,'A',1585,1,19,22,1,0),(2878,515,'A',1585,1,149,22,1.01499998569489,0),(2879,527,'A',1585,1,75,22,1.20000004768372,0),(2880,535,'A',1586,1,160,22,0.344999998807907,0),(2881,513,'A',1586,1,89,22,0.490000009536743,0),(2882,525,'A',1587,1,120,22,0.600000023841858,0),(2883,513,'A',1587,1,89,22,0.730000019073486,0),(2884,289,'A',1587,1,8,22,2,0),(2885,515,'A',1588,1,149,22,0.540000021457672,0),(2886,524,'A',1588,1,65,22,1.08000004291534,0),(2887,525,'A',1588,1,120,22,0.25,0),(2888,518,'A',1589,1,110,22,2.58500003814697,0),(2889,312,'A',1589,1,80,22,1,0),(2890,627,'A',1589,1,17,22,1,0),(2891,704,'A',1589,1,3,22,6,0),(2892,403,'A',1589,1,45,22,1,0),(2893,515,'A',1589,1,149,22,1.28999996185303,0),(2894,525,'A',1589,1,120,22,0.600000023841858,0),(2895,513,'A',1589,1,89,22,1.21000003814697,0),(2896,518,'A',1590,1,110,22,2.57999992370605,0),(2897,532,'A',1590,1,110,22,1.57500004768372,0),(2898,650,'A',1590,1,10,22,1,0),(2899,118,'A',1590,1,10,22,1,0),(2900,651,'A',1590,1,10,22,1,0),(2901,516,'A',1591,1,100,22,0.605000019073486,0),(2902,513,'A',1591,1,89,22,0.495000004768372,0),(2903,538,'A',1592,1,40,22,0.925000011920929,0),(2904,525,'A',1593,1,120,22,0.5,0),(2905,535,'A',1593,1,160,22,0.685000002384186,0),(2906,527,'A',1593,1,75,22,2.22499990463257,0),(2907,516,'A',1594,1,100,22,1.48000001907349,0),(2908,720,'A',1594,1,5,22,2,0),(2909,528,'A',1594,1,75,22,0.6700000166893,0),(2910,525,'A',1594,1,120,22,0.419999986886978,0),(2911,528,'A',1595,1,75,22,9.53999996185303,0),(2912,516,'A',1595,1,100,22,3.85999989509582,0),(2913,522,'A',1595,1,55,22,4.32500028610229,0),(2914,525,'A',1595,1,120,22,2.77500009536743,0),(2915,433,'A',1595,1,1,22,10,0),(2916,518,'A',1595,1,110,22,4.86999988555908,0),(2917,124,'A',1595,1,46,22,1,0),(2918,707,'A',1595,1,28,22,1,0),(2919,515,'A',1595,1,149,22,2.32999992370605,0),(2920,517,'A',1595,1,95,22,1.32500004768372,0),(2921,528,'A',1596,1,75,22,1.14400005340576,0),(2922,525,'A',1596,1,120,22,4.34999990463257,0),(2923,515,'A',1596,1,149,22,0.660000026226044,0),(2924,61,'A',1596,1,30,22,1,0),(2925,401,'A',1596,1,19,22,2,0),(2926,513,'A',1596,1,89,22,7.92899990081787,0),(2927,517,'A',1596,1,95,22,2,0),(2928,522,'A',1596,1,55,22,2.03499984741211,0),(2929,516,'A',1596,1,100,22,0.949999988079071,0),(2930,522,'A',1597,1,55,22,2.05900001525879,0),(2931,517,'A',1597,1,95,22,0.944999992847443,0),(2932,524,'A',1597,1,65,22,0.280000001192093,0),(2933,516,'A',1597,1,100,22,0.488999992609024,0),(2934,707,'A',1597,1,28,22,1,0),(2935,535,'A',1597,1,160,22,0.5799999833107,0),(2936,518,'A',1597,1,110,22,0.870000004768372,0),(2937,522,'A',1598,1,55,22,4.90000009536743,0),(2938,518,'A',1598,1,110,22,18.5149993896484,0),(2939,525,'A',1598,1,120,22,3.76999998092651,0),(2940,513,'A',1598,1,89,22,4.5,0),(2941,535,'A',1599,1,160,22,0.625,0),(2942,524,'A',1599,1,65,22,2,0),(2943,223,'A',1599,1,23,22,1,0),(2944,563,'A',1599,1,13,22,2,0),(2945,633,'A',1599,1,19,22,1,0),(2946,522,'A',1599,1,55,22,1.79999995231628,0),(2947,538,'A',1599,1,40,22,1.17499995231628,0),(2948,516,'A',1599,1,100,22,3.5,0),(2949,513,'A',1599,1,89,22,0.800000011920929,0),(2950,704,'A',1599,1,3,22,6,0),(2951,520,'A',1599,1,125,22,0.5450000166893,0),(2952,534,'A',1599,1,50,22,2.26999998092651,0),(2953,517,'A',1599,1,95,22,1.10000002384186,0),(2954,123,'A',1599,1,3,22,5,0),(2955,100,'A',1599,1,19,22,1,0),(2956,522,'A',1600,1,55,22,1.03999996185303,0),(2957,525,'A',1601,1,120,22,0.615000009536743,0),(2958,522,'A',1602,1,55,22,3.125,0),(2959,525,'A',1602,1,120,22,1.37999999523163,0),(2960,513,'A',1602,1,89,22,0.689999997615814,0),(2961,520,'A',1603,1,125,22,1.85000002384186,0),(2962,522,'A',1603,1,55,22,4.78999996185303,0),(2963,524,'A',1603,1,65,22,0.639999985694885,0),(2964,516,'A',1603,1,100,22,0.639999985694885,0),(2965,515,'A',1604,1,149,22,3.79200005531311,0),(2966,513,'A',1604,1,89,22,3.01500010490418,0),(2967,516,'A',1604,1,100,22,1.5,0),(2968,528,'A',1604,1,75,22,2.71500015258789,0),(2969,350,'A',1605,1,29,22,1,0),(2970,525,'A',1605,1,120,22,0.5,0),(2971,517,'A',1606,1,95,22,2.86500000953674,0),(2972,525,'A',1607,1,120,22,0.785000026226044,0),(2973,350,'A',1608,1,29,22,1,0),(2974,518,'A',1609,1,110,22,3.46000003814697,0),(2975,704,'A',1609,1,3,22,12,0),(2976,525,'A',1609,1,120,22,2.79999995231628,0),(2977,517,'A',1609,1,95,22,4.50500011444092,0),(2978,535,'A',1610,1,160,22,0.615000009536743,0),(2979,538,'A',1610,1,40,22,1.18499994277954,0),(2980,289,'A',1611,1,8,22,1,0),(2981,611,'A',1611,1,22,22,1,0),(2982,626,'A',1611,1,20,22,1,0),(2983,688,'A',1611,1,14,22,1,0),(2984,30,'A',1611,1,36,22,2,0),(2985,627,'A',1611,1,17,22,1,0),(2986,524,'A',1612,1,65,22,2,0),(2987,517,'A',1613,1,95,22,2.24000000953674,0),(2988,524,'A',1613,1,65,22,1.125,0),(2989,91,'A',1614,1,18,22,1,0),(2990,528,'A',1614,1,75,22,1.10500001907349,0),(2991,525,'A',1614,1,120,22,0.529999971389771,0),(2992,524,'A',1615,1,65,22,1.42499995231628,0),(2993,513,'A',1615,1,89,22,0.469999998807907,0),(2994,528,'A',1615,1,75,22,0.689999997615814,0),(2995,525,'A',1616,1,120,22,1.70000004768372,0),(2996,522,'A',1617,1,55,22,1.22500002384186,0),(2997,516,'A',1618,1,100,22,1.20000004768372,0),(2998,535,'A',1618,1,160,22,0.294999986886978,0),(2999,518,'A',1619,1,110,22,1.78999996185303,0),(3000,525,'A',1619,1,120,22,0.699999988079071,0),(3001,516,'A',1620,1,100,22,1.05499994754791,0);
/*!40000 ALTER TABLE ElPam.`lineafactura` ENABLE KEYS */;
UNLOCK TABLES;


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

		Fac_Des = Fac_Des + (xSubTotal + (NEW.LinF_Des / 100))

	WHERE

		Fac_Num = NEW.Fac_Num AND

		Fac_Tip = NEW.Fac_Tip AND

		Fac_Serie = NEW.Fac_Serie

	;

END;$$


DELIMITER ;


