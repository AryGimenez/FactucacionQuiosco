/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio;

import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author ary
 */
public class Dom_Class_MovSalida extends LogN_ClassAb_Movimiento{

    public Dom_Class_MovSalida(Dom_Class_ProductoComp mObjProducto, String mDes_Origen, String mAutoriso, String mDetalle, float mCanProd, int mNumMov) {
        super(mObjProducto, mDes_Origen, mAutoriso, mDetalle, mCanProd,mNumMov);
    }


    @Override
    public void actualisarStok() throws InputException {
        this.validar();
        this.getPord().restarStock(getCanProd());
    }

    public boolean aFab_o_Con() {
        return false;
    }

    public String getTipModificador() {
        return "Movimiento Salida";
    }

    @Override
    public void validar() throws InputException {
        super.validar();
        if (super.getPord().getMProd_Stock() < super.getCanProd()) 
            throw new InputException("El tamaño del movimiento es mas "
                    + "grande que el stock del producto");
    }

}
