/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.MiExepcion.InputException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ary
 */
public class LogN_Class_PaisActual {
    private static LogN_Class_PaisActual instancia;
    private Dom_Class_Pais mObjPais;


    public static LogN_Class_PaisActual getInstancia() {
        if (instancia == null) {
            CrearInstancia();
        }

        return instancia;
    }

    private synchronized static void CrearInstancia() {
        if (instancia == null) {
            instancia = new LogN_Class_PaisActual();
        }
    }

    private LogN_Class_PaisActual (){
        mObjPais = new Dom_Class_Pais("Uruguay");
        try {
            mObjPais.altaProvDep("Salto");
            mObjPais.altaProvDep("Montevideo");
        } catch (InputException ex) {
            Logger.getLogger(LogN_Class_PaisActual.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Dom_Class_Pais getPais (){
        return mObjPais;
    }

}
