package Logica_Negocio.MiExepcion;


/**
 * Class InputException
 */
@SuppressWarnings("serial")
public class InputException extends Exception {

  //
  // Fields
  //

  
  //
  // Constructors
  //
  public InputException () {
      super();
  }
  
  //
  // Methods
  //


  //
  // Accessor methods
  //

  //
  // Other methods
  //

  /**
   * @param        message
   */
  public InputException( String message ){
      super(message);
  }


}
