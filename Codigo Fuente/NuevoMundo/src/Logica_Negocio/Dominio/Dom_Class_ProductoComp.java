package Logica_Negocio.Dominio;


import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.LogN_Inter_Validar;
import Logica_Negocio.MiExepcion.InputException;
import Precentacion.LogN_Class_Accion;
import java.util.ArrayList;


/**
 * Class Producto
 */
public class Dom_Class_ProductoComp  extends LogN_ClassAb_Producto<Dom_Class_ProductoComp> implements LogN_Inter_Validar {


    //Atributos______________________________________________________________________________
  
    /**
   * Precio de costo del producto
   */
  private Dom_Class_IVA mObjIva;

  /**
   * Precio de costo del producto
   */
  private float mProd_PrecCosto;


  /**
   * Stok del producto
   */
  private float mProd_Stock ;

  /**
   * Stok mínimo del producto
   */
  private float mProd_StockMinimo;

  /**
   * Categoría a la que pertenece el producto
   */
  private Dom_Class_Categoria mObjCat;


  private ArrayList<Dom_Class_Notificacion> mColNoti = new ArrayList<Dom_Class_Notificacion>();

  private ArrayList<Dom_Class_SubProducto> mColSubProd = new ArrayList<Dom_Class_SubProducto>();


  //Constructor_________________________________________________________________

//  /**
//   *
//   * @param mProd_Nom
//   * @param mProd_PrecCosto
//   * @param mProd_PrecVenta
//   * @param mProd_Stock
//   * @param mProd_StockMinimo
//   * @param mObjCat
//   */
//    public Dom_Class_Producto(String mProd_Nom, float mProd_PrecCosto, float mProd_PrecVenta, int mProd_Stock, int mProd_StockMinimo, Dom_Class_Categoria mObjCat) {
//      //  this(null, mProd_Nom, null, null, mProd_PrecCosto, mProd_PrecVenta, mProd_Stock, mProd_StockMinimo, mObjCat);
//    }

    public Dom_Class_ProductoComp(int mProd_Cod, String mProd_Nom, String mProd_Desc1,
            String mProd_CodBar, float mProd_PrecCosto, float mProd_PrecVenta,
            float mProd_StockMinimo, Dom_Class_Categoria mObjCat, 
            ArrayList <Dom_Class_Notificacion> mColNot, ArrayList<Dom_Class_SubProducto> mColSubP
            , int mTipStok, Dom_Class_IVA mObjIva) {
        super(mProd_Cod, mProd_Nom, mProd_Desc1, mProd_CodBar, mProd_PrecVenta, mTipStok);
        this.mProd_PrecCosto = mProd_PrecCosto;


        this.mProd_StockMinimo = mProd_StockMinimo;
        this.mObjCat = mObjCat;

        this.mColNoti = mColNot;
        this.mColSubProd = mColSubP;
        this.mObjIva = mObjIva;

    }


    public Dom_Class_ProductoComp (Dom_Class_ProductoComp mObjPord){
        super(mObjPord);
        this.mProd_Stock = mObjPord.mProd_Stock;
        this.mProd_StockMinimo = mObjPord.mProd_StockMinimo;
        this.mProd_PrecCosto = mObjPord.mProd_PrecCosto;
        this.mColNoti = new ArrayList<Dom_Class_Notificacion>(mObjPord.getmColNoti());
        this.mColSubProd = new ArrayList<Dom_Class_SubProducto>(mObjPord.mColSubProd);
        this.mObjCat = mObjPord.mObjCat;
        this.mObjIva = mObjPord.mObjIva;

    }

    public Dom_Class_ProductoComp(int mProd_Cod, String mProd_Nom, String mProd_Desc1,
        String mProd_CodBar, float mProd_PrecCosto, float mProd_PrecVenta,
        float mProd_StockMinimo, Dom_Class_Categoria mObjCat, int mTipStok, Dom_Class_IVA mObjIva) {

        this(mProd_Cod, mProd_Nom, mProd_Desc1, mProd_CodBar, mProd_PrecCosto,
                mProd_PrecVenta, mProd_StockMinimo, mObjCat,
                new ArrayList<Dom_Class_Notificacion>(),
                new ArrayList<Dom_Class_SubProducto>(), mTipStok, mObjIva);
    }





    //Metodos___________________________________________________________________




  public void setMProd_PrecCosto ( float newVar ) {
    mProd_PrecCosto = newVar;
    Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
  }


  public float getMProd_PrecCosto ( ) {
    return mProd_PrecCosto;
  }

    public ArrayList<Dom_Class_SubProducto> getmColSubProd() {
        return mColSubProd;
    }

    public void setmColSubProd(ArrayList<Dom_Class_SubProducto> mColSubProd) {
        this.mColSubProd = mColSubProd;
    }

    @Override
  public float getMProd_Stock ( ) {
    return mProd_Stock;

  }

  /**
   * Set the value of mProd_StockMinimo
   * @param newVar the new value of mProd_StockMinimo
   */
    @Override
  public void setMProd_StockMinimo ( float newVar ) {
    mProd_StockMinimo = newVar;
    Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
  }

  /**
   * Get the value of mProd_StockMinimo
   * @return the value of mProd_StockMinimo
   */
    @Override
  public float getMProd_StockMinimo ( ) {
    return mProd_StockMinimo;
  }

  //
  // Other methods
  //

  /**
   * incrementa el Stock.
   * 
   * @param        xValor Variable utilizada para sumar
   * @throws InputException
   */
    @Override
  public void sumarStock( float xValor ) throws InputException{
      if (xValor < 0) throw new InputException("El valor ingresado es menor que 0");
      if (this.determinarDesimo(xValor) && Tipo_Stok == Stok_Unidad)
          throw new InputException("A ingresado un valor decimal a un producto con stock por unidad");
      this.mProd_Stock += xValor;
  }


  /**
   * @param        xValor Valor utilizado para restar
   * @throws InputException
   */
    @Override
  public void restarStock( float xValor ) throws InputException{
      
      if (this.determinarDesimo(xValor) && Tipo_Stok == Stok_Unidad)
          throw new InputException("A ingresado un valor decimal a un producto con stock por unidad");

      if (xValor < 0) throw new InputException("El valor ingresado es menor que 0");
      if (xValor > mProd_Stock) throw new  InputException("El valor ingresado supera el valor del stok actual");
      mProd_Stock -= xValor;
  }




    @Override
  public void validar() throws InputException {
      super.validar();
      if (mObjCat == null)throw new InputException("No ha ingresado una categoría");
      mObjCat.validar();
//      if (mProd_Cod < 0 ) throw new InputException ("No a ingresado un código de producto o uno invalido");
    
      if (mProd_PrecCosto < 0) throw new InputException ("El precio de costo no puede ser un valor negativo");

      if (mProd_Stock < 0) throw new InputException ("Es stock no puede ser un valor negativo");
      if (mProd_StockMinimo < 0) throw new InputException("Es stock minimo no puede ser un valor negativo");
  }




  
  @Override
  public String toString() {
        return "Cod: " + this.getmProd_Cod() + " Stock: " + mProd_Stock;
    }

  //Determina si el stok stok es menor que el stok minimo
    @Override
    public boolean getStokMimimo (){
        if (mProd_StockMinimo >= mProd_Stock)return true;
        return false;
    }
    
    public void setStok (float xStok){
        mProd_Stock = xStok;
    }

    public ArrayList<Dom_Class_Notificacion> getmColNoti() {
        return new ArrayList<Dom_Class_Notificacion>(mColNoti);
    }

    public void setmColNoti(ArrayList<Dom_Class_Notificacion> mColNoti) {
        if (mColNoti == null) return;
        this.mColNoti = new ArrayList<Dom_Class_Notificacion>(mColNoti);

    }

    public void altaNot (Dom_Class_Notificacion xObjNot) throws InputException{
        xObjNot.validar();
        mColNoti.add(xObjNot);
        Notificar(new LogN_Class_Accion<Dom_Class_Notificacion>(LogN_Class_Accion.Agreger, xObjNot));
    }

    public  boolean bajaNot (Dom_Class_Notificacion xObjNot) {
        if (!mColNoti.remove(xObjNot)) return false;
        Notificar(new LogN_Class_Accion<Dom_Class_Notificacion>(LogN_Class_Accion.Eliminar, xObjNot));
        return true;
    }
    
    public void altaSubProd(Dom_Class_SubProducto xObjSubProd)throws InputException{
        if (xObjSubProd.getmObjProd() == null)
            xObjSubProd.setmObjProd(this);

        else if (xObjSubProd.getmObjProd() != this)
            throw new InputException("El subproducto  ingresado posee un producto diferente");
        if (mColSubProd.contains(xObjSubProd)) 
            throw new InputException("El Subproducto ingresado ya existe en este producto ");
        
        int Size = mColSubProd.size();
        
        for (int Con = 0; Con < Size ; Con ++ ){
            if (xObjSubProd.getmProd_Cod() < mColSubProd.get(Con).getmProd_Cod()){
              mColSubProd.add(Con, xObjSubProd);
              return;
            }
        }
       
        
        mColSubProd.add(xObjSubProd);
    }

    public boolean bajaSubProd(Dom_Class_SubProducto xObjSubProd){
        return mColSubProd.remove(xObjSubProd);
    }



    @Override
    public void Modificar(Dom_Class_ProductoComp xObjProdNue) throws InputException {
        xObjProdNue.validar();
        this.setmProd_Cod(xObjProdNue.getmProd_Cod());
        this.setMProd_Nom(xObjProdNue.getMProd_Nom());
        this.setMProd_Desc(xObjProdNue.getMProd_Desc());
        this.setProd_CodBarr(xObjProdNue.getProd_CodBarr());
        
        this.mProd_PrecCosto = xObjProdNue.mProd_PrecCosto;
        this.setMProd_PrecVenta(xObjProdNue.getMProd_PrecVenta());

        this.mProd_StockMinimo = xObjProdNue.mProd_StockMinimo;
        this.mObjCat = xObjProdNue.mObjCat;
        this.mColNoti = new
                ArrayList<Dom_Class_Notificacion>(xObjProdNue.mColNoti);
        this.mColSubProd = new ArrayList<Dom_Class_SubProducto>(xObjProdNue.mColSubProd);
        
    }

    @Override
    public Dom_Class_Categoria getmObjCat() {
        return mObjCat;
    }

    @Override
    public void setmObjCat(Dom_Class_Categoria mObjCat) throws InputException {
        this.mObjCat = mObjCat;
    }

    public int getNumSubProd (){

        int CodSubP = LogN_Class_Fachada.getInstancia().getNumProd();
        if(super.getmProd_Cod() == CodSubP) CodSubP++;
        
        for (Dom_Class_SubProducto ObjSubProd: mColSubProd){
            if (ObjSubProd.getmProd_Cod() <= CodSubP) CodSubP++;
            else return CodSubP;
        }
        return CodSubP;
    }
    
    public Dom_Class_SubProducto getSutProd(int xNumSubP){
        for (Dom_Class_SubProducto ObjSubP : mColSubProd ){
            if(ObjSubP.getmProd_Cod() == xNumSubP) return ObjSubP;
        }
        return null;
    }


    @Override
    public LogN_ClassAb_Movimiento generarMovimiento(String xDesOr, String xAutorisacion, String xDetalle, float xCatProd, boolean xTipo) {
        LogN_ClassAb_Movimiento ObjMov;

        int NumMov = LogN_Class_Fachada.getInstancia().getNumMovimiento();
        if (xTipo) ObjMov = new Dom_Class_MovEntrada(this, xDesOr, xAutorisacion, xDetalle, xCatProd, NumMov);
        else ObjMov = new Dom_Class_MovSalida(this, xDesOr, xAutorisacion, xDetalle, xCatProd, NumMov);

        return ObjMov;
    }
    
    
    @Override
    public Dom_Class_ProductoComp duplicar() {
        return new Dom_Class_ProductoComp(this);
    }

    @Override
    public Dom_Class_IVA getIVA() {
        return mObjIva;
    }
    
    public void setSubPro (Dom_Class_IVA xObjIva){
        mObjIva = xObjIva;
    }
    
    
    
}
