/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Filtros.Persona;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_FiltPersona<T> extends LogN_Inter_Filtrar<LogN_ClassAb_Persona,T> {
    
    public short getTipPer ();
    
    public void setTipPer (short xTipProd)throws InputException;
    
}
