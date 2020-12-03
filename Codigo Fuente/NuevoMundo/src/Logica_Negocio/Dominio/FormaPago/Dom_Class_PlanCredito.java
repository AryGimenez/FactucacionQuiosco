/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Dominio.FormaPago;


import Logica_Negocio.LogN_ClassAb_Credito;
import Logica_Negocio.MiExepcion.InputException;

/**
 * Clae que se utilisa para guardar una plan de credito que utilisa la empresa
 * (esto solo guarda una forma de utilisar el credito automaticamente )
 * @author Ary
 * @version 1.0
 * @updated 09-nov-2011 12:55:21 a.m.
 */
public class Dom_Class_PlanCredito extends LogN_ClassAb_Credito{

    public Dom_Class_PlanCredito(byte mCanCuot, byte mTipCuotSelec, byte mIntervalo, float mRecargo) throws InputException {
        super(mCanCuot, mTipCuotSelec, mIntervalo, mRecargo);
    }

    public byte getmCanCuot() {
        return mCanCuot;
    }

    public byte getmIntervalo() {
        return mIntervalo;
    }



    public float getmRec() {
        return mRec;
    }

    public byte getmTipCuotSelec() {
        return mTipCuotSelec;
    }
    
    
    
    
    
}
