/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Model.jList;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.LogN_ClassAb_Movimiento;
import Precentacion.LogN_Class_Accion;
import java.util.AbstractCollection;
import java.util.Observable;

/**
 *
 * @author ary
 */
public class PersonalListModelProd extends PersonalListModel<Dom_Class_ProductoComp>{


    public PersonalListModelProd(AbstractCollection<Dom_Class_ProductoComp> v, short Oreden, Observable ObjObsevador) {
        super(v, Oreden, ObjObsevador);
    }

    public PersonalListModelProd(Dom_Class_ProductoComp[] items, short Oreden, Observable ObjObsevador) {
        super(items, Oreden, ObjObsevador);
    }

    public PersonalListModelProd(short Oreden, Observable ObjObsevador) {
        super(Oreden, ObjObsevador);
    }


    @Override
    public void addElement(Object anObject) {
        Dom_Class_ProductoComp ObjProd = (Dom_Class_ProductoComp) anObject;
        if (!ObjProd.getStokMimimo()) return; //si no es stok minimo
        super.addElement(anObject);
    }



    @Override
    public void update(Observable o, Object arg) {


        if (arg == null) return;

        LogN_Class_Accion xObjAccion = (LogN_Class_Accion) arg;
        
        if (xObjAccion.getmAccionar() instanceof Dom_Class_ProductoComp){
            
            switch (xObjAccion.mAccionActual){

            case LogN_Class_Accion.Agreger:
                addElement(xObjAccion.getmAccionar());
            break;

            case LogN_Class_Accion.Eliminar:
                removeElement(xObjAccion.getmAccionar());
            break;

            case LogN_Class_Accion.Modificar:

                    removeElement(xObjAccion.getmAccionar());
                    addElement(xObjAccion.getmAccionar());


            break;
        }
        }else if( xObjAccion.getmAccionar() instanceof LogN_ClassAb_Movimiento){
            Dom_Class_ProductoComp ObjProC = ((LogN_ClassAb_Movimiento)xObjAccion.getmAccionar()).getPord();
            int Pocicion = super.objects.indexOf(ObjProC);
            if(Pocicion >= 0){
                
                if (ObjProC.getStokMimimo()){
                    removeElement(ObjProC);
                    addElement(ObjProC);
                }
                else {
                    removeElement(ObjProC);
                }
            }else {
                addElement(ObjProC);
            }
        }

        
    }




}
