/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.MiExepcion.InputException;
import java.util.Observable;

/**
 * 
 * @author Ary
 * @param <T> 
 */
public abstract  class LogN_ClassAb_Producto<T> extends Observable implements LogN_Inter_Duplicado<T> {
     
  //Atributos______________________________________________________________________________

  /**
  * Código utilizado para identificar el producto
  */
  private int mProd_Cod;

  /**
   * Codicot de barra
   */
  private String mProd_CodBar = "";

  /**
   * Nombre del Producto
   */
  private String mProd_Nom  = "";

  /**
   * Descripción  del producto
   */
  private String mProd_Desc = "";



  /**
   * Precio de venta del producto
   */
  private float mProd_PrecVenta;

  /**
   * Stock por unidad  (no acepta valores decimales). 
   */
  public final static int Stok_Unidad = 0;

  /**
   * Stock por décimo  (acepta valores decimales). 
   */
  public final static int Stok_Decimo = 1;

  /**
   * Tipo de stock actual
   */
  public final  int Tipo_Stok;


  //Constructor_________________________________________________________________

  /**
   * <B>Constructor Completo</B>
   * @param mProd_Cod Código utilizado para identificar el producto
   * @param mProd_Nom Nombre del Producto
   * @param mProd_Desc Descripción  del producto
   * @param mProd_CodBar Codicot de barra
   * @param mProd_PrecVenta Precio de venta del producto
   * @param mTipStok Tipo de stock actual
   */
    public LogN_ClassAb_Producto(int mProd_Cod, String mProd_Nom, String mProd_Desc,
            String mProd_CodBar,  float mProd_PrecVenta, int mTipStok) {
        this.mProd_Cod = mProd_Cod;
        this.mProd_Nom = mProd_Nom.trim();
        this.setMProd_Desc(mProd_Desc);

        this.setProd_CodBarr(mProd_CodBar);
        

        this.mProd_PrecVenta = mProd_PrecVenta;
        
        this.Tipo_Stok = mTipStok;

    }


    /**
     * Inicializa  el objeto con los datos obtenidos del producto pasado por parámetro
     * @param mObjPord 
     */
    public LogN_ClassAb_Producto (LogN_ClassAb_Producto mObjPord){
        this(mObjPord.mProd_Cod, mObjPord.mProd_Nom, mObjPord.mProd_Desc,
                mObjPord.mProd_CodBar, mObjPord.mProd_PrecVenta,
                mObjPord.Tipo_Stok);
        
    }







    //Metodos___________________________________________________________________

    /**
     * Retonra la categoria del predutcot
     * @return 
     */
    public abstract  Dom_Class_Categoria getmObjCat();

    /**
     * 
     * @param mObjCat
     * @throws InputException 
     */
    public abstract  void setmObjCat(Dom_Class_Categoria mObjCat)throws InputException;


    /**
     * Retorna el codigo del producto
     * @return mProd_Cod
     */
    public int getmProd_Cod() {
        return mProd_Cod;
    }

    /**
     * Remplaza el código de producto por el parámetro por parámetro 
     * @param mProd_Cod 
     */
    public void setmProd_Cod(int mProd_Cod) {
        this.mProd_Cod = mProd_Cod;
    }




  /**
   * Set the value of mProd_Nom
   * @param newVar the new value of mProd_Nom
   */
  public void setMProd_Nom ( String newVar ) {
    mProd_Nom = newVar.trim();
    Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
  }

  /**
   * Get the value of mProd_Nom
   * @return the value of mProd_Nom
   */
  public String getMProd_Nom ( ) {
    return mProd_Nom;
  }

  /**
   * Set the value of mProd_Desc1
   * @param newVar the new value of mProd_Desc1
   */
  public void setMProd_Desc ( String newVar ) {
    if (newVar == null) newVar = "";
    mProd_Desc = newVar.trim();
    Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
  }

  /**
   * Get the value of mProd_Desc1
   * @return the value of mProd_Desc1
   */
  public String getMProd_Desc ( ) {
    return mProd_Desc;

  }


  public boolean setProd_CodBarr ( String newVar ) {
      try{
          if (newVar == null || newVar.trim().equals(""))mProd_CodBar = "";
          else Long.parseLong(newVar);
          mProd_CodBar = newVar.trim();
          Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
          return true;
      }catch (NumberFormatException ex){
          return false;
      }
      
  }

  public String getProd_CodBarr ( ) {
    return mProd_CodBar;

  }

  /**
   * Set the value of mProd_PrecVenta
   * @param newVar the new value of mProd_PrecVenta
   */
  public void setMProd_PrecVenta ( Float newVar ) {
    mProd_PrecVenta = newVar;
    Notificar(null); // notifica a los observadors que ubo un cambio en este objeto
  }

  /**
   * Get the value of mProd_PrecVenta
   * @return the value of mProd_PrecVenta
   */
  public Float getMProd_PrecVenta ( ) {
    return mProd_PrecVenta;
  }
  
  /**
   * Get the value of mProd_Stock
   * @return the value of mProd_Stock
   */
  public abstract  float getMProd_Stock ( );

  /**
   * Set the value of mProd_StockMinimo
   * @param newVar the new value of mProd_StockMinimo
   */
  public abstract  void setMProd_StockMinimo ( float newVar ) throws InputException;

  /**
   * Get the value of mProd_StockMinimo
   * @return the value of mProd_StockMinimo
   */
  public abstract float getMProd_StockMinimo ( );

  //
  // Other methods
  //

  /**
   * incrementa el Stock.
   *
   * @param        xValor Variable utilizada para sumar
   * @throws InputException
   */
  public abstract void sumarStock( float xValor ) throws InputException;

  /**
   * @param        xValor Valor utilizado para restar
   * @throws InputException
   */
  public abstract void restarStock( float xValor ) throws InputException;

  /**
   * Notifica que se han efectuado cambios en esta clase a los observadores interesados
   * @param arg Objeto que va a ir cuno a el objeto notificado
   */
  protected void Notificar (Object arg){
      super.setChanged();
      super.notifyObservers(arg);
  }
  
  public abstract Dom_Class_IVA getIVA ();

  public void validar() throws InputException {
      

//      if (mProd_Cod < 0 ) throw new InputException ("No a ingresado un código de producto o uno invalido");
      if (mProd_Nom.equals("")) throw new InputException ("No a ingresado un nombre de producto");
      
      if (mProd_PrecVenta < 0) throw new InputException("El precio de venta no puede ser un valor negativo");


      if (!mProd_CodBar.equals("")){
          Long.parseLong(mProd_CodBar);
      }

      if (this.determinarDesimo(getMProd_Stock()) && Tipo_Stok == Stok_Unidad)
          throw new InputException("El stock es un valor decimal en un producto con stock por unidad");
      if (this.determinarDesimo(getMProd_StockMinimo()) && Tipo_Stok == Stok_Unidad)
          throw new InputException("El stock minimo es un valor decimal en un producto con stock por unidad");
  }

  public abstract void Modificar(T xObjProdNue) throws InputException;

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;

        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LogN_ClassAb_Producto<T> other = (LogN_ClassAb_Producto<T>) obj;
        
        if (this.mProd_Cod != -1 && other.mProd_Cod != -1 && this.mProd_Cod != other.mProd_Cod) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + this.mProd_Cod;
        hash = 47 * hash + (this.mProd_CodBar != null ? this.mProd_CodBar.hashCode() : 0);
        return hash;
    }


  //Determina si el stok stok es menor que el stok minimo
    public boolean getStokMimimo (){
        float Stok , StokM;
        Stok = getMProd_Stock();
        StokM = getMProd_StockMinimo();
        if (StokM >= Stok)return true;
        return false;
    }

    protected  boolean determinarDesimo(float xValor) {
        int Entero = (int)xValor;

        if (((float)Entero) != xValor ) return true;

        return false;
    }

    public abstract  LogN_ClassAb_Movimiento generarMovimiento(String xDesOr, String xAutorisacion, String xDetalle, float xCatProd, boolean xTipo);

    @Override
    public boolean duplicado(T xObjCop) {
        LogN_ClassAb_Producto ObjProducto = (LogN_ClassAb_Producto) xObjCop;
        boolean EsDuplica  = true;
       
        if(this.mProd_Cod !=  ObjProducto.mProd_Cod) EsDuplica = false;
        else if(!this.mProd_Nom.equals(ObjProducto.mProd_Nom)) EsDuplica = false;
        else if (!this.mProd_Desc.equals(ObjProducto.mProd_Desc))EsDuplica = false;
        else if (!this.mProd_CodBar.equals(ObjProducto.mProd_CodBar)) EsDuplica = false;
        else if (mProd_PrecVenta != ObjProducto.mProd_PrecVenta) EsDuplica = false;
        
        return EsDuplica;
    }

    
}
