/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros;

import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;

/**
 *
 * @author ary
 */
public interface LogN_Inter_Filtrar<T, A> {
    
    public short getmPocicion();

    public void setmPocicion(short mPocicion)throws InputException;
    
    public String[] getNomPocicion();

    public void setmCondicion(A ObjCon)throws InputException;

    public A getmCondicion();

    public Class<T> getCalse ();

    public T filtrar (T ObjAFil);
    
    public ArrayList<T> filtar(AbstractCollection <T> ColAFil);
}
