/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.jTabModel;




import Logica_Negocio.Filtros.DocCont.LogN_ClassAb_FilDocCon;
import Logica_Negocio.LogN_Inter_DocCon;
import java.util.ArrayList;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author horacio
 */
public abstract class LogN_ClassAb_ModeljTabCuentas extends AbstractTableModel{
    //Atributos_________________________________________________________________
    private LogN_ClassAb_FilDocCon mObjFiltro;
    private String [] mTitulo= {"Tipo", "Codigo", "Persona", "Emisión", "Caja", "Crédito"};
    protected float mCaja, mCredito;
    //Constructor_______________________________________________________________
     public abstract LogN_Inter_DocCon getDocCon(int rowIndes);

     public abstract ArrayList<LogN_Inter_DocCon> listarDocCon ();
     
     //Metodos___________________________________________________________________

    public float getmCaja() {
        return mCaja;
    }

    public float getmCredito() {
        return mCredito;
    }
    
    @Override
    public String getColumnName(int column) {
        return mTitulo[column];
    }

    @Override
    public int getColumnCount() {
        return mTitulo.length;
    }

    
     public void setFlitro (LogN_ClassAb_FilDocCon xObjFil){
         mObjFiltro = xObjFil;
         actualizar();
     }

     public LogN_ClassAb_FilDocCon getFiltro(){
         return mObjFiltro;
     }
     
     public abstract void actualizar ();



}
