/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Dominio.Personas;

import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Dominio.FechPago.Dom_Class_FechPAño;
import Logica_Negocio.LogN_ClassAb_FechPag;
import Logica_Negocio.LogN_ClassAb_PerExterna;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;

/**
 *
 * @author ary
 */
public class Dom_Class_Proveedor extends LogN_ClassAb_PerExterna{

     //Constructor_______________________________________________________________

    public Dom_Class_Proveedor(String mDir, String mLoc, String mNumDoc, int mTipDoc, 
            String mRut, Dom_Class_Pais mObjPais, Dom_Class_ProvinDepar mObjProvDep, 
            String mObs, String mRasSos, int mCondicionIva, ArrayList<Dom_Class_Cel> mColCel, 
            ArrayList<Dom_Class_Fax> mColFax, ArrayList<Dom_Class_Tel> mColTel, 
            ArrayList<Dom_Class_Mail> mObjMail, ArrayList<Dom_Class_Saldo> mColSaldo, 
            Dom_Class_FechPAño mObjFechPago) {
        
        super(mDir, mLoc, mNumDoc, mTipDoc, mRut, mObjPais, mObjProvDep, mObs, mRasSos, 
                mCondicionIva, mColCel, mColFax, mColTel, mObjMail, mColSaldo, mObjFechPago);
    }

    public Dom_Class_Proveedor(String mDir, String mLoc, String mNumDoc, int mTipDoc, 
            String mRut, Dom_Class_Pais mObjPais, Dom_Class_ProvinDepar mObjProvDep, String mObs, 
            String mRasSos, int mCondicionIva, LogN_ClassAb_FechPag mObjFechPago) {
        
        super(mDir, mLoc, mNumDoc, mTipDoc, mRut, mObjPais, mObjProvDep, mObs, mRasSos, mCondicionIva, mObjFechPago);
    }
  
    public Dom_Class_Proveedor(Dom_Class_Proveedor xObjPer) {
        super(xObjPer);
    }

    public Dom_Class_Proveedor() {
    }
    
    //Metodos___________________________________________________________________
    @Override
    public float calcular_saldo() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_Proveedor duplicar() {
        return new Dom_Class_Proveedor(this);
    }
    
    public void modificar(Dom_Class_Proveedor xObjPer) throws InputException {
        super.modificar(xObjPer);
    }

    @Override
    public boolean duplicado(LogN_ClassAb_Persona xObjCop) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    
}
