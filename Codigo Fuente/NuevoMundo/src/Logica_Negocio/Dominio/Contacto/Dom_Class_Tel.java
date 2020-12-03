
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package Logica_Negocio.Dominio.Contacto;

//~--- non-JDK imports --------------------------------------------------------



import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Utilidades.Util_Class_Utilitario;


/**
 * Representa al telefono
 * @author Ary
 */
public class Dom_Class_Tel extends LogN_ClassAb_Contacto {
    //Atributo__________________________________________________________________
    private static final String Tip = "Telefono";

    //Constructor_______________________________________________________________

    public Dom_Class_Tel (){
        super(Tip);
    }

    public Dom_Class_Tel(String mNom, String mDetalle) throws ClassCastException {
        super(mNom, Tip, mDetalle);
    }


    //Metodos___________________________________________________________________

    /**
     * Remplasa el Nombre del Telefono pero siempre y cuando ese sea numero
     * @param mNom String que solo permite Numeros
     * @return true si la caden pasada por parametro contine solo digito
     * flase en caso contrario
     */
    @Override
    public boolean setNom(String mNom) {
        if (!Util_Class_Utilitario.Comp_Long(mNom)) {
            return false;
        }

        super.mNom = mNom.trim();

        return true;
    }




    @Override
    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_Tel duplicar() {
        Dom_Class_Tel ObjTel = new Dom_Class_Tel(getNom(), getDetalle());
        ObjTel.setNum(getNum());
        return ObjTel;
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
