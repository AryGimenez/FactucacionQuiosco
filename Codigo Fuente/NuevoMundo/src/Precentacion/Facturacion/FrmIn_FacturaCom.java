/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Precentacion.Facturacion;

import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.MiExepcion.InputException;
import java.awt.Window;

/**
 *
 * @author Ary
 */
public class FrmIn_FacturaCom extends FrmIn_Facturacion{

    public FrmIn_FacturaCom(Window mFrmCon) {
        super(mFrmCon);
    }

    @Override
    protected void altaFactura(boolean presupuesto) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    protected LogN_ClassAb_Factura getNueF() {
        return null;
    }

    @Override
    protected LogN_ClassAb_Persona TempPersona() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    protected LogN_ClassAb_Persona selexioPersona() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    protected LogN_ClassAb_Persona getPer(int xNumPer) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    
   
    
}
