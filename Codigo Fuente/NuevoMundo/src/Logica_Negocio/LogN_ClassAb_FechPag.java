/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio;

import Logica_Negocio.MiExepcion.InputException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author horacio
 */
public abstract class LogN_ClassAb_FechPag implements
        LogN_Inter_Validar, LogN_Inter_Duplicado<LogN_ClassAb_FechPag> 
{
    // Atributos________________________________________________________________
    private int mIntervalo, mAviso;
    private Date mFechInicio;
    
    // Metodos _________________________________________________________________

    public LogN_ClassAb_FechPag(int mIntervalo, int mAviso, Date mFechInicio) {
        this.mIntervalo = mIntervalo;
        this.mAviso = mAviso;
        this.mFechInicio = mFechInicio;
    }
    
    public abstract String TipFechPag ();
    
    public int getAviso() {
        return mAviso;
    }

    public void setAviso(int Aviso) {
        this.mAviso = Aviso;
    }

    public int getmIntervalo() {
        return mIntervalo;
    }

    public void setmIntervalo(int mIntervalo) {
        this.mIntervalo = mIntervalo;
    }
    
    public Date getmFechInicio() {
        return mFechInicio;
    }

    public void setmFechInicio(Date mFechInicio) {
        this.mFechInicio = mFechInicio;
    }
    
    public abstract Date getFechPago ();
    
    public abstract int getMesDelAño();
    
    public abstract int getDiaDelMes();

    @Override
    public void validar() throws InputException {
        if (mIntervalo < 1) 
            throw new InputException("El intervalo no puede ser menor a 1");
        if (mAviso < 0) 
            throw new InputException ("El Avoso no puede ser menor a 0");
    }
    
    public abstract boolean dentroRango ();
    
    public long getDifDias (){
        Date FechHoy = new Date();
        
        
        
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(mFechInicio);
        long diferencia = (FechHoy.getTime() - calendar.getTime().getTime()) 
                / 24 * 60 * 60 * 1000;
        
        return diferencia;
    }
    /**
     * Calcula y retorna la distancia entre la fecha de inicio “(mFechInicio) a 
     * la fecha del sistema (fecha de hoy)
     * @return 
     */
    public int getDifMes(){
        Calendar FechIni = new GregorianCalendar();
        FechIni.setTime(mFechInicio);
        Calendar FechHoy = new GregorianCalendar();
        
        int AñoIn, MesIn, AñoHoy, MesHoy, ResAño;
        
        AñoIn = FechIni.get(Calendar.YEAR);
        MesIn = FechIni.get(Calendar.MONTH);
        
        AñoHoy = FechHoy.get(Calendar.YEAR);
        MesHoy = FechHoy.get(Calendar.MONTH);
        
        ResAño = AñoIn - AñoHoy;
        
        if (ResAño == 0)
            return  MesHoy - MesIn;
        
        return ((ResAño - 1) * 12) + MesIn - 12 + MesHoy;
    }
}


