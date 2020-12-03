/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio;

import Logica_Negocio.LogN_Inter_Validar;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author ary
 */
public class Dom_Class_Mesa1 implements LogN_Inter_Validar {
    private int mNumMesa;

    public Dom_Class_Mesa1(int mNumMesa) {
        this.mNumMesa = mNumMesa;
    }

    public int getNumMesa(){
        return mNumMesa;
    }

    @Override
    public String toString() {
        return "Mesa: " + mNumMesa;
    }

    public void validar() throws InputException {

    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Dom_Class_Mesa1 other = (Dom_Class_Mesa1) obj;
        if (this.mNumMesa != other.mNumMesa) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + this.mNumMesa;
        return hash;
    }

    public void setNumMesa(int i) {
        mNumMesa = i;
    }
    

}
