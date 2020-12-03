/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Dominio.FechPago;

import Logica_Negocio.LogN_ClassAb_FechPag;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author horacioi
 */
public class Dom_Class_FechPDiario extends LogN_ClassAb_FechPag{
    private boolean mPeriodo = false;
    private Date mProFechCobro;
    public Dom_Class_FechPDiario(int mIntervalo, int mAviso, Date mFechInicio) {
        super(mIntervalo, mAviso, mFechInicio);
        CalularFecha();
    }

    private Dom_Class_FechPDiario(Dom_Class_FechPDiario xObjDiario) {
        super(xObjDiario.getmIntervalo(), xObjDiario.getAviso(), xObjDiario.getmFechInicio());
        mPeriodo = xObjDiario.mPeriodo;
        mProFechCobro = xObjDiario.mProFechCobro;
    }

    private void CalularFecha(){
        long DifDias = getDifDias();
        int Resto = 0;
        Resto = (int) (DifDias % getmIntervalo());
        
        
        if (Resto != 0 ){
            if (getAviso() >= Resto)
                mPeriodo = true;
            
            Calendar Hoy = new GregorianCalendar();
            
            Hoy.add(Calendar.DATE, Resto);
            mProFechCobro = Hoy.getTime();
        }
        
    }
    
    
    @Override
    public String TipFechPag() {
        return "Diario";
    }

    @Override
    public Date getFechPago() {
        return mProFechCobro;
    }

    @Override
    public int getMesDelAño() {
        return 0;
    }

    @Override
    public int getDiaDelMes() {
        return 0;
    }

    @Override
    public boolean dentroRango() {
        return mPeriodo;
    }

    @Override
    public LogN_ClassAb_FechPag duplicar() {
        return new Dom_Class_FechPDiario(this);
    }

    @Override
    public boolean duplicado(LogN_ClassAb_FechPag xObjCop) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
