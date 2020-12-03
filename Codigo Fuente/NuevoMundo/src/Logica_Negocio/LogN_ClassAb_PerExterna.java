/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.FechPago.Dom_Class_FechPAño;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;

/**
 * <B><FONT COLOR="red">Persona que es ajena a la empresa como seria proveedores o clientes<\FONT> </B>
 * @author Ary
 */
public abstract  class LogN_ClassAb_PerExterna extends LogN_ClassAb_Persona{
    /**
     * Condicion IVA Responsable Inscripto
     */
    public final int CondicionIva_ResIns = 0;
    
    /**
     * Condicion IVA Consumidor final
     */
    public final int CondicionIva_ConsFin = 1;
    
    private int mCondicionIva = CondicionIva_ConsFin;
    
    /**
     * <B>Inicializa la persona con los datos por efecto</B> (llama al super() directamente sin realizar ninguna otra operacion)
     */
    public LogN_ClassAb_PerExterna (){
        super();
    }

    /**
     * Copia todos los datos de la persona externa pasada por parámetro (llama al método super (LogN_Class_Persona) sin realizar ninguna otra operación
     * @param xObjPer
     */
    public LogN_ClassAb_PerExterna(LogN_ClassAb_PerExterna xObjPer) {
        super(xObjPer);
        mCondicionIva = xObjPer.mCondicionIva;
    }

     /**
     * Constructor de la completo de la clase
     * @param mDir Dirección
     * @param mLoc Localidad (el nombre Ciudad, Pueblo, etc)
     * @param mNum Doc Numero de documento (según el tipo)
     * @param mTipDoc Tipo de documento 
     * @param mRut Rut
     * @param mObjPais País
     * @param mObjProvDep Provincia o departamento
     * @param mObs Observacional (Dato auxiliar o comentario)
     * @param mRasSos Razón Social (Nombre completo de la persona o en caso de empresa su nombre)
     * @param mCondicionIva Condicion IVA (ej: No responsable, responsable inscripto, etc.)
     */
    public LogN_ClassAb_PerExterna(String mDir, String mLoc, String mNumDoc, int mTipDoc, String mRut, Dom_Class_Pais mObjPais, 
            Dom_Class_ProvinDepar mObjProvDep, String mObs, String mRasSos, int mCondicionIva, LogN_ClassAb_FechPag mObjFechPago) {
        super (mDir, mLoc, mNumDoc, mTipDoc, mRut, mObjPais, mObjProvDep, mObs, mRasSos, mObjFechPago);
        this.mCondicionIva = mCondicionIva;
    }
    
    /**
     * Constructor de la completo de la clase
     * @param mDir Dirección
     * @param mLoc Localidad (el nombre Ciudad, Pueblo, etc)
     * @param mNumDoc Numero de documento (según el tipo)
     * @param mTipDoc Tipo de documento 
     * @param mRut Rut
     * @param mObjPais País
     * @param mObjProvDep Provincia o departamento
     * @param mObs Observacional (Dato auxiliar o comentario)
     * @param mRasSos Razón Social (Nombre completo de la persona o en caso de empresa su nombre)
     * @param mCondicionIva Condicion IVA (ej: No responsable, responsable inscripto, etc.)
     * @param mColCel Grupo de los números de celulares para contactar a esta persona
     * @param mColFax Grupo de los números de fax para contactar a esta persona
     * @param mColTel Grupo de los números de Teléfono  para contactar a esta persona
     * @param mObjMail Mail de la persna
     * @param mColSaldo Saldo con la persona para con la empresa
     * 
     */
    public LogN_ClassAb_PerExterna(String mDir, String mLoc, String mNumDoc, int mTipDoc, String mRut, Dom_Class_Pais mObjPais, 
            Dom_Class_ProvinDepar mObjProvDep, String mObs, String mRasSos, int mCondicionIva, ArrayList<Dom_Class_Cel> mColCel,
            ArrayList<Dom_Class_Fax> mColFax, ArrayList<Dom_Class_Tel> mColTel, ArrayList <Dom_Class_Mail> mObjMail, 
            ArrayList<Dom_Class_Saldo> mColSaldo, Dom_Class_FechPAño mObjFechPago) {
        super(mDir, mLoc, mNumDoc, mTipDoc, mRut, mObjPais, mObjProvDep, mObs, mRasSos, mColCel, 
                mColFax, mColTel,mObjMail, mColSaldo, mObjFechPago);
        this.mCondicionIva = mCondicionIva;
    }

    /**
     * 
     * @throws InputException 
     */
    @Override
    public void validar() throws InputException {
        super.validar();
        if(mCondicionIva < 0 && mCondicionIva > 1 ) throw new InputException("La condición de IVA ingresada no es valida");
    }

    /**
     * <B>Retorna la condición de IVA</B>
     * @return mCondicionIva
     */
    
    public int getmCondicionIva() {
        return mCondicionIva;
    }
    /**
     * <B>Remplaza la condición de IVA</B>, por la pasada por parámetro
     * @param mCondicionIva 
     */
    public void setmCondicionIva(int mCondicionIva) {
        this.mCondicionIva = mCondicionIva;
    }

    /**
     * <B>Remplaza los datos de este objeto</B>, por los pasado por parámetro
     * @param xObjPer
     * @throws InputException  
     */
    public void modificar(LogN_ClassAb_PerExterna xObjPer) throws InputException {
        super.modificar(xObjPer);
        mCondicionIva = xObjPer.mCondicionIva;
    }
    
    
    
    


}






