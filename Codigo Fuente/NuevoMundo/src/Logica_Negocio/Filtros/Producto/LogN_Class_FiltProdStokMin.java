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
public class LogN_Class_FiltProdStokMin implements LogN_Inter_FlitPorducto<Float>{
    //Atributos_________________________________________________________________
    public final static short Producto = 0;
    public final static short ProductoCom = 1;
    public final static short SubProducto = 2;
    private short mTipProd = 0;

    public final static short EN_STOK_MIN = 0;
    public final static short NO_EN_STOK_MIN = 1;
    private short mPosAc = 0;

    //Constructor_______________________________________________________________

    public LogN_Class_FiltProdStokMin(short mPosAc, short mTipProd) {
        this.mPosAc = mPosAc;

    }

    @Override
    public short getmPocicion() {
        return mPosAc;
    }

    @Override
    public void setmPocicion(short mPocicion) throws InputException {
        if (mPocicion < 0 || mPocicion > 1 ) throw new InputException ("Opción fuera de rango");
        mPosAc = mPocicion;
    }



    @Override
    public Float getmCondicion() {
        return null;
    }

    @Override
    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        ObjAFil = this.filtrarPorTip(ObjAFil);
        if(ObjAFil == null)return null;
        if ((ObjAFil.getStokMimimo() && mPosAc == NO_EN_STOK_MIN)
                || (!ObjAFil.getStokMimimo() && mPosAc == EN_STOK_MIN)) return null;

        return ObjAFil;
    }

    @Override
    public ArrayList<LogN_ClassAb_Producto> filtar(AbstractCollection<LogN_ClassAb_Producto> ColAFil) {
        ArrayList<LogN_ClassAb_Producto> ColProd = new ArrayList<LogN_ClassAb_Producto>();

        for (LogN_ClassAb_Producto ObjPro: ColAFil){
            if (this.filtrar(ObjPro) != null) ColProd.add(ObjPro);
        }
        return ColProd;
    }

    @Override
    public String toString() {
        return "Producto por stok Minimo";

    }
    @Override
    public Class<LogN_ClassAb_Producto> getCalse() {
        return LogN_ClassAb_Producto.class;
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
    // Tipo de Producto*********************************************************

    @Override
    public short getTipProd() {
        return mTipProd;
    }

    @Override
    public void setTipProd(short xTipProd) throws InputException {
        if (xTipProd < Producto || xTipProd > SubProducto) throw new InputException("A ingresado una opcion fuera de rango");
        mTipProd = xTipProd;
    }

    @Override
    public void setmCondicion(Float ObjCon) throws InputException {
        
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }





}
