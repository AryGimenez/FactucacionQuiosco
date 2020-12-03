SELECT 
	TemTab.Doc_Cod,
	TemTab.Doc_Tipo,
	TemTab.Per_Tip,
	TemTab.Per_Num,
	TemTab.Mon_Num,
	TemTab.Doc_Emision,
	Persona.Per_RasSos,
	TemTab.Doc_Caja,
	TemTab.Doc_Credito

FROM
	(
		(	
			SELECT -- Select FormaPago 
				(FormaDePago.Fac_Serie + ' ' + FormaDePago.Fac_Num)AS Doc_Cod,
				Per_Tip,
				Per_Num,
				Mon_Num,
				(Fac_Fech)AS Doc_Emision,
				(
					IF (ForP_Tip = 1 OR ForP_Tip = 3, 
						IF (FormaDePago.Fac_Tip,
							ForP_MonAPag ,
							ForP_MonAPag * -1
						), 
						0.0) 
				) AS Doc_Caja,

				(
					IF (FormaDePago.ForP_Tip = 2, 
						IF (FormaDePago.Fac_Tip ,
							ForP_MonAPag ,
							ForP_MonAPag * -1
						),  
						0.0 
					) 
				) AS Doc_Credito,
				(
					IF (FormaDePago.Fac_Tip,
						'Fac. Venta',
						'Fac. Compra'
					)   
				)AS Doc_Tipo
				
			FROM 
				ElPam.FormaDePago
			LEFT JOIN 
				(
				SELECT 
					(Prov_Num)AS Per_Num,
					(2)AS Per_Tip,
					Fac_Num,
					Fac_Serie,
					Fac_Tip
				FROM 
					ElPam.FacturaCom

					UNION 
					
				SELECT 
					(Cli_Num)AS Per_Num,
					(1)AS Per_Tip,
					Fac_Num,
					Fac_Serie,
					Fac_Tip
				FROM 
					ElPam.FacturaVen
				)AS TabFactura
			ON (FormaDePago.Fac_Num = TabFactura.Fac_Num AND
				FormaDePago.Fac_Tip = TabFactura.Fac_Tip)
			INNER JOIN 
				ElPam.Factura
			ON (FormaDePago.Fac_Num = Factura.Fac_Num AND
				FormaDePago.Fac_Tip = Factura.Fac_Tip)
		)
			UNION	
		(		
			SELECT	-- Select Recibo
				(Recibo.Res_Num)AS Doc_Cod,
				Per_Tip,
				Per_Num,
				Mon_Num,
				(Res_Emision)AS Doc_Emision,
				(Res_Monto)AS Doc_Caja,
				(Res_Monto * -1) AS Doc_Credito,
				('Recibo')AS Doc_Tipo
			FROM
				ElPam.Recibo
		)
	)AS TemTab
INNER JOIN 
	ElPam.Persona
ON (Persona.Per_Num = TemTab.Per_Num AND
	Persona.Per_Tip = TemTab.Per_Tip)