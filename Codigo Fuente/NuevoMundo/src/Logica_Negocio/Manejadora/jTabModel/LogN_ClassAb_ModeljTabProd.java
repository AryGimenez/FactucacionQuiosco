/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.jTabModel;


import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Inter_DocCon;
import java.util.ArrayList;
import java.util.Observer;
import javax.swing.table.AbstractTableModel;



/**
 *
 * @author ary
 */
public abstract  class  LogN_ClassAb_ModeljTabProd extends AbstractTableModel implements Observer {
    //Atributos_________________________________________________________________
    private LogN_Inter_FlitPorducto mObjFiltro;
    //Constructor_______________________________________________________________
     public abstract LogN_ClassAb_Producto getPord(int rowIndes);

     public abstract ArrayList<LogN_ClassAb_Producto> listarProducto ();

     public void setFlitro (LogN_Inter_FlitPorducto xObjFil){
         mObjFiltro = xObjFil;
     }

     public LogN_Inter_FlitPorducto getFiltro(){
         return mObjFiltro;
     }

    //Metodos___________________________________________________________________

  
}
