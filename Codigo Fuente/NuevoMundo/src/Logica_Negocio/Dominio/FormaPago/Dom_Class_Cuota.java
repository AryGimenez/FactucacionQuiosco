package Logica_Negocio.Dominio.FormaPago;

import Logica_Negocio.Dominio.Dom_Class_Resibo;
import java.util.Date;

import Logica_Negocio.LogN_Inter_Validar;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;

public class Dom_Class_Cuota implements LogN_Inter_Validar {
    //Atributos______________________________________________________
	
	/**
	 * <B>Pagar la siguiente cuota:</B> <Br>
	 * Si el recibo ingresado en el mótodo pagar es mayor al monto de la 
	 * cuota pagara la siguiente cuota del credito al que pertenece la misma
	 */
	public static byte OpPag_SigCuota = 0;

	/**
	 * <B>Distribuir en las cuotas:</B> <Br>
	 * Si el recibo ingresado en el mótodo pagar es mayor al monto de la 
	 * cuota distribuye el valor sobrante en las otras cuotas del crídito al que pertenece la misma.
	 */
	public static byte OpPag_DisCuota = 1;
	/**
	 * <B>Acredita deuda cliente:</B> <Br>
	 * Si el recibo ingresado en el método pagar es mayor al monto de la cuota y no ay m�s cuotas a pagar el resto del monto del resido va al saldo de el cliente
	 */
	public static byte OpPag_AcrDeud = 2;
	
	
	/**
	 * Conexi�n de recibo con el cual se pagó la cuota
	 */
	private ArrayList <Dom_Class_Resibo> mColResibo;
    /**
     * Fecha de Vencimiento de la cuota
     */
    private Date mFechVen;

    
    /**
     * Monto a pagar de la cuota
     */
    private float mMonto;
    
    private float mMontoPago = 0;
    /**
     * Crédito al que pertenece esta cuota
     */
    private Dom_Class_Credito mObjCred;
    
    private boolean mPago = false;
    
    /**
     * Número que identifica a la cuota en el crédito
     */
    private int mNumCuot;
    //Constructor______________________________________________________

    /**
     * Constructor Completo de la factura 
     * @param mFechVen Fecha de Vencimiento de la cuota
     * @param mMonto Monto a pagar de la cuota
     * @param mObjCred Crédito al que pertenece esta cuota
     * @param mNumCuot Número que identifica a la cuota en el crédito
     */
    public Dom_Class_Cuota(Date mFechVen, float mMonto, Dom_Class_Credito mObjCred, int mNumCuot) {
        this.mFechVen = mFechVen;
        this.mMonto = mMonto;
        this.mObjCred = mObjCred;
        this.mNumCuot = mNumCuot;
    }

    public Date getmFechVen() {
        return mFechVen;
    }

    public void setmFechVen(Date mFechVen) {
        this.mFechVen = mFechVen;
    }

    public float getmMonto() {
        return mMonto;
    }

    public void setmMonto(float mMonto) {
        this.mMonto = mMonto;
    }

    public int getmNumCuot() {
        return mNumCuot;
    }
    
    public Dom_Class_Credito getmObjCred() {
        return mObjCred;
    }

    public void setmObjCred(Dom_Class_Credito mObjCred) {
        this.mObjCred = mObjCred;
    }
    
    public void pagar (Dom_Class_Resibo xObjResibo){
        
    }
    
    public ArrayList<Dom_Class_Resibo> getColResibo (){
    	return mColResibo;
    }
    
    public boolean getPago(){
    	return mPago;
    }
    
    
    
    
    @Override
    public void validar() throws InputException {
            // TODO Auto-generated method stub

    }
    
    public float monoAPagar (){
    	return mMonto - mMontoPago;
    }
    
    
    

}
