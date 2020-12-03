/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;

/**
 *
 * @author ary
 */
public interface  LogN_Inter_ManejMoneda {

    public ArrayList<Dom_Class_Moneda> listarMondeda ();
    
    public void altaMoneda (Dom_Class_Moneda xObjMoneda, boolean xLocal) throws InputException;
    
    public void bajaMoneda (Dom_Class_Moneda xObjMoneda)throws InputException;
    
    public void modiMoneda (Dom_Class_Moneda xObjMonedaAn, Dom_Class_Moneda xObjMonedaNu)throws InputException;
    
    public Dom_Class_Moneda getMonedaLoc();
    
    public void setMonedaLocal (Dom_Class_Moneda xObjMoneda)throws InputException;
    
    public Dom_Class_Moneda getMoneda(int NumM);
    
    public void addObservadorMoneda(Observer xObjObser);
    
    public void removObservadorMoneda(Observer xObjObser);
    
    
    
    
}
