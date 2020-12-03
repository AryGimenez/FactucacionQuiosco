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
 * @author horacio
 */
public class Dom_Class_FechPAño extends LogN_ClassAb_FechPag {
    private int mMesDelAño = 0;
    private int mDiaDelMes = 0;
    private Date mFechPago;
    private boolean mPeriodo = false;

    public Dom_Class_FechPAño(int mIntervalo, int mAviso, Date mFechInicio, int mDiaDelMes, int mMesDelAño) {
        super(mIntervalo, mAviso, mFechInicio);
        
        this.mMesDelAño = mMesDelAño;
        this.mDiaDelMes = mDiaDelMes;
        
        this.CalularFecha();
    }
    
    public Dom_Class_FechPAño (Dom_Class_FechPAño xObjFechPAño){
         super(xObjFechPAño.getmIntervalo(), xObjFechPAño.getAviso(), xObjFechPAño.getmFechInicio());
         this.mDiaDelMes = xObjFechPAño.mDiaDelMes;
         this.mFechPago = xObjFechPAño.mFechPago;
         this.mMesDelAño = xObjFechPAño.mMesDelAño;
         this.mPeriodo = xObjFechPAño.mPeriodo;
    }
    
    private void CalularFecha(){
        int DifMes = getDiaDelMes();
        int Resto = (int) (DifMes % getmIntervalo());

        Calendar Hoy = new GregorianCalendar();

        Hoy.add(Calendar.MONTH, Resto); // me deja en la proxima fecha de pago
        Hoy.set(Calendar.DAY_OF_MONTH, getDiaDelMes()); // Me modifica el dia del mes por el dia por el de la fecha de pago

        mFechPago = Hoy.getTime();

        Hoy.add(Calendar.DATE, (getAviso() * -1));

        Date FechAviso = Hoy.getTime();
        Date FechActual = new Date();

        if(FechAviso.compareTo(FechActual) <= 0)
            mPeriodo = true;
    }
 
    
    
    @Override
    public String TipFechPag() {
        return "Anual";
    }

    @Override
    public Date getFechPago() {
        return mFechPago;
    }

    @Override
    public int getMesDelAño() {
        return mMesDelAño;
    }

    @Override
    public int getDiaDelMes() {
        return mDiaDelMes;
    }

    @Override
    public boolean dentroRango() {
        return mPeriodo;
    }

    @Override
    public boolean duplicado(LogN_ClassAb_FechPag xObjCop) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_FechPag duplicar() {
        return new Dom_Class_FechPAño(this);
    }
    
}
