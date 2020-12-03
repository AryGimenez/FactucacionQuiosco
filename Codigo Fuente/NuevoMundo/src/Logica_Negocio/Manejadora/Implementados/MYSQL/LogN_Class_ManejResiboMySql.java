/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL;


import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.Dominio.Dom_Class_Resibo;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.LogN_Inter_ManejRecibo;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import com.mysql.jdbc.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;



/**
 *
 * @author horacio
 */
public class LogN_Class_ManejResiboMySql  implements LogN_Inter_ManejRecibo{
    private Per_Class_ConecElPam mObjMySql  = new Per_Class_ConecElPam();
    
    @Override
    public void altaRecibo(Dom_Class_Resibo xObjRecibo) throws InputException {
        String Error = "";
        
        try {
            xObjRecibo.validar();
            PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().
                    prepareStatement("SELECT Fuc_AltaRecibo(?, ?, ?, ?, ?, ?, ?, ?)");
            Ps.setInt(1, xObjRecibo.getmNumResibo());
            Ps.setTimestamp(2, new java.sql.Timestamp(xObjRecibo.getFech().getTime())); // pRes_Emicion
            Ps.setFloat(3, xObjRecibo.getMonto()); // pRes_Monto
            Ps.setString(4, xObjRecibo.getmDeQien());// pRes_DeQuien
            Ps.setString(5,xObjRecibo.getmDetalle());// pRes_Detalle
            Ps.setInt(6, xObjRecibo.getMoneda().getNum());// pMon_Num
            
            // pPer_Tip 
            LogN_ClassAb_Persona xObjPer = xObjRecibo.getPersona(); 
            int Per_Tip = -1;
            if (xObjPer instanceof Dom_Class_Cliente) Per_Tip = 1;
            else if (xObjPer instanceof Dom_Class_Proveedor) Per_Tip = 2;
            Ps.setInt(7, Per_Tip); 
            
            Ps.setInt(8,xObjPer.getmNum()); //pPer_Num
            
            ResultSet Rs = Ps.executeQuery();
            Rs.next();
            
            Error = Rs.getString(1);
             
            int NumR = Integer.parseInt(Error);
            Error = "";
            
        } catch (SQLException ex) {
            Error = ex.getLocalizedMessage();
        } catch (java.lang.NumberFormatException ex){
            
        }finally{
            mObjMySql.closeConecction();
        }
        
        if (!Error.equals(""))
            throw new InputException(Error);
        
    }
    
    

    @Override
    public ArrayList<Dom_Class_Resibo> listarRecibos() throws InputException {


    return null;    
    }

    @Override
    public Dom_Class_Resibo getResibo(int pNumR) throws InputException {
        Dom_Class_Resibo Obj_Res = null;
        try {
            ResultSet Rs =  mObjMySql.AbrirConection().createStatement().executeQuery
                    ("SELECT * FROM Viw_ReciboFull WHERE Res_Num = " + pNumR);
        
            if (Rs.next()){
                
                Date Res_Emision = new Date (Rs.getDate("Res_Emision").getTime());
                
                String Res_DeQuien, Res_Detalle;
                Res_DeQuien = Rs.getString("Res_DeQuien");
                Res_Detalle = Rs.getString("Res_Detalle");
                
                float Res_Monto = Rs.getFloat("Res_Monto");
                
                int Mon_Num, Per_Tip, Per_Num;
                Mon_Num = Rs.getInt("Mon_Num");
                Per_Tip = Rs.getInt("Per_Tip");
                Per_Num = Rs.getInt("Per_Num");
                
                LogN_Class_Fachada ObjFach = LogN_Class_Fachada.getInstancia();
                
                Dom_Class_Moneda ObjMon = ObjFach.getMoneda(Mon_Num);
                
                LogN_ClassAb_Persona ObjPer = null;
                
                switch (Per_Tip){
                    case 1:
                        ObjPer = ObjFach.getCliente(Per_Num);
                    break;
                    case 2:
                        ObjPer = ObjFach.getProveedor(Per_Num);
                    break;
                }
                
                Obj_Res = new Dom_Class_Resibo
                        (pNumR ,Res_Emision, Res_Detalle, ObjPer, Res_DeQuien, Res_Monto, ObjMon);

            }
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }
        return Obj_Res;
    }

    @Override
    public int getNumRecibo() throws InputException {
        int xRespuesta = -1;
        try {
            ResultSet xObjRs = mObjMySql.AbrirConection().createStatement().
                    executeQuery("SELECT * FROM Viw_NumReci");
            if (xObjRs.next())
                xRespuesta = xObjRs.getInt(1);
            
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
            mObjMySql.closeConecction();
        }
        return xRespuesta;
        
    }
    
}
