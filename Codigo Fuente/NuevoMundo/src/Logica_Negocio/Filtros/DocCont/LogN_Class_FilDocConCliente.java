package Logica_Negocio.Filtros.DocCont;


import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;


/**
 * Filtra los documentos contables por el Cliente
 * @author Ary
 * @version 1.0
 * @created 13-mar-2012 12:32:40 p.m.
 */
public class LogN_Class_FilDocConCliente extends LogN_ClassAb_FilDocCon <LogN_ClassAb_Persona> {
      
    private final String[] mTitel = {};
    /**
     * Condicion para filtrar
     */
    private LogN_ClassAb_Persona mCondicion;

    
    public LogN_Class_FilDocConCliente(Dom_Class_Cliente mCondicion ) throws InputException{
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
    public void setmCondicion(LogN_ClassAb_Persona ObjCon) throws InputException {
        if(mCondicion == null) throw new InputException("El cliente ingresado no es valido");
        mCondicion = ObjCon;
        notificar(new LogN_Class_Accion<> (LogN_Class_Accion.Modificar, this));
    }

    @Override
    public LogN_ClassAb_Persona getmCondicion() {
        return mCondicion;
    }

    @Override
    public LogN_Inter_DocCon filtrar(LogN_Inter_DocCon pObjAFil) {
        if (pObjAFil.getPersona().equals(mCondicion))
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
    
    
}//end LogN_Class_FilDocConCliente