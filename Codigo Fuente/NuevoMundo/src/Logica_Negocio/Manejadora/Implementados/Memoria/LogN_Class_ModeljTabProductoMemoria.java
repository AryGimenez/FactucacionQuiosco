/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.Memoria;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author horacio
 */
public class LogN_Class_ModeljTabProductoMemoria extends LogN_ClassAb_ModeljTabProd{
      //Atributos_________________________________________________________________
    private ArrayList <Dom_Class_ProductoComp> mDatos;
    private ArrayList <Dom_Class_ProductoComp>  mTodoDatos;
    private ArrayList <Dom_Class_ProductoComp> mDatoFiltrado;
    private String [] mTitel = {"Codigo", "Nombre", "Categoria", "Pre.Cost", "Pre.Venta", "Stok", "Stok Min"};
    private int mrowIndes = -1;
    private Dom_Class_ProductoComp mObjProSel;
    //Constructor_______________________________________________________________

    public LogN_Class_ModeljTabProductoMemoria (AbstractCollection<Dom_Class_ProductoComp> mColProd){
        this.mTodoDatos = new ArrayList<Dom_Class_ProductoComp>(mColProd);
        this.mDatos = mTodoDatos;
        final LogN_Inter_Filtrar xObjFil = new LogN_Inter_Filtrar(){

            public Class getCalse() {
                return this.getClass();
            }

            public Object filtrar(Object ObjAFil) {
                return ObjAFil;
            }

            public ArrayList filtar(AbstractCollection ColAFil) {
                return (ArrayList) ColAFil;
            }

            public Object getmCondicion() {
                return " ";
            }

            public short getmPocicion() {
                return (short) 1;
            }

            public void setmPocicion(short mPocicion) throws InputException {

            }

            public void setmCondicion(Object ObjCon) throws InputException {
                throw new UnsupportedOperationException("Not supported yet.");
            }

            @Override
            public String[] getNomPocicion() {
                throw new UnsupportedOperationException("Not supported yet.");
            }

        };
//        setFlitro();
    }

    public LogN_Class_ModeljTabProductoMemoria (AbstractCollection<Dom_Class_ProductoComp> mDatos, LogN_Inter_Filtrar mObjFil){
//        setFlitro();
        this.addRow(mDatos);
    }

    //Metodos___________________________________________________________________

    @Override
    public String getColumnName(int column) {
        return mTitel [column];
    }

    public int getRowCount() {
        return mDatos.size();
    }

    public int getColumnCount() {
        return mTitel.length;
    }

    public Dom_Class_ProductoComp getPord(int rowIndes){
        if ( rowIndes != mrowIndes){
            mrowIndes = rowIndes;
            mObjProSel = mDatos.get(rowIndes);
        }
        return mObjProSel;
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Dom_Class_ProductoComp ObjProd = getPord(rowIndex);
        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjProd.getmProd_Cod(); break;
            case 1: Respuesta = ObjProd.getMProd_Nom(); break;
            case 2: Respuesta = ObjProd.getmObjCat(); break;
            case 3: Respuesta = ObjProd.getMProd_PrecCosto(); break;
            case 4: Respuesta = ObjProd.getMProd_PrecVenta(); break;
            case 5: Respuesta = ObjProd.getMProd_Stock(); break;
            case 6: Respuesta = ObjProd.getMProd_StockMinimo(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
//        Dom_Class_ProductoComp ObjProdAn = getPord(rowIndex);
//        Dom_Class_ProductoComp ObjProdNu = new Dom_Class_ProductoComp(ObjProdAn);
//        switch (columnIndex){
//            //CodigoProd
//            case 0: ; break;
//            //NomProd
//            case 1: ObjProdNu.setMProd_Nom((String)aValue);break;
//            //Catogoria
//            case 2:
//                Dom_Class_Categoria ObjCat;
//                try{
//                    ObjCat = (Dom_Class_Categoria) aValue;
//                }catch (ClassCastException Es){
//                    return;
//                }
//                ObjProdNu.setmObjCat(ObjCat);
//            break;
//            case 3: ObjProdNu.setMProd_PrecCosto(((Number)aValue).floatValue());break;
//            case 4: ObjProdNu.setMProd_PrecVenta(((Number)aValue).floatValue());break;
//            case 5: ObjProdNu.setMProd_Stock(((Number)aValue).intValue());break;
//            case 6: ObjProdNu.setMProd_StockMinimo(((Number)aValue).intValue());break;
//            default:return;
//        }
//        try {
//            LogN_Class_Fachada.getInstancia().modificarPored(ObjProdAn, ObjProdNu);
//        } catch (InputException ex) {
//            Logger.getLogger(LogN_ClassAb_ModeljTabProd.class.getName()).log(Level.SEVERE, null, ex);
//        }


    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return true;
    }

    private void addRow (Object o){
        mDatos.add((Dom_Class_ProductoComp) getFiltro().filtrar(o));
        if (mDatos != mTodoDatos)mTodoDatos.add((Dom_Class_ProductoComp) o);
    }

    private void addRow (AbstractCollection O){
        mDatos = getFiltro().filtar(O);
    }

    public void update(Observable o, Object arg) {

        LogN_Class_Accion<Dom_Class_ProductoComp> ObjAxProd = (LogN_Class_Accion<Dom_Class_ProductoComp>) arg;
        int numFil = this.mDatos.indexOf(ObjAxProd.getmAccionar()) ;

        switch (ObjAxProd.mAccionActual){
            case LogN_Class_Accion.Agreger:
                addRow(ObjAxProd.getmAccionar());
                numFil = this.mDatos.indexOf(ObjAxProd.getmAccionar()) ;
                if (numFil == -1) return;
                this.fireTableRowsInserted(numFil, numFil);
            break;
            case LogN_Class_Accion.Eliminar:
                if (numFil == -1)return;
                mDatos.remove(ObjAxProd.getmAccionar());
                mTodoDatos.remove(ObjAxProd);
                this.fireTableRowsDeleted(numFil, numFil);
            break;
            case LogN_Class_Accion.Modificar:
                if (numFil != -1) this.fireTableRowsUpdated(numFil, numFil);
            break;
        }
    }

    @Override
    public ArrayList<LogN_ClassAb_Producto> listarProducto() {
        return new ArrayList<LogN_ClassAb_Producto>(mDatos);
    }




}
