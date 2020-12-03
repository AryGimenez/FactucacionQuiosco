/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora;

import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;

/**
 *Interfaz que administra los reportes comunes en el sistema es decir aquillos informe que no pertenece a producto, 
 * personas, etc. Si no a varios en el sistema como puede ser la cuentas que involucra los Recibos la factura Etc.
 * @author Ary
 */
public interface LogN_Inter_ManejReportComun {
    
    public LogN_ClassAb_ModeljTabCuentas getModeljTabCuentas ();
}
