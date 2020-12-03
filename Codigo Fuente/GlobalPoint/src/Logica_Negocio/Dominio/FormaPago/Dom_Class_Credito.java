package Logica_Negocio.Dominio.FormaPago;
import Logica_Negocio.LogN_Inter_FormaPag;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.Dominio.Dom_Class_Resibo;
import Logica_Negocio.LogN_ClassAb_Credito;
import Logica_Negocio.LogN_Class_ValorMoneda;
import Logica_Negocio.MiExepcion.InputException;
import java.util.Date;

/**
 * Cred
 * @author Ary
 * @version 1.0
 * @updated 17-nov-2011 12:39:54 a.m.
 */
public class Dom_Class_Credito extends LogN_ClassAb_Credito implements LogN_Inter_FormaPag{

    /**
     * Valor de la Compuesto por su moneda correspondiente
     */
    protected LogN_Class_ValorMoneda mObjValMon;

    private float mMontAPagar;
    
    
     public static final String TIPO = "Credito"; 
    
    /**
     * Fecha de pago
     */
    private Date mFechPago;

    // Constructor _________________________________________________________

    public Dom_Class_Credito(short xDiaVen, Date xFechVen, byte mCanCuot, byte mTipCuotSelec, byte mIntervalo, float xMont, Dom_Class_Moneda xObjMoneda, float mRecargo) throws InputException {
       
        super(mCanCuot, mTipCuotSelec, mIntervalo, mRecargo);
        this.mObjValMon = new LogN_Class_ValorMoneda(xMont, xObjMoneda);
        mMontAPagar = xMont;
    }
    
    public Dom_Class_Credito (short xDiVen, Date xFechVen ,float xMont, Dom_Class_Moneda xObjMoneda, Dom_Class_PlanCredito xObjPCre) throws InputException{
        
        super(xObjPCre.getmCanCuot(), xObjPCre.getmTipCuotSelec(), xObjPCre.getmIntervalo()
                , xObjPCre.getmRec());
        this.mObjValMon = new LogN_Class_ValorMoneda(xMont, xObjMoneda);
        mMontAPagar = xMont;
    }
        
    public Dom_Class_Credito (float xMonto, Dom_Class_Moneda xObjMoneda, float xObjRecargo, float xMontoAPagar) throws InputException{
        super((byte)0, LogN_ClassAb_Credito.Tip_SinCuota, (byte)0, xObjRecargo);
        this.mObjValMon = new LogN_Class_ValorMoneda(xMonto, xObjMoneda);
        mMontAPagar = xMontoAPagar;
    }
        
        
    //Flta Terminar -------------------------------------------------------
    private void CrearCuota(Date xFech, short xDiaEn) throws InputException{
            if(mTipCuotSelec == Tip_SinCuota) throw new InputException("No se puede crear cuotas ya que ha seleccionado un crédito sin cuotas");
                    float ValorCuota = mObjValMon.getMonto() / mCanCuot;
        //Pendiente nesesito saber como sacar
            // Dia en el mes
            // Dia en la semana
            // Dia en el año
        for (int i = 0; i <= mCanCuot; i++){

        }
    }

    @Override
    public float getMonto() {
        return mObjValMon.getMonto();
    }

    @Override
    public String getTipo() {
        return this.TIPO;
    }

    @Override
    public float setMonto(float xMonto) throws InputException {
        if (xMonto < 0)throw new InputException("El monto no puede ser un valor negativo");
        if (xMonto > mMontAPagar)throw new InputException("El monto a pagar es meonr al monto pasado por parametro");
    	mObjValMon.setMonto(xMonto);
    	return xMonto;
    }

    @Override
    public void validar() throws InputException {
        if(mCanCuot < 0)throw new InputException("La cantidad de cuotas no puede ser un valor negativo");
        if(mTipCuotSelec < Tip_Anual && mTipCuotSelec > Tip_SinCuota) throw new InputException("El Tipo de periodo seleccionado no es valido");
        if(mTipCuotSelec < Tip_SinCuota && mCanCuot > 0) throw new InputException("Si conexiona un crédito el valor de la cantidad de cuotas debe ser 0");
        mObjValMon.validar();
    }

    @Override
    public float getMontoAPagar() {
            // TODO Auto-generated method stub
        return mMontAPagar;
    }



    public void pagar (Dom_Class_Resibo xObjRes) throws InputException{

    }

    /**
     * Retorna la fecha de pago con respecto a la fecha actua.
     */
    public Date getmFechPago(){
        return mFechPago;
    }
    
    public void setmFechPago (Date  mFechPago){
        this.mFechPago = mFechPago;
    }

    @Override
    public void setMonoAPatar(float xMonto) throws InputException {
        if (xMonto <= 0)throw new InputException("El monto a no asignado de la forma de "
                + "pago no puede ser menor o igual a 0");
        this.mMontAPagar = xMonto;
        
        if (mMontAPagar > mObjValMon.getMonto()) setMonto(mMontAPagar);
        
    }
	

	
}
