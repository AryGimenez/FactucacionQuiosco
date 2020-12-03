/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Precentacion.LogN_Class_Accion;
import java.util.Observable;

/**
 *
 * @author ary
 */
public class LogN_Class_ObsevadoAuxiliar <T> extends Observable{
    //Atributos_________________________________________________________________
    private T mObjObservado;
    private LogN_Class_Accion mObjAccion;

    public LogN_Class_ObsevadoAuxiliar (T Objservado){
        this.mObjObservado = Objservado;
    }

    public LogN_Class_Accion getmObjAccion() {
        return mObjAccion;
    }

    public void setmObjAccion(LogN_Class_Accion mObjAccion) {
        this.mObjAccion = mObjAccion;
    }

    public T getmObjObservado() {
        return mObjObservado;
    }

    public void Notifiar(Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }




}
