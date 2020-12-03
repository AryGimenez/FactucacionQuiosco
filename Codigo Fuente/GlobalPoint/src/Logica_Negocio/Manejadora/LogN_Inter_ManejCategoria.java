/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;


/**
 *
 * @author ary
 */
public interface LogN_Inter_ManejCategoria{

    public void consCategoria (String nomCat)throws InputException;

    public void altaCategoria (Dom_Class_Categoria xObjCat)throws InputException;

    public void bajaCategoria (String NomCat)throws InputException;

    public void bajaCategoria (Dom_Class_Categoria xObjCat)throws InputException;

    public void modificarCategoria (Dom_Class_Categoria xObjCatAn, Dom_Class_Categoria xObjCatNu)throws InputException;

    public void modifcarCategoria (String NomCatAn, String NomCatNu)throws InputException;

    public boolean existeCat(Dom_Class_Categoria xObjCategoria);

    public boolean existeCat (String NomCat);

    public ArrayList <Dom_Class_Categoria> listarCat ();
    
    public Dom_Class_Categoria getCategoria (String NomCat);

    public Dom_Class_Categoria getCategoria (Dom_Class_Categoria xObjCat);

    public Dom_Class_Categoria RetornarOCrearCategoria (String NomCat) throws InputException;

    public Dom_Class_Categoria RetornarOCrarCategoria (Dom_Class_Categoria xobjCat) throws InputException;

    public boolean addObservadorCategoria(Observer xObj);

    public boolean removObservadorCategoria(Observer xObj);

}
