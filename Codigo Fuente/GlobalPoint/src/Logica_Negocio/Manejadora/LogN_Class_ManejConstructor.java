/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;



import Logica_Negocio.Manejadora.Implementados.MYSQL.*;
import Logica_Negocio.Manejadora.MYSQL.LogN_Class_ManejPaisMySql;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author ary
 */
public class LogN_Class_ManejConstructor {

    //Atributos_________________________________________________________________
    /**
     * <b>Crea todos los datos en memoria</b> sin persistir nunguno.<br>
     * Es decir que los datos se pierden al cerrar el programa.
     */
    public static final int CrearMemoria = 0;
    /**
     * <b>Crea los datos utilizado base de datos OpenOffice.</b> <br>
     * Es decir que guarda los datos en disco y nos da una versión potable.
     */
    public static final int CrearODBC = 1;

     /**
     * <b>Crea los datos utilizado base de datos OpenOffice.</b> <br>
     * Es decir que guarda los datos en disco y nos da una versión potable.
     */
    public static final int CrearMySql = 2;

    /**
     * <b>Guarda la opción actual</b> de persistir la información
     */
    public final int SeleccionActual;

    private LogN_Inter_ManejProducto mObjManProd;
    private LogN_Inter_ManejCategoria mObjManCat;
    private LogN_Inter_ManejMoneda mObjManMoneda;
    private LogN_Inter_ManejFactura mObjManFactura;
    private LogN_Inter_ManejMovimiento mObjManMov;
    private LogN_Inter_ManejPais mObjManPais;
    private LogN_Inter_ManejPersona mObjManPersona;
    private LogN_Inter_ManejIVA mObjManIVA;
    private LogN_Inter_ManejRecibo mObjManRes;
    private LogN_Inter_ManejReportComun mObjManRepComun;
    
    //Constructor_______________________________________________________________
    public LogN_Class_ManejConstructor(int SeleccionActual)throws InputException {

        this.SeleccionActual = SeleccionActual;
        switch (SeleccionActual){
            case CrearMemoria: this.CrarEnMemoria(); break;
            case CrearODBC: this.CrearEnODBC(); break;
            case CrearMySql: this.CrearEnMySql(); break;
            default:
                
                mObjManCat = null;
                mObjManProd = null;
                mObjManMoneda = null;
                mObjManFactura = null;
                mObjManPais = null;
                mObjManPersona = null;
                mObjManIVA = null;
                mObjManRes = null;
                throw new InputException("Opción fuera de rango");
                
        }

    }

    public LogN_Class_ManejConstructor()throws InputException {
        CrearEnMySql();
        SeleccionActual = CrearMySql;
    }

    //Metodos___________________________________________________________________
    public LogN_Inter_ManejProducto getManejProducto (){
        return mObjManProd;
    }

    public LogN_Inter_ManejCategoria getManejCategoria(){
        return mObjManCat;
    }

    public LogN_Inter_ManejMoneda getManejMoneda() {
        return mObjManMoneda;
    }

    public LogN_Inter_ManejMovimiento getMajMovimiento(){
        return mObjManMov;
    }

    public LogN_Inter_ManejPais getMajPais(){
        return mObjManPais;
    }
    
    public LogN_Inter_ManejPersona getManejPersona(){
        return mObjManPersona;
    }

    public LogN_Inter_ManejIVA getManejIVA() {
        return mObjManIVA;
    }
    
    public LogN_Inter_ManejRecibo getManejRecibo (){
        return mObjManRes;
    }

    public LogN_Inter_ManejReportComun getmObjManRepComun() {
        return mObjManRepComun;
    }
    
    
    


    private void CrarEnMemoria (){

        

    }

    private void CrearEnODBC() {


    }

    private void CrearEnMySql(){
        mObjManCat = new LogN_Class_ManejCategoriaMySql();
        mObjManProd = new LogN_Class_ManejProductoMySql();
        mObjManMov = new LogN_Class_ManejMovimientoMySql();
        mObjManPais = new LogN_Class_ManejPaisMySql();
        mObjManPersona = new LogN_Class_ManejPersonaMysql();
        mObjManMoneda = new LogN_Class_ManejMonedaMySql();
        mObjManFactura = new LogN_Class_ManejFacturaMySql();
        mObjManIVA = new LogN_Class_ManejIvaMysql();
        mObjManRes = new LogN_Class_ManejResiboMySql();
        mObjManRepComun = new LogN_Class_ManejReportComunMySql();
    }

    public LogN_Inter_ManejFactura getManejFactura() {
        return mObjManFactura;
    }




}
