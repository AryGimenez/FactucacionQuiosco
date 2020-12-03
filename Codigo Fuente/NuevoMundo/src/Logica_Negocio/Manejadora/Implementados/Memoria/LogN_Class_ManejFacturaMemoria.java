/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Memoria;

import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacCom;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Logica_Negocio.Manejadora.LogN_Inter_ManejFactura;
import Logica_Negocio.MiExepcion.InputException;
import Utilidades.Util_Class_CompararFecha;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observable;
import java.util.Observer;

/**
 *
 * @author Ary
 */
public class LogN_Class_ManejFacturaMemoria extends Observable implements LogN_Inter_ManejFactura  {

    //Atributos_________________________________________________________________
    private ArrayList<Dom_Class_FacVen> mColFacVen = new ArrayList<Dom_Class_FacVen>();
    private int NumDeFac = 1;
    //Operaciones_______________________________________________________________
    @Override
    public void altaFacVen(Dom_Class_FacVen xObjFacVen, boolean xPresupuesto) throws InputException {
        xObjFacVen.validar();
        if (mColFacVen.contains(xObjFacVen))throw new InputException("La factura ya existe");
        xObjFacVen.actualizarStock();
        mColFacVen.add(xObjFacVen);
        NumDeFac++;
    }

//    @Override
//    public Dom_Class_FacVen getFacVen(Dom_Class_FacVen xObjFacVen) {
//        int Pos = mColFacVen.indexOf(xObjFacVen);
//        if (Pos == -1) return null;
//        return mColFacVen.get(Pos);
//    }
//
//    @Override
//    public ArrayList<Dom_Class_FacVen> listarFactura() {
//        return new ArrayList<Dom_Class_FacVen>(mColFacVen);
//    }
//
//    @Override
//    public ArrayList<Dom_Class_FacVen> listarFactura(Date FechIn, Date FechFin) {
//        // da vuelta la fecha Haciendo q se oredenen de menor a mayor las fechas ingresadas
//
//        Util_Class_CompararFecha ObjComF = new Util_Class_CompararFecha();
//
//        if (ObjComF.compare(FechIn, FechFin) > 0 ){
//            Date FechT = FechIn; //Se carga la fecha temoral para no perder losd atos
//            FechIn = FechFin;
//            FechFin = FechT;
//        }
//
//        ArrayList <Dom_Class_FacVen> ColFactura =
//                new ArrayList<Dom_Class_FacVen>();
//
//
//
//        for (Dom_Class_FacVen ObjFacV: mColFacVen){
//
//            if (ObjComF.compare(FechIn, ObjFacV.getFech()) <=0
//                    &&
//                    ObjComF.compare(FechFin, ObjFacV.getFech()) >= 0){
//
//                ColFactura.add(ObjFacV);
//            }//Fin if
//
//        }//Fin For
//        return ColFactura;
//    }
//
//
//    @Override
//    public Dom_Class_FacVen NuevaFach() {
//        return new Dom_Class_FacVen(NumDeFac);
//    }

    @Override
    public void addObservadorFactura(Observer xObjObser) {
        super.addObserver(xObjObser);
    }

    @Override
    public void removObservadorFactura(Observer xObjObser) {
        super.deleteObserver(xObjObser);
    }

    @Override
    public void altaFactura(LogN_ClassAb_Factura xObjFactura, boolean xPresupuesto) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void altaFacCom(Dom_Class_FacCom xObjFacCom) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_FacVen getFacVen(int NumFac, char Car) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_FacCom getFacCom(int NumFac, char Car) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> listarFactura() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<LogN_ClassAb_Factura> listarFactura(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<Dom_Class_FacVen> listarFacturaVen(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<Dom_Class_FacCom> listarFacturaCom(Date FechIn, Date FechFin) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_FacVen NuevaFachVen() {
        return null;
    }

    @Override
    public LogN_ClassAb_ModeljTabFactura getModelLf(boolean xTipoF) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
