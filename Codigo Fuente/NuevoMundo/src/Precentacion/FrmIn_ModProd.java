/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.MiExepcion.InputException;
import java.awt.Window;
import javax.swing.JOptionPane;

/**
 *
 * @author Ary
 */
public final class FrmIn_ModProd extends FrmIn_AgProducto{

    private Dom_Class_ProductoComp mObjProdComAn;
    private Dom_Class_ProductoComp mObjProdComNu;

    public FrmIn_ModProd(Window mObjFrmCon, Dom_Class_ProductoComp mObjProdCom) {
        super(mObjFrmCon, "Modificar Producto");
        this.mObjProdComAn =  mObjProdCom;
        this.mObjProdComNu = mObjProdComAn.duplicar();
        
        this.limpiarProdCom();
        
        Btn_Aceptar.setText("Modificar");
        Che_SubP.setText("Modificar Sub Productos");
        
        Btn_AgStok.setEnabled(false);
        Btn_AgStok.setFocusable(false);
        ComB_TipMed.setEditable(false); //Me impide modificar el tipo de stok
    }


    @Override
    public Dom_Class_ProductoComp getProductoCom() throws InputException {
        
        Dom_Class_ProductoComp ObjProdC = super.getProductoCom();
        mObjProdComNu.setmObjCat(ObjProdC.getmObjCat());
        mObjProdComNu.setMProd_Nom(ObjProdC.getMProd_Nom());
        mObjProdComNu.setMProd_Desc(ObjProdC.getMProd_Desc());
        mObjProdComNu.setProd_CodBarr(ObjProdC.getProd_CodBarr());
        mObjProdComNu.setMProd_StockMinimo(ObjProdC.getMProd_StockMinimo());
        mObjProdComNu.setMProd_PrecCosto(ObjProdC.getMProd_PrecCosto());
        mObjProdComNu.setMProd_PrecVenta(ObjProdC.getMProd_PrecVenta());
        return mObjProdComNu;
    }

    @Override
    protected boolean  aceptar() {
        boolean respuesta = false;
        try {
            mObjProdComNu = SubProd(getProductoCom());

            mObjFachada.modificarPord(mObjProdComAn, mObjProdComNu);
            respuesta = true;
        } catch (InputException ex) {
            JOptionPane.showMessageDialog(this, "");
        }
        return respuesta;
    }

    @Override
    protected void limpiarProdCom() {
        super.limpiarProdCom();
        if (mObjProdComNu == null) return;
        
        Txt_Nom.setText(mObjProdComNu.getMProd_Nom());
        TxtA_Des1.setText(mObjProdComNu.getMProd_Desc());
        Lbl_CodIn.setText("" + mObjProdComNu.getmProd_Cod());
        TxtF_PreCos.setValue(mObjProdComNu.getMProd_PrecCosto());
        TxtF_PreVen.setValue(mObjProdComNu.getMProd_PrecVenta());
        ComB_TipMed.setSelectedIndex(mObjProdComNu.Tipo_Stok);
        TxtF_StokMin.setValue(mObjProdComNu.getMProd_StockMinimo());
        TxtF_CodBarr.setText(mObjProdComNu.getProd_CodBarr());
        ComBAu_Categoria.setSelectedItem(mObjProdComNu.getmObjCat());
        ComBAu_Categoria.requestFocus();
        cargarNotific();
        eliminarMovimiento();
        
    }

}
