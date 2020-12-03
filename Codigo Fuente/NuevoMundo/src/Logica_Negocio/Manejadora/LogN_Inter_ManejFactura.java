/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacCom;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observer;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_ManejFactura {

    public void altaFacVen(Dom_Class_FacVen xObjFacVen, boolean xPresupuesto)throws InputException;

    public void altaFactura(LogN_ClassAb_Factura xObjFactura, boolean xPresupuesto)throws InputException;

    public void altaFacCom (Dom_Class_FacCom xObjFacCom) throws InputException;

    public Dom_Class_FacVen getFacVen (int NumFac, char Car);

    public Dom_Class_FacCom getFacCom (int NumFac, char Car);

    public ArrayList<LogN_ClassAb_Factura> listarFactura ();

    public ArrayList<LogN_ClassAb_Factura> listarFactura (Date FechIn, Date FechFin);

    public ArrayList<Dom_Class_FacVen> listarFacturaVen (Date FechIn, Date FechFin);
    
    public ArrayList<Dom_Class_FacCom> listarFacturaCom (Date FechIn, Date FechFin);
    
    public Dom_Class_FacVen NuevaFachVen ();

    public void addObservadorFactura(Observer xObjObser);
    
    public void removObservadorFactura(Observer xObjObser);
    
    public LogN_ClassAb_ModeljTabFactura getModelLf(boolean xTipoF);
    
}
