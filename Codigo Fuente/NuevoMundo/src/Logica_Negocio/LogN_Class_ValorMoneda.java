package Logica_Negocio;

//


import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.MiExepcion.InputException;

//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : Untitled
//  @ File Name : LogN_Class_ValorMoneda.java
//  @ Date : 06/05/2010
//
//




/**
 * Clase contenedora de los monto con respecto a la m//  @ Author : oneda (Cantidad de pesos, d�lares, etc)
 * @uml.dependency   supplier="Logica_Negocio.Dominio.Dom_Class_Moneda"
 */
public class LogN_Class_ValorMoneda  implements LogN_Inter_Validar, LogN_Inter_Duplicado<LogN_Class_ValorMoneda> {
    /**
     * Monto el valor de la mondea
     */
    public float mMonto;
    /**
     * Moneda relacionada con este Valor
     */
    private Dom_Class_Moneda mObjMon;
    
    
    // Constructor______________________________________________________________
    
    public LogN_Class_ValorMoneda (LogN_Class_ValorMoneda xObjValM){
        this(xObjValM.mMonto, xObjValM.mObjMon);
    }

    /**
     * Constructor completo a la cual se le pasan todos los valores comprendidos
     * del valor de la moneda
     * @param mMonto  Monto el valor de la mondea
     * @param mObjMon Moneda relacionada con este Valor
     */
    public LogN_Class_ValorMoneda(float mMonto, Dom_Class_Moneda mObjMon) {
        this.mMonto = mMonto;
        this.mObjMon = mObjMon;
    }

    /**
     * Constructor en el cual se le pasa el valor de la moneda y se le asigna
     * automáticamente la moneda local del sistema
     * @param mMonto Monto el valor de la mondea
     */
    public LogN_Class_ValorMoneda (float mMonto){
        this(mMonto, LogN_Class_Fachada.getInstancia().getMonedaLoc());
    }


    /**
     * Retorna la moneda actual
     * @return Moneda del actual
     */
    public Dom_Class_Moneda getObjMon (){
        return mObjMon;
    }
    /**
     * Remplaza l mondea existente por la pasada por paraemtro
     * @param mObjMon Moneda con la cual se va a remplazar
     * @return Retorna false si la moneda pasada por parámetro contiene un
     * valor nulo o esta es la misma que la actual.
     */
    public boolean setObjMon(Dom_Class_Moneda mObjMon) {
        // Pregunta si la moneda contiene un valor nulo o la moneda pasada por 
        // parámetro es igual a la ya existente
        if (mObjMon == null || mObjMon.equals(this.mObjMon))return false;
        this.mObjMon = mObjMon;
        return true;
    }

    /**
     * Calculo y retorno el monto según el cambio de la moneda actual a la pasada por parámetro
     *
     * @param    xObjMon  Moneda por la cual se ba a efectuar el cambio
     *
     * return   Monto resultante de la operaci�n
    **/
    public float getCompra(Dom_Class_Moneda xObjMon) {
        return this.getCambio(this.mObjMon.getObjCoti().getCompra(), xObjMon.getObjCoti().getCompra());
    }
    /**
     *Multiplica el valor de la moneda por el valor multiplicador y lo divide por el valor divisor.
     * @param ValorMult Valor multiplicador
     * @param ValorDiv Valor divisor
     * @return  Retorna el resultado de la operación descrita
     */
    private float getCambio (float ValorMult, float ValorDiv){
        float ValTem = ValorDiv;
        if (ValTem == 0) ValTem = 0; //Comprueba que el valor no sea 0 para evitar error en la división
        return this.mMonto * ValorMult / ValTem;
    }
    
    /**
     * Calculo y retorno el monto según el cambio de la moneda actual a la pasada por parámetro
     *
     * @param    xObjMon  Moneda por la cual se ba a efectuar el cambio
     *
     * return   Monto resultante de la operaci�n
    **/
    public float getVenta(Dom_Class_Moneda xObjMon) {
        return this.getCambio(this.mObjMon.getObjCoti().getVenta(), xObjMon.getObjCoti().getVenta());
    }

    /**
     * Retorna el monto del valor de la moneda
    **/
    public float getMonto() {
        return mMonto;
    }

    /**
     * Remplaza el valor de la moneda
     * @param mMonto Valor por el cual se remplaza
     * @return Retorna true si el valor pasado por parámetro no es un valor
     * negativo false en caso contrario
     */
    public boolean setMonto(float mMonto) {
        if (mMonto  < 0) return false;
        this.mMonto = mMonto;
        return true;

    }

    @Override
    public void validar() throws InputException {
        if (mMonto < 0 ) throw new InputException("El Monto ingresado es menor a 0");
        
        if (mObjMon == null) throw new InputException("No ha ingresado una moneda");
        
        mObjMon.validar();
    }

    @Override
    public LogN_Class_ValorMoneda duplicar() {
        return new LogN_Class_ValorMoneda (this);
    }

    @Override
    public boolean duplicado(LogN_Class_ValorMoneda xObjCop) {
        if (!mObjMon.equals(xObjCop.mObjMon)) return false;
        if(mMonto != mMonto) return false;
        return true;
    }

    @Override
    public String toString() {
        return   mObjMon.getSim() + " " + mMonto;
    }
    
    
}
