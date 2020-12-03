/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion;



/**
 *
 * @author ary
 */
public  class  LogN_Class_Accion <T> {
    public static final int Modificar = 0;
    public static final int Eliminar = 1;
    public static final int Agreger = 2;
    public final int mAccionActual;

    private final T mAccionar;

    public T getmAccionar() {
        return mAccionar;
    }

    public LogN_Class_Accion (int mAccionActual, T mAccion){
        this.mAccionar = mAccion;
        this.mAccionActual = mAccionActual;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() == obj.getClass()){
            final LogN_Class_Accion<T> other = (LogN_Class_Accion<T>) obj;
            if (!this.mAccionar.equals(other.mAccionar)) return false;
        } else if  (mAccionar.getClass() == obj.getClass()){
            if(!mAccionar.equals(obj)) return false;
        } else {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + (this.mAccionar != null ? this.mAccionar.hashCode() : 0);
        return hash;
    }
    
    

}
