package Logica_Negocio.Filtros.DocCont;

import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;

/**
 * @author Ary
 * @version 1.0
 * @created 13-mar-2012 12:33:16 p.m.
 */
public class LogN_Class_FilDocConIVA extends LogN_ClassAb_FilDocCon <Dom_Class_IVA> {

    private final String[] mTitel = {};
    /**
     * Condicion para filtrar
     */
    private Dom_Class_IVA mCondicion;

    
    public LogN_Class_FilDocConIVA (Dom_Class_IVA mCondicion ) throws InputException{
        this.setmCondicion(mCondicion);
    }

    @Override
    public short getmPocicion() {
        return -1;
    }

    @Override
    public String[] getNomPocicion() {
        return mTitel;
    }

    @Override
    public void setmPocicion(short mPocicion) throws InputException {
        
    }

    @Override
    public void setmCondicion(Dom_Class_IVA ObjCon) throws InputException {
        if(mCondicion == null) throw new InputException("El IVA ingresado no es valido");
        mCondicion = ObjCon;
        notificar(new LogN_Class_Accion<> (LogN_Class_Accion.Modificar, this));
    }

    @Override
    public Dom_Class_IVA getmCondicion() {
        return mCondicion;
    }

    @Override
    public LogN_Inter_DocCon filtrar(LogN_Inter_DocCon pObjAFil) {
        if (pObjAFil.getIVA().equals(mCondicion))
            return pObjAFil;
        return null;
    }

    @Override
    public ArrayList<LogN_Inter_DocCon> filtar(AbstractCollection<LogN_Inter_DocCon> ColAFil) {
        ArrayList <LogN_Inter_DocCon> xColDocCnt = new ArrayList<>();
        for(LogN_Inter_DocCon xObjDocCon: ColAFil){
            xColDocCnt.add(xObjDocCon);
        }
        return xColDocCnt;
    }


    

}//end LogN_Class_FilDocConIVA