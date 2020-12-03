
/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
 */
package Logica_Negocio;

//~--- non-JDK imports --------------------------------------------------------


import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;

import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_Utilitario;

import java.util.ArrayList;






//~--- JDK imports ------------------------------------------------------------



/**
 * Personas de inbolucradas en la empresa
 * @author APA Comprueba todas las personas tanto juridicas y individuales
 * inboluncradas empresa
 * @version 1.0
 * @updated 11-dic-2011 13:32:41
 */
public abstract class LogN_ClassAb_Persona implements LogN_Inter_Validar, LogN_Inter_Duplicado<LogN_ClassAb_Persona> {

     // Atributos ______________________________________________________________

    /**
     * Representa el tipo de documento CI
     */
    public final static int TipDoc_CdulaIdentidad = 0;

    /**
     * Representa el tipo de documento Pasaporte
     */
    public final static int TipDoc_Pasaporte = 1;
    /**
     * Representa el tipo de documento DNI
     */
    public final static int TipDoc_DNI = 2;

    /**
     * Tipo de documento actual
     */
    private int mTipDoc;

    /**
     * Coleccion de Celulares
     */
    private ArrayList<Dom_Class_Cel> mColCel;

    /**
     * Coleccion de Fax
     */
    private ArrayList<Dom_Class_Fax> mColFax;

    /**
     * Coleccion de telefonos
     */
    private ArrayList<Dom_Class_Tel> mColTel;

    /**
     * Coleccion de Mail
     */
    private ArrayList<Dom_Class_Mail>mColMail;
    
    /*
     * Representa la Colexion de saldo con la empresa 
     * puede aber tantos como monedas en el sistema 
     */
    private ArrayList<Dom_Class_Saldo> mColSaldo;



    /**
     * Direccion
     */
    private String mDir;

    /**
     * Localidad(Ciudad y mas)
     */
    private String mLoc;

    /**
     * Numero de persona ivolucrada
     */
    private int mNum = -1;


    /**
     * numero de documento de la persona
     */
    private String mNumDoc;

    /**
     * Pais de la persona usualmente relacionado cona la locualidad y la direccion
     */
    private Dom_Class_Pais mObjPais;

    /**
     * Departamento o Provincia de la persona la cual debe pertenecer al pais selecionado
     */
    private Dom_Class_ProvinDepar mObjProvDep;

    /**
     * observacion de la persona
     */
    private String mObs;

   

    /**
     * Rason social
     *
     */
    private String mRasSos;

    /**
     * Determina si se a facturado en este cliente por lo tanto no podra eliminarse
     */
    private boolean mFact = false;
    /**
     * Rut de la persona
     */
    private String mRut;
    
    private LogN_ClassAb_FechPag mObjFechPago;


    // Constructores ___________________________________________________________

    /**
     * Constructor que inicializa los datos por defecto
     */
    public LogN_ClassAb_Persona(){
        this("", "", "",-1, "",  null, null, "","", null);
    }
    
    
    /**
      * Constructor Copiador
      * @param xObjPer Objeto persona por el cual se rellena los datos
      */
    public LogN_ClassAb_Persona(LogN_ClassAb_Persona xObjPer){
         this(xObjPer.mDir, xObjPer.mLoc, xObjPer.mNumDoc, xObjPer.mTipDoc, xObjPer.mRut, xObjPer.mObjPais,
                 xObjPer.mObjProvDep, xObjPer.mObs, xObjPer.mRasSos, xObjPer.mObjFechPago.duplicar());
     }
     
    /**
     * Constructor de la completo de la clase
     * @param mDir Dirección
     * @param mLoc Localidad (el nombre Ciudad, Pueblo, etc)
     * @param mNumDoc Numero de documento (según el tipo)
     * @param mTipDoc Tipo de documento
     * @param mRut Rut empresarial
     * @param mObjPais País
     * @param mObjProvDep Provincia o departamento
     * @param mObs Observacional (Dato auxiliar o comentario)
     * @param mRasSos Razón Social (Nombre completo de la persona o en caso de empresa su nombre)
     */
    public LogN_ClassAb_Persona(String mDir, String mLoc, String mNumDoc, int mTipDoc, String mRut,
             Dom_Class_Pais mObjPais, Dom_Class_ProvinDepar mObjProvDep,
             String mObs, String mRasSos, LogN_ClassAb_FechPag mObjFechPago) {
        
         this(mDir, mLoc, mNumDoc,mTipDoc, mRut, mObjPais, mObjProvDep, mObs, mRasSos,
                 new ArrayList<Dom_Class_Cel>(), new ArrayList<Dom_Class_Fax>(), new ArrayList<Dom_Class_Tel>(),
                 new ArrayList<Dom_Class_Mail>() , new ArrayList<Dom_Class_Saldo>(), mObjFechPago);
         
    }

    /**
     * Constructor de la completo de la clase
     * @param mDir Dirección
     * @param mLoc Localidad (el nombre Ciudad, Pueblo, etc)
     * @param mNumDoc Numero de documento (según el tipo)
     * @param mTipDoc Tipo de documento 
     * @param mRut RUT empresarial
     * @param mObjPais País
     * @param mObjProvDep Provincia o departamento
     * @param mObs Observacional (Dato auxiliar o comentario)
     * @param mRasSos Razón Social (Nombre completo de la persona o en caso de empresa su nombre)
     * @param mColCel Grupo de los números de celulares para contactar a esta persona
     * @param mColFax Grupo de los números de fax para contactar a esta persona
     * @param mColTel Grupo de los números de Teléfono  para contactar a esta persona
     * @param mColMail Grupo de los Mail para contactar a esta persona
     * @param mColSaldo Saldo con la persona para con la empresa
     */
    public LogN_ClassAb_Persona(String mDir, String mLoc, String mNumDoc , int mTipDoc,String mRut , Dom_Class_Pais mObjPais, 
            Dom_Class_ProvinDepar mObjProvDep, String mObs, String mRasSos,  ArrayList<Dom_Class_Cel> mColCel, ArrayList<Dom_Class_Fax> mColFax, 
            ArrayList<Dom_Class_Tel> mColTel, ArrayList<Dom_Class_Mail> mColMail, ArrayList <Dom_Class_Saldo> mColSaldo, 
            LogN_ClassAb_FechPag mObjFechPag) {
        
            this.mColCel = mColCel;
            this.mColFax = mColFax;
            this.mColTel = mColTel;
            this.mColMail = mColMail;
            this.mColSaldo = mColSaldo;

            this.setmDir(mDir);
            this.setmLoc(mLoc);
            //Asigna -1 para determinar que no se a asignado un numero correlativo con repecto a
            //los otras personas
            this.setmNumDoc(mNumDoc);
            this.setmTipDoc(mTipDoc);
            this.setmRut(mRut);

            this.setmObjPais(mObjPais);
            this.setmObjProvDep(mObjProvDep);
            this.setmObs(mObs);
            this.setmRasSos(mRasSos);
            this.mObjFechPago  = mObjFechPag;

    }

    //Metodos___________________________________________________________________

    /**
     * <B>Retorna el RUT de la persona</B>
     * @return RUT
     */
    public String getmRut() {
        return mRut;
    }
    
    /**
     * <B>Remplaza el RUT</B> de la persona por la pasada por parámetro
     * @param mRut 
     */
    public void setmRut(String mRut) {
        if (mRut == null) mRut = "";
        this.mRut = mRut.trim();
    }

    /**
     * <B>Retorna el tipo de documento</B>
     * @return mTipDoc
     */
    public int getmTipDoc() {
        return mTipDoc;
    }

    /**
     * <B>Remplaza  el tipo de documento </B>por el pasado por parámetro
     * @param mTipDoc 
     */
    public void setmTipDoc(int mTipDoc) {
        this.mTipDoc = mTipDoc;
    }

    /**
     * Retorna la direccion de la persona
     * @return mDir Direccion de la persona
     */
    public String getmDir() {
        return mDir;
    }

    /**
     * Remplasa la direccion de la persona por la pasada por parametro
     * @param mDir Direccion por la cual remplasar
     * @return fase en caso que mDir sea un String null o una cadena vacía (una cadena que no posea caracteres espacios espacios en blanco)
     */
    public final boolean setmDir(String mDir) {
        if (!Util_Class_Utilitario.ValidarString(mDir)) return false;
        this.mDir = mDir.trim(); return true;
    }

    /**
     * Retorna la localidad de la persona
     * @return mLoc Localidad de la persona
     */
    public String getmLoc() {
        return mLoc;
    }

    /**
     * Remplasa la localidad por la pasada por parametro
     * @param mLoc Localidad por la cual remplasar
     */
    public void setmLoc(String mLoc) {
        this.mLoc = mLoc.trim();
    }
    
    
    public LogN_ClassAb_FechPag getmObjFechPago() {
        return mObjFechPago;
    }

    public void setmObjFechPago(LogN_ClassAb_FechPag mObjFechPago) {
        this.mObjFechPago = mObjFechPago;
    }

    /**
     * Retorna el numero de la persona el cual tine que ser unico;
     * @return mNum Numero de la persona
     */
    public int getmNum() {
        return mNum;
    }

    /**
     * Remplasa el numero de la persono por el numero pasado por parametreo
     * @param mNum numero por el cual remplasar
     */
    public void setmNum(int mNum) {
        this.mNum = mNum;
    }

    /**
     * Retorna el numero de documento de la persona
     * @return mNumDoc Numero de documento
     */
    public String getmNumDoc() {
        return mNumDoc;
    }

    /**
     * Remplasa el numero de documento de la persona por el numero pasado por parametro
     * @param mNumDoc Numero de documento por el cual se remplasa
     */
    public void setmNumDoc(String mNumDoc) {
        if(mNumDoc == null) mNumDoc = "";
        this.mNumDoc = mNumDoc.trim();
    }

    /**
     * Retorna la Observacion de la paersona
     * @return mObs Observacion de la persona
     */
    public String getmObs() {
        return mObs;
    }

    /**
     * Remplasa la Observacion de la persona por la pasada por parametro
     * @param mObs Observacion por la caul se ba a remplasar
     */
    public void setmObs(String mObs) {
        this.mObs = mObs.trim();
    }

    /**
     * Restorna RasonSocioal de la personaq
     * @return Rason Socioal
     */
    public String getmRasSos() {
        return mRasSos;
    }

    /**
     * Remplasa la rason social de la persona siempre y cuando esta no sea un ""
     * @param mRasSos Rason social de la persona por la cual se remplas
     * @return fase en caso que mRasSos sea un String null o una cadena vacía (una cadena que no posea caracteres espacios espacios en blanco)
     */
    public boolean setmRasSos(String mRasSos) {
        if (!Util_Class_Utilitario.ValidarString(mDir))return false;

        this.mRasSos = mRasSos;

        return true;
    }

    /**
     * Retorna toda la Colección de celulares de la persona (todo los Numero de
     * celulares que posee en el sistema)
     * @return mColCel
     */
    public ArrayList<Dom_Class_Cel> getmColCel() {
        return new ArrayList<Dom_Class_Cel>(mColCel);
    }

    /**
     * Remplaza la colección de celulares por la pasada por parámetro
     * @param mColCel Colección por la cual se va a realizar la operación
     */
    public void setmColCel(ArrayList<Dom_Class_Cel> mColCel) {
        this.mColCel = mColCel;
    }

    /**
     * Retorna toda la Colección de FAX de la persona (todo los Numero de
     * FAX que posee en el sistema)
     * @return mColFax
     */
    public ArrayList<Dom_Class_Fax> getmColFax() {
        return new ArrayList<Dom_Class_Fax>(mColFax);
    }

    /**
     * Remplaza la colección de FAX por la pasada por parámetro
     * @param mColFax Colección por la cual se va a realizar la operación
     */
    public void setmColFax(ArrayList<Dom_Class_Fax> mColFax) {
        this.mColFax = mColFax;
    }

    /**
     * Retorna toda la Colección de Teléfono de la persona (todo los Numero de
     * Teléfono que posee en el sistema)
     * @return mColTel
     */
    public ArrayList<Dom_Class_Tel> getmColTel() {
        return new ArrayList<Dom_Class_Tel> (mColTel);
    }
    
    /**
    * Remplaza la colección de Telefono por la pasada por parámetro
    * @param mColTel  Colección por la cual se va a realizar la operación
    */
    public void setmColTel(ArrayList<Dom_Class_Tel> mColTel) {
        this.mColTel = mColTel;
    }
    
    /**
     * Retorna el País de la persona
     * @return mObjPais 
     */
    public Dom_Class_Pais getmObjPais() {
        return mObjPais;
    }

    /**
     * Remplaza el país de la persona por la pasada por parámetro 
     * @param mObjPais País por el cual se va a realizar la operación
     * @return  trute si se puedo efectuar la operación fase en caso contrario
     */
    public boolean setmObjPais(Dom_Class_Pais mObjPais){


        if (this.mObjPais != null && !this.mObjPais.equals(mObjPais)) {//Comprueba que el pais no aya cambiado
            //Si es aci buelbe la probincia a null
            this.mObjProvDep = null;
        }

        this.mObjPais = mObjPais;
        return true;
    }

    /**
     * <B>Retorna la provincia/departamento</B> de la persona
     * @return mObjProvDep
     */
    public Dom_Class_ProvinDepar getmObjProvDep() {
        return mObjProvDep;
    }
    
    /**
     * Remplaza la provincia o departamento por la pasada por parámetro
     * @param mObjProvDep Provincia o departamento con la cual se va a realizar
     * la operación
     */
    public void setmObjProvDep(Dom_Class_ProvinDepar mObjProvDep){
        this.mObjProvDep = mObjProvDep;
    }
    

    /**
     * <B>Modifica los datos de la persona</B> por los de la persona pasada por parámetro
     * @param xObjPer
     * @throws InputException 
     * Exceptión lanzada por el método validar de la persona pasada por parámetro
     */
    public void modificar (LogN_ClassAb_Persona xObjPer) throws InputException{
        xObjPer.validar();
        
        mColCel = new ArrayList<Dom_Class_Cel>(xObjPer.mColCel);
        mColTel = new ArrayList<Dom_Class_Tel>(xObjPer.mColTel);
        mColMail = new ArrayList<Dom_Class_Mail>(xObjPer.mColMail);
        mColFax = new ArrayList<Dom_Class_Fax> (xObjPer.mColFax);
        //Falta La parte de modificar saldo tiene que estar un poco mas contralada
        mColSaldo = new ArrayList<Dom_Class_Saldo>(xObjPer.mColSaldo);
        
        mDir = xObjPer.mDir;
        mLoc = xObjPer.mLoc;
        mNumDoc = xObjPer.mNumDoc;
        mTipDoc = xObjPer.mTipDoc;
        mFact = xObjPer.mFact;
        mObjPais = xObjPer.mObjPais;
        mObjProvDep = xObjPer.mObjProvDep;
        mObs = xObjPer.mObs;
        mRasSos = xObjPer.mRasSos;
        mRut = xObjPer.mRut;
        
    }

    // <editor-fold defaultstate="collapsed" desc="Metodos Telefono">
        /**
         * <B>Da de alta el teléfono </B>pasado por parámetro
         * @param xObjTel
         * @throws InputException 
         * Exception lanzada por el metodo <K>altaxNom</K>
         */
        public void altaTel(Dom_Class_Tel xObjTel)throws InputException {
            this.altaXNOm(xObjTel, mColTel);
        }

        /**
         * <B>Da de baja el teléfono </B> pasado por parámetro
         * @param xObjTel
         * @return True o false si se pudo realizar o no la operación  
         */
        public boolean bajaTel(Dom_Class_Tel xObjTel) {
            return mColTel.remove(xObjTel);
        }
        
        /**
         * <B>Retorna o da de alta el teléfono</B> pasado por parámetro<BR>
         * Retorna el teléfono del sistema que corresponda con el “equals() “ 
         * del teléfono pasado por parámetro en caso de no existir coincidencias lo de alta en la persona
         * @param xObjTel
         * @return
         * @throws InputException 
         */
        public Dom_Class_Tel retur_o_altaTel(Dom_Class_Tel xObjTel) throws InputException {
            return (Dom_Class_Tel) this.retor_o_CrarXNom(xObjTel, mColTel);
        }

        /**
         * <B>Modifica los datos del teléfono</B>
         * @param xObjTel_Modificado <U>Teléfono a ser modificado</U>: Busca el teléfono del sistema que coincida con su “equals()” 
         * @param xObjTel_Modificador <U>Teléfono modificador</U>: Este contiene los datos que se van a utilizar para modificar el teléfono del sistema 
         * @throws InputException 
         * Excepción lanzada por el método “ModificarXNom()”
         */
        public void  modificarTel(Dom_Class_Tel xObjTel_Modificado, Dom_Class_Tel xObjTel_Modificador) throws InputException {
            this.ModificarXNom(xObjTel_Modificado, xObjTel_Modificador, mColTel);
        }

        /**
         * <B>Determina si existe el teléfono </B>pasado por parámetro en esta persona 
         * @param xObjTel
         * @return true  si existe el teléfono false en caso contrario
         */
        public boolean existeTel(Dom_Class_Tel xObjTel) {
            return mColTel.contains(xObjTel);
        }

     // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Metodos Celular">
        
        /**
         * <B>Da de alta el celular </B>pasado por parámetro
         * @param xObjCel
         * @throws InputException 
         * Exception lanzada por el metodo <K>altaxNom</K>
         */
        public void altaCel(Dom_Class_Cel xObjCel)throws  InputException{
             this.altaXNOm(xObjCel, mColCel);
        }
        
        /**
         * <B>Da de baja el celular </B> pasado por parámetro
         * @param xObjCel
         * @return True o false si se pudo realizar o no la operación  
         */
        public boolean bajaCel(Dom_Class_Cel xObjCel) {
            return mColCel.remove(xObjCel);
        }

        /**
         * <B>Retorna o da de alta el celular</B> pasado por parámetro<BR>
         * Retorna el celular del sistema que corresponda con el “equals() “ 
         * del teléfono pasado por parámetro en caso de no existir coincidencias lo de alta en la persona
         * @param xObjCel
         * @return 
         * @throws InputException 
         */
        public Dom_Class_Cel retur_o_altaCel(Dom_Class_Cel xObjCel) throws InputException {
            return (Dom_Class_Cel) retor_o_CrarXNom(xObjCel, mColCel);
        }
        
        /**
         * <B>Modifica los datos del Celular</B>
         * @param xObjCel_Modificado <U>Celular a ser modificado</U>: Busca el celular del sistema que coincida con su “equals()” 
         * @param xObjCel_Modificador <U>Celular modificador</U>: Este contiene los datos que se van a utilizar para modificar 
         * el celular del sistema 
         * @throws InputException 
         * Excepción lanzada por el método “ModificarXNom()”
         */
        public void modificarCel(Dom_Class_Cel xObjCel_Modificado, Dom_Class_Cel xObjCel_Modificador) throws InputException {
            this.ModificarXNom(xObjCel_Modificado, xObjCel_Modificador, mColCel);
        }
        
        /**
         * <B>Determina si existe el celular </B>pasado por parámetro en esta persona 
         * @param xObjCel
         * @return true si existe el celular, false en caso contrario
         */
        public boolean existeCel(Dom_Class_Cel xObjCel) {
            return mColCel.contains(xObjCel);
        }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Metodos Fax">
        
        /**
         * <B>Da de alta el fax </B>pasado por parámetro
         * @param xObjFax
         * @throws InputException 
         * Exception lanzada por el metodo <K>altaxNom</K>
         */
        public void altaFax(Dom_Class_Fax xObjFax)throws InputException {
             this.altaXNOm(xObjFax, mColFax);
        }
        
        /**
         * <B>Da de baja el fax </B> pasado por parámetro
         * @param xObjFax
         * @return True o false si se pudo realizar o no la operación  
         */
        public boolean bajaFax(Dom_Class_Fax xObjFax) {
            return mColFax.remove(xObjFax);
        }

        /**
         * <B>Retorna o da de alta el fax</B> pasado por parámetro<BR>
         * Retorna el fax del sistema que corresponda con el “equals() “ 
         * del fax pasado por parámetro en caso de no existir coincidencias lo de alta en la persona
         * @param xObjFax
         * @return 
         * @throws InputException 
         */
        public Dom_Class_Fax retur_o_altaFax(Dom_Class_Fax xObjFax) throws InputException {
            return (Dom_Class_Fax)this.retor_o_CrarXNom(xObjFax, mColFax);
        }

        /**
         * <B>Modifica los datos del fax</B>
         * @param xObjFax_Modificado <U>Fax a ser modificado</U>: Busca el fax del sistema que coincida con su “equals()” 
         * @param xObjFax_Modificador <U>Fax modificador</U>: Este contiene los datos que se van a utilizar para modificar 
         * el fax del sistema 
         * @throws InputException 
         * Excepción lanzada por el método “ModificarXNom()”
         */
        public void modificarFax(Dom_Class_Fax xObjFax_Modificado, Dom_Class_Fax xObjFax_Modificador) throws InputException {
            this.ModificarXNom(xObjFax_Modificado, xObjFax_Modificador, mColFax);
        }

        /**
         * <B>Determina si existe el fax </B>pasado por parámetro en esta persona 
         * @param xObjFax
         * @return true si existe el fax, false en caso contrario
         */
        public boolean existeFax(Dom_Class_Fax xObjFax) {
            return mColFax.contains(xObjFax);
        }
     // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Metodos Mail">
        
         /**
         * <B>Da de alta el mail </B>pasado por parámetro
         * @param xObjMail
         * @throws InputException 
         * Exception lanzada por el metodo <K>altaxNom</K>
         */
        public void altamMail(Dom_Class_Mail xObjMail)throws InputException{
            this.altaXNOm(xObjMail, mColMail);
        }
        
        /**
         * <B>Da de baja el mail </B> pasado por parámetro
         * @param xObjMail
         * @return True o false si se pudo realizar o no la operación  
         */
        public boolean bajaMail(Dom_Class_Mail xObjMail) {
            return mColMail.remove(xObjMail);
        }
        
        /**
         * <B>Retorna o da de alta el mail</B> pasado por parámetro<BR>
         * Retorna el mail del sistema que corresponda con el “equals() “ 
         * del mail pasado por parámetro en caso de no existir coincidencias lo de alta en la persona
         * @param xObjMail
         * @return 
         * @throws InputException 
         */
        public Dom_Class_Mail retur_o_altaMail(Dom_Class_Mail xObjMail) throws InputException {
            return (Dom_Class_Mail) this.retor_o_CrarXNom(xObjMail, mColMail);
        }
        
        /**
         * <B>Modifica los datos del mail</B>
         * @param xObjMail_Modificado <U>Mail a ser modificado</U>: Busca el mail del sistema que coincida con su “equals()” 
         * @param xObjMail_Modificador <U>Mail modificador</U>: Este contiene los datos que se van a utilizar para modificar 
         * el mail del sistema 
         * @throws InputException 
         * Excepción lanzada por el método “ModificarXNom()”
         */
        public void modificarMail(Dom_Class_Mail xObjMail_Modificado, Dom_Class_Mail xObjMail_Modificador) throws InputException {
            this.ModificarXNom(xObjMail_Modificado, xObjMail_Modificador, mColMail);
        }
        
        /**
         * <B>Determina si existe el mail </B>pasado por parámetro en esta persona 
         * @param xObjMail
         * @return true si existe el mail, false en caso contrario
         */
        public boolean existeMail(Dom_Class_Mail xObjMail) {
            return mColMail.contains(xObjMail);
        }
        
        /**
         * Retorna la colecion de mail
         * @return mColMail
         */
        public ArrayList<Dom_Class_Mail> getmColMail() {
            return mColMail;
        }

        /**
         * Remplaza la conexión de mail por la pasada por parámetro.
         * @param mColMail 
         */
        public void setmColMail(ArrayList<Dom_Class_Mail> mColMail) {
            this.mColMail = mColMail;
        }

     // </editor-fold>
        
    // <editor-fold defaultstate="collapsed" desc="Metodos xNom">
        
        /**
         * metodo comun para dar de alta los objetos que extiendan de “LogN_ClassAb_CrePorNom”
         * @param xObjCreXNom Objeto a dar de alta
         * @param xCol Colección en la cual se va a dar de lata el objeto 
         */
        private void altaXNOm (LogN_ClassAb_CrePorNom xObjCreXNom, ArrayList xCol) throws InputException{
            if (xObjCreXNom == null) throw new InputException("A ingresado " + xObjCreXNom.Tipo + " un no valido");
            xObjCreXNom.validar();
            if (xCol.contains(xObjCreXNom))throw new  InputException("El " + xObjCreXNom.Tipo + "ya existe ");
            xCol.add(xObjCreXNom);

        }

        private void ModificarXNom (LogN_ClassAb_CrePorNom xObjCreXNom, LogN_ClassAb_CrePorNom xObjCrePorNomModificador, ArrayList xCol) throws InputException{
            xObjCreXNom = this.getObjCreXNom(xObjCreXNom, xCol);
            if (xObjCreXNom == null) throw new InputException("El a"+ xObjCreXNom.Tipo +"modificar no existe en le sistema");
            xObjCrePorNomModificador.modificar(xObjCreXNom);
        }

        private LogN_ClassAb_CrePorNom getObjCreXNom (LogN_ClassAb_CrePorNom xObjCreXNom,ArrayList xCol){

            if (xObjCreXNom == null) return null;

            int Pos = xCol.indexOf(xObjCreXNom);

            if (Pos == -1)return null;

            return (LogN_ClassAb_CrePorNom)xCol.get(Pos);


        }

        private LogN_ClassAb_CrePorNom retor_o_CrarXNom (LogN_ClassAb_CrePorNom xObjCreXNom, ArrayList xCol) throws InputException{
            if (xCol.contains(xObjCreXNom)){
                xObjCreXNom = this.getObjCreXNom(xObjCreXNom, xCol);
            }else{
                this.altaXNOm(xObjCreXNom, xCol);
            }
            return xObjCreXNom;
        }
    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Metodos Saldo">
        /**
         * Da de alta el saldo pasado por parametro
         * @param xObjSaldo
         * @throws InputException 
         */
        public void altaSaldo (Dom_Class_Saldo xObjSaldo) throws InputException{
            xObjSaldo.validar();
            if (mColSaldo.contains(mColSaldo))throw new InputException("El saldo ya existe compruebe la moneda");
            mColSaldo.add (xObjSaldo);
        }

        /**
         * Retorna la colecion de saldo de la persona
         * @return mColSaldo
         */
        public ArrayList<Dom_Class_Saldo> getmColSaldo (){
            return new ArrayList<Dom_Class_Saldo>(mColSaldo);
        }
        

        public Dom_Class_Saldo getSaldo(Dom_Class_Saldo xObjSaldoNu) {
            int PosS = mColSaldo.indexOf(xObjSaldoNu);
            if (PosS == -1) return null;
            return mColSaldo.get(PosS);
        }
        
        public Dom_Class_Saldo getSaldo(Dom_Class_Moneda xObjMon){
            return this.getSaldo(new Dom_Class_Saldo(true, 0, xObjMon));
        }
        
        /**
         * Calcula la deuda de la persona
         * @return mDeu
         */
        public abstract float calcular_saldo();
    // </editor-fold>

        

    /**
     * Da veracidad a los datos de la persona
     * @throws InputException 
     * <UL><U>Comprueba que</U>:
         * <LI>haya ingresado una rosón social (mRasSos) →No posee una Razón Social←
         * <LI>haya ingresado un país →No a asignado un país (mObjPais)←
         * <LI>haya ingresado una provincia o departamento (mObjProvDep) →No a asignado una provincia o departamento←
         * <LI>la provincia/departamento pertenezca ingresada pertenezca al país ingresado (mObjProvDep)
         * →La provincia o departamento no pertenece al país seleccionado ←
         * <LI>el RUT ingresado posea un formato numérico (mRut) 
         * →El RUT Ingresado no posee un formato numérico←
         * <LI>el numero documento ingresado  un posea formato numérico (mNumDoc) 
         * →El numero de documento Ingresado no posee un formato numérico←
     */
    @Override
    public void validar () throws InputException {

        String Error = "";
        
        if (!setmRasSos(mRasSos)) Error += "No posee una Razón Social\n";// Valida Rason Social
        

        //Pais****
        if (mObjPais == null) throw new InputException("No a asignado un país");
        mObjPais.validar();
        // Departamento****
        if (mObjProvDep == null) throw  new InputException("No a asignado una provincia o departamento");
        mObjProvDep.validar();
        if (!mObjPais.existeProvDep(mObjProvDep)) throw  new InputException("La provincia o departamento no pertenece al país seleccionado");


        if (!Error.equals("")) throw new InputException(Error);
        int i = 1;
        // Validar que el rut sea de tipo numerico
        if(!mRut.equals("")){
            try{
                long l = Long.parseLong(mRut);
            }catch (java.lang.NumberFormatException ex){
                throw new InputException("El RUT Ingresado no posee un formato numérico");
            }
            
        }
        
        // Validar que el Num Doc sea de tipo Num
        if(!mNumDoc.equals("")){
            try{
                long l = Long.parseLong(mNumDoc);
            }catch (java.lang.NumberFormatException ex){
                throw new InputException("El numero de documento Ingresado no posee un formato numérico");
            }
        }
        

    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LogN_ClassAb_Persona other = (LogN_ClassAb_Persona) obj;
        
        
        
        if (mNum != -1 && other.getmNum() == this.getmNum()){
            return true;
        }
        
        
        
        if (this.mTipDoc != other.mTipDoc) {
            return false;
        }

        if ((this.mNumDoc == null) ? (other.mNumDoc != null) : !this.mNumDoc.equals(other.mNumDoc)) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 13 * hash + this.mTipDoc;
        hash = 13 * hash + this.mNum;
        hash = 13 * hash + (this.mNumDoc != null ? this.mNumDoc.hashCode() : 0);
        return hash;
    }
    
    


    




}


//~ Formatted by Jindent --- http://www.jindent.com
