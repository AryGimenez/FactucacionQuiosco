/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Utilidades;

/**
 *
 * @author Ary
 */
public class Util_Class_CompararStringAcendente implements Util_Inter_CompararString {


    
    public int compare(Object o1, Object o2) {

        return o1.toString().toLowerCase().compareTo(o2.toString().toLowerCase());
    }


}
