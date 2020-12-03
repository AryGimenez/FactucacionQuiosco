/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros.Producto;



import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;



/**
 *
 * @author ary
 */

public class LogN_Class_FiltProdCod implements LogN_Inter_FlitPorducto<String> {
    //Atributos_________________________________________________________________

    public final static short Producto = 0;
    public final static short ProductoCom = 1;
    public final static short SubProducto = 2;
    private short mTipProd = 0;

    public final static short IGUAL_QUE = 0;
    private short mVal = IGUAL_QUE;
    private String mComarador;
    private LogN_ClassAb_Producto mObjProducto;

    //Constructor_______________________________________________________________

    public LogN_Class_FiltProdCod(short mTipProd, short mPocicion, String Comparar) throws InputException{
        this.setTipProd(mTipProd);
        this.setmPocicion(mPocicion);
        this.setmCondicion(Comparar);
        
    }

    //Metodos___________________________________________________________________
    @Override
    public short getmPocicion() {
        return mVal;
    }

    @Override
    public void setmPocicion(short mPocicion) throws InputException {
        if (mPocicion != IGUAL_QUE) throw new InputException("");
    }



    @Override
    public String getmCondicion() {
        return mComarador;
    }

    @Override
    public Class<LogN_ClassAb_Producto> getCalse() {
        return LogN_ClassAb_Producto.class;
    }

    @Override
    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        
        
        LogN_ClassAb_Producto ObjProd = this.filtrarPorTip(ObjAFil);
        if(ObjProd == null) return null;
        if (ObjAFil.getmProd_Cod() == Integer.parseInt(mComarador)) ObjProd = ObjAFil;
        return ObjProd;
    }

    @Override
    public ArrayList<LogN_ClassAb_Producto> filtar(AbstractCollection<LogN_ClassAb_Producto> ColAFil) {
        ArrayList<LogN_ClassAb_Producto> ColProd = new ArrayList<LogN_ClassAb_Producto>();
        for (LogN_ClassAb_Producto ObjProd : ColAFil){
            ColProd.add(this.filtrar(ObjProd));
        }
        return ColProd;
    }

    @Override
    public String toString() {
        return "Producto por Codigo";
    }

    //Tipo Producto ************************************************************
    @Override
    public short getTipProd() {
        return mTipProd;
    }

    @Override
    public void setTipProd(short xTipProd)throws InputException{
        if (xTipProd < Producto || xTipProd > SubProducto) throw new InputException("A ingresado una opcion fuera de rango");
        mTipProd = xTipProd;
    }

    
    private LogN_ClassAb_Producto filtrarPorTip (LogN_ClassAb_Producto ObjAFil){
        LogN_ClassAb_Producto Respuesta = null;
        switch (mTipProd){
            case Producto : Respuesta = ObjAFil; break;
            case ProductoCom:
                if(ObjAFil instanceof Dom_Class_ProductoComp) Respuesta = ObjAFil;
            break;
            case SubProducto:
                if(ObjAFil instanceof Dom_Class_SubProducto)Respuesta = ObjAFil;
            break;
        }
        return Respuesta;
    }

    @Override
    public void setmCondicion(String ObjCon) throws InputException {
       try{
          mComarador = "" + Long.parseLong(ObjCon.trim());
      }catch (NumberFormatException ex){
          throw new InputException("El valor ingresado no es un valor numérico");
      }
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    
    





    












}
