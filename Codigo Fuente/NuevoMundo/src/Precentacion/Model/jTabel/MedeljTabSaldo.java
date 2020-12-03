/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Model.jTabel;

import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author horacio
 */
public class MedeljTabSaldo  extends  AbstractTableModel  implements Observer {
    //Atributos_________________________________________________________________
    private ArrayList <Dom_Class_Saldo> mDatos;
    private String [] mTitel = {"Acree.", "Monto", "L.Acree", "L.Deud", "Moneda"};
    private LogN_Inter_Filtrar mObjFiltro;
    //Constructor_______________________________________________________________

    public MedeljTabSaldo (AbstractCollection<Dom_Class_Saldo> mColMoneda){
        this.mDatos = new ArrayList<Dom_Class_Saldo>(mColMoneda);

        mObjFiltro = new LogN_Inter_Filtrar(){

            @Override
            public Class getCalse() {
                return mObjFiltro.getCalse();
            }

            @Override
            public Object filtrar(Object ObjAFil) {
                return ObjAFil;
            }

            @Override
            public ArrayList filtar(AbstractCollection ColAFil) {
                return (ArrayList) ColAFil;
            }

            @Override
            public Object getmCondicion() {
                return " ";
            }

            @Override
            public short getmPocicion() {
                return (short) 1;
            }

            @Override
            public void setmPocicion(short mPocicion) throws InputException {

            }

            @Override
            public void setmCondicion(Object ObjCon) throws InputException {
                throw new UnsupportedOperationException("Not supported yet.");
            }

            @Override
            public String[] getNomPocicion() {
                throw new UnsupportedOperationException("Not supported yet.");
            }

        };
    }

    public MedeljTabSaldo (AbstractCollection<Dom_Class_Saldo> mDatos, LogN_Inter_Filtrar mObjFil){
        this.mObjFiltro = mObjFil;
        this.addRow(mDatos);
    }

    //Metodos___________________________________________________________________

    @Override
    public String getColumnName(int column) {
        return mTitel [column];
    }

    @Override
    public int getRowCount() {
        return mDatos.size();
    }

    @Override
    public int getColumnCount() {
        return mTitel.length;
    }

    public Dom_Class_Saldo getSaldo(int rowIndes){
        try{
            return mDatos.get(rowIndes);
        }catch(java.lang.ArrayIndexOutOfBoundsException Ex){
            return null;
        }
        
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {

        Dom_Class_Saldo ObjSaldo = getSaldo(rowIndex);

        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjSaldo.getAcreedor(); break; // Arreglar esto
            case 1: Respuesta = ObjSaldo.getMonto(); break;
            case 2: Respuesta = ObjSaldo.getmLimAceedor(); break;
            case 3: Respuesta = ObjSaldo.getmLimDeudor(); break;
            case 4: Respuesta = ObjSaldo.getObjMon(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {

        Dom_Class_Saldo ObjSaldoAn = getSaldo(rowIndex);
        Dom_Class_Saldo ObjSaldoNu = ObjSaldoAn.duplicar();
        
        switch (columnIndex) {
        //Catogoria
            case 0:
                ObjSaldoNu.setAcreedor((Boolean)aValue);
            break;
            case 1:
                ObjSaldoNu.setMonto(((Number)aValue).floatValue());
            break;
            case 2:
                ObjSaldoNu.setmLimAceedor(((Number)aValue).floatValue());
            break;
            case 3:
                ObjSaldoNu.setmLimDeudor((((Number)aValue).floatValue()));
            break;
            default:
                return;
        }
        try {
            ObjSaldoAn.modificar(ObjSaldoNu);
            super.fireTableRowsUpdated(rowIndex, rowIndex);
        } catch (InputException ex) {
        }
        
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if(columnIndex > 3) return false;
        return true;
    }

    public void addRow (Object o){
        mDatos.add((Dom_Class_Saldo) mObjFiltro.filtrar(o));
        int Pos = mDatos.indexOf(o);
        super.fireTableRowsInserted(Pos, Pos);
    }

    public void deleteRow (Dom_Class_Saldo xObjSaldo){
        int Pos = mDatos.indexOf(xObjSaldo);
        if (Pos >= 0){
            mDatos.remove(Pos);
            super.fireTableRowsDeleted(Pos, Pos);
        }
    }

    public void addRow (AbstractCollection O){
        mDatos = mObjFiltro.filtar(O);
    }



    public void update(Observable o, Object arg) {
//        try{
//            LogN_Class_Accion<Dom_Class_Notificacion> ObjAxProd = (LogN_Class_Accion<Dom_Class_Notificacion>) arg;
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

    public void setDatos(ArrayList<Dom_Class_Saldo> mColLinF) {
        mDatos.clear();
        mDatos.addAll(mColLinF);
        super.fireTableStructureChanged();
    }

    public ArrayList<Dom_Class_Saldo> getDatos (){
        return mDatos;
    }
}
