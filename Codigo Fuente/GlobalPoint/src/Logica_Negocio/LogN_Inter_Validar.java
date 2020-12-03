package Logica_Negocio;

import Logica_Negocio.MiExepcion.InputException;




/**
 * Interface LogN_Class_Validar
 * Interfase compungir para los datos que requieran una validación de sus datos.
 */
public interface LogN_Inter_Validar {
    /**
     * Error de datos
     * @throws InputException
     */
  public void validar(  ) throws InputException;


}
