/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros.Producto;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.LogN_Class_PaisActual;
import Logica_Negocio.MiExepcion.InputException;


/**
 *
 * @author ary
 */
public  abstract class LogN_ClassAb_FiltrarStringProducto implements LogN_Inter_FlitPorducto<String>{
    //Atributos_________________________________________________________________
    
    public final static short Producto = 0;
    public final static short ProductoCom = 1;
    public final static short SubProducto = 2;
    private short mTipProd = 0;

    public final static short No_Completa = 0;
    public final static short Completa = 1;
    public final static short Principio = 2;
    public final static short Final = 3;
    private short mPocicion;

    /**
     * Condicion para filtrar
     */
    private String mCondicion;

     //Constructor_______________________________________________________________
    public LogN_ClassAb_FiltrarStringProducto(String Condicion, short Poscicion, short TipProd) throws InputException {
        setmCondicion(Condicion);
        setmPocicion(mPocicion);
        setTipProd(TipProd);
    }

    //Metodos___________________________________________________________________



    public final void setmCondicion(String xObjCon) throws InputException {
        xObjCon = xObjCon.trim();
        mCondicion = xObjCon;
    }
    
    public String getmCondicion() {
        return mCondicion;
    }

    public short getmPocicion() {
         return mPocicion;
    }

    public final void setmPocicion(short mPocicion)throws InputException{
        if (mPocicion < 0 || mPocicion > 3 ) throw new InputException ("Opción fuera de rango");
        this.mPocicion = mPocicion;
    }

    protected boolean ComprarString (String xAComparar){

        xAComparar = xAComparar.trim();

        if (xAComparar.length() < mCondicion.length()) return false;

        String Comparador = mCondicion;
        boolean Res = false;

        switch (mPocicion){
                case Completa: Res = this.ComCompleto(xAComparar,Comparador);break;
                case No_Completa: Res = this.ComNo_Completa(xAComparar, Comparador);break;
                case Principio: Res = this.ComPrincipio(xAComparar, Comparador); break;
                case Final: Res = this.ConFinal (xAComparar, Comparador); break;
        }

        return Res;
    }

    private boolean ComCompleto(String xAComparar, String xComparador) {
        return xAComparar.equals(xComparador);
    }

    private boolean ComNo_Completa(String xAComparar, String xComparador) {
        if (xAComparar.indexOf(xComparador) == -1) return false;
        return true;
    }

    private boolean ComPrincipio(String xAComparar, String xComparador) {
        return xAComparar.startsWith(xComparador);
    }

    private boolean ConFinal(String xAComparar, String xComparador) {
        return xAComparar.endsWith(xComparador);
    }

    public short getTipProd() {
        return mTipProd;
    }

    public void setTipProd(short xTipProd) throws InputException {
        if (xTipProd < Producto || xTipProd > SubProducto) throw new InputException("A ingresado una opcion fuera de rango");
        mTipProd = xTipProd;
    }

    protected LogN_ClassAb_Producto filtrarPorTip (LogN_ClassAb_Producto ObjAFil){
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

    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        ObjAFil = filtrarPorTip(ObjAFil);
        return ObjAFil;
    }




}
