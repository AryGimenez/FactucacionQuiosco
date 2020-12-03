/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona;

import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.Filtros.Persona.LogN_Inter_FiltPersona;
import Logica_Negocio.LogN_ClassAb_Persona;
import Precentacion.LogN_Class_Accion;
import java.util.Observable;

/**
 *
 * @author ary
 */
public class LogN_Class_ModeljTabProveedorMysql extends LogN_ClassAb_ModeljTabPersonaMySql{

    public LogN_Class_ModeljTabProveedorMysql(LogN_Inter_FiltPersona xObjFiltro) {
        super(xObjFiltro);
    }

    @Override
    protected void actualizar() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_Persona getPer(int rowIndes) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void update(Observable o, Object arg) {
        if(!(arg instanceof LogN_Class_Accion)) return;
        LogN_Class_Accion ObjAccion = (LogN_Class_Accion) arg;
        if (ObjAccion.getmAccionar() instanceof Dom_Class_Proveedor)actualizar();
    }
    
}
