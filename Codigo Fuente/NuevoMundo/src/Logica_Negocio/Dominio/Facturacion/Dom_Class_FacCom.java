/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio.Facturacion;

import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author Ary Gimenez
 */
public class Dom_Class_FacCom extends LogN_ClassAb_Factura{

    @Override
    public LogN_ClassAb_Persona getPersona() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setPersona(LogN_ClassAb_Persona mObjPer) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void actualizarStock() throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_Factura duplicar() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_LineaFac CrearLinFac(float mCan, float mDes, float mPrePro, LogN_ClassAb_Producto mObjProducto) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getTipoDoc() {
        return "Factura Compra";
    }

    @Override
    public Dom_Class_IVA getIVA() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
