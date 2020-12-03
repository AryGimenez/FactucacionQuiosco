/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion;

/**
 *
 * @author ary
 */
public class CompararStringDesendente implements CompararString {

    public int compare(Object o1, Object o2) {
        Object o3 = o2;
        o2 = o1;
        o1 = o3;
        return o1.toString().toLowerCase().compareTo(o2.toString().toLowerCase());
    }

}
