/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio;

import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.MiExepcion.InputException;


/**
 *
 * @author ary
 */
public class Dom_Class_SubProducto extends LogN_ClassAb_Producto<Dom_Class_SubProducto> {
    //Atributos_________________________________________________________________
    private Dom_Class_ProductoComp mObjProd;
    private float mUnidadStok = 1;

    public Dom_Class_SubProducto(Dom_Class_SubProducto mObjSubPord) {
        super(mObjSubPord);
        this.mObjProd = mObjSubPord.mObjProd;
    }

    /**
     * 
     * @param mProd_Cod
     * @param mProd_Nom
     * @param mProd_Desc
     * @param mProd_CodBar
     * @param mProd_PrecVenta
     * @param mObjProd
     */
    public Dom_Class_SubProducto(int mProd_Cod, String mProd_Nom, String mProd_Desc,
            String mProd_CodBar, float mProd_PrecVenta, Dom_Class_ProductoComp mObjProd, 
            float mUnidadStok) {
        super(mProd_Cod, mProd_Nom, mProd_Desc, mProd_CodBar, mProd_PrecVenta, mObjProd.Tipo_Stok);
        this.mObjProd = mObjProd;
        this.mUnidadStok = mUnidadStok;
    }

    //Constructor_______________________________________________________________

    @Override
    public Dom_Class_Categoria getmObjCat() {
        return mObjProd.getmObjCat();
    }

    @Override
    public void setmObjCat(Dom_Class_Categoria mObjCat) throws InputException {
        throw new InputException("Este es un subproducto por lo tanto no se puede modificar la categoría");
    }

    @Override
    public float getMProd_Stock() {
        return mObjProd.getMProd_Stock();
    }

    @Override
    public void setMProd_StockMinimo(float newVar) throws InputException {
        throw new InputException("Este es un subproducto por lo tanto no se puede modificar el stok minimo");
    }

    @Override
    public float getMProd_StockMinimo() {
        return mObjProd.getMProd_StockMinimo();
    }

    public float getmUnidadStok() {
        return mUnidadStok;
    }

    public void setmUnidadStok(float mUnidadStok) {
        this.mUnidadStok = mUnidadStok;
    }
    
    

    @Override
    public void sumarStock(float xValor) throws InputException {
        mObjProd.sumarStock(xValor);
    }

    @Override
    public void restarStock(float xValor) throws InputException {
        this.mObjProd.restarStock(xValor);
    }

    @Override
    public void Modificar(Dom_Class_SubProducto xObjProdNue) throws InputException {
        xObjProdNue.validar();
        this.setmProd_Cod(xObjProdNue.getmProd_Cod());
        this.setMProd_Nom(xObjProdNue.getMProd_Nom());
        this.setMProd_Desc(xObjProdNue.getMProd_Desc());
        this.setMProd_PrecVenta(super.getMProd_PrecVenta());

        this.mObjProd = xObjProdNue.mObjProd;

    }

    @Override
    public void validar() throws InputException {
        super.validar();
        if(this.mObjProd == null)throw new InputException("No a ingresado un producto para este subproducto");
        if (super.Tipo_Stok == Stok_Unidad && mUnidadStok < 1 && ((int) mUnidadStok) != 0) 
            throw new InputException("Si el tipo de stock del producto es por unidad "
                    + "la unidad del subproducto debe ser un numero entero y mayor a 1.");
        
    }

    public Dom_Class_ProductoComp getmObjProd() {
        return mObjProd;
    }

    public void setmObjProd(Dom_Class_ProductoComp mObjProd) {
        this.mObjProd = mObjProd;
    }


    public LogN_ClassAb_Movimiento generarMovimiento(String xDesOr, String xAutorisacion, String xDetalle, float xCatProd, boolean xTipo) {
        LogN_ClassAb_Movimiento ObjMov;
        if (xDetalle == null) xDetalle = "";

        xDetalle += " Sub Producto ("+ this.getMProd_Nom() +")";
        int NumMov = LogN_Class_Fachada.getInstancia().getNumMovimiento();
        if (xTipo) ObjMov = new Dom_Class_MovEntrada(this.mObjProd, xDesOr, xAutorisacion, xDetalle, xCatProd, NumMov);
        else ObjMov = new Dom_Class_MovSalida(this.mObjProd, xDesOr, xAutorisacion, xDetalle, xCatProd, NumMov);

        return ObjMov;
    }


    @Override
    public Dom_Class_SubProducto duplicar() {
        Dom_Class_SubProducto ObjP = new Dom_Class_SubProducto(this);
        return ObjP;
    }

    @Override
    public boolean duplicado(Dom_Class_SubProducto xObjSubP) {
        
        if (!super.duplicado(xObjSubP)) return false;
        else if (!this.mObjProd.equals(xObjSubP.mObjProd)) return false;
        return true;
        
    }

    @Override
    public Dom_Class_IVA getIVA() {
       return mObjProd.getIVA();
    }
    
    

}
