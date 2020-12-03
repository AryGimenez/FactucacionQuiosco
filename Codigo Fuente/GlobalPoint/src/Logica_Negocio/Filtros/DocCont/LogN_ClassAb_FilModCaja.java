package Logica_Negocio.Filtros.DocCont;

import Logica_Negocio.MiExepcion.InputException;


/**
 * @author Ary
 * @version 1.0
 * @created 13-mar-2012 12:37:42 p.m.
 */
public abstract class LogN_ClassAb_FilModCaja<A> extends LogN_ClassAb_FilDocCon<A> {
    
    public LogN_ClassAb_FilModCaja() throws InputException{
        setTipDoc(TipDoc_ModCaja);
    }

    @Override
    public void setTipDoc(short pTipDoc) throws InputException {
        if (pTipDoc < TipDoc_ModCaja) throw new 
                InputException("Opción fuera de rango");
        super.setTipDoc(pTipDoc);
    }

}//end LogN_ClassAb_FilModCaja