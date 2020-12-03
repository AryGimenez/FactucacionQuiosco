/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Filtros.Producto;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;
import java.util.AbstractCollection;
import java.util.ArrayList;

/**
 *
 * @author ary
 */
public class LogN_Class_FiltProdNom extends LogN_ClassAb_FiltrarStringProducto{
    //Consturctor_______________________________________________________________
    public LogN_Class_FiltProdNom(String Condicion, short Poscicion, short TipProd) throws InputException {
        super(Condicion, Poscicion, TipProd);
    }
    //Metodos___________________________________________________________________

    @Override
    public Class getCalse() {
        return  Dom_Class_ProductoComp.class;
    }

    @Override
    public ArrayList filtar(AbstractCollection ColAFil) {
        ArrayList <Dom_Class_ProductoComp> ColProd = new ArrayList<Dom_Class_ProductoComp>();
        Dom_Class_ProductoComp ObjPord;

        for (Object o : ColAFil ){
            ObjPord = (Dom_Class_ProductoComp) o;

            if (super.ComprarString(ObjPord.getMProd_Nom())) {
                 ColProd.add(ObjPord);
             }
        }
        return ColProd;
    }

    @Override
    public String toString() {
        return "Producto por nombre";
    }

    @Override
    public LogN_ClassAb_Producto filtrar(LogN_ClassAb_Producto ObjAFil) {
        ObjAFil = super.filtrar(ObjAFil);
        if(ObjAFil == null) return null;
        if (!super.ComprarString(((Dom_Class_ProductoComp)ObjAFil).getMProd_Nom()))return null;
        return ObjAFil;
    }

    @Override
    public String[] getNomPocicion() {
        throw new UnsupportedOperationException("Not supported yet.");
    }


}
