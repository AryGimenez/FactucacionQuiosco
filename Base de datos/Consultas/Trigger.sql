



CREATE FUNCTION`ElPam`.`Fuc_AsigSaldo` (pFac_Num INT, pFac_Serie VARCHAR (1), pFac_Tip BOOLEAN,  pMon_Num INT, 
	pForP_MonAPag DOUBLE) RETURNS VARCHAR(60)
BEGIN 
	
	DECLARE xPer_Tip , xPer_Num INT;
	DECLARE xSal_LimDeu, xSal_LimAcre, xSal_Val, xSal_Tipo FLOAT;
	

	
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
			Sal_Val,
			Sal_Tipo
		INTO 
			xSal_LimDeu,
			xSal_LimAcre,
			xSal_Val,
			xSal_Tipo
	FROM
		Saldo
	WHERE
		Per_Num = xPer_Num AND
		Per_Tip = xPer_Tip AND
		Mon_Num = xMon_Num;
	; -- Fin SELECT
	
	IF xSal_LimDeu NOT NULL THEN
		IF pFac_Tip THEN  -- Si la factura es fenta
		
			IF xSal_Tio THEN -- Si el saldo es deudor
				SET xSal_Val +=  pForP_MonAPag;
			ELSE -- Saldo Acreedor
				SET xSal_Val -= pForP_MonAPag;
				IF xSal_Val < 0 THEN 
					xSal_Tip = !xSal_Tip;
					xSal_Val = xSal_Val * -1;
				END IF;
			END IF;
			
		ELSE -- Factura Compra
		
			IF xSal_Tio THEN -- Si el saldo es deudor
				SET xSal_Val -= pForP_MonAPag;
				IF xSal_Val < 0 THEN 
					xSal_Tip = !xSal_Tip;
					xSal_Val = xSal_Val * -1;
				END IF;
			ELSE -- Saldo Acreedor
				SET xSal_Val +=  pForP_MonAPag;
			END IF;
			
		END IF;
		
		
		IF xSal_LimDeu > 0 AND xSal_Tip AND xSal_LimDeu < xSal_Val THEN  -- Deudor
			RETURN 'El saldo deudor supera el límite deudor';
		END IF;
		
		IF xSal_LimAcre > 0 AND xSal_Tip = FALSE AND xSal_LimAcre < xSal_Val THEN  -- Acreedor
			RETURN 'El saldo acreedor supera el límite acreedor';
		END IF;
		
		UPDATE 
			ElPam.Saldo 
		SET
			Sal_Tipo = xSal_Tipo,
			Sal_Val = xSal_Val
		WHERE
			Per_Num = xPerNum AND
			Per_Tip = xPer_Tip AND
			Mon_Num = xMon_Num
		; -- Fin Update
		
	ELSE 
		INSERT INTO 
			ElPam.Saldo
				(Per_Num, Per_Tip, Mon_Num, Sal_Vla, Sal_Tipo)
		VALUE 
			(xPer_Num, xPer_Tip, pMon_Num, pForP_MonAPag, pFac_Tip)
		;
	END IF;
	
	RETURN "";

	
END;