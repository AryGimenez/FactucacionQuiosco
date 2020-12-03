/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;


/**
 *
 * @author horacio
 */
public interface  LogN_Inter_ManejPais {

    public ArrayList<Dom_Class_Pais> listarPais ();

    public void altaPais (Dom_Class_Pais xObjPais)throws InputException;

    public void modifPais (Dom_Class_Pais xObjPaisAn, Dom_Class_Pais xObjPaNu)throws InputException;

    public void bajaPais (Dom_Class_Pais xObjPais) throws InputException;

    public void altaProvDep (Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep)throws InputException;

    public void modiProvDep (Dom_Class_ProvinDepar xObjProvDepAn, Dom_Class_ProvinDepar xObjProvDepNu) throws InputException;

    public void bajaProvDep (Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep ) throws InputException;

    public Dom_Class_Pais getPais (int xNumP);

    public Dom_Class_ProvinDepar getProvDep (int xNumProvDep);

    public void addObservadorPais (Observer xObjObservador);
    
    public void removObservadorPais(Observer xObjObser);
    
}
