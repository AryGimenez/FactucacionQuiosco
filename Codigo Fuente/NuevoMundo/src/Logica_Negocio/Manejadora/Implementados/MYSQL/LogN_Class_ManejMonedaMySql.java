/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.Dom_Class_Cotisacion;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Manejadora.LogN_Inter_ManejMoneda;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ary
 */
public class LogN_Class_ManejMonedaMySql extends Observable implements LogN_Inter_ManejMoneda {
    private Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();
    
    @Override
    public ArrayList<Dom_Class_Moneda> listarMondeda() {
        
        ArrayList <Dom_Class_Moneda> ColMoneda = new ArrayList<Dom_Class_Moneda>();
       

        try {
            String Sql= "SELECT * FROM ElPam.Viw_Moneda";

            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery(Sql);

            while (Rs.next()){
                
                Integer NumPais = Rs.getInt("Pai_Num");
                Dom_Class_Pais ObjPais = new Dom_Class_Pais (Rs.getString("Pai_Nom"));
                ObjPais.setNum(NumPais);
                
                String Nom, Sig;
                float CotVen, CotCom;
                Nom = Rs.getString ("Mon_Nom");
                Sig = Rs.getString("Mon_Sig");
                CotVen = Rs.getFloat("Mon_CotVenta");
                CotCom = Rs.getFloat("Mon_CotCom");
                
                Date FechModCot = new Date();
                long dateTim = Rs.getTimestamp("Mon_FechMod").getTime();
                FechModCot.setTime(dateTim);
                
                Dom_Class_Moneda ObjMoneda = new Dom_Class_Moneda
                        (Nom, Sig, ObjPais, new Dom_Class_Cotisacion(CotVen, CotCom, FechModCot));
                ObjMoneda.setNum(Rs.getInt("Mon_Num"));
                ColMoneda.add(ObjMoneda);
            
            }
            

        } catch (SQLException ex) {
            ColMoneda = new ArrayList<>();

        } finally {
            mObjMiSql.closeConecction();
        }

        return ColMoneda;
    }

    @Override
    public void altaMoneda(Dom_Class_Moneda xObjMoneda, boolean xLocal) throws InputException {
        xObjMoneda.validar();
        try {
             PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement
                     ("SELECT Fuc_AltaMon( ?, ?, ?, ?, ?, ?)");
             
             Ps.setString(1, xObjMoneda.getSim());
             Ps.setString(2, xObjMoneda.getNom());
             Ps.setFloat(3, xObjMoneda.getObjCoti().getCompra());
             Ps.setFloat(4, xObjMoneda.getObjCoti().getVenta());
             Ps.setInt(5, xObjMoneda.getObjPais().getNum());
             Ps.setBoolean(6, xLocal);

             
             
             ResultSet Rs = Ps.executeQuery();
             Rs.next();
             xObjMoneda.setNum(Rs.getInt(1));
             Notificar(new LogN_Class_Accion<Dom_Class_Moneda> (LogN_Class_Accion.Agreger, xObjMoneda));
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
             mObjMiSql.closeConecction();
        }
    }

    @Override
    public void bajaMoneda(Dom_Class_Moneda xObjMoneda) throws InputException {
        Statement s;
        try {
            s = (Statement) mObjMiSql.AbrirConection().createStatement();
            s.executeUpdate("DELETE FROM `Moneda` WHERE `Mon_Num` = " + xObjMoneda.getNum());
            Notificar(new LogN_Class_Accion<Dom_Class_Moneda>(LogN_Class_Accion.Eliminar, xObjMoneda));
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }
    }

    @Override
    public void modiMoneda(Dom_Class_Moneda xObjMonedaAn, Dom_Class_Moneda xObjMonedaNu) throws InputException {
        try {
             PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement
                     ("CALL Pro_ModMon( ?, ?, ?, ?, ?)");
             
             Ps.setInt(1, xObjMonedaAn.getNum());
             Ps.setString(2, xObjMonedaNu.getSim());
             Ps.setString(3, xObjMonedaNu.getNom());
             Ps.setFloat(4, xObjMonedaNu.getObjCoti().getCompra());
             Ps.setFloat(5, xObjMonedaNu.getObjCoti().getVenta());
             
             Ps.execute();
             
             xObjMonedaAn.modificar(xObjMonedaNu);
             Notificar(new LogN_Class_Accion<Dom_Class_Moneda> (LogN_Class_Accion.Modificar, xObjMonedaAn));
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
             mObjMiSql.closeConecction();
        }
    }

    @Override
    public Dom_Class_Moneda getMonedaLoc() {
        try {
            
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().
                    executeQuery("SELECT * FROM ElPam.Viw_Moneda WHERE Mon_Local = 1 ");
            if(!Rs.next()) return null;
            
            Integer NumPais = Rs.getInt("Pai_Num");
            Dom_Class_Pais ObjPais = new Dom_Class_Pais (Rs.getString("Pai_Nom"));
            ObjPais.setNum(NumPais);

            String Nom, Sig;
            float CotVen, CotCom;
            Nom = Rs.getString ("Mon_Nom");
            Sig = Rs.getString("Mon_Sig");
            CotVen = Rs.getFloat("Mon_CotVenta");
            CotCom = Rs.getFloat("Mon_CotCom");

            Date FechModCot = new Date();
            long dateTim = Rs.getTimestamp("Mon_FechMod").getTime();
            FechModCot.setTime(dateTim);

            Dom_Class_Moneda ObjMoneda = new Dom_Class_Moneda
                    (Nom, Sig, ObjPais, new Dom_Class_Cotisacion(CotVen, CotCom, FechModCot));
            ObjMoneda.setNum(Rs.getInt("Mon_Num"));
      

                    
            return ObjMoneda;
        } catch (SQLException ex) {
            return null;
        }
    }
    
    
    public void setMonedaLocal (Dom_Class_Moneda xObjMoneda)throws InputException{
        try {
            xObjMoneda.validar();
            Statement s =  mObjMiSql.AbrirConection().createStatement();
            s.execute("CALL Pro_SetMonLocal(" +xObjMoneda.getNum()+ ")");
            
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejMonedaMySql.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InputException ex){
            throw new InputException("La moneda ingresada pose datos incorrectos");
        }
        
    }
    
    @Override
    public Dom_Class_Moneda getMoneda(int NumM) {
        Dom_Class_Moneda ObjMoneda = null;
        String Sql= "SELECT * FROM ElPam.Viw_Moneda WHERE Pai_Num = " + NumM;
        try{
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery(Sql);

            if(Rs.next()){
                
                Integer NumPais = Rs.getInt("Pai_Num");
                Dom_Class_Pais ObjPais = new Dom_Class_Pais (Rs.getString("Pai_Nom"));
                ObjPais.setNum(NumPais);
                
                String Nom, Sig;
                float CotVen, CotCom;
                Nom = Rs.getString ("Mon_Nom");
                Sig = Rs.getString("Mon_Sig");
                CotVen = Rs.getFloat("Mon_CotVenta");
                CotCom = Rs.getFloat("Mon_CotCom");
                
                Date FechModCot = new Date();
                long dateTim = Rs.getTimestamp("Mon_FechMod").getTime();
                FechModCot.setTime(dateTim);
                
                ObjMoneda = new Dom_Class_Moneda
                        (Nom, Sig, ObjPais, new Dom_Class_Cotisacion(CotVen, CotCom, FechModCot));
                ObjMoneda.setNum(Rs.getInt("Mon_Num"));

            
            }
            

        } catch (SQLException ex) {
        } finally {
            mObjMiSql.closeConecction();
        }
        
        return ObjMoneda;
    }
    
    @Override
    public void addObservadorMoneda(Observer xObjObser) {
        super.addObserver(xObjObser);
    }

    @Override
    public void removObservadorMoneda(Observer xObjObser) {
        super.deleteObserver(xObjObser);
    }
    
    private void Notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }
    
}
