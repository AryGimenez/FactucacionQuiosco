/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.MYSQL;

import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.Manejadora.LogN_Inter_ManejPais;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author horacio
 */
public class LogN_Class_ManejPaisMySql extends Observable implements LogN_Inter_ManejPais{
    private Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();
// Metodos Pais*****************************************************************
    @Override
    public ArrayList<Dom_Class_Pais> listarPais() {
        ArrayList <Dom_Class_Pais> ColPais = new ArrayList<Dom_Class_Pais>();
        HashMap <Integer, Dom_Class_Pais> MapPais = new HashMap<Integer, Dom_Class_Pais>();

        try {
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery("SELECT `Pai_Num`, `Pai_Nom` FROM Pais ORDER BY `Pai_Nom`");

            while (Rs.next()){
                Integer NumPais = Rs.getInt("Pai_Num");
                Dom_Class_Pais ObjPais = new Dom_Class_Pais (Rs.getString("Pai_Nom"));
                ObjPais.setNum(NumPais);
                ColPais.add(ObjPais);
                MapPais.put(NumPais, ObjPais);
            }
            asignarPorvDep(MapPais);

        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InputException ex){
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            mObjMiSql.closeConecction();
        }

        return ColPais;
    }

    private void asignarPorvDep (HashMap<Integer , Dom_Class_Pais> xColPais)throws InputException{
        try {
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery("SELECT `Pai_Num`, `ProvD_Num`, `ProvD_Nom` FROM ProvDep ORDER BY `Pai_Num`");

            while (Rs.next()){
                Dom_Class_Pais ObjPai = xColPais.get(Rs.getInt("Pai_Num"));
                Dom_Class_ProvinDepar ObjProDep = new Dom_Class_ProvinDepar(Rs.getString("ProvD_Nom"));
                ObjProDep.setNum(Rs.getInt("ProvD_Num"));
                ObjPai.altaProvDep(ObjProDep);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
    }

    private void asignarProfDep ( Dom_Class_Pais xObjPis)throws InputException{
                try {
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery
                    ("SELECT `Pai_Num`, `ProvD_Num`, `ProvD_Nom` FROM ProvDep WHERE Pai_Num = "+ xObjPis.getNum() +"  ORDER BY `Pai_Num`");

            while (Rs.next()){
               
                Dom_Class_ProvinDepar ObjProDep = new Dom_Class_ProvinDepar(Rs.getString("ProvD_Nom"));
                ObjProDep.setNum(Rs.getInt("ProvD_Num"));
                xObjPis.altaProvDep(ObjProDep);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
    }
    
    @Override
    public void altaPais(Dom_Class_Pais xObjPais) throws InputException {
        
        xObjPais.validar();
        try {
            PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement("INSERT INTO Pais (`Pai_Nom`) VALUES(?)",Statement.RETURN_GENERATED_KEYS);
            Ps.setString(1, xObjPais.getNom());

            Ps.execute();
            
            ResultSet rs = Ps.getGeneratedKeys();
            rs.next();
            xObjPais.setNum(rs.getInt(1));

        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
    }

    public void altaProvD (int xNumPai, ArrayList<Dom_Class_ProvinDepar> xColProvD){

        try {
            PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement("INSERT INTO ProvDep (`Pai_Num`, `ProvD_Nom`) VALUES(?,?)",Statement.RETURN_GENERATED_KEYS);
            for (Dom_Class_ProvinDepar ObjProvD : xColProvD){
                Ps.setInt(1, xNumPai);
                Ps.setString(2, ObjProvD.getNom());

                ResultSet rs = Ps.getGeneratedKeys();
                rs.next();
                ObjProvD.setNum(rs.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
    }
    
    @Override
    public void modifPais(Dom_Class_Pais xObjPaisAn, Dom_Class_Pais xObjPaNu) throws InputException {
        xObjPaNu.validar();
        try {
            PreparedStatement Ps = mObjMiSql.AbrirConection().prepareStatement
                    ("UPDATE Pais SET Pai_Nom = ? WHERE Pai_Num  = ?");

            Ps.setString(1, xObjPaNu.getNom());
            Ps.setInt (2, xObjPaisAn.getNum());
            Ps.execute();
            
            xObjPaisAn.setNom(xObjPaNu.getNom());

        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
            mObjMiSql.closeConecction();
        }

    }

    @Override
    public void bajaPais(Dom_Class_Pais xObjPais) throws InputException {
        try {
            mObjMiSql.AbrirConection().createStatement().executeUpdate("DELETE FROM `Pais` WHERE `Pai_Num` = " + xObjPais.getNum());
        } catch (SQLException ex) {
            String mensajeAM = ex.getLocalizedMessage();
            if(ex.getErrorCode() == 1451) mensajeAM = "El País (" + xObjPais.getNom()
                    + ") a eliminar posee Provincias o departamento por lo tanto no se pude eliminar";
            
            throw new InputException(mensajeAM);
        }finally{
            mObjMiSql.closeConecction();
        }


    }

// Metodos de provincia o departamento *******************************************   
    @Override
    public void altaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
        
        xObjPais.altaProvDep(xObjProvDep);
        try {
            PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement
                    ("INSERT INTO ProvDep (Pai_Num, ProvD_Nom) VALUE  (?, ?)",Statement.RETURN_GENERATED_KEYS);
            Ps.setInt(1, xObjPais.getNum());
            Ps.setString(2, xObjProvDep.getNom());
            
            Ps.execute();
            
            ResultSet rs = Ps.getGeneratedKeys();
            rs.next();
            xObjProvDep.setNum(rs.getInt(1));

        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
            mObjMiSql.closeConecction();
        }
    }

    @Override
    public void modiProvDep(Dom_Class_ProvinDepar xObjProvDepAn, Dom_Class_ProvinDepar xObjProvDepNu) throws InputException {
        xObjProvDepNu.validar();
        
        try {
            PreparedStatement Ps = mObjMiSql.AbrirConection().prepareStatement
                    ("UPDATE ProvDep SET ProvD_Nom = ? WHERE ProvD_Num  = ?");

            Ps.setString(1, xObjProvDepNu.getNom());
            Ps.setInt (2, xObjProvDepAn.getNum());
            Ps.execute();
            
            xObjProvDepAn.setNom(xObjProvDepNu.getNom());
            

        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
            mObjMiSql.closeConecction();
        }
    }

    @Override
    public void bajaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
        if (!xObjPais.bajaPorvDep(xObjProvDep)) throw new InputException
                ("La provincia o departamento a dar de baja no existe en el país seleccionado");
        try {
            mObjMiSql.AbrirConection().createStatement().executeUpdate("DELETE FROM ProvDep WHERE `ProvD_Num` = " + xObjProvDep.getNum());
        } catch (SQLException ex) {
            String mensajeAM = ex.getLocalizedMessage();

            
            throw new InputException(mensajeAM);
        }finally{
            mObjMiSql.closeConecction();
        }
    }

    @Override
    public Dom_Class_Pais getPais(int xNumP) {
        Dom_Class_Pais ObjPais = null;
        try {
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery("SELECT `Pai_Num`, `Pai_Nom` FROM Pais WHERE  `Pai_Num` = " + xNumP);
            if(Rs.next()){
                ObjPais = new Dom_Class_Pais (Rs.getString("Pai_Nom"));
                ObjPais.setNum(Rs.getInt("Pai_Num"));
                this.asignarProfDep(ObjPais);
            }
 
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InputException ex){
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ObjPais;
    }

    @Override
    public Dom_Class_ProvinDepar getProvDep(int xNumProvDep) {
        Dom_Class_ProvinDepar ObjProDep = null;
        try {
            ResultSet Rs = mObjMiSql.AbrirConection().createStatement().executeQuery
                    ("SELECT `ProvD_Num`, `ProvD_Nom` WHERE `ProvD_Num` = " + xNumProvDep);

            if (Rs.next()){
                
                ObjProDep = new Dom_Class_ProvinDepar(Rs.getString("ProvD_Nom"));
                ObjProDep.setNum(Rs.getInt("ProvD_Num"));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejPaisMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
        return ObjProDep;
    }

    @Override
    public void addObservadorPais(Observer xObjObservador) {
        this.addObservadorPais(xObjObservador);
    }

    @Override
    public void removObservadorPais(Observer xObjObser) {
        this.removObservadorPais(xObjObser);
    }




}
