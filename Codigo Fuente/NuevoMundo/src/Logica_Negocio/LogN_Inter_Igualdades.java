/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

/**
 * <pre>
 *<b><font color="red">Identificar valores repetidos</b></font>
 *Interfaces común para aquellos objetos que necesitar representa
 * el nombre de los valores que no se pueden repetir.
 *</pre>
 * @author ary
 */
public interface LogN_Inter_Igualdades <T> {

    /**
     *
     * <b><font color="blue">Igualdades no permitidas </b></font><br>
     * Método encargado de retornar lo valores que se repiten de y que no están permitidos.
     *
     * @param xObjComparado Objeto con el cual se compara
     * @return Array de String conteniendo el nombre de valores que que se repiten
     */
    public String[] getIgualInva (T xObjCoparado);

}
