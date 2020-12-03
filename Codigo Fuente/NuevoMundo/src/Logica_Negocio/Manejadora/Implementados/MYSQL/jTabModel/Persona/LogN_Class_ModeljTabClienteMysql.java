/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona;

import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Filtros.Persona.LogN_Inter_FiltPersona;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Class_Fachada;
import Precentacion.LogN_Class_Accion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ary
 */
public class LogN_Class_ModeljTabClienteMysql extends LogN_ClassAb_ModeljTabPersonaMySql {

    public LogN_Class_ModeljTabClienteMysql(LogN_Inter_FiltPersona xObjFiltro) {
        super(xObjFiltro);
    }

    @Override
    protected void actualizar() {
        try {
            mObjMYsql.closeConecction();
            String Con = this.TraducirFlitro();
            if (!Con.equals("")) Con = " WHERE " + Con;
            String Select = "SELECT Per_Num, Per_RasSos, Per_TipDocum, Per_Docum, Per_Rut, "
                    + "Pai_Nom, ProvD_Nom, Per_Localidad , Per_Direccion, Pai_Num, ProvD_Num FROM ElPam.Viw_Cliente" + Con;
            
            
            state = mObjMYsql.AbrirConection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rec = state.executeQuery(Select);
            
            super.fireTableDataChanged();
        } catch (SQLException ex) {
            Logger.getLogger(LogN_ClassAb_ModeljTabPersonaMySql.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public LogN_ClassAb_Persona getPer(int rowIndes) {
        if (rowIndes < 0) return null;
        return LogN_Class_Fachada.getInstancia().getCliente(((Integer)getValueAt(rowIndes, 0)));
    }

    @Override
    public void update(Observable o, Object arg) {
        if(!(arg instanceof LogN_Class_Accion)) return;
        LogN_Class_Accion ObjAccion = (LogN_Class_Accion) arg;
        if (ObjAccion.getmAccionar() instanceof Dom_Class_Cliente)actualizar();
    }
    
}
