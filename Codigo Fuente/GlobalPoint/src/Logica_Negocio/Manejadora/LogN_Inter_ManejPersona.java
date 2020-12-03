/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.Dom_Class_Resibo;
import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.LogN_ClassAb_PerExterna;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabClienteMysql;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabProveedorMysql;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;

/**
 *
 * @author ary
 */
public interface LogN_Inter_ManejPersona {
    
    //Metodos Alta **************************************************************
    public void altaCliente (Dom_Class_Cliente xObjCLi)throws InputException;
    
    public void altaProv (Dom_Class_Proveedor xObjProv)throws InputException;
    
    public void altaPersonaEx (LogN_ClassAb_PerExterna xObjPerEx) throws InputException;
    
    
    //Metodos Baja***************************************************************
    public void bajaCliente (Dom_Class_Cliente xObjCLi)throws InputException;
    
    public void bajaProv (Dom_Class_Proveedor xObjProv)throws InputException;
    
    public void bajaPersonaEx (LogN_ClassAb_PerExterna xObjPerEx) throws InputException;
    
    
    //Metodos Modificacion ******************************************************
    public void ModCliente (Dom_Class_Cliente xObjCLiAn , Dom_Class_Cliente xObjCLiNu)throws InputException;
    
    public void ModProv (Dom_Class_Proveedor xObjProvAn, Dom_Class_Proveedor xObjProvNu)throws InputException;
    
    public void ModPersonaEx (LogN_ClassAb_PerExterna xObjPerExAn , LogN_ClassAb_PerExterna xObjPerExNu) throws InputException;
    
    
    public int getNumProv();
    
    public int getNumCli();
    
    public LogN_Class_ModeljTabClienteMysql getModJtabClienteMysql();
    
    public LogN_Class_ModeljTabProveedorMysql getModJtabProvMysql();
        
    public Dom_Class_Cliente getCliente (int NumCli);
    
    public Dom_Class_Proveedor getProveedor (int NumProv);
    
    //Obsevable*****************************************************************
    public void addObservadorPersona(Observer xObjObser);

    public void removObservadorPersona(Observer xObjObser);
    
    
    // <editor-fold defaultstate="collapsed" desc="Metodos Saldo">
    
    public void altaSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo)throws InputException;
    
    public void bajaSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo)throws InputException;
    
    public void modifSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo)throws InputException;
    
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Metodos Contacto">
    
    //Metodo Alta Contacto******************************************************
    
        public void altaContacto (LogN_ClassAb_PerExterna xObjPerEx, LogN_ClassAb_Contacto xObjCon)throws InputException;

        public void altaCel (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel )throws InputException;

        public void altaTel (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjTel )throws InputException;

        public void altaMail (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjMail )throws InputException;

        public void altaFax (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjFax )throws InputException;

        //Metodo Baja Contacto******************************************************


        public void bajaCel (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel )throws InputException;

        public void bajaTel (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjTel )throws InputException;

        public void bajaMail (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjMail )throws InputException;

        public void bajaFax (LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjFax )throws InputException;

       //Metodo modifContacto*******************************************************

        public void modifContacto(LogN_ClassAb_Contacto xObjConAn, LogN_ClassAb_Contacto xObjConNu) throws InputException;

        public void modifCel(Dom_Class_Cel xObjCelAn, Dom_Class_Cel xObjCelNu) throws InputException;

        public void modifTel(Dom_Class_Tel xObjTelAn, Dom_Class_Tel xObjTelNu) throws InputException; 

        public void modifMail(Dom_Class_Mail xObjCelAn, Dom_Class_Mail xObjCelNu) throws InputException;

        public void modifFax(Dom_Class_Fax xObjFaxAn, Dom_Class_Fax xObjFaxNu) throws InputException;
       
    // </editor-fold>



}
