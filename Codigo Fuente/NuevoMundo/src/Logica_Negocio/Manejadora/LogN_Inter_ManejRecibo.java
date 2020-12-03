/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_Resibo;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;

/**
 *
 * @author horacio
 */
public interface LogN_Inter_ManejRecibo {
    
    public void altaRecibo (Dom_Class_Resibo xObjRecibo)throws InputException;
    
    public ArrayList<Dom_Class_Resibo> listarRecibos ()throws InputException;
    
    public Dom_Class_Resibo getResibo (int xNumR)throws InputException; 
    
    public int getNumRecibo()throws InputException;
    
    
}
