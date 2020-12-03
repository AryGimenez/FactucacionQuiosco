/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Dominio;

import Logica_Negocio.LogN_Class_ValorMoneda;
import java.util.Date;

/**
 *
 * @author horacio
 */
public class Dom_Class_Caja {
    // Atributos________________________________________________________________
    private Dom_Class_Moneda mObjMoneda;
    
    private float mMontoInicial;
    
    private Date mFechInicio;
    
    private String mResInicio;
    
    private float mMontoFin;
    
    private Date mFechFin;
    
    private String mResFin;
    
    private float mMontoActual;
    
    private Date mFechActual;
    
    private float mRestoEnCaja;
    
    private boolean mAbiertaCaja;
    
    //Constructor_______________________________________________________________
            
    public Dom_Class_Caja(Dom_Class_Moneda mObjMoneda, float mMontoInicial, Date mFechInicio, String mResInicio) {
        this.mObjMoneda = mObjMoneda;
        this.mMontoInicial = mMontoInicial;
        this.mFechInicio = mFechInicio;
        this.mMontoActual = mMontoInicial;
        this.mFechActual = mFechInicio;
        this.mResInicio =  mResInicio;
        this.mAbiertaCaja = true;
    }

    public Dom_Class_Caja(Dom_Class_Moneda mObjMoneda, Date mFechInicio, float mMontoIni,
            String mResIni, float mMontoFin, Date mFechFin, float mRestoEnCaja, String mResFin) {
        
        this.mObjMoneda = mObjMoneda;
        
        this.mFechInicio = mFechInicio;
        this.mMontoInicial = mMontoIni;
        this.mResInicio =  mResIni;
        
        this.mMontoFin = mMontoFin;
        this.mFechFin = mFechFin;
        this.mResFin = mResFin;
        
        this.mRestoEnCaja = mRestoEnCaja;
        
        this.mAbiertaCaja = false;
    }
    
    public Date getmFechActual() {
        return mFechActual;
    }

    public Date getmFechFin() {
        return mFechFin;
    }

    public Date getmFechInicio() {
        return mFechInicio;
    }

    public float getmMontoActual() {
        return mMontoActual;
    }

    public float getmMontoFin() {
        return mMontoFin;
    }

    public float getmMontoInicial() {
        return mMontoInicial;
    }

    public Dom_Class_Moneda getmObjMoneda() {
        return mObjMoneda;
    }

    public boolean ismAbiertaCaja() {
        return mAbiertaCaja;
    }

    public float getmRestoEnCaja() {
        return mRestoEnCaja;
    }

    public String getmResFin() {
        return mResFin;
    }

    public String getmResInicio() {
        return mResInicio;
    }

    @Override
    public String toString() {
        String mRespuesta = "";
        if (mAbiertaCaja){
            mRespuesta = "Abierta / Por: " + mResInicio + "  Con el Monto: " + 
                    mObjMoneda.getSim() + mMontoInicial +  " / Fecha Hora: " ;
        }
        return mRespuesta;
    }
}
