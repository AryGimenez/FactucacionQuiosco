/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio.Facturacion;

import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author horacio
 */
public class Dom_Class_LineaFacCom extends LogN_ClassAb_LineaFac {

    public Dom_Class_LineaFacCom(int mCan, float mDes, LogN_ClassAb_Producto mObjProducto) throws InputException {
        super(mCan, mDes, mObjProducto);
    }

    public Dom_Class_LineaFacCom(int mCan, float mDes, float mPrePro, LogN_ClassAb_Producto mObjProducto) throws InputException {
        super(mCan, mDes, mPrePro, mObjProducto);
    }


    @Override
    public void setCan(float mCan) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void actualizarStok() throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
