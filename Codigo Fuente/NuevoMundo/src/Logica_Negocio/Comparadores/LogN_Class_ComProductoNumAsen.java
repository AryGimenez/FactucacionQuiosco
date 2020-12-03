/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Comparadores;

import Logica_Negocio.LogN_ClassAb_Producto;

/**
 *
 * @author ary
 * */
public class LogN_Class_ComProductoNumAsen implements LogN_Inter_ComProducto {

    @SuppressWarnings("unchecked")
	public int compare(LogN_ClassAb_Producto o1, LogN_ClassAb_Producto o2) {
        return o2.getmProd_Cod() - o1.getmProd_Cod();
    }

}
