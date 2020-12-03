/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * FrmDi_CreaPorNom.java
 *
 * Created on 21/04/2011, 11:18:26 AM
 */

package Precentacion;

import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import javax.swing.JOptionPane;


/**
 *
 * @author horacio
 */
public abstract class FrmDi_CreaPorNom extends javax.swing.JDialog {
    /** A return status code - returned if Cancel button has been pressed */
    public static final int RET_CANCEL = 0;
    /** A return status code - returned if OK button has been pressed */
    public static final int RET_OK = 1;
    
    private int returnStatus = RET_CANCEL;
    
    private PersonalComboBoxMedel<LogN_ClassAb_CrePorNom> mObjComBModel;
    private ArrayList <LogN_Class_Accion> mColAcciones = new ArrayList<LogN_Class_Accion>();
    private LogN_ClassAb_CrePorNom mObjCrePorNSel;
    private ArrayList <LogN_ClassAb_CrePorNom> mColCrePorNoms = new ArrayList<LogN_ClassAb_CrePorNom>();
    private String mTitulo;



    /** Creates new form FrmDi_CreaPorNom */
    public FrmDi_CreaPorNom(java.awt.Window parent, String Tipod, ArrayList<LogN_ClassAb_CrePorNom> xColCreXNom) {
         super(parent,java.awt.Dialog.ModalityType.APPLICATION_MODAL); //Yama al contsructor de el dealog para bloquear los formularios ijos
         
         initComponents();
         cargarAllCrepor(xColCreXNom);

         this.CargarTitulo(Tipod);
         
         focusInicial();

    }




    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        Pan_Prin = new javax.swing.JPanel();
        jPanel7 = new javax.swing.JPanel();
        Btn_Agregar = new javax.swing.JButton();
        Btn_Borrar = new javax.swing.JButton();
        Pan_Modificar = new javax.swing.JPanel();
        Btn_Modificar = new javax.swing.JButton();
        TxtF_Modificar = new Utilidades.JFormattedText();
        Lbl_Modificar = new javax.swing.JLabel();
        Btn_Aceptar = new javax.swing.JButton();
        Btn_Cancelar = new javax.swing.JButton();
        Lbl_Titulo = new javax.swing.JLabel();
        ComB_CreaPorNom = new javax.swing.JComboBox();

        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                closeDialog(evt);
            }
        });

        jPanel7.setBackground(new java.awt.Color(207, 228, 228));
        jPanel7.setForeground(java.awt.Color.white);

        Btn_Agregar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Crystal_Clear_action_db_add.png"))); // NOI18N
        Btn_Agregar.setNextFocusableComponent(Btn_Borrar);
        Btn_Agregar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_AgregarActionPerformed(evt);
            }
        });

        Btn_Borrar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Crystal_Clear_action_db_remove.png"))); // NOI18N
        Btn_Borrar.setNextFocusableComponent(Btn_Cancelar);
        Btn_Borrar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_BorrarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(Btn_Agregar, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(Btn_Borrar, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(Btn_Agregar, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(Btn_Borrar, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        Pan_Modificar.setBorder(javax.swing.BorderFactory.createEtchedBorder());
        Pan_Modificar.setForeground(java.awt.Color.white);

        Btn_Modificar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/addedit.png"))); // NOI18N
        Btn_Modificar.setEnabled(false);
        Btn_Modificar.setNextFocusableComponent(Btn_Agregar);
        Btn_Modificar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_ModificarActionPerformed(evt);
            }
        });

        TxtF_Modificar.setNextFocusableComponent(Btn_Agregar);
        TxtF_Modificar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                TxtF_ModificarActionPerformed(evt);
            }
        });
        TxtF_Modificar.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                TxtF_ModificarFocusGained(evt);
            }
        });

        Lbl_Modificar.setBackground(new java.awt.Color(13, 151, 239));
        Lbl_Modificar.setFont(new java.awt.Font("DejaVu Sans", 1, 13));
        Lbl_Modificar.setForeground(new java.awt.Color(254, 254, 254));
        Lbl_Modificar.setText("Modificar");
        Lbl_Modificar.setOpaque(true);

        javax.swing.GroupLayout Pan_ModificarLayout = new javax.swing.GroupLayout(Pan_Modificar);
        Pan_Modificar.setLayout(Pan_ModificarLayout);
        Pan_ModificarLayout.setHorizontalGroup(
            Pan_ModificarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(Pan_ModificarLayout.createSequentialGroup()
                .addGroup(Pan_ModificarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(TxtF_Modificar, javax.swing.GroupLayout.DEFAULT_SIZE, 181, Short.MAX_VALUE)
                    .addComponent(Lbl_Modificar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 181, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(Btn_Modificar, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE))
        );
        Pan_ModificarLayout.setVerticalGroup(
            Pan_ModificarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(Btn_Modificar, javax.swing.GroupLayout.DEFAULT_SIZE, 51, Short.MAX_VALUE)
            .addGroup(Pan_ModificarLayout.createSequentialGroup()
                .addComponent(Lbl_Modificar)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(TxtF_Modificar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        Btn_Aceptar.setFont(new java.awt.Font("DejaVu Sans", 1, 13));
        Btn_Aceptar.setForeground(java.awt.Color.white);
        Btn_Aceptar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Yes v3.png"))); // NOI18N
        Btn_Aceptar.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.LOWERED, java.awt.Color.white, java.awt.Color.gray, null, java.awt.Color.gray));
        Btn_Aceptar.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        Btn_Aceptar.setNextFocusableComponent(ComB_CreaPorNom);
        Btn_Aceptar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_AceptarActionPerformed(evt);
            }
        });

        Btn_Cancelar.setFont(new java.awt.Font("Arial Black", 1, 13));
        Btn_Cancelar.setForeground(java.awt.Color.white);
        Btn_Cancelar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/cancel_f2.png"))); // NOI18N
        Btn_Cancelar.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.LOWERED, java.awt.Color.white, java.awt.Color.gray, null, java.awt.Color.gray));
        Btn_Cancelar.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        Btn_Cancelar.setNextFocusableComponent(Btn_Aceptar);
        Btn_Cancelar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_CancelarActionPerformed(evt);
            }
        });

        Lbl_Titulo.setBackground(new java.awt.Color(13, 151, 239));
        Lbl_Titulo.setFont(new java.awt.Font("DejaVu Sans", 1, 13));
        Lbl_Titulo.setForeground(java.awt.Color.white);
        Lbl_Titulo.setText("Codigo");
        Lbl_Titulo.setOpaque(true);

        ComB_CreaPorNom.setNextFocusableComponent(TxtF_Modificar);
        ComB_CreaPorNom.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ComB_CreaPorNomActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout Pan_PrinLayout = new javax.swing.GroupLayout(Pan_Prin);
        Pan_Prin.setLayout(Pan_PrinLayout);
        Pan_PrinLayout.setHorizontalGroup(
            Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(Pan_PrinLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(Pan_PrinLayout.createSequentialGroup()
                        .addGroup(Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(Pan_Modificar, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(Lbl_Titulo, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 232, Short.MAX_VALUE)
                            .addComponent(ComB_CreaPorNom, javax.swing.GroupLayout.Alignment.LEADING, 0, 232, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, Pan_PrinLayout.createSequentialGroup()
                        .addComponent(Btn_Cancelar, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 118, Short.MAX_VALUE)
                        .addComponent(Btn_Aceptar, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(89, 89, 89))))
        );
        Pan_PrinLayout.setVerticalGroup(
            Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, Pan_PrinLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(Pan_PrinLayout.createSequentialGroup()
                        .addComponent(Lbl_Titulo)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(ComB_CreaPorNom, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(Pan_Modificar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(Pan_PrinLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(Btn_Aceptar)
                    .addComponent(Btn_Cancelar))
                .addGap(57, 57, 57))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(Pan_Prin, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(Pan_Prin, javax.swing.GroupLayout.PREFERRED_SIZE, 177, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /** Closes the dialog */
    private void closeDialog(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_closeDialog
        doClose(RET_CANCEL);
    }//GEN-LAST:event_closeDialog

    private void Btn_AceptarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_AceptarActionPerformed
        doClose(FrmDi_ConLinFactura.RET_OK);
}//GEN-LAST:event_Btn_AceptarActionPerformed

    private void Btn_CancelarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_CancelarActionPerformed
        // TODO add your handling code here:
        this.doClose(FrmDi_ConLinFactura.RET_CANCEL);
}//GEN-LAST:event_Btn_CancelarActionPerformed

    private void TxtF_ModificarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_TxtF_ModificarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_TxtF_ModificarActionPerformed

    private void Btn_AgregarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_AgregarActionPerformed
        // TODO add your handling code here:
        altaCreProNom();

    }//GEN-LAST:event_Btn_AgregarActionPerformed

    private void Btn_BorrarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_BorrarActionPerformed
        // TODO add your handling code here:
        this.elminiarCrePorNom();
        
}//GEN-LAST:event_Btn_BorrarActionPerformed

    private void Btn_ModificarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_ModificarActionPerformed
        // TODO add your handling code here:
        this.modificarCrePorNom();
    }//GEN-LAST:event_Btn_ModificarActionPerformed

    private void ComB_CreaPorNomActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ComB_CreaPorNomActionPerformed
        // TODO add your handling code here:
        this.cargarCrePorNomSel();

    }//GEN-LAST:event_ComB_CreaPorNomActionPerformed

    private void TxtF_ModificarFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_TxtF_ModificarFocusGained
        // TODO add your handling code here:
    }//GEN-LAST:event_TxtF_ModificarFocusGained

    private void doClose(int retStatus) {
        returnStatus = retStatus;
        setVisible(false);
        dispose();
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    protected javax.swing.JButton Btn_Aceptar;
    private javax.swing.JButton Btn_Agregar;
    private javax.swing.JButton Btn_Borrar;
    protected javax.swing.JButton Btn_Cancelar;
    private javax.swing.JButton Btn_Modificar;
    protected javax.swing.JComboBox ComB_CreaPorNom;
    private javax.swing.JLabel Lbl_Modificar;
    protected javax.swing.JLabel Lbl_Titulo;
    protected javax.swing.JPanel Pan_Modificar;
    protected javax.swing.JPanel Pan_Prin;
    protected javax.swing.JFormattedTextField TxtF_Modificar;
    protected javax.swing.JPanel jPanel7;
    // End of variables declaration//GEN-END:variables


    /** @return the return status of this dialog - one of RET_OK or RET_CANCEL */
    public int getReturnStatus() {
        return returnStatus;
    }
    
    
    private void CargarTitulo (String xTitel){
        this.mTitulo = xTitel;
        Lbl_Titulo.setText(xTitel);
        this.setTitle("Modificador " + xTitel);
        
    }

    private void cargarAllCrepor(ArrayList <LogN_ClassAb_CrePorNom> xColCreXNom){

        for (LogN_ClassAb_CrePorNom ObjCrexNom: xColCreXNom){
           mColCrePorNoms.add(ObjCrexNom.duplicar());
        }
        
        mObjComBModel = new PersonalComboBoxMedel<LogN_ClassAb_CrePorNom>
                 (mColCrePorNoms, PersonalComboBoxMedel.Alfabet_Acendente, null);

        if(xColCreXNom.size() > 0){
            mObjCrePorNSel = xColCreXNom.get(0);
            cargarCrePorNomSel();
        }

        ComB_CreaPorNom.setModel(mObjComBModel);

    }

    private void cargarCrePorNomSel (){
        
        mObjCrePorNSel = (LogN_ClassAb_CrePorNom) mObjComBModel.getSelectedItem();
        if(mObjCrePorNSel == null) return;
        TxtF_Modificar.setText(mObjCrePorNSel.getNom());
        Btn_Modificar.setEnabled(true);
        TxtF_Modificar.setNextFocusableComponent(Btn_Modificar);
    }

    private void altaCreProNom (){


        LogN_ClassAb_CrePorNom ObjCrePorNom = null;
        try {
            ObjCrePorNom = crearCrePorNom();
        } catch (InputException ex) {
            JOptionPane.showMessageDialog(this, ex.getLocalizedMessage());
            TxtF_Modificar.requestFocus();
            return;
        }

        if (mColCrePorNoms.contains(ObjCrePorNom)) JOptionPane.showMessageDialog(this, "El "+ mTitulo+ " a agregar ya existe");
        else {
            LogN_Class_Accion ObjAccion = new LogN_Class_Accion<LogN_ClassAb_CrePorNom> (LogN_Class_Accion.Agreger, ObjCrePorNom);
            int Pos = this.posAccion(ObjAccion);
            if (Pos != -1){
                ObjCrePorNom = (LogN_ClassAb_CrePorNom) mColAcciones.get(Pos).getmAccionar();
            } else {
                mColAcciones.add(ObjAccion);
            }

            mColCrePorNoms.add(ObjCrePorNom);
            mObjComBModel.addElement(ObjCrePorNom);
            mObjComBModel.setSelectedItem(ObjCrePorNom);
            ComB_CreaPorNom.requestFocus();
            
        }

    }
    
    protected abstract LogN_ClassAb_CrePorNom crearCrePorNom()throws InputException;
    


    private void modificarCrePorNom (){
        int Pos = this.posAccion(mObjCrePorNSel);

        String NomMod = mObjCrePorNSel.getNom();
        mObjCrePorNSel.setNom(TxtF_Modificar.getText());
        try {
            mObjCrePorNSel.validar();
        } catch (InputException ex) {
            JOptionPane.showMessageDialog(this, ex.getLocalizedMessage());
            mObjCrePorNSel.setNom(NomMod);
            return;
        }

        if (Pos == -1 ) {

            mColAcciones.add(
                    new LogN_Class_Accion<LogN_ClassAb_CrePorNom>
                    (LogN_Class_Accion.Modificar,mObjCrePorNSel));
        }
        
        mObjComBModel.setSelectedItem(mObjCrePorNSel);
    }

    private void elminiarCrePorNom(){
        LogN_ClassAb_CrePorNom ObjCrePorN = mObjCrePorNSel;
        if(ObjCrePorN == null){
            JOptionPane.showMessageDialog(this, "Debe seleccionar una "+ mTitulo +" a para dar de baja ");
            return;
        }
        int Pos = this.posAccion(ObjCrePorN);

        mColCrePorNoms.remove(ObjCrePorN);
        mObjComBModel.removeElement(ObjCrePorN);
        if(Pos != -1) mColAcciones.remove(Pos);

        mColAcciones.add(new LogN_Class_Accion<LogN_ClassAb_CrePorNom> (LogN_Class_Accion.Eliminar,ObjCrePorN ));
    }

    private  int posAccion (Object xObjAccion){

        int Size = mColAcciones.size();
        if (Size == -1) return -1;
        
        for (int i = 0 ; Size  > i ; ++i){
            if(mColAcciones.get(i).equals(xObjAccion)) return i;
            
        }
        return -1;

    }

    public ArrayList<LogN_Class_Accion> getAccion (){
        return mColAcciones;
    }
    
    private void focusInicial (){
        if(mColCrePorNoms.size() > 0) ComB_CreaPorNom.requestFocus();
        else TxtF_Modificar.requestFocus();
    }



}
