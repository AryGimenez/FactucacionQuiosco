/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Precentacion.Model.jTabel;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_Class_ObsevadoAuxiliar;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author Ary
 */
public class ModeljTabMoneda extends  AbstractTableModel  implements Observer {
    //Atributos_________________________________________________________________
    private ArrayList <Dom_Class_Moneda> mDatos;
    private String [] mTitel = {"Pais", "Nombre", "Simbolo", "Cot.Compra", "Cot.Venta", "Fecha Cot."};
    private LogN_Class_ObsevadoAuxiliar <ModeljTabMoneda> mObjObsAux = new LogN_Class_ObsevadoAuxiliar<ModeljTabMoneda>(this);
            
    private LogN_Inter_Filtrar mObjFiltro;
    //Constructor_______________________________________________________________

    public ModeljTabMoneda (AbstractCollection<Dom_Class_Moneda> mColMoneda){
        this.mDatos = new ArrayList<Dom_Class_Moneda>(mColMoneda);

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
    

    public ModeljTabMoneda (AbstractCollection<Dom_Class_Moneda> mDatos, LogN_Inter_Filtrar mObjFil){
        this.mObjFiltro = mObjFil;
        this.addRow(mDatos);
    }

    //Metodos___________________________________________________________________

    
    
    public synchronized void deleteObservers() {
        mObjObsAux.deleteObservers();
    }

    public synchronized void addObserver(Observer o) {
        mObjObsAux.addObserver(o);
    }

    public void Notifiar(Object arg) {
        mObjObsAux.Notifiar(arg);
    }

    
    
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

    public Dom_Class_Moneda getMondeda(int rowIndes){
        try{
            return mDatos.get(rowIndes);
        }catch (java.lang.ArrayIndexOutOfBoundsException ex){
            return null;
        }
        
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        
        Dom_Class_Moneda ObjMon = getMondeda(rowIndex);
        
        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjMon.getObjPais(); break;
            case 1: Respuesta = ObjMon.getNom(); break;
            case 2: Respuesta = ObjMon.getSim(); break;
            case 3: Respuesta = ObjMon.getObjCoti().getCompra(); break;
            case 4: Respuesta = ObjMon.getObjCoti().getVenta(); break;
            case 5: Respuesta = ObjMon.getObjCoti().getmFechMod(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {

        Dom_Class_Moneda ObjMonNu, ObjMonAn;
        ObjMonAn = getMondeda(rowIndex);
        ObjMonNu = ObjMonAn.duplicar();
        

        switch (columnIndex) {
        //Catogoria
            case 1:
                ObjMonNu.setNom(aValue.toString());
                break;
            case 2:
                ObjMonNu.setSim((String)aValue);
                break;
            case 3:
                ObjMonNu.getObjCoti().setCompra(((Number)aValue).floatValue());
                break;
            case 4:
                ObjMonNu.getObjCoti().setVenta(((Number)aValue).floatValue());
            default:
                return;
        }
        try {
            ObjMonAn.modificar(ObjMonNu);
            super.fireTableRowsUpdated(rowIndex, rowIndex);
            mObjObsAux.Notifiar(new LogN_Class_Accion<Dom_Class_Moneda> (LogN_Class_Accion.Modificar, ObjMonAn));
        } catch (InputException ex) {
            
        }
        
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if(columnIndex == 5) return false;
        return true;
    }

    public void addRow (Object o){
        if(mDatos.add((Dom_Class_Moneda) mObjFiltro.filtrar(o))){
            int numFil = this.mDatos.indexOf(o);
            if (numFil == -1) return;
            this.fireTableRowsInserted(numFil, numFil); 
        }
    }

    private void addRow (AbstractCollection O){
        mDatos = mObjFiltro.filtar(O);
    }
    
    public void bajaRow (Object o){
         int numFil = this.mDatos.indexOf(o);
        if (mDatos.remove(o)){
            this.fireTableRowsDeleted(numFil, numFil);
        }
        
    }

    @Override
    public void update(Observable o, Object arg) {
        try{
            LogN_Class_Accion<Dom_Class_Moneda> ObjAxProd = (LogN_Class_Accion<Dom_Class_Moneda>) arg;
            int numFil = this.mDatos.indexOf(ObjAxProd.getmAccionar()) ;

            switch (ObjAxProd.mAccionActual){
                case LogN_Class_Accion.Agreger:
                    addRow(ObjAxProd.getmAccionar());
                    
                   
                break;
                case LogN_Class_Accion.Eliminar:
                    if (numFil == -1)return;
                    bajaRow(arg);
                break;
                case LogN_Class_Accion.Modificar:
                    if (numFil != -1) this.fireTableRowsUpdated(numFil, numFil);
                break;
            }
        }catch (ClassCastException ex){


        }
        
    }

    public void setDatos(ArrayList<Dom_Class_Moneda> mColLinF) {
        mDatos.clear();
        mDatos.addAll(mColLinF);
        super.fireTableStructureChanged();
    }

    public ArrayList<Dom_Class_Moneda> getDatos (){
        return mDatos;
    }
}
