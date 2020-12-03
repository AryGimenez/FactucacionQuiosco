/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Manejadora.LogN_Inter_ManejCategoria;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author horacio
 */
public class LogN_Class_ManejCategoriaMySql extends Observable  implements LogN_Inter_ManejCategoria  {
    private Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();

    public void consCategoria(String nomCat) throws InputException {
        altaCategoria(new Dom_Class_Categoria(nomCat));
    }

    public void altaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
        xObjCat.validar();

        PreparedStatement Ps;

        try {
            
            
            Ps = mObjMiSql.AbrirConection().prepareStatement("INSERT INTO Categoria (Cat_Nom) VALUES(?)");
            
            Ps.setString(1,xObjCat.getNom());
            Ps.executeUpdate();
            
            Dom_Class_Categoria xObjCat2 = getCategoria(xObjCat);
            xObjCat.setCat_Num(xObjCat2.getCat_Num());

                
            Notificar(new LogN_Class_Accion<Dom_Class_Categoria>(LogN_Class_Accion.Agreger, xObjCat));
        } catch (SQLException ex) {
            if (ex.getErrorCode() == 1062) throw new InputException("A ingresado una categoría ya existente");
            else throw new InputException
                    ("Hubo un error insuperado en el sistema comuníquese con el/n desarrollador correspondiente (Cel: 098559058)");
        }finally {
            mObjMiSql.setEditable(true);
            mObjMiSql.closeConecction();
        }


    }

    public void bajaCategoria(String NomCat) throws InputException {
        bajaCategoria(new Dom_Class_Categoria(NomCat));
    }

    public void bajaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
       Statement s;
        try {
            s = (Statement) mObjMiSql.AbrirConection().createStatement();
            s.executeUpdate("DELETE FROM `Categoria` WHERE `Cat_Nom` = '" + xObjCat.toString() + "'");
        } catch (SQLException ex) {
            throw new InputException("La categoría a dar de baja no existe en el sistema");
        }

    }

    public void modificarCategoria(Dom_Class_Categoria xObjCatAn, Dom_Class_Categoria xObjCatNu) throws InputException {
        try {
            xObjCatNu.validar();
        }catch (InputException ex){
            throw new InputException ("La categoría a modificar no es valida");
        }


        try {
           mObjMiSql.AbrirConection();
           mObjMiSql.setEditable(false);
           xObjCatAn = this.getCategoria(xObjCatAn);
           if (xObjCatAn == null) throw new InputException("La categoría a medicar no existe en el sistema");

            mObjMiSql.AbrirConection().createStatement().executeUpdate(
                    "UPDATE Categoria SET Cat_Id = '" + xObjCatNu.getNom() + "' WHERE Cat_Nom = '" + xObjCatAn.getNom() + "'");

        } catch (SQLException ex) {
            throw new InputException("La categoría a modificar ya existe");
        }finally {
            mObjMiSql.closeConecction();
        }
    }

    public void modifcarCategoria(String NomCatAn, String NomCatNu) throws InputException {
        modificarCategoria(new Dom_Class_Categoria(NomCatAn), new Dom_Class_Categoria(NomCatNu));
    }

    public boolean existeCat(Dom_Class_Categoria xObjCategoria) {

        try {
            Statement s = (Statement) mObjMiSql.AbrirConection().createStatement();

            ResultSet Rs = s.executeQuery("select COUNT(*) from `Categoria` WHERE `Cat_Nom` = '" + xObjCategoria.toString() + "'");
            Rs.next();
            if (Rs.getInt(1) > 0) return true;   
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ManejCategoriaMySql.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            mObjMiSql.closeConecction();
        }
        return false;

    }

    public boolean existeCat(String NomCat) {
       return existeCat(new Dom_Class_Categoria(NomCat));
    }

    public ArrayList<Dom_Class_Categoria> listarCat() {
        ArrayList<Dom_Class_Categoria> ColCategoria = new ArrayList<Dom_Class_Categoria>();
        try {
            Statement s = null;
            while (s == null){
                try{
                    s = (Statement) mObjMiSql.AbrirConection().createStatement();
                }catch (NullPointerException ex2){}
            }

            ResultSet Rs = s.executeQuery("select * from `Categoria` ORDER BY `Cat_Nom`");
           
            while(Rs.next()){
                 Dom_Class_Categoria ObjCat = new Dom_Class_Categoria(Rs.getString("Cat_Nom"),Rs.getInt("Cat_Num"));
                 ColCategoria.add(ObjCat);
            }
        } catch (SQLException ex) {
            
        }finally{
             mObjMiSql.closeConecction();
        }

        return ColCategoria;
    }

    public Dom_Class_Categoria getCategoria(String NomCat) {
        return getCategoria(new Dom_Class_Categoria(NomCat));
    }

    public Dom_Class_Categoria getCategoria(Dom_Class_Categoria xObjCat) {

        try {
            Statement s = (Statement) mObjMiSql.AbrirConection().createStatement();

            ResultSet Rs = s.executeQuery("select * from `Categoria` WHERE `Cat_Nom` = '" 
                    + xObjCat.getNom() + "' OR Cat_Num = " + xObjCat.getCat_Num());
            while(Rs.next()){
                
                Dom_Class_Categoria ObjCategoria = new Dom_Class_Categoria(Rs.getString("Cat_Nom"), Rs.getInt("Cat_Num"));
                mObjMiSql.closeConecction();
                return ObjCategoria;
            }
            
        } catch (SQLException ex) {
            return null;
        } finally{
            mObjMiSql.closeConecction();
        }

        return null;
    }

    public Dom_Class_Categoria RetornarOCrearCategoria(String NomCat) throws InputException {
        return RetornarOCrarCategoria(new Dom_Class_Categoria(NomCat));
    }

    public Dom_Class_Categoria RetornarOCrarCategoria(Dom_Class_Categoria xobjCat) throws InputException {

        Dom_Class_Categoria ObjCat =  getCategoria(xobjCat);
        if (ObjCat != null) return ObjCat;
        String Exepcion = "";
        

        try {

            Connection Con = mObjMiSql.AbrirConection();
            mObjMiSql.setEditable(false);
            this.altaCategoria(xobjCat);

        } catch (InputException Ex) {
            if(!Ex.getLocalizedMessage().equals("A ingresado una categoría ya existente")) Exepcion = Ex.getLocalizedMessage();
            else ObjCat = getCategoria(xobjCat);
        }finally{
            mObjMiSql.setEditable(true);
            mObjMiSql.closeConecction();
        }

        if (!Exepcion.equals("")) throw new InputException(Exepcion);
        return xobjCat;
        
    }

    public boolean addObservadorCategoria(Observer xObj) {
        super.addObserver(xObj);
        return true;
    }

    public boolean removObservadorCategoria(Observer xObj) {
        super.deleteObserver(xObj);
        return true;
    }
    
    private void Notificar (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }

}
