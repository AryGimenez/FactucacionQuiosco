/*
 * .
 */
package Logica_Negocio;
/**
 * Representa a los documetos contables
 */
import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import java.util.Date;

/**
 *
 * @author horacio
 */
public interface LogN_Inter_DocCon {
    
    public Date getFech ();
    
    public String getTipoDoc ();
    
    public String getCodDoc();
    
    public float getMonto();
    
    public Dom_Class_Moneda getMoneda();
    
    public LogN_ClassAb_Persona getPersona();
    

    /**
    * Retorna el IVA del documento
    */
    public Dom_Class_IVA getIVA();
    
}
