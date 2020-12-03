/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio;



import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author Ary
 */
public abstract class LogN_ClassAb_Credito implements LogN_Inter_Validar{
      //Atrigutos_______________________________________________________________________
	/**
	 * Cantidad de cuotas
	 */
	protected byte mCanCuot = 0;
        /**
         * Recargo de del credito
         */
        protected float mRec = 0;
	/**
	 * Tipo de periodo anual
	 */
	public static byte Tip_Anual = 1;
	/**
	 * Tipo de periodo mensual
	 */
	public static byte Tip_Mensual = 2;
	/**
	 * Tipo de periodo por d�as 
	 */
	public static byte Tip_Dial = 3;
	/**
	 * Cr�dito sin cuotas 
	 */
	public static byte Tip_SinCuota = 4;
	/**
	 * Tipo de periodo seleccionado en este cr�dito
	 */
	protected byte mTipCuotSelec;
	/**
	 * El intervalo del periodo seleccionado eso decir cada cuanto Meses, Años, o d�as se genera una cuota
	 */
	protected byte mIntervalo;

	//Constructor_____________________________________________________________________
        
        
        

        /**
         * 
         * @param xDiaEn
         * @param xFechVen
         * @param mCanCuot
         * @param mTipCuotSelec
         * @param mIntervalo
         * @param xMont
         * @param xObjMoneda
         * @param mRecargo
         * @throws InputException 
         */
	public LogN_ClassAb_Credito (byte mCanCuot, byte mTipCuotSelec, byte mIntervalo, float mRecargo) throws InputException{
		this.mCanCuot = mCanCuot;
		this.mTipCuotSelec = mTipCuotSelec;
		this.mIntervalo = mIntervalo;
		
		
		
	}

    @Override
    public void validar() throws InputException {

    }

    /**
	 * Cantidad de cuotas
	 */
    public byte getmCanCuot(){
        return mCanCuot;
    }

    /**
     * Recargo de del credito
     */
    public float getmRec(){
        return mRec;
    }

    /**
     * Recargo de del credito
     * 
     * @param newVal
     */
    public void setmRec(float newVal){
        mRec = newVal;
    }

    /**
     * Cantidad de cuotas
     * 
     * @param newVal
     */
    public void setmCanCuot(byte newVal){
        mCanCuot = newVal;
    }

    /**
     * Tipo de periodo seleccionado en este cr�dito
     */
    public byte getmTipCuotSelec(){
        return mTipCuotSelec;
    }

    /**
     * Tipo de periodo seleccionado en este cr�dito
     * 
     * @param newVal
     */
    public void setmTipCuotSelec(byte newVal){
        mTipCuotSelec = newVal;
    }

    /**
     * El intervalo del periodo seleccionado eso decir cada cuanto Meses, Años, o
     * d�as se genera una cuota
     */
    public byte getmIntervalo(){
        return mIntervalo;
    }

    /**
     * El intervalo del periodo seleccionado eso decir cada cuanto Meses, Años, o
     * d�as se genera una cuota
     * 
     * @param newVal
     */
    public void setmIntervalo(byte newVal){
        mIntervalo = newVal;
    }

}
