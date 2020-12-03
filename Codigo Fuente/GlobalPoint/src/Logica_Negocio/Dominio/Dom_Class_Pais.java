
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package Logica_Negocio.Dominio;

//~--- non-JDK imports --------------------------------------------------------




import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;

//~--- JDK imports ------------------------------------------------------------

import java.util.ArrayList;

/**
 * Representa a los paises
 * @author Ary
 */
public class Dom_Class_Pais extends LogN_ClassAb_CrePorNom {

    // Atributos _______________________________________________________________

    private static final String Tip = "País";

    /**
     * Lista de Provincias o departamentos
     */
    private ArrayList<Dom_Class_ProvinDepar> mColProvDep = new ArrayList<Dom_Class_ProvinDepar>();


     // Consturctor ____________________________________________________________
    
    public Dom_Class_Pais (){
        super(Tip);
    }

    /**
     * Contructor completo
     * @param mNom Nombre del pis
     * @param mNum Numero del interno del pais
     * @throws ClassCastException
     */
    public Dom_Class_Pais(String mNom) throws ClassCastException {
        super(mNom,Tip);
    }

    /**
     *
     */


    // Operaciones _____________________________________________________________

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

    /**
     * Agrega un un departamento o provincia  al pais
     * @param xObjProvDep Provincia o departamento a agregar
     * @return true si se pudo efectuar la operacion con exito, retorna false
     * en caso contrario
     */
    public void altaProvDep(Dom_Class_ProvinDepar xObjProvDep) throws InputException{
        if (xObjProvDep == null) throw new InputException("A ingresado una porvincia o departamento no valido");
        xObjProvDep.validar();
        if (mColProvDep.contains(xObjProvDep))throw new  InputException("La provincia o depertameto ya existe ");
        mColProvDep.add(xObjProvDep);
    }

    /**
     * Agrega un un departamento o provincia  al pais pasandoel el nombre
     * @param xObjProvDep Provincia o departamento a agregar
     * @return true si se pudo efectuar la operacion con exito, retorna false
     * en caso contrario
     */
    public void altaProvDep(String NomProDep) throws InputException {
         this.altaProvDep(new Dom_Class_ProvinDepar(NomProDep));
    }

    /**
     * Da de alta el departamento si este no existe en la colecion en caso contrario retorna
     * el objeto que coresponda con el iquals
     * @param xObjProvDep
     * @return
     */
    private Dom_Class_ProvinDepar alta_o_RetProvDepar (Dom_Class_ProvinDepar xObjProvDep) throws InputException{
        
        if (mColProvDep.contains(xObjProvDep)){
            
            xObjProvDep= this.getProvDep(xObjProvDep);
            
        }else{
            this.altaProvDep(xObjProvDep);
        }
        return xObjProvDep;
    }
    
     public  Dom_Class_ProvinDepar getProvDep (Dom_Class_ProvinDepar xObjProvDep){

        if (xObjProvDep == null) return null;

        int Pos = mColProvDep.indexOf(xObjProvDep);

        if (Pos == -1)return null;

        return mColProvDep.get(Pos);


    }

    /**
     * Da de alta el un Objeto "Dom_Class_ProvinDepar con" el nombre pasado por paraetro 
     * en caso contrario retorna un Dom_Class_ProvinDepar que coinsida con el nombre pasado por parametro
     * @param NomProDep
     * @return
     */
    public Dom_Class_ProvinDepar alta_o_RetProvDepar(String NomProDep) throws InputException {
        return alta_o_RetProvDepar(new Dom_Class_ProvinDepar(NomProDep));
    }

    /**
     *
     * @param xObjProvDep
     * @return
     */
    public boolean bajaPorvDep(Dom_Class_ProvinDepar xObjProvDep) {
        return mColProvDep.remove(xObjProvDep);
    }

    /**
     *
     * @param NomProDep
     * @return
     */
    public boolean bajaPorvDep(String NomProDep) {
        return this.bajaPorvDep(new Dom_Class_ProvinDepar(NomProDep));
    }

    /**
     *
     * @param xObjProvDep_Modificador
     * @param xObjProvDep_Modificado
     * @return
     */
    public boolean modificacionProvDep(Dom_Class_ProvinDepar xObjProvDep_Modificador,
                                       Dom_Class_ProvinDepar xObjProvDep_Modificado){
        return false;
    }

    /**
     * Determina si esiste la Porvincia o departamento pasado por parametro en este pais
     * @param xObjProvDep Provincia o departamento a determinar si existe
     * @return true si existe false en caso contrario
     */
    public boolean existeProvDep(Dom_Class_ProvinDepar xObjProvDep) {
        return mColProvDep.contains(xObjProvDep);
    }



    public ArrayList<Dom_Class_ProvinDepar> listarProvoDep (){
        return new ArrayList<Dom_Class_ProvinDepar>(mColProvDep);
    }
    
    @Override
    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LogN_ClassAb_CrePorNom duplicar() {
        Dom_Class_Pais ObjPais = new Dom_Class_Pais(mNom);
        ObjPais.mColProvDep.addAll(mColProvDep);
        ObjPais.setNum(this.getNum());
        return ObjPais;
    }
}



