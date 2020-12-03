/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistencia;

/**
 *
 * @author ary
 */
public class Per_Class_ConecElPam extends Per_ClassAb_Coneccion {

    public Per_Class_ConecElPam() {
        super("jdbc:mysql://localhost:3306/ElPam", "root", "admin", "");
    }


}
