/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Model.jTabel;

import Logica_Negocio.Comparadores.LogN_Class_ComProductoNumAsen;
import Logica_Negocio.Comparadores.LogN_Class_ComProductoNumDes;
import Logica_Negocio.Comparadores.LogN_Inter_ComProducto;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Observable;
import java.util.Observer;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author ary
 */
public class ModeljTabSubProd extends AbstractTableModel implements Observer{


//Atributos_________________________________________________________________
    public static final int OrdenarPorCodAcen = 0;
    public static final int OrdenarProCodDese = 1;
    public static final int SinOrden = 2;

    private int mOrdenAc;

    private LogN_Inter_ComProducto mObjComP;

    private ArrayList <Dom_Class_SubProducto> mDatos;
    private String [] mTitel = {"Código ", "Nombre", "Cod. Barra", "Pre. Ven"};
    private LogN_Inter_Filtrar mObjFiltro;
    //Constructor_______________________________________________________________

    public ModeljTabSubProd (AbstractCollection<Dom_Class_SubProducto> mColProd, int mOrdenA){
        this.mDatos = new ArrayList<Dom_Class_SubProducto>(mColProd);

        mObjFiltro = new LogN_Inter_Filtrar(){

            public Class getCalse() {
                return mObjFiltro.getCalse();
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
        this.setOrdAc(mOrdenA);
    }


    public ModeljTabSubProd (AbstractCollection<LogN_ClassAb_LineaFac> mDatos, LogN_Inter_Filtrar mObjFil, int mOrdenA){
        this.mObjFiltro = mObjFil;
        this.addRow(mDatos);
        this.setOrdAc(mOrdenA);
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

    public Dom_Class_SubProducto getValue(int rowIndes){
        try{
            return mDatos.get(rowIndes);
        }catch(ArrayIndexOutOfBoundsException ex){
            return null;
        }
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Dom_Class_SubProducto ObjSubProd = getValue(rowIndex);
        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjSubProd.getmProd_Cod(); break;
            case 1: Respuesta = ObjSubProd.getMProd_Nom(); break;
            case 2: Respuesta = ObjSubProd.getProd_CodBarr(); break;
            case 3: Respuesta = ObjSubProd.getMProd_PrecVenta(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {

            Dom_Class_SubProducto SubProd = getValue(rowIndex);

            switch (columnIndex) {
            //Catogoria
                case 1:
                    SubProd.setMProd_Nom(aValue.toString());
                    break;
                case 2:
                    SubProd.setProd_CodBarr(aValue.toString());
                    break;
                case 3:
                    SubProd.setMProd_PrecVenta(Float.parseFloat(aValue.toString()));
                    break;
                default:
                    return;
            }
            super.fireTableRowsUpdated(rowIndex, rowIndex);
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if (columnIndex >= 1  ) return true;
        return false;
    }

    public void addRow (Object o){
        Dom_Class_SubProducto ObjSubP = (Dom_Class_SubProducto) mObjFiltro.filtrar(o);
        if (ObjSubP == null) return;
        if (mOrdenAc == SinOrden) mDatos.add(ObjSubP);
        else addEnOrden(ObjSubP);
    }
    
    public void addEnOrden (Dom_Class_SubProducto xObjSub){
         int CanEl = mDatos.size();
         for (int Con = 0; Con < CanEl; Con ++ ){

             int res = mObjComP.compare(xObjSub, mDatos.get(Con));

            if (res >= 0){
              insertElementAt(Con , xObjSub);
              return;
            }
        }
         if(CanEl == 0) insertElementAt(0,xObjSub);
         else if (CanEl == mDatos.size()) insertElementAt(++CanEl, xObjSub);
    }

    public void addRow (AbstractCollection O){
        mDatos = mObjFiltro.filtar(O);
    }

    private void insertElementAt(int xPos, Dom_Class_SubProducto xObjSubP){
        if(xPos >= mDatos.size()){
            mDatos.add(xObjSubP);
            xPos = mDatos.size() - 1;
        }else mDatos.add(xPos, xObjSubP);
        
        super.fireTableRowsInserted(xPos, xPos);
    }


    public void update(Observable o, Object arg) {
//        try{
//            LogN_Class_Accion<LogN_ClassAb_LineaFac> ObjAxProd = (LogN_Class_Accion<LogN_ClassAb_LineaFac>) arg;
//            int numFil = this.mDatos.indexOf(ObjAxProd.getmAccionar()) ;
//
//            switch (ObjAxProd.mAccionActual){
//                case LogN_Class_Accion.Agreger:
//                    addRow(ObjAxProd.getmAccionar());
//                    numFil = this.mDatos.indexOf(ObjAxProd.getmAccionar()) ;
//                    if (numFil == -1) return;
//                    this.fireTableRowsInserted(numFil, numFil);
//                break;
//                case LogN_Class_Accion.Eliminar:
//                    if (numFil == -1)return;
//                    mDatos.remove(ObjAxProd.getmAccionar());
//                    this.fireTableRowsDeleted(numFil, numFil);
//                break;
//                case LogN_Class_Accion.Modificar:
//                    if (numFil != -1) this.fireTableRowsUpdated(numFil, numFil);
//                break;
//            }
//        }catch (ClassCastException ex){
//
//
//        }

    }

    public void setDatos(ArrayList<Dom_Class_SubProducto> mColSubP) {
        mDatos.clear();
        mDatos.addAll(mColSubP);
        super.fireTableStructureChanged();
    }

    public ArrayList<Dom_Class_SubProducto> getDatos (){
        return new ArrayList<Dom_Class_SubProducto>(mDatos);
    }

    public boolean setOrdAc (int mOrdA) {
        switch (mOrdA){
            case 0:
                mObjComP = new LogN_Class_ComProductoNumAsen();
            break;
            case 1:
                mObjComP = new LogN_Class_ComProductoNumDes();
            break;
            case 2:
                this.mOrdenAc = mOrdA;
                return true;
            
            default: return false;
        }
        this.mOrdenAc = mOrdA;
        OrdenarAll();
        return true;
    }

    public void OrdenarAll (){
        Collections.sort(mDatos,mObjComP);
    }
    public boolean deleteRow(Dom_Class_SubProducto xObjClass_SubProducto){
        int Pos = mDatos.indexOf(xObjClass_SubProducto);
        if(Pos == -1 )return false;

        mDatos.remove(Pos);
        super.fireTableRowsDeleted(Pos, Pos);
        return true;
    }


}
