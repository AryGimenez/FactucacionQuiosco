
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package Logica_Negocio.Dominio.Contacto;

//~--- non-JDK imports --------------------------------------------------------

import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;




/**
 * Representa a el celular
 * @author Ary
 */
public class Dom_Class_Cel extends LogN_ClassAb_Contacto {

    //Atributos_________________________________________________________________

    private static final String Tip = "Celular";

    //Constructor_______________________________________________________________

    public Dom_Class_Cel(){
        super(Tip);
    }

    public Dom_Class_Cel(String mNom, String mDetalle) throws ClassCastException {
        super(mNom, Tip, mDetalle);
        
    }



    //Metodos___________________________________________________________________

    /**
     * Remplasa el Nombre del sel pero siempre y cuando ese sea numero
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
        Dom_Class_Cel xObjCel = (Dom_Class_Cel) xObjCoparado;
        
        if (xObjCel.getNom().equals(this.getNom())) return new String [] {"Numero"};
        
        return new String[0];
        
    }

    @Override
    public void validar() throws InputException {
        if(!this.setNom(mNom))throw new InputException("A ingresado un valor no numérico");
    }

    @Override
    public Dom_Class_Cel duplicar() {
        Dom_Class_Cel ObjCel = new Dom_Class_Cel(mNom, getDetalle());
        ObjCel.setNum(this.getNum());
        return ObjCel;
    }


}


//~ Formatted by Jindent --- http://www.jindent.com
