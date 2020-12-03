/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.jTabModel;

import Logica_Negocio.Filtros.Factura.LogN_Inter_FiltFactura;
import Logica_Negocio.LogN_ClassAb_Factura;
import java.util.ArrayList;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author Ary
 */
public abstract  class LogN_ClassAb_ModeljTabFactura extends AbstractTableModel{
        //Atributos_________________________________________________________________
    private LogN_Inter_FiltFactura mObjFiltro;
    //Constructor_______________________________________________________________
     public abstract LogN_ClassAb_Factura getFactura(int rowIndes);

     public abstract ArrayList<LogN_ClassAb_Factura> listarFacturas ();

     public void setFlitro (LogN_Inter_FiltFactura xObjFilF){
         mObjFiltro = xObjFilF;
     }

     public LogN_Inter_FiltFactura getFiltro(){
         return mObjFiltro;
     }

    //Metodos___________________________________________________________________
     
    public abstract float getSubTotal ();
    
    public abstract float getDescuento();
    
    public abstract float getIvaTb ();
    
    public abstract float getIvaTm ();

}
