/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.jTabModel;


import Logica_Negocio.Filtros.Persona.LogN_Inter_FiltPersona;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_ClassAb_Producto;
import java.util.ArrayList;
import java.util.Observer;
import javax.swing.table.AbstractTableModel;



/**
 *
 * @author ary
 */
public abstract  class  LogN_ClassAb_ModeljTabPer extends AbstractTableModel implements Observer {
    //Atributos_________________________________________________________________
    private LogN_Inter_FiltPersona mObjFiltro;
    //Constructor_______________________________________________________________
     public abstract LogN_ClassAb_Persona getPer(int rowIndes);

     public abstract ArrayList<LogN_ClassAb_Persona> listarPersona ();

     public void setFlitro (LogN_Inter_FiltPersona xObjFil){
         mObjFiltro = xObjFil;
     }

     public LogN_Inter_FiltPersona getFiltro(){
         return mObjFiltro;
     }

    //Metodos___________________________________________________________________

  
}
