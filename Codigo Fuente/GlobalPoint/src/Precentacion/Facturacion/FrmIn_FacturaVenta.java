/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Facturacion;



import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.Persona.FrmDi_ConPer;
import Precentacion.Persona.FrmIn_AgrCom;
import Precentacion.Persona.FrmIn_ListarCliente;
import java.awt.Window;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.jasperreports.engine.JRException;


/**
 *
 * @author horacio
 */
public class FrmIn_FacturaVenta extends FrmIn_Facturacion{
    
    public FrmIn_FacturaVenta(Window mFrmCon) {
        super(mFrmCon);
    }
    
    
    @Override
    protected void altaFactura(boolean presupuesto) throws InputException {
        mObjFachada.altaFacVen((Dom_Class_FacVen)mObjFactura, presupuesto);
        try {
            LogN_ClassAb_Persona xObjPer = mObjFactura.getPersona();
            if (mObjFactura.getPersona() == null)
                xObjPer = TempPersona();
                
            Reportes.Rep_Class_IniciarReporte.imprimirFactura(mObjFactura, xObjPer);
        } catch (JRException ex) {
            Logger.getLogger(FrmIn_FacturaVenta.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected LogN_ClassAb_Persona selexioPersona() {
       FrmDi_ConPer ObjFrmConP = new FrmDi_ConPer(super.mFrmCon, new FrmIn_AgrCom(null), new FrmIn_ListarCliente(null));
       ObjFrmConP.setVisible(true);
       if (ObjFrmConP.getReturnStatus() == FrmDi_ConPer.RET_OK) super.mObjPerSel = ObjFrmConP.getPerSel();
       return mObjPerSel;
    }

    @Override
    protected LogN_ClassAb_Factura getNueF() {
        return mObjFachada.NuevaFachVen();
    }

    @Override
    protected LogN_ClassAb_Persona getPer(int xNumPer) {
        return mObjFachada.getCliente(xNumPer);
    }

    @Override
    protected LogN_ClassAb_Persona TempPersona() {
        return new Dom_Class_Cliente(Txt_Dir.getText(), "", "", Dom_Class_Cliente.TipDoc_CdulaIdentidad, 
                TxtF_Rur.getText(), null, null, "", Txt_RasSos.getText(), 1, null);
        
    }
    

}
