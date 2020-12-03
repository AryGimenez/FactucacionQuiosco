/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Model.jTabel;

import Logica_Negocio.Filtros.LogN_Inter_Filtrar;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author ary
 */
public class ModeljTabLinFac extends AbstractTableModel implements Observer {
    //Atributos_________________________________________________________________
    private ArrayList <LogN_ClassAb_LineaFac> mDatos;
    private String [] mTitel = {"Código ", "Descripción", "Cantidad", "P.Unitario", "Des. %", "Importe"};
    private LogN_Inter_Filtrar mObjFiltro;
    //Constructor_______________________________________________________________

    public ModeljTabLinFac (AbstractCollection<LogN_ClassAb_LineaFac> mColProd){
        this.mDatos = new ArrayList<LogN_ClassAb_LineaFac>(mColProd);

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

    public ModeljTabLinFac (AbstractCollection<LogN_ClassAb_LineaFac> mDatos, LogN_Inter_Filtrar mObjFil){
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

    public LogN_ClassAb_LineaFac getLinFac(int rowIndes){
        return mDatos.get(rowIndes);
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        LogN_ClassAb_LineaFac ObjLinFac = getLinFac(rowIndex);
        Object Respuesta = null;
        switch (columnIndex){
            case 0: Respuesta = ObjLinFac.getmObjArt().getmProd_Cod(); break;
            case 1: Respuesta = ObjLinFac.getmObjArt().getMProd_Nom(); break;
            case 2: Respuesta = ObjLinFac.getmCan(); break;
            case 3: Respuesta = ObjLinFac.getmPrePro(); break;
            case 4: Respuesta = ObjLinFac.getmDes(); break;
            case 5: Respuesta = ObjLinFac.getSubTotSinIva(); break;
        }
        return Respuesta;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return getValueAt(0, columnIndex).getClass();
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
        try {
            LogN_ClassAb_LineaFac ObjLiFac = getLinFac(rowIndex);
            Number Num = (Number) aValue;
            switch (columnIndex) {
            //Catogoria
                case 2:
                    ObjLiFac.setCan(Num.floatValue());
                    break;
                case 3:
                    ObjLiFac.setPrePro(Num.floatValue());
                    break;
                case 4:
                    ObjLiFac.setDes(Num.floatValue());
                    break;
                default:
                    return;
            }
            super.fireTableRowsUpdated(rowIndex, rowIndex);
        } catch (InputException ex) {

        }


    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if (columnIndex >= 2 && columnIndex <= 4 ) return true;
        return false;
    }

    private void addRow (Object o){
        mDatos.add((LogN_ClassAb_LineaFac) mObjFiltro.filtrar(o));
    }

    private void addRow (AbstractCollection O){
        mDatos = mObjFiltro.filtar(O);
    }

    public void update(Observable o, Object arg) {
        try{
            LogN_Class_Accion<LogN_ClassAb_LineaFac> ObjAxProd = (LogN_Class_Accion<LogN_ClassAb_LineaFac>) arg;
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

    public void setDatos(ArrayList<LogN_ClassAb_LineaFac> mColLinF) {
        mDatos.clear();
        mDatos.addAll(mColLinF);
        super.fireTableStructureChanged();
    }



}
