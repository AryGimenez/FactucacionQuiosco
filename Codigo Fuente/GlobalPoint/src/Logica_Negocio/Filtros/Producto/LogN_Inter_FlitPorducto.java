/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros.Producto;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_FlitPorducto <A> extends LogN_Inter_Filtrar<LogN_ClassAb_Producto, A> {
    
    public short getTipProd();

    public void setTipProd (short xTipProd)throws InputException;




}
