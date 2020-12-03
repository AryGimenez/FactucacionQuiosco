/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Memoria;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.LogN_Inter_ManejCategoria;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;



/**
 *Manejadora categoría en memoria
 *Los datos en esta manejadora están persistido totalmente en memoria
 * @author ary
 */
public class LogN_Class_ManejCategoriaMemoria extends Observable implements LogN_Inter_ManejCategoria{
    //Atributos_________________________________________________________________

    public ArrayList<Dom_Class_Categoria> mColCat = new ArrayList<Dom_Class_Categoria>();

    //Metodos___________________________________________________________________

    public void consCategoria(String NomCat) throws InputException {
        this.altaCategoria(new Dom_Class_Categoria(NomCat));
    }

    public void altaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
        xObjCat.validar();
        if (mColCat.contains(xObjCat)) throw new InputException("La categoría ingresada ya existe");
        mColCat.add(xObjCat);
        Notificar(new LogN_Class_Accion<Dom_Class_Categoria> (LogN_Class_Accion.Agreger, xObjCat));
    }

    public void bajaCategoria(String NomCat) throws InputException {
        bajaCategoria(new  Dom_Class_Categoria(NomCat));
    }

    public void bajaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
        xObjCat = getCategoria(xObjCat);
        if (xObjCat == null) throw new InputException("La categoría ingresada no existe en el sistema.");
        if (LogN_Class_Fachada.getInstancia().existeCanEnPro(xObjCat)) throw new InputException("La categoría no se puede eliminar /n"+
                "Verifique que la misma no este relacionara un producto ");
        mColCat.remove(xObjCat);
        Notificar(new LogN_Class_Accion<Dom_Class_Categoria>(LogN_Class_Accion.Eliminar, xObjCat));

    }

    public void modificarCategoria(Dom_Class_Categoria xObjCatAn, Dom_Class_Categoria xObjCatNu) throws InputException {
        
         Dom_Class_Categoria ObjCatSis = this.getCategoria(xObjCatNu);

        if (ObjCatSis == null) throw new InputException("La categoría a modificar no existe en el sistema");


        if (!ObjCatSis.equals(xObjCatNu) && existeCat(xObjCatNu)) throw new InputException("No se puede modificar la categoria ya "
                + "que el nuevo nombre de la categoría ya existe ");

        ObjCatSis.modificar(xObjCatNu);

        Notificar(new LogN_Class_Accion<Dom_Class_Categoria>(LogN_Class_Accion.Modificar, ObjCatSis) );
        
    }

    public void modifcarCategoria(String NomCatAn, String NomCatNu) throws InputException {
        this.modificarCategoria(new Dom_Class_Categoria(NomCatAn), new Dom_Class_Categoria(NomCatNu));
    }

    public boolean existeCat(Dom_Class_Categoria xObjCategoria) {
        return mColCat.contains(xObjCategoria);
    }

    public boolean existeCat(String NomCat) {
        return this.existeCat(new Dom_Class_Categoria(NomCat));
    }

    public ArrayList<Dom_Class_Categoria> listarCat() {
        return new ArrayList<Dom_Class_Categoria>(mColCat);
    }

    public Dom_Class_Categoria getCategoria (String NomCat){
        return getCategoria(new Dom_Class_Categoria(NomCat));
    }

    public Dom_Class_Categoria getCategoria (Dom_Class_Categoria xObjCat){

        try {
            xObjCat.validar();
        } catch (InputException ex) {
            return null;
        }

        int pocicion  = mColCat.indexOf(xObjCat);

        if (pocicion == -1 )return null;

        return  mColCat.get(pocicion);


    }

    public Dom_Class_Categoria RetornarOCrearCategoria (String NomCat) throws InputException{
        return this.RetornarOCrarCategoria(new Dom_Class_Categoria(NomCat));
    }

    public Dom_Class_Categoria RetornarOCrarCategoria (Dom_Class_Categoria xobjCat) throws InputException{
        xobjCat.validar();
        Dom_Class_Categoria ObjCat =  this.getCategoria(xobjCat);

        if (ObjCat != null) return ObjCat;

        this.altaCategoria(xobjCat);

        return xobjCat;
    }

    public boolean addObservadorCategoria(Observer xObj) {
         addObserver(xObj);
         return true;
    }

    public boolean removObservadorCategoria(Observer xObj){
         super.deleteObserver(xObj);
         return true;
    }

    private void Notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }



}
