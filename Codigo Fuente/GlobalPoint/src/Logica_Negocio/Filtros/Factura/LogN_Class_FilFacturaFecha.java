/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Filtros.Factura;

import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Date;


/**
 *
 * @author Ary
 */
public class LogN_Class_FilFacturaFecha implements LogN_Inter_FiltFactura<ArrayList<Date>> {
    private boolean mTipFac;
    private ArrayList<Date> mColF;
    
    

    public LogN_Class_FilFacturaFecha(boolean mTipFac, ArrayList<Date> mColF) {
        this.mTipFac = mTipFac;
        this.mColF = mColF;
    }

    @Override
    public boolean getTipFac() {
        return mTipFac;
    }

    @Override
    public void setTipFac(boolean xTipFac) {
        mTipFac = xTipFac;
    }

    @Override
    public short getmPocicion() {
        return 0;
    }

    @Override
    public void setmPocicion(short mPocicion) throws InputException {
        
    }



    @Override
    public Class<LogN_ClassAb_Factura> getCalse() {
        return null;
    }

    @Override
    public LogN_ClassAb_Factura filtrar(LogN_ClassAb_Factura ObjAFil) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> filtar(AbstractCollection<LogN_ClassAb_Factura> ColAFil) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setmCondicion(ArrayList<Date> ObjCon) throws InputException {
        this.mColF = ObjCon;
    }

    @Override
    public ArrayList<Date> getmCondicion() {
        return new ArrayList<Date>(mColF);
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

   
    
}
