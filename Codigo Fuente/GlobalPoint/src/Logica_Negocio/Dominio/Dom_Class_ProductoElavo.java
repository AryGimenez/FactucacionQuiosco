package Logica_Negocio.Dominio;

import java.util.ArrayList;

import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;

public class Dom_Class_ProductoElavo extends LogN_ClassAb_Producto<Dom_Class_ProductoElavo>{
	
    //Atributos______________________________________________________________________________
	  
    /**
     * Precio de costo del producto
     */
    private Dom_Class_IVA mObjIva;

    /**
     * Categoria a la que pertenece el producto
     */
    private Dom_Class_Categoria mObjCat;


    private ArrayList<Dom_Class_Notificacion> mColNoti = new ArrayList<Dom_Class_Notificacion>();
    //Constructor_________________________________________________________________________________


    public Dom_Class_ProductoElavo(int mProdCod, String mProdNom,
                    String mProdDesc, String mProdCodBar, float mProdPrecVenta,
                    int mTipStok, Dom_Class_IVA mObjIva, Dom_Class_Categoria mObjCategoria) {

            super(mProdCod, mProdNom, mProdDesc, mProdCodBar, mProdPrecVenta, mTipStok);

            this.mObjIva = mObjIva;
            this.mObjCat = mObjCategoria;
            // TODO Auto-generated constructor stub
    }

    public Dom_Class_ProductoElavo (Dom_Class_ProductoElavo mObjPord){
        super(mObjPord);



        this.mColNoti = new ArrayList<Dom_Class_Notificacion>(mObjPord.getmColNoti());

        this.mObjCat = mObjPord.mObjCat;
        this.mObjIva = mObjPord.mObjIva;

    }

    //Atributos____________________________________________________________________________________

    @Override
    public void Modificar(Dom_Class_ProductoElavo xObjProdNue)throws InputException {

        xObjProdNue.validar();
        this.setmProd_Cod(xObjProdNue.getmProd_Cod());
        this.setMProd_Nom(xObjProdNue.getMProd_Nom());
        this.setMProd_Desc(xObjProdNue.getMProd_Desc());
        this.setProd_CodBarr(xObjProdNue.getProd_CodBarr());


        this.setMProd_PrecVenta(xObjProdNue.getMProd_PrecVenta());

        this.mObjCat = xObjProdNue.mObjCat;
        this.mColNoti = new
                ArrayList<Dom_Class_Notificacion>(xObjProdNue.mColNoti);
        this.mObjIva = xObjProdNue.mObjIva;

    }

    @Override
    public LogN_ClassAb_Movimiento generarMovimiento(String xDesOr,
                    String xAutorisacion, String xDetalle, float xCatProd, boolean xTipo) {
            // TODO Auto-generated method stub
            return null;
    }

    @Override
    public Dom_Class_IVA getIVA() {
            // TODO Auto-generated method stub
            return this.mObjIva;
    }

    @Override
    public float getMProd_Stock() {
            // TODO Auto-generated method stub
            return 100;
    }

    public ArrayList<Dom_Class_Notificacion> getmColNoti(){
        return mColNoti;
    }

    @Override
    public float getMProd_StockMinimo() {
            // TODO Auto-generated method stub
            return 0;
    }

    @Override
    public Dom_Class_Categoria getmObjCat() {
            // TODO Auto-generated method stub
            return mObjCat;
    }
    // <editor-fold defaultstate="collapsed" desc="Metodos no implementados">    
        @Override
        public void restarStock(float xValor) throws InputException {
                // TODO Auto-generated method stub

        }

        @Override
        public void setMProd_StockMinimo(float newVar) throws InputException {
                // TODO Auto-generated method stub

        }
        
            @Override
        public void sumarStock(float xValor) throws InputException {
                // TODO Auto-generated method stub

        }
    // </editor-fold>


    @Override
    public void setmObjCat(Dom_Class_Categoria mObjCat) throws InputException {
            // TODO Auto-generated method stub
        this.mObjCat = mObjCat;

    }



    @Override
    public Dom_Class_ProductoElavo duplicar() {
            // TODO Auto-generated method stub
            return null;
    }


}
