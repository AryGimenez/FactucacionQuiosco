/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Model.jTabel;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.Dominio.Dom_Class_Notificacion;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observable;
import java.util.Observer;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author ary
 */
public class ModeljTabNotificacion extends AbstractTableModel implements Observer {
    //Atributos_________________________________________________________________
    private ArrayList <Dom_Class_Notificacion> mDatos;
    private String [] mTitel = {"Fecha", "Nombre", "Detalle"};
    private LogN_Inter_Filtrar mObjFiltro;
    //Constructor_______________________________________________________________

    public ModeljTabNotificacion (AbstractCollection<Dom_Class_Notificacion> mColProd){
        this.mDatos = new ArrayList<Dom_Class_Notificacion>(mColProd);

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
    }

    public ModeljTabNotificacion (AbstractCollection<Dom_Class_Notificacion> mDatos, LogN_Inter_Filtrar mObjFil){
        this.mObjFiltro = mObjFil;
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

    public Dom_Class_Notificacion getNotificacin(int rowIndes){
        return mDatos.get(rowIndes);
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Dom_Class_Notificacion ObjNot = getNotificacin(rowIndex);
        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjNot.getmFechNot(); break;
            case 1: Respuesta = ObjNot.getmNom(); break;
            case 2: Respuesta = ObjNot.getmDetalle(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {

        Dom_Class_Notificacion ObjNot = getNotificacin(rowIndex);

        switch (columnIndex) {
        //Catogoria
            case 0:
                ObjNot.setmFechNot((Date)aValue);
                break;
            case 1:
                ObjNot.setmNom((String)aValue);
                break;
            case 2:
                ObjNot.setmDetalle((String)aValue);
                break;
            default:
                return;
        }
        super.fireTableRowsUpdated(rowIndex, rowIndex);
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return true;
    }

    private void addRow (Object o){
        mDatos.add((Dom_Class_Notificacion) mObjFiltro.filtrar(o));
    }

    private void addRow (AbstractCollection O){
        mDatos = mObjFiltro.filtar(O);
    }

    public void update(Observable o, Object arg) {
        try{
            LogN_Class_Accion<Dom_Class_Notificacion> ObjAxProd = (LogN_Class_Accion<Dom_Class_Notificacion>) arg;
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
                    this.fireTableRowsDeleted(numFil, numFil);
                break;
                case LogN_Class_Accion.Modificar:
                    if (numFil != -1) this.fireTableRowsUpdated(numFil, numFil);
                break;
            }
        }catch (ClassCastException ex){


        }
        
    }

    public void setDatos(ArrayList<Dom_Class_Notificacion> mColLinF) {
        mDatos.clear();
        mDatos.addAll(mColLinF);
        super.fireTableStructureChanged();
    }

    public ArrayList<Dom_Class_Notificacion> getDatos (){
        return mDatos;
    }



}
