/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.Memoria;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Dominio.Dom_Class_ProductoElavo;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.Manejadora.LogN_Inter_ManejProducto;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import Precentacion.LogN_Class_AccionTostring;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;


/**
 *
 * @author ary
 */
public class LogN_Class_ManejProductoMemoria extends Observable implements LogN_Inter_ManejProducto, Observer{

    //Atributuso________________________________________________________________
   
    private ArrayList<Dom_Class_ProductoComp> mColProd = new ArrayList<Dom_Class_ProductoComp>();
    
    private ArrayList<Dom_Class_ProductoComp> mColProdStokM = new ArrayList<Dom_Class_ProductoComp>();
    
    
    //Metodos___________________________________________________________________




    public void altaProducto(Dom_Class_ProductoComp xObjProduto) throws InputException {
        xObjProduto.validar();
        if (mColProd.contains(xObjProduto)) throw  new InputException("El producto ingresado ya existe en el sistema");
        mColProd.add(xObjProduto);
        Notivicar(new LogN_Class_Accion<Dom_Class_ProductoComp>(LogN_Class_Accion.Agreger, xObjProduto));
    }

    public boolean bajaProducto(Dom_Class_ProductoComp xObjProducto) {
        if (mColProd.remove(xObjProducto)){ //Si lo pudo eliminar
            Notivicar(new LogN_Class_Accion<Dom_Class_ProductoComp>(LogN_Class_Accion.Eliminar, xObjProducto));
            return true;
        }

        return false;
    }

    public ArrayList<Dom_Class_ProductoComp> listarProducto() {
        return new ArrayList<Dom_Class_ProductoComp>(mColProd);
    }

    public ArrayList <Dom_Class_ProductoComp> listarProStokMin() {
        return new ArrayList<Dom_Class_ProductoComp>(mColProdStokM);
    }

    public boolean existeCanEnPro(Dom_Class_Categoria xObjCat) {
        for (Dom_Class_ProductoComp ObjProd : mColProd){
            if (ObjProd.getmObjCat().equals(xObjCat)) return true;
        }
        return false;
    }

    public void addObservadorProducto (Observer xObjObser){
        super.addObserver(xObjObser);
    }

    public void removObservadorProducto (Observer xObjObser){
        super.deleteObserver(xObjObser);
    }

    private void Notivicar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }

    public void modificarPored (Dom_Class_ProductoComp xObjProdAn, Dom_Class_ProductoComp xObjProdNue) throws InputException{
        xObjProdAn = getProducot (xObjProdAn);

        if(xObjProdAn == null)throw new InputException("El producto a modificar no existe en el sistema");

        if (!xObjProdAn.equals(xObjProdNue) && mColProd.contains(xObjProdNue)) throw new InputException ("El nuevo producto a modificar ya existe en le sistema");

        String toString = xObjProdAn.toString();

        xObjProdAn.Modificar(xObjProdNue);
    
        if (toString.equals(xObjProdAn.toString())){ //Determina que se modifico los datos que componen el tostring
            Notivicar(new LogN_Class_Accion <Dom_Class_ProductoComp>(LogN_Class_Accion.Modificar, xObjProdAn));
        } else{
            Notivicar(new LogN_Class_AccionTostring<Dom_Class_ProductoComp>(LogN_Class_AccionTostring.Modificar, xObjProdAn));
        }
    }

    public void update(Observable o, Object arg) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public Dom_Class_ProductoComp getProducot(Dom_Class_ProductoComp xObjPord) {
        int Pos = mColProd.indexOf(xObjPord);
        if (Pos == -1) return null;
        return mColProd.get(Pos);
    }

     public void sumarStockProducto(Dom_Class_ProductoComp xObjProd, int xValor ) throws InputException{
         xObjProd = getProducot(xObjProd);

         if (xObjProd == null) throw new InputException("El producto a restar stock no existe en el sistema");
         
         xObjProd.sumarStock(xValor);

         Notivicar(new LogN_Class_AccionTostring<Dom_Class_ProductoComp>(LogN_Class_Accion.Modificar,xObjProd));
     }

     public void restarStockProducto(Dom_Class_ProductoComp xObjProd, int xValor ) throws InputException{
         xObjProd = getProducot(xObjProd);

         if (xObjProd == null) throw new InputException("El producto a sumar stock no existe en el sistema");

         xObjProd.restarStock(xValor);
         Notivicar(new LogN_Class_AccionTostring<Dom_Class_ProductoComp>(LogN_Class_Accion.Modificar,xObjProd));
     }

    public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_Filtrar xObjFiltro) {
        LogN_Class_ModeljTabProductoMemoria Model;
        if (xObjFiltro == null) Model = new LogN_Class_ModeljTabProductoMemoria(listarProducto());
        else Model = new LogN_Class_ModeljTabProductoMemoria(mColProd, xObjFiltro);
        addObservadorProducto(Model);
        return Model;
    }

    @Override
    public void altaProductoCom(Dom_Class_ProductoComp xObjProduto) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void altaSubProducto(Dom_Class_SubProducto xObjSubP) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean bajaProducto(LogN_ClassAb_Producto xObjProducto) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void modificarPord(LogN_ClassAb_Producto xObjProdAn, LogN_ClassAb_Producto xObjProdNue) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void modificarProdCom(Dom_Class_ProductoComp xObjProdNu, Dom_Class_ProductoComp xObjProdAn) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void modificarSubProducto(Dom_Class_SubProducto xObjProdNu, Dom_Class_SubProducto xObjProdAn) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    
    @Override
    public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_FlitPorducto xObjFiltro) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int getNumProd() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_ProductoComp getProdCom(int xNumP) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_SubProducto getSubProd(int xNumP) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void asignarSubProd(Dom_Class_ProductoComp xObjProdCom) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_Producto getProducot(int xNumP) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String existeCodBarProd(int xCodPro, String xCodBarr) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void altaProductoElav(Dom_Class_ProductoElavo xObjProdElav) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void modificarProdElav(Dom_Class_ProductoElavo xObjProdNu, Dom_Class_ProductoElavo xObjProdAn) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_ProductoElavo getProdElav(int xNumP) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }










}
