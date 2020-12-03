/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;
import java.util.Observable;

/**
 * <B><FONT COLOR="red">Clase abstracta que se utilisa para representar un movimiento</FONT> </B>
 * el cual afecta solo al stok del producto (sin afectar la caja)
 * @author Ary Gimenez
 */
public abstract class LogN_ClassAb_Movimiento extends Observable implements LogN_Inter_Validar, LogN_Inter_ModificStok{

    //Atributos_________________________________________________________________
    /**
     * <B>Sotk solo por unidad </B>(no permite valores desimales)
     */
    public final static int STOK_X_UNIDAD = 0;
    
    /**
     * <B>Stok solo por decimo </B> (Permite Valores desimales)
     */
    public final static int STOK_X_DESIMO = 1;

    /**
     * Tipo de stok acutal
     */
    public final int TipStok;

    /**
     * Cantidad de producto a mover
     */
    private float mCanProd;

    /**
     * Producto involucrado en el movimiento
     */
    private Dom_Class_ProductoComp mObjProducto;

    /**
     * Destino o origen de la mercadería  
     */
    private String mDes_Origen;

    /**
     * Responsable del movimiento
     */
    private String mAutoriso;

    /**
     * Detalle del movimiento (una observación o información que se quiera registrar al momento del movimiento)  
     */
    private String mDetalle;

    /**
     * Número que identifica al movimiento (este es generado por el sistema)  
     */
    private int mNumMov;

    //Constructor_______________________________________________________________
    /**
     * <B>Constructor completo </B>
     * @param mObjProducto Producto a mover
     * @param mDes_Origen Destino o origen de la mercadería
     * @param mAutoriso Responsable del movimiento
     * @param mDetalle Detalle del movimiento (una observación o información que se quiera registrar al momento del movimiento)  
     * @param mCanProd Cantidad de producto a mover
     * @param mNumMov Número que identifica al movimiento
     */    
    public LogN_ClassAb_Movimiento(Dom_Class_ProductoComp mObjProducto, String mDes_Origen, String mAutoriso, String mDetalle, float mCanProd, int mNumMov) {
        this.setmDes_Origen(mDes_Origen);
        this.setmAutoriso(mAutoriso);
        this.setmDetalle(mDetalle);
        this.setProducto(mObjProducto);
        this.TipStok = mObjProducto.Tipo_Stok;
        this.mCanProd = mCanProd;
        this.mNumMov = mNumMov;
    }



    //Metodos___________________________________________________________________


    /**
     * <B>Retorna el responsable del movimiento</B>
     * @return mAutoriso
     */
    public String getmAutoriso() {
        return mAutoriso;
    }

    /**
     * <B>Remplaza el responsable del movimiento por el pasado por parámetro</B>
     * @param mAutoriso 
     */
    public void setmAutoriso(String mAutoriso) {
        this.mAutoriso = mAutoriso.trim();
    }

    /**
     * <B>Retorna el destino o origen</B> de la mercadería 
     * @return mDes_Origen
     */    
    public String getmDes_Origen() {
        return mDes_Origen;
    }

    /**
     * <B>Remplaza el destino /origen</B> del movimiento por el pasado por parámetro
     * @param mDes_Origen 
     */
    public void setmDes_Origen(String mDes_Origen) {
        this.mDes_Origen = mDes_Origen.trim();
    }

    /**
     * <B>Retorna el detalle</B> del movimiento
     * @return 
     */
    public String getmDetalle() {
        return mDetalle;
    }

    /**
     * <B>Remplaza el detalle</B> del producto por el pasado por parámetro
     * @param mDetalle 
     */
    public void setmDetalle(String mDetalle) {
        this.mDetalle = mDetalle.trim();
    }
    
    /**
     * <B>Comprueba si el valor pasado por parámetro es entero o no</B>
     * @param xValor Valor a comportar
     * @return True o false si es entero o no 
     */
    private boolean determinarDesimo(float xValor) {
        int Entero = (int)xValor;

        if (((float)Entero) != xValor ) return true;

        return false;
    }




    /**
     * <B>Retorna la cantidad de mercadería</B> involucrada en el movimiento
     * @return mCanProd
     */
    @Override
    public float getCanProd() {
        return mCanProd;
    }
    /**
     * Remplaza la cantidad de merecería del movimiento por la pasada por parámetro
     * @param xCanProd 
     */
    @Override
    public void setCanPord(float xCanProd) {
        mCanProd = xCanProd;
    }

    /**
     * <B>Retorna el número</B> de movimiento
     * @return mNumMov
     */
    @Override
    public int getNumModificador() {
        return mNumMov;
    }

    /**
     * <B>Remplaza el numero de movimiento,</B> por el pasado por parámetro 
     * @param xNumMod 
     */
    @Override
    public void setNumModificador(int xNumMod) {
        mNumMov = xNumMod;
    }

    /**
     * <B>Retorna el producto</B> involucrado en este movimiento
     * @return mObjProducto
     */
    @Override
    public Dom_Class_ProductoComp getPord() {
        return mObjProducto;
    }
    
    /**
     * <B>Remplaza el producto</B> involucrado en el movimiento, por el pasado por parametro
     * @param xObjPord 
     */
    @Override
    public void setProducto(Dom_Class_ProductoComp xObjPord) {
        mObjProducto = xObjPord;
    }
    
    /**
     * <B>Da veracidad</B> a los datos del movimiento
     * @throws InputException 
     * Compureba que:
     * <UL> 
         * <LI>haya ingresado un responsable de movimiento (mAutoriso) →No a ingresado el nombre de quien autorizo la operación←
         * <LI>haya ingresado un destino/origen de mercaderia (mDes_Origen) →No a ingresado un destino/origen del movimiento←
         * <LI>haya ingresado un producto para este movimiento (mObjProducto)
         * →No a ingresado un producto al cual se va a realizar el movimiento←
         * <LI>haya ingresado un tipo de stock dentro de los parámetros (TipStok) →A ingresado un tipo de stock fuera de rango←
         * <LI>no haya ingresado un tipo de stock no correlativo al producto del movimiento (mCanProd)
         * →A ingresado un valor decimal a un producto con stock por unidad←
     * </UL>
     */
    @Override
    public void validar() throws InputException {
        if (!Util_Class_Utilitario.ValidarString(mAutoriso)) throw new InputException("No a ingresado el nombre de quien autorizo la operación");
        if (!Util_Class_Utilitario.ValidarString(mDes_Origen)) throw new InputException("No a ingresado un destino/origen del movimiento");
        if (mObjProducto == null )throw new InputException("No a ingresado un producto al cual se va a realizar el movimiento");
        if (TipStok < 0 || TipStok > 1) throw new InputException("A ingresado un tipo de stock fuera de rango ");
        if (determinarDesimo(mCanProd) && TipStok == STOK_X_UNIDAD)throw new InputException ("A ingresado un valor decimal a un producto con stock por unidad ");

//        try{
//            mObjProducto.validar();
//        }catch (InputException Ex){
//            throw new InputException("El producto a mover no es valido");
//        }
    }

    



    
}
