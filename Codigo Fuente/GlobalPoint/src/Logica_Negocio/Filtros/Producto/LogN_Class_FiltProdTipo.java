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
public class LogN_Class_FiltProdTipo implements LogN_Inter_FlitPorducto<Object>{
    //Atributos_________________________________________________________________
    
    public final static short Producto = 0;
    public final static short ProductoCom = 1;
    public final static short SubProducto = 2;
    private short mTipProd = 0;
    //Constructor_______________________________________________________________
    public LogN_Class_FiltProdTipo(short TipPro)throws InputException{
        setTipProd(mTipProd);
    }


    // Metodos__________________________________________________________________

    public void setmCondicion(Object ObjCon) throws InputException {

    }

    public short getmPocicion() {
        return 0;
    }

    public void setmPocicion(short mPocicion) throws InputException {

    }

    public Object getmCondicion() {
        return null;
    }

    public Class<LogN_ClassAb_Producto> getCalse() {
        return LogN_ClassAb_Producto.class;
    }

    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        LogN_ClassAb_Producto Respuesta = filtrarPorTip(ObjAFil);
        if(Respuesta == null) return null;
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

    public ArrayList<LogN_ClassAb_Producto> filtar(AbstractCollection<LogN_ClassAb_Producto> ColAFil) {
        ArrayList<LogN_ClassAb_Producto> ColRespuesta = new ArrayList<LogN_ClassAb_Producto>();
        for (LogN_ClassAb_Producto ObjP: ColAFil)ColRespuesta.add(filtrar(ObjP));
        return ColRespuesta;
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
    public String toString() {
        return "Productos por Tipo";
    }

    //Tipo de produto **********************************************************

    public short getTipProd() {
        return mTipProd;
    }

    public void setTipProd(short xTipProd) throws InputException {
        if (xTipProd < Producto || xTipProd > SubProducto) throw new InputException("A ingresado una opcion fuera de rango");
        mTipProd = xTipProd;
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }




}
