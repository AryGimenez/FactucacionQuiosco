-- 
--Consulta a las personas que tienen saldo en su cuenta y 
-- que tienen una fecha de pago asignada
--
SELECT 
	FechPago.*,
	Persona.Per_RasSos,
	Saldo.Sal_Valor,
	Saldo.Sal_Tipo,
	Moneda.Mon_Sig
FROM
    ElPam.Persona
	INNER JOIN 
		ElPam.FechPago
			ON 
		(Persona.Per_Num = FechPago.Per_Num)
	INNER JOIN 
		ElPam.Saldo
			ON 
		(Persona.Per_Num = Saldo.Per_Num)
	INNER JOIN 
		ElPam.Moneda
			ON 
		(Saldo.Mon_Num = Moneda.Mon_Num)
WHERE 
	Saldo.Sal_Valor > 0 
;
	
	