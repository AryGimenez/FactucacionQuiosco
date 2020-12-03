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
 * @author horacio
 */
public class LogN_Class_FiltProdCodBarr implements  LogN_Inter_FlitPorducto<String>{
    //Atributos_________________________________________________________________
    public final static short Producto = 0;
    public final static short ProductoCom = 1;
    public final static short SubProducto = 2;
    private short mTipProd = Producto;
    
    private String mCondicion;
    
    public final static short Completa = 3;
    public final static short Principio = 4;
    public final static short Final = 5;
    private short mPocicion = Completa;
    
    //Constructor_______________________________________________________________
    public LogN_Class_FiltProdCodBarr (short TipProd, short mPocicion, String Condicion ){
        try {
            setTipProd(TipProd);
            setmCondicion(Condicion);
            setmPocicion(mPocicion);
        } catch (InputException ex) {
            
        }
        
        
        
    }
    //Metodo____________________________________________________________________
    public void setmCondicion(String ObjCon) throws InputException {
        try{
          mCondicion = "" + Long.parseLong(ObjCon.trim());
      }catch (NumberFormatException ex){
          throw new InputException("El valor ingresado no es un valor numérico");
      }
    }

    public short getmPocicion() {
        return mPocicion;
    }

    public void setmPocicion(short mPocicion) throws InputException {
        
        if (mPocicion < 0 || (short) 5 < mPocicion) throw new InputException("A ingresado una opcion fuera de rango");
        if (mPocicion < 3) mPocicion += 3;
        this.mPocicion = mPocicion;
    }
    

    public String getmCondicion() {
        return mCondicion;
    }

    public Class<LogN_ClassAb_Producto> getCalse() {
        return LogN_ClassAb_Producto.class;
    }

    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        LogN_ClassAb_Producto ObjProd = this.filtrarPorTip(ObjAFil);
        if(ObjProd == null) return null;
        if (ObjAFil.getProd_CodBarr().equals(mCondicion)) ObjProd = ObjAFil;
        return ObjProd;

    }

    public ArrayList<LogN_ClassAb_Producto> filtar(AbstractCollection<LogN_ClassAb_Producto> ColAFil) {
        ArrayList<LogN_ClassAb_Producto> ColProd = new ArrayList<LogN_ClassAb_Producto>();
        for (LogN_ClassAb_Producto ObjP : ColAFil){
            ColProd.add(this.filtrar(ObjP));
        }
        return ColProd;
    }

    @Override
    public String toString() {
        return "Producto por Cod. Barra";
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
    
    //Tipo de produto **********************************************************
    public short getTipProd() {
        return mTipProd;
    }

    @Override
    public void setTipProd(short xTipProd) throws InputException {
        if (xTipProd < Producto || xTipProd > SubProducto) throw new InputException("A ingresado una opcion fuera de rango");
        mTipProd = xTipProd;
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    

    



    

}
