/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Precentacion.Persona;

import Logica_Negocio.Filtros.Persona.LogN_Inter_FiltPersona;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabPer;
import java.awt.Window;

/**
 *
 * @author ary
 */
public class FrmIn_ListarCliente extends FrmIn_ListarPersona{
    

    public FrmIn_ListarCliente(Window mWindow) {
        super(mWindow);
        this.setTitle("Listar Cliente");
        
    }

    @Override
    protected LogN_ClassAb_ModeljTabPer crearModjTabPer(LogN_Inter_FiltPersona xObFil) {
        return mObjFachada.getModJtabClienteMysql();
    }


    
}
