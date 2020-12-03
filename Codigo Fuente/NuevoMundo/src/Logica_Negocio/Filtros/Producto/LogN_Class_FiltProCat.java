/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros.Producto;


import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;

/**
 *
 * @author horacio
 */
public class LogN_Class_FiltProCat extends LogN_ClassAb_FiltrarStringProducto {
    //Constructor_______________________________________________________________

    public LogN_Class_FiltProCat(String Condicion,short Poscicion, short TipProd) throws InputException {
        super (Condicion, Poscicion, TipProd);
    }

    @Override
    public Class getCalse() {
        return  LogN_ClassAb_Producto.class;
    }

    @Override
    public ArrayList<LogN_ClassAb_Producto> filtar(AbstractCollection<LogN_ClassAb_Producto> ColAFil) {
        ArrayList <LogN_ClassAb_Producto> ColProd = new ArrayList<LogN_ClassAb_Producto>();
        

        for (LogN_ClassAb_Producto ObjProd : ColAFil ){
            ColProd.add(this.filtrar(ObjProd));
        }

        return ColProd;
    }

    @Override
    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        ObjAFil = super.filtrar(ObjAFil);
        if(ObjAFil == null) return null;
        if (!super.ComprarString(ObjAFil.getmObjCat().getNom()))return null;
        return ObjAFil;
    }

    @Override
    public String toString() {
        return "Producto por Categoria";
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }



    

    


}
