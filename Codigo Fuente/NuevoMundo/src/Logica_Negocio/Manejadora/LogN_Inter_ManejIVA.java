/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_ManejIVA {
    
    public ArrayList<Dom_Class_IVA> listarIVA();
    
    public Dom_Class_IVA getIVA (float pPorcentaje) throws InputException;
    
    public Dom_Class_IVA getIVA (int pNum) throws InputException;
}
