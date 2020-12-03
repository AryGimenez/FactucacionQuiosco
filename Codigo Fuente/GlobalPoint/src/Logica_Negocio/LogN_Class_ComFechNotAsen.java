/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Dom_Class_Notificacion;
import Utilidades.Util_Class_CompararFecha;


/**
 *
 * @author ary
 */
public class LogN_Class_ComFechNotAsen extends LogN_ClassAb_ComFechNot {

    public int compare(Dom_Class_Notificacion o1, Dom_Class_Notificacion o2) {
        Util_Class_CompararFecha Comparador = new Util_Class_CompararFecha();
        return Comparador.compare(o1.getmFechNot(), o2.getmFechNot());
    }
}
