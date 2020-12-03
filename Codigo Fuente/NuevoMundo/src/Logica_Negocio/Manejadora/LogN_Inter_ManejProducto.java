/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Dominio.Dom_Class_ProductoElavo;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;

/**
 *
 * @author ary
 */
public interface LogN_Inter_ManejProducto {

    public void altaProductoCom (Dom_Class_ProductoComp xObjProduto)throws InputException;

    public void altaSubProducto(Dom_Class_SubProducto xObjSubP) throws InputException;
    
    public void altaProductoElav (Dom_Class_ProductoElavo xObjProdElav) throws InputException;
    
    public boolean bajaProducto (LogN_ClassAb_Producto xObjProducto) throws InputException;

    public ArrayList <Dom_Class_ProductoComp> listarProducto ();
    
    public ArrayList <Dom_Class_ProductoComp> listarProStokMin()throws InputException;

    public boolean existeCanEnPro (Dom_Class_Categoria xObjCat);

    public void addObservadorProducto (Observer xObjObser);

    public void removObservadorProducto (Observer xObjObser);

    public void modificarPord(LogN_ClassAb_Producto xObjProdAn, LogN_ClassAb_Producto xObjProdNue) throws InputException ;
    
    public void modificarProdCom (Dom_Class_ProductoComp xObjProdNu, Dom_Class_ProductoComp xObjProdAn) throws InputException;
    
    public void modificarSubProducto (Dom_Class_SubProducto xObjProdNu, Dom_Class_SubProducto xObjProdAn) throws InputException;
    
    public void modificarProdElav (Dom_Class_ProductoElavo xObjProdNu, Dom_Class_ProductoElavo xObjProdAn) throws InputException;
    
    public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_FlitPorducto xObjFiltro);

    public int getNumProd ();
    
    public Dom_Class_ProductoComp getProdCom(int xNumP) throws InputException;

    public Dom_Class_SubProducto getSubProd(int xNumP) throws InputException;
    
    public Dom_Class_ProductoElavo getProdElav (int xNumP) throws InputException;
    
    
    public void asignarSubProd (Dom_Class_ProductoComp xObjProdCom)throws InputException;

    public LogN_ClassAb_Producto getProducot(int  xNumP) throws InputException;
    
    public String existeCodBarProd(int xCodPro, String xCodBarr);
}
