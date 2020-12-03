/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.MiExepcion.InputException;
import java.util.Observer;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_ManejMovimiento {

    public int getNumMovimiento();

    public void altaMovimiento(LogN_ClassAb_Movimiento xObjMov) throws InputException;
    
    public void addObservadorMovimiento(Observer xObjObser);
    
    public void removObservadorMovimiento(Observer xObjObser);
    
}
