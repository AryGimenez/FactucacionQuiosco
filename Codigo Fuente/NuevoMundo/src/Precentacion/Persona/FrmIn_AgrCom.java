/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Precentacion.Persona;

import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Class_Fachada;
import java.awt.Window;

/**
 *
 * @author horacio
 */
public class FrmIn_AgrCom extends FrmIn_AgrPer{

    public FrmIn_AgrCom(Window mFrmCon) {
        super(mFrmCon);
        this.setTitle("Agregar Cliente");
    }


    @Override
    protected LogN_ClassAb_Persona getPersona() {
        String RasSos, Loc, Dir, Rut, NumDoc;
        int ConIva, TipDoc;
        
        RasSos = Txt_RazonSocial.getText();
        Loc = Txt_Localidad.getText();
        Dir = Txt_Dirreccion.getText();
        Rut = TxtF_Rut.getText();
        NumDoc = TxtF_NumDocumento.getText();
        
       ConIva = ComB_CondIva.getSelectedIndex();
       TipDoc = ComB_TipoDocumento.getSelectedIndex();
       
       
       return new Dom_Class_Cliente(Dir,Loc,NumDoc,TipDoc,Rut,mObjPaisSel,mObjProvDepSel,"",RasSos,ComB_CondIva.getSelectedIndex() + 1, super.getFechP());
       
    }

    @Override
    protected int getNumPer() {
        return LogN_Class_Fachada.getInstancia().getNumCli();
    }
    



}
