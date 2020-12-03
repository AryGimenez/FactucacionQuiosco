
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
 * Representa el fax
 * @author Ary
 */
public class Dom_Class_Fax extends LogN_ClassAb_Contacto {

    // Atributos _______________________________________________________________

    private static final String Tip = "Fax";

    //Consturctor ______________________________________________________________

    public Dom_Class_Fax() {
        super(Tip);
    }

    public Dom_Class_Fax(String mNom, String mDetalle) throws ClassCastException {
        super(mNom, Tip, mDetalle);
    }



    //Metodos___________________________________________________________________

    /**
     * Remplasa el Nombre del fax pero siempre y cuando ese sea numero
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



    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {

        Dom_Class_Fax xObjFax = (Dom_Class_Fax) xObjCoparado;

        if (xObjFax.getNom().equals(this.getNom())) {
            return new String[]{"Numero"};
        }

        return new String[0];
    }




    @Override
    public Dom_Class_Fax duplicar() {
        Dom_Class_Fax ObjFax = new Dom_Class_Fax(getNom(), getDetalle());
        ObjFax.setNum(getNum());
        return ObjFax;
    }


}


//~ Formatted by Jindent --- http://www.jindent.com

