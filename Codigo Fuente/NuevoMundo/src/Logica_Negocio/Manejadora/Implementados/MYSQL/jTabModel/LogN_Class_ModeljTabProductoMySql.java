/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.MYSQL.jTabModel;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Filtros.Producto.LogN_ClassAb_FiltrarStringProducto;
import Logica_Negocio.Filtros.Producto.LogN_Class_FiltProdCod;
import Logica_Negocio.Filtros.Producto.LogN_Class_FiltProdCodBarr;
import Logica_Negocio.Filtros.Producto.LogN_Class_FiltProdNom;
import Logica_Negocio.Filtros.Producto.LogN_Class_FiltProdStokMin;
import Logica_Negocio.Filtros.Producto.LogN_Class_FiltProCat;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author horacio
 */
public class LogN_Class_ModeljTabProductoMySql extends LogN_ClassAb_ModeljTabProd{

    //Atributos_________________________________________________________________
    private int filas = -1;
    private Per_Class_ConecElPam mObjMYsql = new Per_Class_ConecElPam();
    private Statement state ;
    private ResultSet rec;
    private LogN_Class_Fachada mObjFach = LogN_Class_Fachada.getInstancia();


    public LogN_Class_ModeljTabProductoMySql(LogN_Inter_FlitPorducto xObjFiltro) {
        actualizar();
        setFlitro(xObjFiltro);

    }


    private void actualizar (){
                try {
                    mObjMYsql.closeConecction();
                    String Con = this.TraducirFlitro();
                    if (!Con.equals("")) Con = " WHERE " + Con;
                    state = mObjMYsql.AbrirConection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    rec = state.executeQuery("SELECT Pro_CodIn, Pro_Nom, Cat_Nom, Pro_CodBar,"
                            + " Pro_PreVen, Pro_Stok, Tipo FROM ElPam.Viw_Producto" + Con);
                    super.fireTableDataChanged();
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ModeljTabProductoMySql.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String TraducirFlitro (){
        LogN_Inter_FlitPorducto ObjFil = getFiltro();

         if (ObjFil == null) return "";
          String Condicion = "";
          
         if (ObjFil instanceof LogN_ClassAb_FiltrarStringProducto){
             switch (ObjFil.getmPocicion()){
                 case LogN_ClassAb_FiltrarStringProducto.Completa : Condicion = "¬¬# = '" + ObjFil.getmCondicion() + "'"; break;
                 case LogN_ClassAb_FiltrarStringProducto.Final: Condicion = "¬¬# like '%" + ObjFil.getmCondicion() + "'"; break;
                 case LogN_ClassAb_FiltrarStringProducto.Principio: Condicion = "¬¬# like '" + ObjFil.getmCondicion() + "%'"; break;
                 case LogN_ClassAb_FiltrarStringProducto.No_Completa: Condicion = "¬¬# like '%" + ObjFil.getmCondicion() + "%'"; break;

             }

             if (ObjFil instanceof LogN_Class_FiltProdCod)Condicion = Condicion.replace ("¬¬#", "Pro_Cod");
             else if (ObjFil instanceof LogN_Class_FiltProdNom) Condicion = Condicion.replace ("¬¬#", "Pro_Nom");
             else if (ObjFil instanceof LogN_Class_FiltProCat) Condicion = Condicion.replace ("¬¬#", "Cat_Nom");
             
         }else if (ObjFil instanceof LogN_Class_FiltProdStokMin){
             Condicion = "Pro_Stok ¬¬# Pro_StokMin";
             if (ObjFil.getmPocicion() == LogN_Class_FiltProdStokMin.EN_STOK_MIN) Condicion = Condicion.replace ("¬¬#", "<=");
             else if (ObjFil.getmPocicion() == LogN_Class_FiltProdStokMin.NO_EN_STOK_MIN) Condicion = Condicion.replace ("¬¬#", ">");

         }else if (ObjFil instanceof  LogN_Class_FiltProdCod){

             Condicion = "Pro_CodIn = " + ObjFil.getmCondicion();

         }else if (ObjFil instanceof  LogN_Class_FiltProdCodBarr){

             
             switch (ObjFil.getmPocicion()){
                 case LogN_Class_FiltProdCodBarr.Completa : Condicion = "Pro_CodBar = '" + ObjFil.getmCondicion() + "'"; break;
                 case LogN_Class_FiltProdCodBarr.Final: Condicion = "Pro_CodBar like '%" + ObjFil.getmCondicion() + "'"; break;
                 case LogN_Class_FiltProdCodBarr.Principio: Condicion = "Pro_CodBar like '" + ObjFil.getmCondicion() + "%'"; break;
                 

             }
         
         }

          if (ObjFil.getTipProd() == LogN_ClassAb_FiltrarStringProducto.Producto) return Condicion;

          if(!Condicion.equals("")){
             Condicion += " AND";
          }

          Condicion += " Tipo = ";

          switch (ObjFil.getTipProd()){
              case LogN_ClassAb_FiltrarStringProducto.ProductoCom:
                  Condicion += " 'Pro.Compuesto'";
              break;
              case LogN_ClassAb_FiltrarStringProducto.SubProducto:
                  Condicion += " 'Sub.Producto'";
              break;

          }


         return Condicion ;
    }

    @Override
    public int getRowCount() {
       
        	try {
                    rec.last();
                    this.filas=rec.getRow();
        	}
                catch (SQLException e) {}
     
        return filas;
    }

    @Override
    public Object getValueAt(int r, int c) {
    	Object x=null;
    	try {
            rec.absolute(r+1);
            x = rec.getObject(c+1);

    	}
        catch (SQLException e){}
    	return x;
    }

    @Override
    public int getColumnCount(){
        return  7;
    }

    @Override
    public String getColumnName(int c) {
    	String nom="";
       	switch(c){
            case 0: nom="Codigo"; break;
            case 1: nom="Nombre"; break;
            case 2: nom="Categoria"; break;
            case 3: nom="Cod. Barra";break;
            case 4: nom="Pre.Venta"; break;
            case 5: nom="Stock"; break;
            case 6: nom="Tipo"; break;
       	}
       	return nom;
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if(columnIndex == 2 && (!this.getValueAt(rowIndex, 6).toString().equals("Producto"))) return false;
        else if(columnIndex < 1 || columnIndex > 4) return false;
        return true;
    }


    public boolean setSizeColumnsToFit(){
    	return false;
    }


    
    
    @Override
    public LogN_ClassAb_Producto getPord(int rowIndes) {
        LogN_ClassAb_Producto ObjProd = null;
        try {
            rec.absolute(rowIndes+1);
            ObjProd = mObjFach.getProducot(rec.getInt("Pro_CodIn"));
        }
        catch (SQLException e){

        }catch (InputException ex){

        }

        return ObjProd;
    }

     @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
        LogN_ClassAb_Producto ObjProdAn = getPord(rowIndex);
        LogN_ClassAb_Producto ObjProdNu = (LogN_ClassAb_Producto) ObjProdAn.duplicar();
        try{
            switch (columnIndex){
            //NomProd
                case 1: ObjProdNu.setMProd_Nom((String)aValue);break;
            //Catogoria
                case 2:
                    Dom_Class_Categoria ObjCat;
                    try{
                        ObjCat = (Dom_Class_Categoria) aValue;
                    }catch (ClassCastException Es){
                        return;
                    }
                    ObjProdNu.setmObjCat(ObjCat);
                break;
                case 3: ObjProdNu.setProd_CodBarr(aValue.toString());break;
                case 4: ObjProdNu.setMProd_PrecVenta(((Number)aValue).floatValue());break;
                default:return;
            }
        
            LogN_Class_Fachada.getInstancia().modificarPord(ObjProdAn, ObjProdNu);


        Object OO = getValueAt(rowIndex, columnIndex);
        OO = getValueAt(rowIndex, columnIndex);
        OO = getValueAt(rowIndex, columnIndex);

       super.fireTableRowsUpdated(rowIndex, rowIndex);
        } catch (InputException ex) {
            Logger.getLogger(LogN_ClassAb_ModeljTabProd.class.getName()).log(Level.SEVERE, null, ex);
        }
        
//
    }

     @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    public void update(Observable o, Object arg) {
        if (! (arg instanceof  LogN_Class_Accion)) return ;
        LogN_Class_Accion<Object> ObjA = (LogN_Class_Accion) arg;

        if (!(ObjA.getmAccionar() instanceof LogN_ClassAb_Producto ||
                ObjA.getmAccionar() instanceof LogN_ClassAb_Movimiento)) return;

                this.actualizar();
                  
        }

    @Override
    public ArrayList<LogN_ClassAb_Producto> listarProducto() {
        ArrayList <LogN_ClassAb_Producto> ColProd = new ArrayList<LogN_ClassAb_Producto>();
        for (int i = 0 ; i < getRowCount() ; i++) {
            ColProd.add(getPord(i));
        }

        return ColProd;
    }

    @Override
    public void setFlitro(LogN_Inter_FlitPorducto xObjFil) {
        super.setFlitro(xObjFil);
        actualizar();
    }
    
    

}
