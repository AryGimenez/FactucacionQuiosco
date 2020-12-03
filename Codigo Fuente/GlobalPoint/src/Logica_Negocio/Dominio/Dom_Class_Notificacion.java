/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio;

import Logica_Negocio.LogN_Inter_Validar;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Observable;

/**
 *
 * @author ary
 */
public final class Dom_Class_Notificacion extends Observable implements LogN_Inter_Validar {
    //Atributos_________________________________________________________________
    /**
     * Nombre de atributo
     */
    private String mNom;

 
    /**
     * Detalle
     */
    private String mDetalle;
    /**
     * Fecha y hora para notificar
     */
    private Date mFechNot;

    private int mNum;

    public Dom_Class_Notificacion(String mNom, String mDetalle, Date mFechNot, int mNum) {
        this.mFechNot = mFechNot;
        setmDetalle(mDetalle);
        setmNom(mNom);
        this.mNum = mNum;
    }
    public Dom_Class_Notificacion(String mNom, String mDetalle, Date mFechNot) {
        this(mNom, mDetalle, mFechNot, -1);
    }

    
    // Constructor______________________________________________________________
    
    public String getmDetalle() {
        return mDetalle;
    }

    public void setmDetalle(String mDetalle) {
        this.mDetalle = mDetalle.trim();
    }

    public Date getmFechNot() {
        return mFechNot;
    }

    public void setmFechNot(Date mFechNot) {
        this.mFechNot = mFechNot;
    }

    public String getmNom() {
        return mNom;
    }

    public void setmNom(String mNom) {
        this.mNom = mNom.trim();
    }

    public void validar() throws InputException {
        if (!Util_Class_Utilitario.ValidarString(mNom))throw new InputException("No a ingresado un nombre de "
                + "notificación o a ingresado uno no valido");

        if (mFechNot == null)throw new InputException("No a ingresado una fecha  de "
                + "notificación o a ingresado uno no valido");

    }

    @Override
    public String toString() {
       SimpleDateFormat sdf = new SimpleDateFormat("EE dd-MM-yy");

        return sdf.format(mFechNot) + " " +  mNom;
    }

}
