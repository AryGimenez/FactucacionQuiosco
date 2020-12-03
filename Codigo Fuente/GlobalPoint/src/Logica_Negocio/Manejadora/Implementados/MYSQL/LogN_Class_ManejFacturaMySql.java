/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Implementados.MYSQL;

import Logica_Negocio.Manejadora.MYSQL.jTabModel.LogN_Class_ModeljTabFacturaMsql;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacCom;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.Dominio.FormaPago.Dom_Class_Contado;
import Logica_Negocio.Dominio.FormaPago.Dom_Class_Credito;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.LogN_Inter_FormaPag;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Logica_Negocio.Manejadora.LogN_Inter_ManejFactura;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observable;
import java.util.Observer;



/**
 *
 * @author horacio
 */
public class LogN_Class_ManejFacturaMySql extends Observable implements LogN_Inter_ManejFactura{
    private Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();

    @Override
    public void altaFacVen(Dom_Class_FacVen xObjFacVen, boolean xPresupuesto) throws InputException {
        xObjFacVen.validar();
        try {
            
            
            
             PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement
                     ("SELECT Fuc_AltaFacVen( ?, ?)");
             
             java.util.Date FechFac = xObjFacVen.getFech();
             java.sql.Date FechBd = new java.sql.Date(FechFac.getTime());
             
             Ps.setDate(1, FechBd);
             
             Dom_Class_Cliente ObjCli =  (Dom_Class_Cliente) xObjFacVen.getPersona();
             int NumCli = -1;
             if (ObjCli != null)
                 NumCli = ObjCli.getmNum();
             
             Ps.setInt(2, NumCli);
             
             
             ResultSet Rs = Ps.executeQuery();
             Rs.next();
             xObjFacVen.setNum(Rs.getInt(1));
             
             AltaLin(xObjFacVen);
             
             this.altaForPago(xObjFacVen);
             
             
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }finally{
             mObjMiSql.closeConecction();
        }
    }
    
    
    private void AltaLin (LogN_ClassAb_Factura xObjFac) throws SQLException{
        boolean TipFach = false ;
        if (xObjFac instanceof Dom_Class_FacVen) TipFach = true;
        
        PreparedStatement Ps = (PreparedStatement) mObjMiSql.AbrirConection().prepareStatement
                     ("INSERT INTO LineaFactura (`Pro_CodIn`, `Fac_Serie`, `Fac_Num`, `Fac_Tip`, "
                + "`LinF_PrePro`, `LinF_Iva`, `LinF_CanProd`, `LinF_Des`) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        for (LogN_ClassAb_LineaFac ObjLF : xObjFac.getmColLinF()) {
            Ps.setInt(1, ObjLF.getmObjArt().getmProd_Cod());
            Ps.setString(2, "" + xObjFac.getmSerFac());
            Ps.setInt(3,xObjFac.getNum());
            Ps.setBoolean(4, TipFach);
            Ps.setDouble(5, ObjLF.getmPrePro());
            Ps.setDouble(6, ObjLF.getmIva());
            Ps.setDouble(7, ObjLF.getmCan());
            Ps.setDouble(8, ObjLF.getResDes());
            Ps.executeUpdate();
        }
        
    }

    @Override
    public void altaFactura(LogN_ClassAb_Factura xObjFactura, boolean xPresupuesto) throws InputException {
        if(xObjFactura instanceof Dom_Class_FacVen)altaFacVen((Dom_Class_FacVen) xObjFactura,xPresupuesto);
        else altaFacCom((Dom_Class_FacCom) xObjFactura);

    }

    @Override
    public void altaFacCom(Dom_Class_FacCom xObjFacCom) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_FacVen getFacVen(int NumFac, char Car) {
       return null;
    }

    @Override
    public Dom_Class_FacCom getFacCom(int NumFac, char Car) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> listarFactura() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> listarFactura(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<Dom_Class_FacVen> listarFacturaVen(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<Dom_Class_FacCom> listarFacturaCom(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_FacVen NuevaFachVen() {
        try {
            int NumF = -1;
            char Sigal = 'A';
            Statement s = (Statement) mObjMiSql .AbrirConection().createStatement();
            ResultSet Rs = s.executeQuery("select * from Viw_NumFacVen");
            Rs.next();
            NumF = Rs.getInt(1);
            return new Dom_Class_FacVen(NumF, Sigal);
        } catch (SQLException ex) {
           return null;
        } finally {
            mObjMiSql.closeConecction();
        }
    }

    @Override
    public void addObservadorFactura(Observer xObjObser) {
        super.addObserver(xObjObser);
    }

    @Override
    public void removObservadorFactura(Observer xObjObser) {
        this.deleteObserver(xObjObser);
    }
    
    public LogN_ClassAb_ModeljTabFactura getModelLf(boolean xTipoF){
        LogN_Class_ModeljTabFacturaMsql ObjModF = new LogN_Class_ModeljTabFacturaMsql(xTipoF);
        addObservadorFactura(ObjModF);
        return ObjModF;
    }

    private void altaForPago(LogN_ClassAb_Factura xObjFactura)throws InputException {
        

        for (LogN_Inter_FormaPag ObjForP : xObjFactura.getmColForPag())
           // CONTADO
            if(ObjForP.getTipo().equals(Dom_Class_Contado.TIPO))
                this.altaForPagoContado((Dom_Class_Contado)ObjForP, xObjFactura);
            // CREDITO
            else if (ObjForP.getTipo().equals(Dom_Class_Credito.TIPO))
                this.altaForPagoCredito((Dom_Class_Credito) ObjForP, xObjFactura);
    }
    
    
    private void altaForPagoContado(Dom_Class_Contado xObjContado, LogN_ClassAb_Factura xObjFactura)throws InputException{
        try {
            PreparedStatement Ps;
            boolean tipFac = (xObjFactura instanceof Dom_Class_FacVen);
            
            Ps = mObjMiSql.AbrirConection().prepareStatement
                    ("CALL Pro_AltaContado "
                    + "(?, ?, ?, ?, ?)");
            Ps.setInt(1,xObjFactura.getNum()); //pFac_Num: Numero factura 
            Ps.setString(2, "A"); //pFac_Serie: Serie factura
            Ps.setBoolean(3, tipFac); // pFac_Tip: Tipo factura true Venta false Compra
            Ps.setInt (4, xObjFactura.getMoneda().getNum()); // //pMon_Num: Moneda de la factura 
            Ps.setDouble(5, xObjContado.getMonto()); // pForP_MonAPag: Monto a pagar

            Ps.execute();
        } catch (SQLException ex) {
            throw new InputException(ex.getLocalizedMessage());
        }
    }
    
    private void altaForPagoCredito(Dom_Class_Credito xObjCredito, LogN_ClassAb_Factura xObjFactura)throws InputException{
       String Error = "";
        try {
            
            PreparedStatement Ps;
            boolean tipFac = (xObjFactura instanceof Dom_Class_FacVen); 
            
            Ps =  mObjMiSql.AbrirConection().prepareStatement
                ("SELECT Fuc_AltaCredito(?,?,?,?,?,?,?,?,?,?)");

            Ps.setInt(1,xObjFactura.getNum()); //pFac_Num: Numero factura 
            Ps.setString(2, "A"); //pFac_Serie: Serie factura
            Ps.setBoolean(3, tipFac); // pFac_Tip: Tipo factura true Venta false Compra
            Ps.setInt (4, xObjFactura.getMoneda().getNum()); // //pMon_Num: Moneda de la factura 
            Ps.setDouble(5, xObjCredito.getMonto()); // pForP_MonAPag: Monto a pagar
            Ps.setInt(6, -1);// pIn_Mon : Intereses asignados a este forma de pago
            Ps.setInt(7, xObjCredito.getmCanCuot()); // pCre_CanCuo: Cantidad de cuots 
            Ps.setInt(8, xObjCredito.getmTipCuotSelec());//pCre_Tipo: Tipo de cuota seleccionada
            Ps.setInt(9, xObjCredito.getmIntervalo());//pCre_Intervalo: Intervalo de las cuotas es decir la cantidad de dias que pasan entre cuota y cuota
            java.sql.Date FechPago = new java.sql.Date(xObjCredito.getmFechPago().getTime());
            Ps.setDate(10, FechPago);// pCre_VencIni: Fecha de inicio de pago de factura.

            ResultSet Rs = Ps.executeQuery(); // Retorna el mesaje de error 
            Rs.next();
            
            Error = Rs.getString(1);
 
        } catch (SQLException ex) {
            Error = ex.getLocalizedMessage();
        }finally{
            mObjMiSql.closeConecction();
        }
        
        if (!Error.equals("")) throw new InputException(Error);
}

                  
    
            
    
    


}
    