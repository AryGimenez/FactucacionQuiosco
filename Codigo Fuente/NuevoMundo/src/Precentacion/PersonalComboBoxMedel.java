/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion;

import java.io.Serializable;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Observable;
import java.util.Observer;
import javax.swing.AbstractListModel;
import javax.swing.MutableComboBoxModel;

/**
 *
 * @author ary
 */
public class PersonalComboBoxMedel<T> extends AbstractListModel implements MutableComboBoxModel, Serializable, Observer {

    //Atributos_________________________________________________________________
    /**
     * Determina que no se va ordenar los datos
     */
    public static final short Sin_Orden = 0;

    /**
     * Orden alfabético ascendente a → z
     */
    public static final short Alfabet_Acendente = 1;
    /**
     * Orden alfabético descendente  z → a
     */
    public static final short Alfabet_Decendente = 2;

    public short OrdenActual = Sin_Orden;

    private ArrayList<T> objects;
    
    private T selectedObject;

    //Constructor_______________________________________________________________

    /**
     * Constructs an empty DefaultComboBoxModel object.
     */
    public PersonalComboBoxMedel(short Oreden, Observable ObjObsevador) {
        objects = new ArrayList<T>();
        this.setOrden(Oreden);
        this.agregarObservado(ObjObsevador);

    }

    /**
     * Constructs a DefaultComboBoxModel object initialized with
     * an array of objects.
     *
     * @param items  an array of Object objects
     */
    public PersonalComboBoxMedel( T items[], short Oreden, Observable ObjObsevador) {


        objects = new ArrayList<T>();
        objects.ensureCapacity( items.length );

        int i,c;
        for ( i=0,c=items.length;i<c;i++ )

            objects.add( ((T)items[i]) );

        this.setOrden(Oreden);
        if ( getSize() > 0 ) {
            selectedObject =  (T)getElementAt( 0 );
        }
        this.agregarObservado(ObjObsevador);

    }

    /**
     * Constructs a DefaultComboBoxModel object initialized with
     * a vector.
     *
     * @param v  a Vector object ...
     */
    public PersonalComboBoxMedel(AbstractCollection<T> v, short Oreden, Observable ObjObsevador) {

        objects = new ArrayList<T>(v);
        this.setOrden(Oreden);
        if ( getSize() > 0 ) {
            selectedObject = (T) getElementAt( 0 );
        }
        if (ObjObsevador == null) return;
        this.agregarObservado(ObjObsevador);
    }

    //Metodos___________________________________________________________________

    private void agregarObservado (Observable xObjObservado){
        if (xObjObservado == null) return;
        xObjObservado.addObserver(this);
    }

    // implements javax.swing.ComboBoxModel
    /**
     * Set the value of the selected item. The selected item may be null.
     * <p>
     * @param anObject The combo box value or null for no selection.
     */
    public void setSelectedItem(Object anObject) {
        if ((selectedObject != null && !selectedObject.equals( anObject )) ||
	    selectedObject == null && anObject != null) {
	    selectedObject = (T)anObject;
	    fireContentsChanged(this, -1, -1);
        }
    }

    
    // implements javax.swing.ComboBoxModel
    public Object getSelectedItem() {
        return selectedObject;
    }

    // implements javax.swing.ListModel
    @Override
    public int getSize() {
        return objects.size();
    }

    // implements javax.swing.ListModel
    @Override
    public Object getElementAt(int index) {
        if ( index >= 0 && index < objects.size() )
            return objects.get(index);
        else
            return null;
    }
    
    public Object getElementAt (Object anObject){
            
        for (Object ObjCom : objects){
            if (ObjCom.equals(anObject)) return ObjCom;
        }
        
        return null;
    
    }

    /**
     * Returns the index-position of the specified object in the list.
     *
     * @param anObject
     * @return an int representing the index position, where 0 is
     *         the first position
     */
    public int getIndexOf(Object anObject) {
        return objects.indexOf(anObject);
    }

    // implements javax.swing.MutableComboBoxModel
    public void addElement(Object anObject) {
        if (getSize() == 0  || OrdenActual == Sin_Orden) {
            objects.add((T)anObject);
            int Valor = objects.size()-1;
            fireIntervalAdded(this,objects.size()-1, objects.size()-1);
        } else {
            this.addAlabeticamente((T)anObject);

        }
       

        if ( objects.size() == 1 && selectedObject == null && anObject != null ) {
            setSelectedItem( anObject );
        }
    }

    // implements javax.swing.MutableComboBoxModel
    @Override
    public void insertElementAt(Object anObject,int index) {
        objects.add(index, (T) anObject);
        fireIntervalAdded(this, index, index);
    }

    // implements javax.swing.MutableComboBoxModel
    public void removeElementAt(int index) {
        if ( getElementAt( index ) == selectedObject ) {
            if ( index == 0 ) {
                setSelectedItem( getSize() == 1 ? null : getElementAt( index + 1 ) );
            }
            else {
                setSelectedItem( getElementAt( index - 1 ) );
            }
        }

        objects.remove(index);

        fireIntervalRemoved(this, index, index);
    }

    // implements javax.swing.MutableComboBoxModel
    @Override
    public void removeElement(Object anObject) {
        int index = objects.indexOf(anObject);
        if ( index != -1 ) {
            removeElementAt(index);
        }
    }

    /**
     * Empties the list.
     */
    public void removeAllElements() {
        if ( objects.size() > 0 ) {
            int firstIndex = 0;
            int lastIndex = objects.size() - 1;
            objects.clear();
	    selectedObject = null;
            fireIntervalRemoved(this, firstIndex, lastIndex);
        } else {
	    selectedObject = null;
	}
    }

    private void setOrden(short Oreden) {
        if (Oreden < (short)0 || Oreden > 2) return;
        this.OrdenActual = Oreden;
        this.ordenar();
        
    }

    public short getOrdenar(){
        return OrdenActual;
    }

    public void ordenar (){
        if (getSize() == 0) return;
        switch (OrdenActual){
            case Alfabet_Acendente:
               Collections.sort(objects,new CompararStringAcendente());
            break;
            case Alfabet_Decendente:
                Collections.sort(objects, new CompararStringDesendente());
            break;
            default: return;

        }

        fireContentsChanged(this, 0, getSize() - 1);

    }

    private void addAlabeticamente (T O){
         
         CompararString ObjCom = null;

         if (Alfabet_Acendente == OrdenActual){
             ObjCom = new CompararStringAcendente();
         }else if (Alfabet_Decendente == OrdenActual){
             ObjCom = new CompararStringDesendente();
         } else {
             return;
         }
         int CanEl = getSize();
         for (int Con = 0; Con < CanEl; Con ++ ){
             
             int res = ObjCom.compare(O, getElementAt(Con));

            if (res >= 0){
              insertElementAt(O, Con);
              return;
            }
        }
         if (CanEl == getSize()){
             insertElementAt(O, CanEl);
         }
    }

    public void update(Observable o, Object arg) {
        
        LogN_Class_Accion <T> xObjAccion = (LogN_Class_Accion<T>) arg;
        if (xObjAccion == null) return;
        
        switch (xObjAccion.mAccionActual){
            
            case LogN_Class_Accion.Agreger:
                addElement(xObjAccion.getmAccionar());
            break;

            case LogN_Class_Accion.Eliminar:
                removeElement(xObjAccion.getmAccionar());
            break;

            case LogN_Class_Accion.Modificar:
                if (xObjAccion instanceof LogN_Class_AccionTostring){
                    removeElement(xObjAccion.getmAccionar());
                    addElement(xObjAccion.getmAccionar());
                }

            break;
        }
    }

}
