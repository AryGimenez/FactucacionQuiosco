/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Filtros.Factura;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_Factura;


/**
 *
 * @author Ary
 */
public interface LogN_Inter_FiltFactura <T> extends LogN_Inter_Filtrar<LogN_ClassAb_Factura, T> {
    public boolean getTipFac ();
    
    public void setTipFac (boolean xTipFac);
}
