/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Dominio.Contacto;


import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;

/**
 *
 * @author ary
 */
public class Dom_Class_Mail  extends LogN_ClassAb_Contacto {

    //Atributos ________________________________________________________________
    private static final String Tip = "Mail";

    //Constructor ______________________________________________________________

    public Dom_Class_Mail(String mNom, String mDetalle) {
        super(mNom, Tip, mDetalle);
    }

    public Dom_Class_Mail (){
        super(Tip);
    }

    //Metodos __________________________________________________________________

    @Override
    public boolean setNom(String mNom) {
        if (!Util_Class_Utilitario.ValidarString(mNom)) return false;
        this.mNom = mNom.trim(); return true;
    }



    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {

        Dom_Class_Mail xObjMail = (Dom_Class_Mail) xObjCoparado;

        if (xObjMail.getNom().equals(this.getNom())) return new String [] {"Mail"};

        return new String[0];
    }




    @Override
    public void validar() throws InputException {
        super.validar();
        if ( mNom.indexOf('@') == -1) throw new InputException ("No ingresado el carácter @ en el mail");
        
    }

    @Override
    public Dom_Class_Mail duplicar() {
        Dom_Class_Mail ObjMail = new Dom_Class_Mail(getNom(), getDetalle());
        ObjMail.setNum(getNum());
        return ObjMail;
    }

    


}
