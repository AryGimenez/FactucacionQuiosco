/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.Manejadora.LogN_Inter_ManejIVA;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ary
 */
public class LogN_Class_ManejIvaMysql implements LogN_Inter_ManejIVA{
    private Per_Class_ConecElPam mObjMySql = new Per_Class_ConecElPam();
    @Override
    public ArrayList<Dom_Class_IVA> listarIVA() {
        ArrayList<Dom_Class_IVA> mColRes = new ArrayList<Dom_Class_IVA>();
        ResultSet Rs;
        try {
            Rs = mObjMySql.AbrirConection().createStatement().executeQuery("SELECT IVA_Num, IVA_Nom, IVA_Pors FROM IVA");


            while (Rs.next()){
                Dom_Class_IVA ObjIva = new Dom_Class_IVA(Rs.getString("IVA_Nom"), (float) Rs.getDouble("IVA_Pors"));
                ObjIva.setmNum(Rs.getInt("IVA_Num"));
                mColRes.add(ObjIva);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejIvaMysql.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mColRes;
    }
    
    public Dom_Class_IVA getIVA (float pPorcentaje) throws InputException{
        ResultSet Rs;
        Dom_Class_IVA xRespuesta = null;
        try {
            Rs = mObjMySql.AbrirConection().createStatement().executeQuery
                    ("SELECT IVA_Num, IVA_Nom FROM IVA WHERE IVA_Pors = " + pPorcentaje);


            if (Rs.next()){
                xRespuesta = new Dom_Class_IVA(Rs.getString("IVA_Nom"), pPorcentaje);
                xRespuesta.setmNum(Rs.getInt("IVA_Num"));
                
            }
        } catch (SQLException ex) {
           throw new InputException(ex.getLocalizedMessage());
        }
        return xRespuesta;
    }

    
    public Dom_Class_IVA getIVA (int pNum) throws InputException{
        ResultSet Rs;
        Dom_Class_IVA xRespuesta = null;
        try {
            Rs = mObjMySql.AbrirConection().createStatement().executeQuery
                    ("SELECT IVA_Pors,  IVA_Nom FROM IVA WHERE IVA_Num= " + pNum);


            if (Rs.next()){
                xRespuesta = new Dom_Class_IVA(Rs.getString("IVA_Nom"), (float) Rs.getDouble("IVA_Pors"));
                xRespuesta.setmNum(pNum);
            }
        } catch (SQLException ex) {
           throw new InputException(ex.getLocalizedMessage());
        }
        return xRespuesta;
    }
}
