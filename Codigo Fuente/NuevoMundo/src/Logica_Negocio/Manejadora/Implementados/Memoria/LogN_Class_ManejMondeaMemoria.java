/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora.Memoria;

import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.LogN_Class_PaisActual;
import Logica_Negocio.Manejadora.LogN_Inter_ManejMoneda;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Observer;

/**
 *
 * @author ary
 */
public class LogN_Class_ManejMondeaMemoria implements LogN_Inter_ManejMoneda{
    //Atributos_________________________________________________________________
    private ArrayList<Dom_Class_Moneda> mColMoneda = new ArrayList<Dom_Class_Moneda>();

    public LogN_Class_ManejMondeaMemoria (){
        mColMoneda.add(new Dom_Class_Moneda("Peso Uruguayo", "$", LogN_Class_PaisActual.getInstancia().getPais()));
    }

    @Override
    public ArrayList<Dom_Class_Moneda> listarMondeda() {
        return mColMoneda;
    }

    @Override
    public void altaMoneda(Dom_Class_Moneda xObjMoneda, boolean xLocal) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void bajaMoneda(Dom_Class_Moneda xObjMoneda) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void modiMoneda(Dom_Class_Moneda xObjMonedaAn, Dom_Class_Moneda xObjMonedaNu) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_Moneda getMonedaLoc() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void addObservadorMoneda(Observer xObjObser) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void removObservadorMoneda(Observer xObjObser) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Dom_Class_Moneda getMoneda(int NumM) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setMonedaLocal(Dom_Class_Moneda xObjMoneda) throws InputException {
        throw new UnsupportedOperationException("Not supported yet.");
    }



}
