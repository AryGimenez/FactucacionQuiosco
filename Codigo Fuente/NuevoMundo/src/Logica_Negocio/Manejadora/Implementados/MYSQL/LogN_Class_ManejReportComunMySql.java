/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL;


import Logica_Negocio.Manejadora.Implementados.MYSQL.jTabModel.LogN_Class_ModeljTabCuentasMySql;
import Logica_Negocio.Manejadora.LogN_Inter_ManejReportComun;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;

/**
 *
 * @author Ary
 */
public class LogN_Class_ManejReportComunMySql implements LogN_Inter_ManejReportComun{

    @Override
    public LogN_ClassAb_ModeljTabCuentas getModeljTabCuentas() {
        return new LogN_Class_ModeljTabCuentasMySql();
    }
    
}
