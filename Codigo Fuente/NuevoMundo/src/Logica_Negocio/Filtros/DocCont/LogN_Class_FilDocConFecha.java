package Logica_Negocio.Filtros.DocCont;

import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import Utilidades.Util_Class_CompararFecha;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Date;

/**
 * Filtra los documentos contables por fecha
 * @author Ary
 * @version 1.0
 * @created 13-mar-2012 12:32:59 p.m.
 */
public class LogN_Class_FilDocConFecha extends LogN_ClassAb_FilDocCon <ArrayList<Date>> {
    
    public static final short Pos_DentroDeRango = 0;
    
    public static final short Pos_FueraDeRango = 1;
    
    public static final short Pos_Mayor = 2;
    
    public static final short Pos_Menor = 3;
    
    private static final String [] mNomPocicion = { "Dentro del rango", "Fuera del rango ", "Mayor que", "Menor que"};
    
    private short mPocicion = Pos_DentroDeRango;
    
    private ArrayList <Date> mCondicion;

    public LogN_Class_FilDocConFecha(ArrayList<Date> mCondicion) throws InputException {
        setmCondicion(mCondicion);
    }
    
    
    public LogN_Class_FilDocConFecha(ArrayList<Date> mCondicion, short mPocicion) throws InputException {
        setmCondicion(mCondicion);
        setmPocicion(mPocicion);
    }
    
    
    
    @Override
    public short getmPocicion() {
        return mPocicion;
    }

    @Override
    public String[] getNomPocicion() {
        return mNomPocicion;
    }

    @Override
    public void setmPocicion(short mPocicion) throws InputException {
        if(this.mPocicion < Pos_DentroDeRango && this.mPocicion > Pos_Menor)
            throw new InputException("Opción fuera de rango");
        this.mPocicion = mPocicion;
    }

    @Override
    public void setmCondicion(ArrayList<Date> ObjCon) throws InputException {
        if (ObjCon == null && ObjCon.size() != 2)
            throw new InputException("La condición de filtrado ingresado no es valida");
        mCondicion = ObjCon;
        notificar(new LogN_Class_Accion<>(LogN_Class_Accion.Modificar, this));
    }

    @Override
    public ArrayList<Date> getmCondicion() {
        return mCondicion;
    }

    @Override
    public LogN_Inter_DocCon filtrar(LogN_Inter_DocCon ObjAFil) {
        
        LogN_Inter_DocCon xRespuesta = null;
        switch(mPocicion){
            case Pos_DentroDeRango:
                xRespuesta = filtDentRango(ObjAFil);
            break;
            case Pos_FueraDeRango:
                xRespuesta = filtFuerRango(ObjAFil);
            break;
            case Pos_Mayor:
                xRespuesta = filtMayor(ObjAFil);
            break;
            case Pos_Menor:
                xRespuesta = filtMenor(ObjAFil);
            break;
                
        }
        
        return xRespuesta;
    }
    
    private LogN_Inter_DocCon filtDentRango (LogN_Inter_DocCon pObjDocCont){
        Date xFechIni = mCondicion.get(0);
        Date xFechFin = mCondicion.get(1);
        Util_Class_CompararFecha xObjComFech = new Util_Class_CompararFecha();
        
        if (xObjComFech.compare(xFechIni, xFechFin) > 0){
            Date Fecha3 = xFechIni;
            xFechIni = xFechFin;
            xFechFin = Fecha3;
        }
        if(xObjComFech.compare(pObjDocCont.getFech(), xFechIni) < 0
                || xObjComFech.compare(pObjDocCont.getFech(), xFechFin) > 0)
            return null;
        return pObjDocCont;
    }
    
    private LogN_Inter_DocCon filtFuerRango (LogN_Inter_DocCon pObjDocCont){
        Date xFechIni = mCondicion.get(0);
        Date xFechFin = mCondicion.get(1);
        Util_Class_CompararFecha xObjComFech = new Util_Class_CompararFecha();
        
        if (xObjComFech.compare(xFechIni, xFechFin) > 0){
            Date Fecha3 = xFechIni;
            xFechIni = xFechFin;
            xFechFin = Fecha3;
        }
        if(xObjComFech.compare(pObjDocCont.getFech(), xFechIni) < 0
                || xObjComFech.compare(pObjDocCont.getFech(), xFechFin) > 0)
            return pObjDocCont;
        return null;
    }
    
    private LogN_Inter_DocCon filtMayor (LogN_Inter_DocCon pObjDocCont){
        Date xFechIni = mCondicion.get(0);
        
        Util_Class_CompararFecha xObjComFech = new Util_Class_CompararFecha();
        
        
        if(xObjComFech.compare(pObjDocCont.getFech(), xFechIni) <= 0)
            return pObjDocCont;
        return null;
    }
    
    
    private LogN_Inter_DocCon filtMenor (LogN_Inter_DocCon pObjDocCont){
        Date xFechIni = mCondicion.get(0);
        
        Util_Class_CompararFecha xObjComFech = new Util_Class_CompararFecha();
        
        
        if(xObjComFech.compare(pObjDocCont.getFech(), xFechIni) >= 0)
            return pObjDocCont;
        return null;
    }
    

    @Override
    public ArrayList<LogN_Inter_DocCon> filtar(AbstractCollection<LogN_Inter_DocCon> ColAFil) {
        ArrayList<LogN_Inter_DocCon> xColList = new ArrayList<>();
        for (LogN_Inter_DocCon xObjDocCon : ColAFil){
            xObjDocCon = filtrar(xObjDocCon);
            if(xObjDocCon != null)
                xColList.add(xObjDocCon);
        }
        return xColList;
    }


}//end LogN_Class_FilDocConFecha