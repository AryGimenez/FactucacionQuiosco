/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona;

import Logica_Negocio.Filtros.Persona.LogN_Inter_FiltPersona;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabPer;
import Persistencia.Per_Class_ConecElPam;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Observer;



/**
 *
 * @author horacio
 */
public abstract  class LogN_ClassAb_ModeljTabPersonaMySql extends LogN_ClassAb_ModeljTabPer implements Observer{

    //Atributos_________________________________________________________________
    private int filas = -1;
    protected Per_Class_ConecElPam mObjMYsql = new Per_Class_ConecElPam();
    protected Statement state ;
    protected ResultSet rec;
    
    //Construcor________________________________________________________________
    public LogN_ClassAb_ModeljTabPersonaMySql(LogN_Inter_FiltPersona xObjFiltro) {
        actualizar();
        setFlitro(xObjFiltro);

    }
    
    //Operacioes________________________________________________________________
    @Override
    public int getColumnCount() {
        return 8;
    }

    protected abstract void actualizar ();

    protected String TraducirFlitro (){
//        LogN_Inter_FiltPersona ObjFil = getFiltro();
//
//         if (ObjFil == null) return "";
//          String Condicion = "";
//          
//         if (ObjFil instanceof LogN_ClassAb_FiltrarStringProducto){
//             switch (ObjFil.getmPocicion()){
//                 case LogN_ClassAb_FiltrarStringProducto.Completa : Condicion = "¬¬# = '" + ObjFil.getmCondicion() + "'"; break;
//                 case LogN_ClassAb_FiltrarStringProducto.Final: Condicion = "¬¬# like '%" + ObjFil.getmCondicion() + "'"; break;
//                 case LogN_ClassAb_FiltrarStringProducto.Principio: Condicion = "¬¬# like '" + ObjFil.getmCondicion() + "%'"; break;
//                 case LogN_ClassAb_FiltrarStringProducto.No_Completa: Condicion = "¬¬# like '%" + ObjFil.getmCondicion() + "%'"; break;
//
//             }
//
//             if (ObjFil instanceof LogN_Class_FiltProdCod)Condicion = Condicion.replace ("¬¬#", "Pro_Cod");
//             else if (ObjFil instanceof LogN_Class_FiltProdNom) Condicion = Condicion.replace ("¬¬#", "Pro_Nom");
//             else if (ObjFil instanceof LogN_Class_FiltProCat) Condicion = Condicion.replace ("¬¬#", "Cat_Nom");
//             
//         }else if (ObjFil instanceof LogN_Class_FiltProdStokMin){
//             Condicion = "Pro_Stok ¬¬# Pro_StokMin";
//             if (ObjFil.getmPocicion() == LogN_Class_FiltProdStokMin.EN_STOK_MIN) Condicion = Condicion.replace ("¬¬#", "<=");
//             else if (ObjFil.getmPocicion() == LogN_Class_FiltProdStokMin.NO_EN_STOK_MIN) Condicion = Condicion.replace ("¬¬#", ">");
//
//         }else if (ObjFil instanceof  LogN_Class_FiltProdCod){
//
//             Condicion = "Pro_CodIn = " + ObjFil.getmCondicion();
//
//         }else if (ObjFil instanceof  LogN_Class_FiltProdCodBarr){
//
//             Condicion = "Pro_CodBar = '" + ObjFil.getmCondicion() + "'";
//         
//         }
//
//          if (ObjFil.getTipProd() == LogN_ClassAb_FiltrarStringProducto.Producto) return Condicion;
//
//          if(!Condicion.equals("")){
//             Condicion += " AND";
//          }
//
//          Condicion += " Tipo = ";
//
//          switch (ObjFil.getTipProd()){
//              case LogN_ClassAb_FiltrarStringProducto.ProductoCom:
//                  Condicion += " 'Pro.Compuesto'";
//              break;
//              case LogN_ClassAb_FiltrarStringProducto.SubProducto:
//                  Condicion += " 'Sub.Producto'";
//              break;
//
//          }
//
//
//         return Condicion ;
        return "";
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
    	Object x = null;
        if (r < 0)return null;
    	try {
            rec.absolute(r+1);
            if (c == 2){
                Integer i = (Integer) rec.getObject(c+1);
                switch (i){
                    case LogN_ClassAb_Persona.TipDoc_CdulaIdentidad: 
                        x = "Ci";
                    break;
                    case LogN_ClassAb_Persona.TipDoc_DNI:
                        x = "DNI";
                    break;
                    case LogN_ClassAb_Persona.TipDoc_Pasaporte:
                        x = "Pasaporte";
                    break;
                }
            } else x = rec.getObject(c+1);

    	}
        catch (SQLException e){}
        if (x == null) x = "";
    	return x;
    }
    
    @Override
    public String getColumnName(int c) {
    	String nom="";
       	switch(c){
            case 0: nom="Numero"; break;
            case 1: nom="Rason Sicial"; break;
            case 2: nom="Tio. Doc."; break;
            case 3: nom="Num. Doc";break;
            case 4: nom="Rut"; break;
            case 5: nom="Pais"; break;
            case 6: nom="Prov./Dep."; break;
            case 7: nom="Localidad"; break;
       	}
       	return nom;
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if (rowIndex == 0) return false;
        return true;
        
    }

    public boolean setSizeColumnsToFit(){
    	return false;
    }
    
    @Override
    public abstract LogN_ClassAb_Persona getPer(int rowIndes);

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
//        LogN_ClassAb_Persona ObjProdAn = getPer(rowIndex);
//        LogN_ClassAb_Persona ObjProdNu = ObjProdAn.duplicar();
//        try{
//            switch (columnIndex){
//            //NomProd
//                case 1: ObjProdNu.setmNum(((Number)aValue).intValue());break;
//            //Catogoria
//                case 2:
//                    
//                break;
//                case 3: ObjProdNu.setProd_CodBarr(aValue.toString());break;
//                case 4: ObjProdNu.setMProd_PrecVenta(((Number)aValue).floatValue());break;
//                default:return;
//            }
//        
//            LogN_Class_Fachada.getInstancia().modificarPord(ObjProdAn, ObjProdNu);
//
//
//        Object OO = getValueAt(rowIndex, columnIndex);
//        OO = getValueAt(rowIndex, columnIndex);
//        OO = getValueAt(rowIndex, columnIndex);
//
//       super.fireTableRowsUpdated(rowIndex, rowIndex);
//        } catch (InputException ex) {
//            Logger.getLogger(LogN_ClassAb_ModeljTabProd.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        
//
    }

     @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }
     
    @Override
    public ArrayList<LogN_ClassAb_Persona> listarPersona() {
        ArrayList <LogN_ClassAb_Persona> ColProd = new ArrayList<LogN_ClassAb_Persona>();
        for (int i = 0 ; i < getRowCount() ; i++) {
            ColProd.add(getPer(i));
        }

        return ColProd;
    }
    
    @Override
    public void setFlitro(LogN_Inter_FiltPersona xObjFil) {
        super.setFlitro(xObjFil);
        actualizar();
    }
    



}
