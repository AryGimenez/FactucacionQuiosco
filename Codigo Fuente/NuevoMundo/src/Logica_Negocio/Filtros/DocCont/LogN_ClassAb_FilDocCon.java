package Logica_Negocio.Filtros.DocCont;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.MiExepcion.InputException;
import java.util.Observable;

/**
 * Filtro común para todos los documentos (Las clases que implementas la interfas
 * LogN_Inter_DocCont) contable
 * @author Ary
 * @version 1.0
 * @updated 13-mar-2012 04:42:11 p.m.
 */
public abstract class LogN_ClassAb_FilDocCon<A> extends Observable implements LogN_Inter_Filtrar<LogN_Inter_DocCon, A>  {
    /**
    * No discrimina todos los tipos documentos contables 
    */
    public static final short TipDoc_Todo = 0;
    
    /**
    * Filtra solo los tipo factura
    */
    public static final short TipDoc_Factura = 1;
    
    public static final short TipDoc_Recibo = 2;
    
    /**
    * Filtra los objetos que heredan de modificador de caja (LogN_ClasAb_ModCaja)
    */
    public static final short TipDoc_ModCaja = 3;
    
    /**
    * Filtra los gastos
    */
    public static final short TipDoc_Gasto = 4;
    
    /**
    * Filtra por Entrada
    */
    public final short TipDoc_Entrada = 5;
    
    private short mTipo; 
    
    private static final String[] mTituloTipo = {"Todo", "Factura", "Recibo", 
        "Gasto/Ingreso",  "Gasto", "Ingreso"};
    //Metodos___________________________________________________________________

    
    
    @Override
    public Class<LogN_Inter_DocCon> getCalse(){
        return LogN_Inter_DocCon.class;
    }

    /**
    * Retorna por el tipo de documento que se filtra 
    */
    public short getTipDoc(){
        return mTipo;
    }

    /**
    * Modifica el tipo de documento que se filtra
    * 
    * @param setTipDoc
    */
    public void setTipDoc(short pTipDoc) throws InputException{
        if(TipDoc_Todo < mTipo && TipDoc_Entrada > mTipo) 
            throw new InputException("Opción fuera de rango");
        mTipo = pTipDoc;
    }

    /**
    * Retorna un arraya que corresponde con el nombre de tipo de documento
    */
    public String[] getNomTipDoc(){
            return null;
    }
    
    
    public void notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }
    
        
}//end LogN_ClassAb_FilDocCon