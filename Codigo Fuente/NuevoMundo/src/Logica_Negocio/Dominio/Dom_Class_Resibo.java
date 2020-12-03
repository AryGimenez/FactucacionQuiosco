package Logica_Negocio.Dominio;

import Logica_Negocio.*;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.MiExepcion.InputException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * 
 * @author Ary Gimenez
 *
 */
public class Dom_Class_Resibo implements  LogN_Inter_Validar, LogN_Inter_DocCon{
    //Atrigutos___________________________________________________________
    /**
     * Monto Resibido
     */
    private LogN_Class_ValorMoneda mObjValMon;
    /**
     * Fecha de emision
     */
    private Date mFechEmi;
    
    /**
     * Detalle que describe el por el cual se emite el recibo
     */
    private String mDetalle;
    
    /**
     * Cliente al cual afecha el saldo
     */
    private LogN_ClassAb_Persona mObjPersona;
    
    /**
     * Numero que identifica el recibo este es �nico 
     */
    private int mNumResibo = -1;
    
    /**
     * Determina de quien recibí el dinero ya que esta no tiene que ser el cliente al que afecta el saldo
     */
    private String mDeQien;    
    
    //Consturctor_______________________________________________________

    public Dom_Class_Resibo(int mNum, Date mFechEmi, String mDetalle, 
            LogN_ClassAb_Persona mObjPersona, String mDeQien, float mMonto, 
            Dom_Class_Moneda xObjMon) {
        this.mFechEmi = mFechEmi;
        this.mDetalle = mDetalle;
        this.mObjPersona = mObjPersona;
        this.mDeQien = mDeQien;
        
        mObjValMon = new LogN_Class_ValorMoneda(mMonto, xObjMon);
        this.setNum(mNum);
    }

    public String getmDeQien() {
        return mDeQien;
    }

    public String getmDetalle() {
        return mDetalle;
    }

    public int getmNumResibo() {
        return mNumResibo;
    }

    public void setNum(int mNumRecibo){
        mNumResibo = mNumRecibo;
    }
    
    public LogN_ClassAb_Persona getmObjPersona() {
        return mObjPersona;
    }
    
    @Override
    public Dom_Class_Moneda getMoneda () {
        return mObjValMon.getObjMon();
    }
    
    @Override
    public float getMonto (){
        return mObjValMon.getMonto();
    }

    @Override
    public void validar() throws InputException {
        if (mDeQien.equals("")) throw new InputException("No a ingresado de quien  se recibió el dinero");
        if (mFechEmi == null) throw new InputException("No a ingresado una fecha de emicion de resito");
        if (mObjPersona == null) throw new InputException("No a ingresado una persona a la cual adjudicarle el recibo");
        mObjValMon.validar();
        
    }

    @Override
    public Date getFech() {
        return mFechEmi;
    }

    @Override
    public String getTipoDoc() {
        return "Resibo";
    }

    @Override
    public String getCodDoc() {
        return "" + mNumResibo;
    }

    @Override
    public LogN_ClassAb_Persona getPersona() {
        return mObjPersona;
    }

    @Override
    public Dom_Class_IVA getIVA() {
        
        try {
            return LogN_Class_Fachada.getInstancia().getIVA((float)0);
        } catch (InputException ex) {
            Logger.getLogger(Dom_Class_Resibo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
