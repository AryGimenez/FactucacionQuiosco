/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.*;
import Logica_Negocio.Dominio.FechPago.Dom_Class_FechPAño;
import Logica_Negocio.Dominio.FechPago.Dom_Class_FechPDiario;
import Logica_Negocio.Dominio.FechPago.Dom_Class_FechPMensual;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.LogN_ClassAb_FechPag;
import Logica_Negocio.LogN_ClassAb_PerExterna;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.LogN_Inter_ManejPersona;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabClienteMysql;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabProveedorMysql;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;






/**
 *
 * @author ary
 */
public  class LogN_Class_ManejPersonaMysql extends Observable implements LogN_Inter_ManejPersona {
    

    private Per_Class_ConecElPam mObjMySql  = new Per_Class_ConecElPam();

   
    
    @Override
    public void altaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
        xObjCLi.validar();
        try {
            
             PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                     ("SELECT Fuc_AltaCli (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
             
             Ps.setString(1, xObjCLi.getmRasSos());
             Ps.setString(2, xObjCLi.getmLoc());
             Ps.setString(3, xObjCLi.getmDir());
             Ps.setString(4, xObjCLi.getmRut());
             Ps.setInt (5, xObjCLi.getmCondicionIva());
             
             String NumDoc = xObjCLi.getmNumDoc();
             if(NumDoc.equals(""))
                 NumDoc = null;
             Ps.setString(6, NumDoc);
             
             Ps.setInt(7, xObjCLi.getmTipDoc());
             Ps.setInt(8, xObjCLi.getmObjPais().getNum());
             Ps.setInt(9, xObjCLi.getmObjProvDep().getNum());
             
             Integer FechP_Intervalo, FechP_Aviso, FechP_Dia, FechP_Mes;
             java.sql.Date FechP_FechAlta;
             String FechP_Tipo;
             
             LogN_ClassAb_FechPag ObjFechP = xObjCLi.getmObjFechPago();
             
             if (ObjFechP != null){
                 FechP_Tipo = ObjFechP.TipFechPag();
                 FechP_Intervalo = ObjFechP.getmIntervalo();
                 FechP_Aviso = ObjFechP.getAviso();
                 FechP_Dia = ObjFechP.getDiaDelMes();
                 FechP_Mes =  ObjFechP.getMesDelAño();
                 FechP_FechAlta = new java.sql.Date(ObjFechP.getmFechInicio().getTime());
             } else {
                 
                 FechP_Tipo = null;
                 FechP_Intervalo = 0;
                 FechP_Aviso = 0;
                 FechP_Dia = 0;
                 FechP_Mes =  0;
                 FechP_FechAlta = null;
             }
             
             Ps.setString(10, FechP_Tipo);
             Ps.setInt(11, FechP_Intervalo);
             Ps.setInt(12, FechP_Mes);
             Ps.setInt(13, FechP_Dia);
             Ps.setInt(14, FechP_Aviso);
             Ps.setDate(15, FechP_FechAlta);
             
             ResultSet Rs = Ps.executeQuery();
             Rs.next();
             xObjCLi.setmNum(Rs.getInt(1));
             
             
             for (Dom_Class_Cel ObjCel : xObjCLi.getmColCel())altaContacto(xObjCLi, ObjCel);
             
             for (Dom_Class_Tel ObjTel : xObjCLi.getmColTel())altaContacto(xObjCLi, ObjTel);
             
             for (Dom_Class_Mail ObjMail : xObjCLi.getmColMail())altaContacto(xObjCLi, ObjMail);
             
             for (Dom_Class_Fax ObjFax : xObjCLi.getmColFax())altaContacto(xObjCLi, ObjFax);
             
             for (Dom_Class_Saldo ObjSaldo: xObjCLi.getmColSaldo()) altaSaldo(xObjCLi, ObjSaldo);
             
             Notificar(new LogN_Class_Accion<Dom_Class_Cliente> (LogN_Class_Accion.Agreger,xObjCLi));
             
             
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
    }

    @Override
    public void altaProv(Dom_Class_Proveedor xObjProv) throws InputException {
         xObjProv.validar();
        try {
            
             PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                     ("SELECT Fuc_AltaProv (?, ?, ?, ?, ?, ?, ?, ?,?)");
             
             Ps.setString(1, xObjProv.getmRasSos());
             Ps.setString(2, xObjProv.getmLoc());
             Ps.setString(3, xObjProv.getmDir());
             Ps.setString(4, xObjProv.getmRut());
             Ps.setInt (5, xObjProv.getmCondicionIva());
             Ps.setString(6, xObjProv.getmNumDoc());
             Ps.setInt(7, xObjProv.getmTipDoc());
             Ps.setInt(8, xObjProv.getmObjPais().getNum());
             Ps.setInt(9, xObjProv.getmObjProvDep().getNum());
             
             ResultSet Rs = Ps.executeQuery();
             Rs.next();
             xObjProv.setmNum(Rs.getInt(1));
             
             
             for (Dom_Class_Cel ObjCel : xObjProv.getmColCel())altaCel(xObjProv, ObjCel);
             
             for (Dom_Class_Tel ObjTel : xObjProv.getmColTel())altaTel(xObjProv, ObjTel);
             
             for (Dom_Class_Mail ObjMail : xObjProv.getmColMail())altaMail(xObjProv, ObjMail);
             
             for (Dom_Class_Fax ObjFax : xObjProv.getmColFax())altaFax(xObjProv, ObjFax);
             
             for (Dom_Class_Saldo ObjSaldo: xObjProv.getmColSaldo()) altaSaldo(xObjProv, ObjSaldo);
             
             Notificar(new LogN_Class_Accion<Dom_Class_Proveedor> (LogN_Class_Accion.Agreger,xObjProv));
             
             
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
             mObjMySql .closeConecction();
        }
    }

    @Override
    public void altaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
        if(xObjPerEx instanceof Dom_Class_Cliente)this.altaCliente((Dom_Class_Cliente)xObjPerEx);
        else if(xObjPerEx instanceof Dom_Class_Proveedor) this.altaProv((Dom_Class_Proveedor) xObjPerEx);
        this.Notificar(new LogN_Class_Accion<LogN_ClassAb_PerExterna>( LogN_Class_Accion.Agreger ,xObjPerEx));
    }
    
    // <editor-fold defaultstate="collapsed" desc="Metodos Saldo">
    
        private void asignarSaldo(LogN_ClassAb_Persona xObjPer) throws SQLException, InputException {
            int TipPer = -1;

            if(xObjPer instanceof  Dom_Class_Cliente) TipPer = 1;
            else if (xObjPer instanceof Dom_Class_Proveedor) TipPer = 2;
            String Sql = "SELECT `Sal_Valor`, `Sal_LimDeu`, `Sal_LimAcre`, `Sal_FechM`," +
                    "`Mon_Num`, `Mon_Nom`, `Mon_Sig`, `Mon_CotCom`, `Mon_CotVenta`, `Mon_FechMod`, " +
                    "`Pai_Num`, `Pai_Nom` FROM Viw_Saldo WHERE Per_Tip = " + TipPer + " AND Per_Num = " +
                    xObjPer.getmNum();
            ResultSet Rs = mObjMySql.AbrirConection().createStatement().executeQuery(Sql);
            while (Rs.next()){
                Dom_Class_Pais ObjPais = LogN_Class_Fachada.getInstancia().getPais(Rs.getInt("Pai_Num"));
                int NumMon;
                float ValorSaldo, LimAcree, LimDeud, MonCotCom, MonCotVen;
                String  MonSig, MonNom;
                boolean SalTip;
                java.sql.Date FechMSaldo, FechMMoneda;

                ValorSaldo = Rs.getFloat("Sal_Valor");
                
                if (ValorSaldo < 0){
                    SalTip = false;
                    ValorSaldo = ValorSaldo *-1;
                }else
                    SalTip = true;
                
                LimDeud = Rs.getFloat("Sal_LimDeu");
                LimAcree = Rs.getFloat("Sal_LimAcre");
                FechMSaldo = Rs.getDate("Sal_FechM");

                NumMon = Rs.getInt("Mon_Num");
                MonNom = Rs.getString("Mon_Nom");
                MonSig = Rs.getString("Mon_Sig");
                MonCotCom = Rs.getFloat("Mon_CotCom");
                MonCotVen = Rs.getFloat("Mon_CotVenta");
                FechMMoneda = Rs.getDate("Mon_FechMod");

                Dom_Class_Cotisacion ObjCoti = new 
                        Dom_Class_Cotisacion(MonCotVen, MonCotCom, 
                        new java.util.Date(FechMMoneda.getTime()));

                Dom_Class_Moneda ObjMoneda = new Dom_Class_Moneda(MonNom, MonSig, ObjPais, ObjCoti);
                ObjMoneda.setNum(NumMon);
                Dom_Class_Saldo ObjSaldo = new Dom_Class_Saldo(!SalTip, MonCotVen, ObjMoneda, LimAcree, LimDeud);
                ObjSaldo.setMonto(ValorSaldo);
                

                xObjPer.altaSaldo(ObjSaldo);
            }

        }

        @Override
        public void altaSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo)throws InputException{

            int TipPer = -1;
            float MontoSaldo = xObjSaldo.getMonto();
            if (xObjPer instanceof Dom_Class_Cliente) TipPer = 1;
            else if (xObjPer instanceof Dom_Class_Proveedor) TipPer = 2;
            try {         
                PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                             ("INSERT INTO Saldo "
                        + "(`Per_Num`, `Per_Tip`, `Mon_Num`, `Sal_Valor`,`Sal_Tipo`, `Sal_LimDeu`, `Sal_LimAcre`, `Sal_FechM`) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)");

                 Ps.setInt(1, xObjPer.getmNum());
                 Ps.setInt(2, TipPer);
                 Ps.setInt(3, xObjSaldo.getObjMon().getNum());
                // if (xObjSaldo.getAcreedor())MontoSaldo = MontoSaldo*-1; ////no se porque este cambio////
                 Ps.setFloat(4, MontoSaldo);
                 Ps.setBoolean(5, !xObjSaldo.getAcreedor());
                 Ps.setFloat(6, xObjSaldo.getmLimDeudor());
                 Ps.setFloat(7, xObjSaldo.getmLimAceedor());
                 
                 Ps.executeUpdate();
            }

            catch (SQLException ex) {
                throw new InputException(ex.getLocalizedMessage());
            }

        }  

        @Override
        public void bajaSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo)throws InputException{
            
        }

        @Override
        public void modifSaldo (LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldoNu)throws InputException{
            xObjSaldoNu.validar();
            Dom_Class_Saldo ObjSaldoAn = xObjPer.getSaldo(xObjSaldoNu);
            int TipPer = 1; // 1: Clinete 
            if ( xObjPer instanceof  Dom_Class_Proveedor) TipPer = 2;
            
            try {
                PreparedStatement Ps = mObjMySql.AbrirConection().prepareStatement("SELECT Fuc_ModSaldo "
                        + "( ?, ?, ?, ?, ?)");
                Ps.setInt(1, TipPer);
                Ps.setInt(2, xObjPer.getmNum());
                Ps.setInt(3, xObjSaldoNu.getObjMon().getNum());
                Ps.setFloat(4, xObjSaldoNu.getmLimDeudor());
                Ps.setFloat(5, xObjSaldoNu.getmLimAceedor());
                ResultSet Rs  = Ps.executeQuery();
                Rs.next();
                String Res = Rs.getString(1);
                if (!Res.equals("")) throw new InputException (Res);
            } catch (SQLException ex) {
                throw new InputException (ex.getLocalizedMessage());
            }
            
            
            
            ObjSaldoAn.modificar(xObjSaldoNu);
            
            
        }

    // </editor-fold>
    
    
    // <editor-fold defaultstate="collapsed" desc="Metodos Contacto">

            private void asignarContacto(LogN_ClassAb_Persona xObjPer) throws  SQLException, InputException{
                int TipPer = -1;
                if (xObjPer instanceof Dom_Class_Cliente) TipPer = 1;
                else if (xObjPer instanceof Dom_Class_Proveedor) TipPer = 2;


                String Sql = "SELECT `Con_Num`, `Con_Nom`, `Con_Detalle`, `Con_Tipo` "
                        + "FROM Contacto WHERE `Per_Num` = "+ xObjPer.getmNum() +"  AND`Per_Tip` = " + TipPer;

                ResultSet Rs = mObjMySql.AbrirConection().createStatement().executeQuery(Sql);

                while (Rs.next()){
                    String NomCon, DetalleCon;
                    int NumCon = Rs.getInt("Con_Num");
                    NomCon = Rs.getString("Con_Nom");
                    DetalleCon = Rs.getString("Con_Detalle");

                    switch (Rs.getInt("Con_Tipo")){
                        case 1:
                            Dom_Class_Tel ObjTel = new Dom_Class_Tel(NomCon, DetalleCon);
                            ObjTel.setNum(NumCon);
                            xObjPer.altaTel(ObjTel);
                        break;
                        case 2:
                            Dom_Class_Cel ObjCel = new Dom_Class_Cel(NomCon, DetalleCon);
                            ObjCel.setNum(NumCon);
                            xObjPer.altaCel(ObjCel);
                        break;
                        case 3:
                            Dom_Class_Fax ObjFax = new Dom_Class_Fax(NomCon, DetalleCon);
                            ObjFax.setNum(NumCon);
                            xObjPer.altaFax(ObjFax);
                        break;
                        case 4:
                            Dom_Class_Mail ObjMail = new Dom_Class_Mail(NomCon, DetalleCon);
                            ObjMail.setNum(NumCon);
                            xObjPer.altamMail(ObjMail);
                        break;

                    }
                }
            }  
    
        //Metodo Alta Contacto *************************************************

        @Override
        public void altaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
           this.altaContacto(xObjPerEx, xObjCel);
           xObjPerEx.altaCel(xObjCel);
        }

        @Override
        public void altaContacto(LogN_ClassAb_PerExterna xObjPerEx, LogN_ClassAb_Contacto xObjCon) throws InputException {
            
            xObjPerEx.validar();
            xObjCon.validar();
            
            int PerTip = -1;
            String Fuc = "";
            
            if(xObjPerEx instanceof Dom_Class_Cliente )PerTip = 1;
            else if (xObjPerEx instanceof Dom_Class_Proveedor)PerTip = 2;
            
            if (xObjCon instanceof Dom_Class_Cel) Fuc = "Fuc_AltaCel";
            else if (xObjCon instanceof Dom_Class_Tel) Fuc = "Fuc_AltaTel";
            else if (xObjCon instanceof Dom_Class_Mail) Fuc = "Fuc_AltaMail";
            else if (xObjCon instanceof Dom_Class_Fax) Fuc = "Fuc_AltaFax";
            
            try {
                 Statement s = (Statement) mObjMySql .AbrirConection().createStatement();

                 PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                         ("SELECT "+ Fuc + " (?, ?, ?, ?)");

                 Ps.setString(1, xObjCon.getNom());
                 Ps.setString(2, xObjCon.getDetalle());
                 Ps.setInt(3, xObjPerEx.getmNum());
                 Ps.setInt(4, PerTip);

                 ResultSet Rs = Ps.executeQuery();
                 Rs.next();
                 xObjCon.setNum(Rs.getInt(1));
            } catch (SQLException ex) {
                throw new InputException(ex.getLocalizedMessage());
            }finally{
                 mObjMySql .closeConecction();
            }
        }

        @Override
        public void altaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjFax) throws InputException {
            altaContacto(xObjPerEx, xObjFax);
            xObjPerEx.altaFax(xObjFax);
        }

        @Override
        public void altaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjMail) throws InputException {
            altaContacto(xObjPerEx, xObjMail);
            xObjPerEx.altamMail(xObjMail);
        }

        @Override
        public void altaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjCel) throws InputException {
            altaContacto(xObjPerEx, xObjCel);
            xObjPerEx.altaTel(xObjCel);
            
        }

        
        //Metodo Baja Contacto *************************************************
        
        
        @Override
        public void bajaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
            bajaContacto( xObjCel);
            xObjPerEx.bajaCel(xObjCel);
        }
        



        @Override
        public void bajaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjFax) throws InputException {
            bajaContacto(xObjFax);
            xObjPerEx.bajaFax(xObjFax);
        }

        @Override
        public void bajaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjMail) throws InputException {
            bajaContacto(xObjMail);
            xObjPerEx.bajaMail(xObjMail);
        }

        @Override
        public void bajaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjTel) throws InputException {
            bajaContacto(xObjTel);
            xObjPerEx.bajaTel(xObjTel);
        }
        
        private void bajaContacto(LogN_ClassAb_Contacto xObjCon) throws InputException {
            Statement s;
            try {
                s = (Statement) mObjMySql .AbrirConection().createStatement();
                s.executeUpdate("DELETE FROM `Contacto` WHERE `Con_Num` = " + xObjCon.getNum()); 
                Notificar(new LogN_Class_Accion<LogN_ClassAb_Contacto>(LogN_Class_Accion.Eliminar, xObjCon));
            } catch (SQLException ex) {
                throw new InputException(ex.getLocalizedMessage());
            }

        }

       
        //Metodo Modificar Contacto ********************************************
        
      
        @Override
        public void modifCel(Dom_Class_Cel xObjCelAn, Dom_Class_Cel xObjCelNu) throws InputException {
            modifContacto(xObjCelAn, xObjCelNu);
        }

        @Override
        public void modifContacto(LogN_ClassAb_Contacto xObjConAn, LogN_ClassAb_Contacto xObjConNu) throws InputException {
            xObjConAn.modificar(xObjConNu);
            try {
                
                PreparedStatement Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                         ("UPDATE Contacto SET `Con_Nom` = ?, `Con_Detalle` = ? WHERE `Per_Num` = ?");
                Ps.setString(1, xObjConNu.getNom());
                Ps.setString(2, xObjConNu.getDetalle());
                Ps.setInt(3, xObjConAn.getNum());
                Ps.executeUpdate();



            } catch (SQLException ex) {
                throw new InputException(ex.getLocalizedMessage());
            }finally{
                mObjMySql.closeConecction();
            }
        
        }

        @Override
        public void modifFax(Dom_Class_Fax xObjFaxAn, Dom_Class_Fax xObjFaxNu) throws InputException {
            this.modifContacto(xObjFaxAn, xObjFaxNu);
        }

        @Override
        public void modifMail(Dom_Class_Mail xObjCelAn, Dom_Class_Mail xObjCelNu) throws InputException {
            this.modifContacto(xObjCelAn, xObjCelNu);
        }

        @Override
        public void modifTel(Dom_Class_Tel xObjTelAn, Dom_Class_Tel xObjTelNu) throws InputException {
            this.modifContacto(xObjTelAn, xObjTelNu);
        }
        


        
        
        //Metodo Update Contacto ***************************************************
        
        
        private void updateCel (LogN_ClassAb_Persona xObjPerAn, LogN_ClassAb_Persona xObjPerNu) throws InputException{
        
            ArrayList  ColTelAn = new ArrayList<Dom_Class_Cel>(xObjPerAn.getmColCel());
            ArrayList  ColTelNu = new ArrayList<Dom_Class_Cel>(xObjPerNu.getmColCel());

            updateContacto((LogN_ClassAb_PerExterna)xObjPerAn, ColTelAn, ColTelNu);
        }
            
        private void updateTel (LogN_ClassAb_Persona xObjPerAn, LogN_ClassAb_Persona xObjPerNu) throws InputException{

            ArrayList  ColTelAn = new ArrayList<Dom_Class_Tel>(xObjPerAn.getmColTel());
            ArrayList  ColTelNu = new ArrayList<Dom_Class_Tel>(xObjPerNu.getmColTel());

            updateContacto((LogN_ClassAb_PerExterna)xObjPerAn, ColTelAn, ColTelNu);
        }

        private void updateMail (LogN_ClassAb_Persona xObjPerAn, LogN_ClassAb_Persona xObjPerNu) throws InputException{

            ArrayList  ColTelAn = new ArrayList<Dom_Class_Mail>(xObjPerAn.getmColMail());
            ArrayList  ColTelNu = new ArrayList<Dom_Class_Mail>(xObjPerNu.getmColMail());

            updateContacto((LogN_ClassAb_PerExterna)xObjPerAn, ColTelAn, ColTelNu);
        }

        private void updateFax (LogN_ClassAb_Persona xObjPerAn, LogN_ClassAb_Persona xObjPerNu) throws InputException{

            ArrayList  ColTelAn = new ArrayList<Dom_Class_Fax>(xObjPerAn.getmColFax());
            ArrayList  ColTelNu = new ArrayList<Dom_Class_Fax>(xObjPerNu.getmColFax());

            updateContacto((LogN_ClassAb_PerExterna)xObjPerAn, ColTelAn, ColTelNu);
        }

        private void updateContacto (
                LogN_ClassAb_PerExterna xObjPer,
                ArrayList <LogN_ClassAb_Contacto> xColContAn, 
                ArrayList <LogN_ClassAb_Contacto> xColContNu) throws InputException{



            for (LogN_ClassAb_Contacto ObjConNu : xColContNu){

                int Pos = xColContAn.indexOf(ObjConNu);

                if (Pos == -1){
                    this.altaContacto(xObjPer, ObjConNu);
                }else {
                     LogN_ClassAb_Contacto ObjConAn = xColContAn.get(Pos);
                     if (!ObjConAn.duplicado(ObjConNu)) this.modifContacto(ObjConAn, ObjConNu);
                    xColContAn.remove(Pos);
                }
            }

            for (LogN_ClassAb_Contacto ObjContacto : xColContAn){
                this.bajaContacto(ObjContacto);
            }
        }
    
        
    // </editor-fold>

    @Override
    public void bajaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
        Statement s;
        try {
            s = (Statement) mObjMySql .AbrirConection().createStatement();
            s.executeUpdate("DELETE FROM `Persona` WHERE `Per_Num` = " + xObjCLi.getmNum() + 
                    "AND Per_Tip = 1"); 
            Notificar(new LogN_Class_Accion<LogN_ClassAb_Persona>(LogN_Class_Accion.Eliminar, xObjCLi));
        } catch (SQLException ex) {
            
        }
         
    }

    @Override
    public void bajaProv(Dom_Class_Proveedor xObjProv) throws InputException {
        Statement s;
        try {
            s = (Statement) mObjMySql .AbrirConection().createStatement();
            s.executeUpdate("DELETE FROM `Persona` WHERE `Per_Num` = " + xObjProv.getmNum() + 
                    "AND Per_Tip = 2"); 
            Notificar(new LogN_Class_Accion<LogN_ClassAb_Persona>(LogN_Class_Accion.Eliminar, xObjProv));
        } catch (SQLException ex) {
            
        }
    }

    @Override
    public void bajaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
        if(xObjPerEx instanceof Dom_Class_Cliente)bajaCliente((Dom_Class_Cliente)xObjPerEx);
        else if (xObjPerEx instanceof Dom_Class_Proveedor) bajaProv((Dom_Class_Proveedor) xObjPerEx);
    }

    @Override
    public void ModCliente(Dom_Class_Cliente xObjCliAn, Dom_Class_Cliente xObjCliNu) throws InputException {
        xObjCliNu.validar();
        
        updateCel(xObjCliNu, xObjCliNu);
        updateTel(xObjCliNu, xObjCliNu);
        updateMail(xObjCliNu, xObjCliNu);
        updateFax(xObjCliNu, xObjCliNu);
        
        xObjCliAn.modificar(xObjCliNu);
        

        PreparedStatement Ps;
        try {
            Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                    ("CALL Pro_ModCli(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            Ps.setInt(1, xObjCliAn.getmNum());
            Ps.setString(2, xObjCliNu.getmRasSos());
            Ps.setString(3, xObjCliNu.getmLoc());
            Ps.setString(4, xObjCliNu.getmDir());
            Ps.setString(5, xObjCliNu.getmRut());
            Ps.setInt (6, xObjCliNu.getmCondicionIva());
            Ps.setString(7 , xObjCliNu.getmNumDoc());
            Ps.setInt(8, xObjCliNu.getmTipDoc());
            Ps.setInt(9, xObjCliNu.getmObjPais().getNum());
            Ps.setInt(10, xObjCliNu.getmObjProvDep().getNum());
            
            Ps.execute();
        
        } catch (SQLException ex) {
           throw new InputException(ex.getLocalizedMessage());
        }

        
    }
    
    @Override
    public void ModProv(Dom_Class_Proveedor xObjProvAn, Dom_Class_Proveedor xObjProvNu) throws InputException {
        xObjProvNu.validar();
        
        updateCel(xObjProvNu, xObjProvNu);
        updateTel(xObjProvNu, xObjProvNu);
        updateMail(xObjProvNu, xObjProvNu);
        updateFax(xObjProvNu, xObjProvNu);
        
        xObjProvAn.modificar(xObjProvNu);
        

        PreparedStatement Ps;
        try {
            Ps = (PreparedStatement) mObjMySql.AbrirConection().prepareStatement
                    ("CALL Pro_ModProv(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            Ps.setInt(1, xObjProvAn.getmNum());
            Ps.setString(2, xObjProvNu.getmRasSos());
            Ps.setString(3, xObjProvNu.getmLoc());
            Ps.setString(4, xObjProvNu.getmDir());
            Ps.setString(5, xObjProvNu.getmRut());
            Ps.setInt (6, xObjProvNu.getmCondicionIva());
            Ps.setString(7 , xObjProvNu.getmNumDoc());
            Ps.setInt(8, xObjProvNu.getmTipDoc());
            Ps.setInt(9, xObjProvNu.getmObjPais().getNum());
            Ps.setInt(10, xObjProvNu.getmObjProvDep().getNum());
            
            Ps.execute();
        
        } catch (SQLException ex) {
           throw new InputException(ex.getLocalizedMessage());
        }
    }

    @Override
    public void ModPersonaEx(LogN_ClassAb_PerExterna xObjPerExAn, LogN_ClassAb_PerExterna xObjPerExNu) throws InputException {
        if (xObjPerExAn instanceof Dom_Class_Cliente) ModCliente((Dom_Class_Cliente) xObjPerExAn, (Dom_Class_Cliente)xObjPerExNu);
        else if (xObjPerExNu instanceof Dom_Class_Proveedor) ModProv((Dom_Class_Proveedor)xObjPerExAn, (Dom_Class_Proveedor)xObjPerExNu);
    }

    @Override
    public int getNumProv() {
        try {
            Statement s = (Statement) mObjMySql .AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select * from Viw_NumProv");
            Rs.next();
            return Rs.getInt(1);

        } catch (SQLException ex) {
            return 1;
        }
    }

    @Override
    public int getNumCli() {
        try {
            Statement s = (Statement) mObjMySql .AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select * from Viw_NumCli");
            Rs.next();
            return Rs.getInt(1);

        } catch (SQLException ex) {
            return 1;
        }
    }

    @Override
    public LogN_Class_ModeljTabClienteMysql getModJtabClienteMysql() {
        LogN_Class_ModeljTabClienteMysql ObjModTab  = new LogN_Class_ModeljTabClienteMysql(null);
        this.addObservadorPersona(ObjModTab);
        return ObjModTab;
    }

    @Override
    public LogN_Class_ModeljTabProveedorMysql getModJtabProvMysql() {
        LogN_Class_ModeljTabProveedorMysql ObjModTab = new LogN_Class_ModeljTabProveedorMysql(null);
        this.addObservadorPersona(ObjModTab);
        return ObjModTab;
    }
    
    
    

    @Override
    public Dom_Class_Cliente getCliente(int NumCli) {
        
        Dom_Class_Cliente ObjRes = null;
        String Sql = "SELECT * FROM Viw_Cliente WHERE Per_Num = " + NumCli;
        try {
            ResultSet Rs = mObjMySql.AbrirConection().createStatement().executeQuery(Sql);
            if (!Rs.next()) return null;
            
            int NumPer, TipDoc, CodIva;
            
            
            String RasSos, Localidad, Direccion, NumDoc, Rut,
                    FechP_Tipo;
            LogN_ClassAb_FechPag ObjFp = null;
            
            
            NumPer = Rs.getInt("Per_Num");
            RasSos = Rs.getString("Per_RasSos");
            Localidad = Rs.getString("Per_Localidad");
            Direccion = Rs.getString("Per_Direccion");
            NumDoc = Rs.getString("Per_Docum");
            TipDoc = Rs.getInt("Per_TipDocum");
            CodIva = Rs.getInt("Per_CondIva");
            Rut = Rs.getString("Per_Rut");
            
            FechP_Tipo = Rs.getString("FechP_Tipo");
            if (FechP_Tipo != null){
                switch (FechP_Tipo){
                case "Anual":
                    ObjFp = new Dom_Class_FechPAño(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime())
                            , Rs.getInt("FechP_Mes"), Rs.getInt("FechP_Dia"));
                break;
                case "Mensual":
                    ObjFp = new Dom_Class_FechPMensual(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime()),
                            Rs.getInt("FechP_Dia"));
                break;
                case "Diario":
                    ObjFp = new Dom_Class_FechPDiario(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime()));
                break;
                default:
                    ObjFp = null;
                } // Fin switch
            }// Fin if
            
            
            
            LogN_Class_Fachada ObjFachada = LogN_Class_Fachada.getInstancia();
            Dom_Class_Pais ObjPais = ObjFachada.getPais(Rs.getInt("Pai_Num"));
            Dom_Class_ProvinDepar ObjProvD = 
                    ObjPais.getProvDep(new Dom_Class_ProvinDepar(Rs.getString("ProvD_Nom")));
            // Obtiene el cliente;
            ObjRes = new Dom_Class_Cliente(Direccion, Localidad, NumDoc, TipDoc, Rut, ObjPais, ObjProvD, "", RasSos, CodIva, ObjFp);
            ObjRes.setmNum(NumPer);
            
            this.asignarContacto (ObjRes);
            
            this.asignarSaldo (ObjRes);
            
        } catch (SQLException ex) {
            return null;
        } catch (InputException ex){
            return null;
        }
        
        return ObjRes;
    }

    @Override
    public Dom_Class_Proveedor getProveedor(int NumProv) {
        
        Dom_Class_Proveedor ObjRes = null;
        String Sql = "SELECT * FROM Viw_Proveedor WHERE Per_Num = " + NumProv;
        try {
            ResultSet Rs = mObjMySql.AbrirConection().createStatement().executeQuery(Sql);
            if (!Rs.next()) return null;
            
            int NumPer, TipDoc, CodIva;
            
            String RasSos, Localidad, Direccion, NumDoc, Rut,
                    FechP_Tipo;
            
            LogN_ClassAb_FechPag ObjFp;
            
            NumPer = Rs.getInt("Per_Num");
            RasSos = Rs.getString("Per_RasSos");
            Localidad = Rs.getString("Per_Localidad");
            Direccion = Rs.getString("Per_Direccion");
            NumDoc = Rs.getString("Per_Docum");
            TipDoc = Rs.getInt("Per_TipDocum");
            CodIva = Rs.getInt("Per_CondIva");
            Rut = Rs.getString("Per_Rut");
            
            
             FechP_Tipo = Rs.getString("FechP_Tipo");
            
            switch (FechP_Tipo){
                case "Anual":
                    ObjFp = new Dom_Class_FechPAño(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime())
                            , Rs.getInt("FechP_Mes"), Rs.getInt("FechP_Dia"));
                break;
                case "Mensual":
                    ObjFp = new Dom_Class_FechPMensual(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime()),
                            Rs.getInt("FechP_Dia"));
                break;
                case "Diario":
                    ObjFp = new Dom_Class_FechPDiario(Rs.getInt("FechP_Intervalo"), 
                            Rs.getInt("FechP_Aviso"), 
                            new java.util.Date(Rs.getDate("FechP_FechAlta").getTime()));
                break;
                default:
                    ObjFp = null;
                    
            } // Fin switch
            
            LogN_Class_Fachada ObjFachada = LogN_Class_Fachada.getInstancia();
            Dom_Class_Pais ObjPais = ObjFachada.getPais(Rs.getInt("Pai_Num"));
            Dom_Class_ProvinDepar ObjProvD = 
                    ObjPais.getProvDep(new Dom_Class_ProvinDepar(Rs.getString("ProvD_Nom")));
            
            
            // Obtiene el cliente;
            ObjRes = new Dom_Class_Proveedor(Direccion, Localidad, NumDoc, TipDoc, Rut, ObjPais, ObjProvD, "", RasSos, CodIva, ObjFp);
            
            this.asignarContacto (ObjRes);
            
            this.asignarSaldo (ObjRes);
            
        } catch (SQLException ex) {
            return null;
        } catch (InputException ex){
            return null;
        }
        
        return ObjRes;
    }

    
    
    @Override
    public void addObservadorPersona(Observer xObjObser) {
        super.addObserver(xObjObser);
    }

    @Override
    public void removObservadorPersona(Observer xObjObser) {
        super.deleteObserver(xObjObser);
    }
  
    private void Notificar (LogN_Class_Accion xObjAcion){
        super.setChanged();
        super.notifyObservers(xObjAcion);
    }


}
