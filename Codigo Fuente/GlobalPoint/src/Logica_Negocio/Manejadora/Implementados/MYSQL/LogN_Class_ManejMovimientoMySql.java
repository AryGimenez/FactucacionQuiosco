/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.Dom_Class_MovSalida;
import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.Manejadora.LogN_Inter_ManejMovimiento;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Observable;
import java.util.Observer;

/**
 *
 * @author Ary
 */
public class LogN_Class_ManejMovimientoMySql extends Observable implements LogN_Inter_ManejMovimiento{

    private Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();

    @Override
    public int getNumMovimiento(){
         try {
            Statement s = (Statement) mObjMiSql.AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select * from Viw_NumMov");
            Rs.next();
            return Rs.getInt(1);

        } catch (SQLException ex) {
            return 1;
        }
    }

    @Override
    public void altaMovimiento(LogN_ClassAb_Movimiento xObjMov) throws InputException{
          xObjMov.validar();
          boolean TipoMov = true;
          if (xObjMov instanceof Dom_Class_MovSalida) TipoMov = false;

        java.sql.PreparedStatement Ps;
        
        int NumM = this.getNumMovimiento();
        try {
            Ps = mObjMiSql.AbrirConection().prepareStatement
                    ("INSERT INTO Movimiento ( ProCom_CodIn, Mov_NomEmit, Mov_Detalle, Mov_DesOr, Mov_Tip,"
                    + " Mov_CanProd) VALUES(?, ?, ?, ?, ?, ?)");

            Ps.setInt(1,xObjMov.getPord().getmProd_Cod());
            Ps.setString(2,xObjMov.getmAutoriso());
            Ps.setString(3, xObjMov.getmDetalle());
            Ps.setString(4,xObjMov.getmDes_Origen());
            Ps.setBoolean(5,TipoMov);
            Ps.setDouble(6,xObjMov.getCanProd());

            Ps.executeUpdate();

            

            xObjMov.setNumModificador(NumM);
            xObjMov.actualisarStok();
            mObjMiSql.closeConecction();

            Notificar(new LogN_Class_Accion<LogN_ClassAb_Movimiento>(LogN_Class_Accion.Agreger, xObjMov));
        } catch (SQLException ex) {
           // throw new InputException("Ha ingresado un código o nombre de producto ya existente.");
            throw new InputException(""+ ex.getLocalizedMessage());
        }finally {
            mObjMiSql.closeConecction();
        }

    }
    
    
    @Override
    public void addObservadorMovimiento(Observer xObjObser) {
        super.addObserver(xObjObser);
    }



    @Override
    public void removObservadorMovimiento(Observer xObjObser) {
        super.deleteObserver(xObjObser);
    }
    
        private void Notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }

}
