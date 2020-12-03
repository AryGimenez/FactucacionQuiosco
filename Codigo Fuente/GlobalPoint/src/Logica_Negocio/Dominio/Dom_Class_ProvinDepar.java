
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package Logica_Negocio.Dominio;

//~--- non-JDK imports --------------------------------------------------------



import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Utilidades.Util_Class_Utilitario;


/**
 * Representa la provincia o departamento
 * @author Ary
 */
public class // <editor-fold defaultstate="collapsed" desc="comment">
        Dom_Class_ProvinDepar// </editor-fold>
 extends LogN_ClassAb_CrePorNom {

    //Atributos_________________________________________________________________

    private static final String Tip = "Provincia o departamento";

    //Constructores ____________________________________________________________

    public Dom_Class_ProvinDepar (){
        super(Tip);
    }

    public Dom_Class_ProvinDepar(String mNom) throws ClassCastException {
        super(mNom, Tip);
    }



    //Atributos_________________________________________________________________

    /**
     * Remplasa el Nombre del pais por el pasado por parametro siempre y cuando este no sea una cadena basia
     * @param mNom Nombre del pais por el cual va a remplasarse
     * @return true si se pudo efecutar la modificacion en caso contrario retorna fasle
     */
    @Override
    public boolean setNom(String mNom) {
        

        if (!Util_Class_Utilitario.ValidarString(mNom)) {
            return false;    // Si la cadena es basia
        }

        this.mNom = Util_Class_Utilitario.PasarPM(mNom);
        return true;
    }

    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_CrePorNom duplicar() {
        Dom_Class_ProvinDepar ObjProvDep = new Dom_Class_ProvinDepar(mNom);
        ObjProvDep.setNum(this.getNum());
        return ObjProvDep;
    }


}


//~ Formatted by Jindent --- http://www.jindent.com
