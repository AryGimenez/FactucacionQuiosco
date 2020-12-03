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
public class Dom_Class_FechPMensual extends LogN_ClassAb_FechPag{
    private int mDiaDelMes = 0;
    private Date mFechPago;
    private boolean mPeriodo = false;

    public Dom_Class_FechPMensual(int mIntervalo, int mAviso, Date mFechInicio, int mDiaDelMes) {
        super(mIntervalo, mAviso, mFechInicio);
        this.mDiaDelMes = mDiaDelMes;
        this.CalularFecha();
    }
    
    private Dom_Class_FechPMensual(Dom_Class_FechPMensual xObjMensual){
        super(xObjMensual.getmIntervalo(), xObjMensual.getAviso(), xObjMensual.getmFechInicio());
        this.mDiaDelMes = xObjMensual.mDiaDelMes;
        this.mFechPago = xObjMensual.mFechPago;
        this.mPeriodo = xObjMensual.mPeriodo;
    }
    
            
    @Override
    public String TipFechPag() {
        return "Mensual";
    }

    @Override
    public Date getFechPago() {
        return mFechPago;
    }

    @Override
    public int getMesDelAño() {
        return 0;
    }

    @Override
    public int getDiaDelMes() {
        return mDiaDelMes;
    }

    @Override
    public boolean dentroRango() {
        return mPeriodo;
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
    public LogN_ClassAb_FechPag duplicar() {
        return new Dom_Class_FechPMensual(this);
    }

    @Override
    public boolean duplicado(LogN_ClassAb_FechPag xObjCop) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
 
    
}
