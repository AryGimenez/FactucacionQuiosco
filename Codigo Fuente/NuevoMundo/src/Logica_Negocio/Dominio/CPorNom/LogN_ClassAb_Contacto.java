/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Dominio.CPorNom;

import Logica_Negocio.LogN_Inter_Duplicado;

/**
 *
 * @author ary
 */
public abstract class LogN_ClassAb_Contacto 
extends LogN_ClassAb_CrePorNom 
{
    private String mDetalle ;
    
    public LogN_ClassAb_Contacto(String mNom, String Tipo, String mDetalle) {
        super(mNom, Tipo);
        this.mDetalle = mDetalle;
    }

    public LogN_ClassAb_Contacto(String Tipo) {
        super(Tipo);
    }
    
    public String getDetalle (){
        return mDetalle;
    }
    
    public void setDetalle (String mDetalle){
        if (mDetalle == null) mDetalle = "";
        this.mDetalle = mDetalle.trim();
        
    }
    

    @Override
    public abstract  LogN_ClassAb_Contacto duplicar();

    

    
    @Override
    public boolean duplicado(LogN_ClassAb_CrePorNom xObjCop) {
        
        if(!super.duplicado(xObjCop)) return false;
        LogN_ClassAb_Contacto ObjContacto = (LogN_ClassAb_Contacto) xObjCop;
        
        if(!mDetalle.equals(ObjContacto.mDetalle)) return false;
        
        return true;
    }
    
}
