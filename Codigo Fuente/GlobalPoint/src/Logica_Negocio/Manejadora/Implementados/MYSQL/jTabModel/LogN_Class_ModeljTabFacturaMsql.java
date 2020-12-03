/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.MYSQL.jTabModel;



import Logica_Negocio.Filtros.Factura.LogN_Class_FilFacturaFecha;
import Logica_Negocio.Filtros.Factura.LogN_Inter_FiltFactura;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.sql.Date;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author ary
 */
public class LogN_Class_ModeljTabFacturaMsql extends LogN_ClassAb_ModeljTabFactura implements Observer {
    //Atributos_________________________________________________________________
    private String [] mTitel = {"Codigo ","Fecha Hora",  "", "Sub Total", "Descuento", "IVA. Tb", "IVA. Tm", "Total" };
    //Tipo de Factur True: Venta False: Compra
    private boolean mTipF;
    private String mListarFDe, mTipPer;
    private Per_Class_ConecElPam mObjMYsql = new Per_Class_ConecElPam();
    private Statement state ;
    private ResultSet rec;
    private LogN_Class_Fachada mObjFach = LogN_Class_Fachada.getInstancia();
    private int filas = 0;
    
    private float mSubT , mIvaTb, mIvaTm, mDes = 0;
    
    //Constructor_______________________________________________________________
    
    public LogN_Class_ModeljTabFacturaMsql (boolean mTipF){
        
        this.setmTipF(mTipF);
        
    }
    
    //Metodos___________________________________________________________________
    
    public void setmTipF (boolean mTipF){
        this.mTipF = mTipF;
        if (mTipF){
            mListarFDe = "Viw_FacturaVen";
            mTipPer = "Cli_Num";
            this.mTitel[2] = "Cliente";
        } else {
            mListarFDe = "Viw_FacturaCom";
            mTipPer = "Prov_Num";
            this.mTitel[2] = "Cliente";
        }
        
        
        this.actualizar();
        
    }


    private void actualizar (){
        try {
            
            
            mObjMYsql.closeConecction();
            String Con = this.TraducirFlitro();
            if (!Con.equals("")) Con = " WHERE " + Con;
            
            state = (Statement) mObjMYsql.AbrirConection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
           String SetSal= "SELECT `Fac_Num`, `Fac_Serie`, `Fac_Fech`, `Per_RasSos`, `Fac_SubTot`, "
                    + "`Fac_Des`, `Fac_ReIvaTm`, `Fac_ReIvaTb`, `Fac_Total`, "
                    + mTipPer + ", `Per_Tip`, `Fac_IvaTb`, `Fac_IvaTm` FROM ElPam." + mListarFDe + " " + Con;
           rec = state.executeQuery(SetSal);
           
           super.fireTableDataChanged();
           CargarTotales();
           
        } catch (SQLException ex) {
            Logger.getLogger(LogN_Class_ModeljTabProductoMySql.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void CargarTotales () throws SQLException{
        float SubT, Des, IvaTb, IvaTm;
        SubT = Des = IvaTb = IvaTm = 0;
        
        for (int i = 1; getRowCount() >= i; i++){
            rec.absolute(i);

            SubT += rec.getFloat("Fac_SubTot");
            Des += rec.getFloat("Fac_Des");
            IvaTb += rec.getFloat("Fac_ReIvaTb");
            IvaTm += rec.getFloat("Fac_ReIvaTm");
        }
        
        mSubT = SubT;
        mDes = Des;
        mIvaTb = IvaTb;
        mIvaTm = IvaTm;
        
    }

    private String TraducirFlitro (){
        LogN_Inter_FiltFactura ObjFil = getFiltro();

         
         String Condicion = "";
         if (ObjFil instanceof LogN_Class_FilFacturaFecha){
             LogN_Class_FilFacturaFecha ObjFilF = (LogN_Class_FilFacturaFecha) ObjFil; 
             ArrayList<java.util.Date> ColF = ObjFilF.getmCondicion();
             java.sql.Date ObjF1 = new Date (ColF.get(0).getTime())
                     , ObjF2 = new Date (ColF.get(1).getTime());
             
             Condicion = "Fac_Fech >= '" + ObjF1 + "' AND Fac_Fech <= '" + ObjF2 + "'";
         }


         return Condicion ;
    }

    @Override
    public int getRowCount() {
       
        	try {
                    rec.last();
                    this.filas = rec.getRow();
        	}
                catch (SQLException e) {}
     
        return filas;
    }

    @Override
    public Object getValueAt(int r, int c) {
    	Object x=null;
        try {
            rec.absolute(r+1);
            if (c == 0)
                x= rec.getObject(c+1).toString() + " " + rec.getObject(c+2).toString();
            else x = rec.getObject(c+2);
    	}
        catch (SQLException e){}
    	return x;
    }

    @Override
    public int getColumnCount(){
        return  mTitel.length;
    }

    @Override
    public String getColumnName(int c) {
        return mTitel[c];
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return false;
    }


    public boolean setSizeColumnsToFit(){
    	return false;
    }
    
     @Override
    public Class<?> getColumnClass(int columnIndex) {
         try{
             return getValueAt(0, columnIndex).getClass();
         } catch (java.lang.NullPointerException Ex){
             return new String ().getClass();
         }
        
    }

    @Override
    public void update(Observable o, Object arg) {
        if (! (arg instanceof  LogN_Class_Accion)) return ;
        LogN_Class_Accion<Object> ObjA = (LogN_Class_Accion) arg;

        if (!(ObjA.getmAccionar() instanceof LogN_ClassAb_Factura)) return;

                this.actualizar();
                  
        }



    @Override
    public void setFlitro(LogN_Inter_FiltFactura xObjFil) {
        super.setFlitro(xObjFil);
        actualizar();
    }

    
    @Override
    public LogN_ClassAb_Factura getFactura(int rowIndes) {
//        rec.absolute(rowIndes + 1);
//        
//        Integer NumF = rec.getInt("Fac_Num");
//        String SigF = rec.getString("Fac_Serie");
//        return mObjFach.getFacCom(filas, Car);
        return null;
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> listarFacturas() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public float getSubTotal (){
        return mSubT;
    }
    
    @Override
    public float getDescuento(){
        return mDes;
    }
    
    @Override
    public float getIvaTb (){
        return mIvaTb;
    }
    
    @Override
    public float getIvaTm (){
        return mIvaTm;
    }




}
