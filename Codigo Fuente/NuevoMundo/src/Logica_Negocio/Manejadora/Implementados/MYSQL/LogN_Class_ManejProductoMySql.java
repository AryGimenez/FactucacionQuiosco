/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.*;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.LogN_Inter_ManejProducto;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.LogN_Class_ModeljTabProductoMySql;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author horacio
 */
public class LogN_Class_ManejProductoMySql extends Observable implements LogN_Inter_ManejProducto{

    private Per_Class_ConecElPam mObjMySql  = new Per_Class_ConecElPam();

    @Override
    public void altaProductoCom(Dom_Class_ProductoComp xObjProducto) throws InputException {
        xObjProducto.validar();

        java.sql.PreparedStatement Ps;

        try {
            Ps = mObjMySql .AbrirConection().prepareStatement
                    ("SELECT Fuc_AltaProdCom ( ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            
            Ps.setString(1,xObjProducto.getMProd_Nom());
            Ps.setString(2,xObjProducto.getMProd_Desc());
            Ps.setString(3, xObjProducto.getProd_CodBarr());
            Ps.setDouble(4,xObjProducto.getMProd_PrecVenta());
            Ps.setInt(5, xObjProducto.getmObjCat().getCat_Num());
            
            Ps.setDouble(6,xObjProducto.getMProd_StockMinimo());
            Ps.setDouble(7,xObjProducto.getMProd_PrecCosto());
            Ps.setInt(8,xObjProducto.Tipo_Stok);
            Ps.setInt(9, xObjProducto.getIVA().getmNum());
            


            ResultSet rs = Ps.executeQuery();
            rs.next();
            rs.getInt(1);

            xObjProducto.setmProd_Cod(rs.getInt(1));

            for (Dom_Class_SubProducto ObjSp : xObjProducto.getmColSubProd()){
                this.altaSubProducto(ObjSp);
            }

            mObjMySql .closeConecction();

            Notificar(new LogN_Class_Accion<Dom_Class_ProductoComp>(LogN_Class_Accion.Agreger, xObjProducto));
        } catch (SQLException ex) {
           // throw new InputException("Ha ingresado un código o nombre de producto ya existente.");
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally {
            mObjMySql .closeConecction();
        }

    }
    
    @Override
    public void altaSubProducto(Dom_Class_SubProducto xObjSubP) throws InputException {
        xObjSubP.validar();

        java.sql.PreparedStatement Ps;

        try {
            Ps = mObjMySql .AbrirConection().prepareStatement
                    ("SELECT Fuc_AltaSubPro ( ?, ?, ?, ?, ?, ?)");


            Ps.setString(1,xObjSubP.getMProd_Nom());
            Ps.setString(2,xObjSubP.getMProd_Desc());
            Ps.setString(3, xObjSubP.getProd_CodBarr());
            Ps.setDouble(4,xObjSubP.getMProd_PrecVenta());
            Ps.setInt(5,xObjSubP.getmObjProd().getmProd_Cod());
            Ps.setFloat(6, xObjSubP.getmUnidadStok());
            
            
            ResultSet rs = Ps.executeQuery();
            rs.next();
            rs.getInt(1);

            xObjSubP.setmProd_Cod(rs.getInt(1));

            mObjMySql .closeConecction();

            Notificar(new LogN_Class_Accion<>(LogN_Class_Accion.Agreger, xObjSubP));
        } catch (SQLException ex) {
           // throw new InputException("Ha ingresado un código o nombre de producto ya existente.");
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally {
            mObjMySql .closeConecction();
        }

    }
    
    private void updateSupbProd (Dom_Class_ProductoComp xObjProAn, Dom_Class_ProductoComp xObjProdNu) throws InputException{
        ArrayList <Dom_Class_SubProducto> ColSubPAn = new ArrayList<>(xObjProAn.getmColSubProd());
        ArrayList <Dom_Class_SubProducto> ColSubPNu = new ArrayList<>(xObjProdNu.getmColSubProd());
        
        for (Dom_Class_SubProducto ObjSubPNu : ColSubPNu){
            int Pos = ColSubPAn.indexOf(ObjSubPNu);
            
            if (Pos == -1){
                this.altaSubProducto(ObjSubPNu);    
            }else {
                Dom_Class_SubProducto ObjSubPAn = ColSubPAn.get(Pos);
                if (!ObjSubPAn.duplicado(ObjSubPNu)) this.modificarSubProducto(ObjSubPAn, ObjSubPNu);
                ColSubPAn.remove(Pos);
            }
            
            
        }
        
        for (Dom_Class_SubProducto ObjSubP : ColSubPAn){
            this.bajaProducto(ObjSubP);
        }
    }
    
    @Override
    public boolean bajaProducto(LogN_ClassAb_Producto xObjProducto) throws InputException {
         Statement s;
        try {
            s = (Statement) mObjMySql .AbrirConection().createStatement();
            s.executeUpdate("DELETE FROM `Producto` WHERE `Pro_CodIn` = " + xObjProducto.getmProd_Cod()); 
            Notificar(new LogN_Class_Accion<>(LogN_Class_Accion.Eliminar, xObjProducto));
        } catch (SQLException ex) {
            return false;
        }
         return true;
    }

    @Override
    public ArrayList<Dom_Class_ProductoComp> listarProducto() {


    ArrayList<Dom_Class_ProductoComp> ColProd = new ArrayList<>();

          try{
              Statement s = (Statement) mObjMySql.AbrirConection().createStatement();

              ResultSet Rs = s.executeQuery("SELECT * FROM `Viw_ProductoCom` ");

              while (Rs.next()){
                    Dom_Class_IVA xObjIva = new Dom_Class_IVA(Rs.getString("IVA_Nom"), (float) Rs.getDouble("IVA_Pors"));
                    xObjIva.setmNum(Rs.getInt("IVA_Num"));

                    Dom_Class_Categoria ObjCat = LogN_Class_Fachada.getInstancia().getCategoria(
                     new Dom_Class_Categoria(
                        Rs.getString("Cat_Nom"),
                        Rs.getInt("Cat_Num")));

                    Dom_Class_ProductoComp ObjProd = new Dom_Class_ProductoComp(Rs.getInt("ProCom_CodIn"), Rs.getString("ProCom_Nom"), Rs.getString("ProCom_Descr"),
                     Rs.getString("ProCom_CodBar"), (float)Rs.getDouble("ProCom_PreCom"), (float) Rs.getDouble("ProCom_PreVen"), (float)Rs.getDouble("ProCom_StokMin"),
                     ObjCat, Rs.getInt("ProCom_TipStok"), xObjIva);

                    ObjProd.setStok((float)Rs.getDouble("ProCom_Stok"));
                    
                    ColProd.add(ObjProd);
              }
              for (Dom_Class_ProductoComp ObjProd: ColProd){
                
                  try {
                    this.asignarSubProd(ObjProd);
                } catch (InputException ex) {
                    
                }
              }


        } catch (SQLException ex) {
            return null;
        }finally{
             mObjMySql .closeConecction();
        }
          
        return ColProd;
    }

    @Override
    public boolean existeCanEnPro(Dom_Class_Categoria xObjCat) {
         try {
            Statement s = (Statement) mObjMySql .AbrirConection().createStatement();

            ResultSet Rs = s.executeQuery("select COUNT(*) from `Articulo` WHERE `Cat_Id` = '" + xObjCat.getCat_Num() + "'");
            Rs.next();
            if (Rs.getInt(1) > 0) return true;
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejCategoriaMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMySql .closeConecction();
        }
        return false;
    }

    @Override
    public void addObservadorProducto(Observer xObjObser) {
        super.addObserver(xObjObser);
    }

    @Override
    public void removObservadorProducto(Observer xObjObser) {
        this.deleteObserver(xObjObser);
    }

    @Override
    public LogN_ClassAb_Producto getProducot(int  xNumP) throws InputException {
        LogN_ClassAb_Producto Respesta = null ;
        Respesta = getProdCom(xNumP);
        if (Respesta == null) Respesta = getSubProd(xNumP);

        return Respesta;
    }

    @Override
    public Dom_Class_ProductoComp getProdCom(int xNumP) throws InputException{
        Dom_Class_ProductoComp Respuesta= null;
          try{

              Statement s = (Statement) mObjMySql.AbrirConection().createStatement();

              ResultSet Rs = s.executeQuery("select * from `Viw_ProductoCom` WHERE `ProCom_CodIn` = " +xNumP);

              if (Rs.next()){
                    Dom_Class_IVA xObjIva = new Dom_Class_IVA(Rs.getString("IVA_Nom"), (float) Rs.getDouble("IVA_Pors"));
                    xObjIva.setmNum(Rs.getInt("IVA_Num"));

                    Dom_Class_Categoria ObjCat = LogN_Class_Fachada.getInstancia().getCategoria(
                     new Dom_Class_Categoria(
                        Rs.getString("Cat_Nom"),
                        Rs.getInt("Cat_Num")));

                    Dom_Class_ProductoComp ObjProd = new Dom_Class_ProductoComp(Rs.getInt("ProCom_CodIn"), Rs.getString("ProCom_Nom"), Rs.getString("ProCom_Descr"),
                     Rs.getString("ProCom_CodBar"), (float)Rs.getDouble("ProCom_PreCom"), (float) Rs.getDouble("ProCom_PreVen"), (float)Rs.getDouble("ProCom_StokMin"),
                     ObjCat, Rs.getInt("ProCom_TipStok"), xObjIva);

                    ObjProd.setStok((float)Rs.getDouble("ProCom_Stok"));
                    this.asignarSubProd(ObjProd);
                    Respuesta = ObjProd;
              }
              
        } catch (SQLException ex) {
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
        return Respuesta;
    }

    @Override
    public Dom_Class_SubProducto getSubProd(int xNumP) throws InputException{
      Dom_Class_SubProducto Respuesta= null;
          try{
              Statement s = (Statement) mObjMySql.AbrirConection().createStatement();

              ResultSet Rs = s.executeQuery("SELECT `SubP_CodIn`, `ProCom_CodIn` FROM SubProducto WHERE `SubP_CodIn` =" +xNumP);

              if(Rs.next()){
                  Dom_Class_ProductoComp ObjProdCom = this.getProdCom(Rs.getInt("ProCom_CodIn"));
                  Respuesta = ObjProdCom.getSutProd(xNumP);
              }
          } catch (SQLException ex) {
              throw new InputException(""+ ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
        return Respuesta;
    }

    @Override
    public void asignarSubProd (Dom_Class_ProductoComp xObjProdCom)throws InputException{

          try{
              Statement s = (Statement) mObjMySql.AbrirConection().createStatement();

              ResultSet Rs = s.executeQuery("SELECT * FROM `Viw_SubProducto` WHERE `ProCom_CodIn` = " + xObjProdCom.getmProd_Cod());

              while (Rs.next()){
                  Dom_Class_SubProducto ObjSubProd = new Dom_Class_SubProducto
                          (Rs.getInt("SubP_CodIn"), Rs.getString("SubP_Nom"), Rs.getString("SubP_Descr"),
                     Rs.getString("SubP_CodBar"), (float) Rs.getDouble("SubP_PreVen"), 
                          xObjProdCom, Rs.getFloat("SubP_UnidadStok"));
                  xObjProdCom.altaSubProd(ObjSubProd);
              }

          } catch (SQLException ex) {
              throw new InputException(""+ ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
    }
    
    @Override
    public void modificarPord(LogN_ClassAb_Producto xObjProdAn, LogN_ClassAb_Producto xObjProdNue) throws InputException {
        if(!xObjProdAn.getClass().equals(xObjProdNue.getClass())) 
            throw new InputException("No se puede modificar un producto con un subproducto e viceversa ");
        else if (xObjProdAn instanceof Dom_Class_ProductoComp)
            modificarProdCom((Dom_Class_ProductoComp)xObjProdAn, (Dom_Class_ProductoComp)xObjProdNue);
        else if(xObjProdAn instanceof Dom_Class_SubProducto)
            modificarSubProducto((Dom_Class_SubProducto)xObjProdAn, (Dom_Class_SubProducto)xObjProdNue);
        
    }
    
    @Override
    public void modificarProdCom (Dom_Class_ProductoComp xObjProdAn, Dom_Class_ProductoComp xObjProdNu) throws InputException{

        this.updateSupbProd(xObjProdAn, xObjProdNu);
        xObjProdAn.Modificar(xObjProdNu);
        java.sql.PreparedStatement Ps;

        try {
            Ps = mObjMySql .AbrirConection().prepareStatement
                    ("CALL Pro_ModifProdCom  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            Ps.setInt(1, xObjProdAn.getmProd_Cod());
            Ps.setString(2,xObjProdNu.getMProd_Nom());
            Ps.setString(3,xObjProdNu.getMProd_Desc());
            Ps.setString(4, xObjProdNu.getProd_CodBarr());
            Ps.setDouble(5,xObjProdNu.getMProd_PrecVenta());
            Ps.setInt(6, xObjProdNu.getmObjCat().getCat_Num());
            
            Ps.setDouble(7,xObjProdNu.getMProd_StockMinimo());
            Ps.setDouble(8,xObjProdNu.getMProd_PrecCosto());
            Ps.setInt(9,xObjProdNu.Tipo_Stok);
            Ps.setInt(10, xObjProdNu.getIVA().getmNum());
            
            Ps.execute();
            
            
            mObjMySql.closeConecction();

            Notificar(new LogN_Class_Accion<>(LogN_Class_Accion.Modificar, xObjProdAn));
        } catch (SQLException ex) {
           // throw new InputException("Ha ingresado un código o nombre de producto ya existente.");
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally {
            mObjMySql .closeConecction();
        }

    }
    
    @Override
    public void modificarSubProducto (Dom_Class_SubProducto xObjProdAn, Dom_Class_SubProducto xObjProdNu) throws InputException{
        xObjProdAn.Modificar(xObjProdNu);
        java.sql.PreparedStatement Ps;

        try {
            Ps = mObjMySql .AbrirConection().prepareStatement
                    ("CALL Pro_ModifSubProd  ( ?, ?, ?, ?, ?, ?)");

            Ps.setInt(1, xObjProdAn.getmProd_Cod());
            Ps.setString(2,xObjProdNu.getMProd_Nom());
            Ps.setString(3,xObjProdNu.getMProd_Desc());
            Ps.setString(4, xObjProdNu.getProd_CodBarr());
            Ps.setDouble(5,xObjProdNu.getMProd_PrecVenta());
            Ps.setFloat(6, xObjProdNu.getmUnidadStok());
            
            Ps.execute();
            mObjMySql.closeConecction();

            Notificar(new LogN_Class_Accion<>(LogN_Class_Accion.Modificar, xObjProdAn));
        } catch (SQLException ex) {
           // throw new InputException("Ha ingresado un código o nombre de producto ya existente.");
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally {
            mObjMySql .closeConecction();
        }
    }
   
    @Override
    public ArrayList<Dom_Class_ProductoComp> listarProStokMin() throws InputException {
        ArrayList<Dom_Class_ProductoComp> ColProd = new ArrayList<>();

          try{
              Statement s = (Statement) mObjMySql.AbrirConection().createStatement();

              ResultSet Rs = s.executeQuery("SELECT * FROM `Viw_ProductoCom` WHERE `ProCom_StokMin` > `ProCom_Stok`");

              while (Rs.next()){
                    Dom_Class_IVA xObjIva = new Dom_Class_IVA(Rs.getString("IVA_Nom"), (float) Rs.getDouble("IVA_Pors"));
                    xObjIva.setmNum(Rs.getInt("IVA_Num"));
                    
                    Dom_Class_Categoria ObjCat = LogN_Class_Fachada.getInstancia().getCategoria(
                            new Dom_Class_Categoria(
                    Rs.getString("Cat_Nom"),
                    Rs.getInt("Cat_Num")));

                    Dom_Class_ProductoComp ObjProd = new Dom_Class_ProductoComp(Rs.getInt("ProCom_CodIn"), Rs.getString("ProCom_Nom"), Rs.getString("ProCom_Descr"),
                            Rs.getString("ProCom_CodBar"), (float)Rs.getDouble("ProCom_PreCom"), (float) Rs.getDouble("ProCom_PreVen"), (float)Rs.getDouble("ProCom_StokMin"),
                            ObjCat, Rs.getInt("ProCom_TipStok"), xObjIva);

                    ObjProd.setStok((float)Rs.getDouble("ProCom_Stok"));

                    ColProd.add(ObjProd);
              }
              for (Dom_Class_ProductoComp ObjProd: ColProd){
                this.asignarSubProd(ObjProd);
              }


        } catch (SQLException ex) {
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
        return ColProd;
    }

    private void Notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }

    @Override
    public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_FlitPorducto xObjFiltro) {

        LogN_Class_ModeljTabProductoMySql ObjP = new LogN_Class_ModeljTabProductoMySql(xObjFiltro);
        this.addObservadorProducto(ObjP);
        LogN_Class_Fachada.getInstancia().addObservadorMovimiento(ObjP);
        return ObjP;
    }

    @Override
    public int getNumProd() {
        try {
            Statement s = (Statement) mObjMySql .AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select * from Viw_NumProd");
            Rs.next();
            return Rs.getInt(1);

        } catch (SQLException ex) {
            return 1;
        }
    }
    
    @Override
    public String existeCodBarProd(int xCodPro, String xCodBarr){
        String Respuesta = "";
        xCodBarr = xCodBarr.trim();
        
        if (xCodBarr.equals("")) return "";// Comprueba que el codigo de barra no sea una cadena basia.
        
        try {
            Statement s = (Statement) mObjMySql .AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select `Pro_CodIn` from ElPam.Producto WHERE `Pro_CodBar` = '"+ xCodBarr +"'");
            while (Rs.next()){
                int NumPro = Rs.getInt(1);
                if (NumPro != xCodPro){
                    if (!Respuesta.equals("")) Respuesta += ", ";
                    Respuesta += NumPro;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejProductoMySql.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Respuesta;
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
