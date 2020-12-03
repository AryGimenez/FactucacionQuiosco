/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.LogN_Class_ObsevadoAuxiliar;
import Logica_Negocio.MiExepcion.InputException;
import java.awt.Window;
import javax.swing.JOptionPane;

/**
 *
 * @author Ary
 */
public class FrmIn_AgrProd extends FrmIn_AgProducto{

    public FrmIn_AgrProd(Window mObjFrmCon) {
        super(mObjFrmCon, "Agregar Producto");
    }

    @Override
    protected boolean aceptar() {
        
        boolean repusesat = false;
        Dom_Class_ProductoComp ObjProductoComp = null;
       try{
            ObjProductoComp= this.getProductoCom();
            ObjProductoComp.validar();
            ObjProductoComp = this.SubProd(ObjProductoComp);

            mObjFachada.altaProductoCom(ObjProductoComp);
            if(mObjMov != null){
                mObjMov.setProducto(ObjProductoComp);
                mObjFachada.altaMovimiento(mObjMov);
            }
            mObjObservado.Notifiar(ObjProductoComp);
            repusesat = true;
        } catch (InputException ex) {
            JOptionPane.showMessageDialog(this, ex.getLocalizedMessage());
            ComBAu_Categoria.requestFocus();
            try {
                mObjFachada.bajaCategoria(ObjProductoComp.getmObjCat());
            } catch (InputException ex1) {

            }
        }
        limpiarProdCom();
        return repusesat;
    }

    @Override
    protected void limpiarProdCom() {
        super.limpiarProdCom();
        Txt_Nom.setText("");
        TxtA_Des1.setText("");
        Lbl_CodIn.setText("" + mObjFachada.getNumProd());
        TxtF_PreCos.setValue(new Float (0.0));
        TxtF_PreVen.setValue(new Float (0.0));
        TxtF_StokMin.setValue(new Integer (0));
        TxtF_CodBarr.setText("");
        ComBAu_Categoria.requestFocus();
        cargarNotific();
        eliminarMovimiento();
        ComB_TipMed.requestFocus();
    }

}
