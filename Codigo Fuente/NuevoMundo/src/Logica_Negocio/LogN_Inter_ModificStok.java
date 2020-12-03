/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.MiExepcion.InputException;

/**
 *
 * @author Ary
 */
public interface LogN_Inter_ModificStok {
    public Dom_Class_ProductoComp getPord();

    public void setProducto (Dom_Class_ProductoComp xObjPord);

    public void actualisarStok () throws InputException;

    /**
     * Determina si el si el modificador aumenta o disminuye  el stock
     * @return
     * ♦  true en caso que aumente el stok <hd>
     * ♦  false en caso contrario
     */
    public boolean aFab_o_Con();

    public float getCanProd();

    public void setCanPord(float xCanProd);

    public String getTipModificador();

    public int getNumModificador();

    public void setNumModificador(int xNumMod);


}
