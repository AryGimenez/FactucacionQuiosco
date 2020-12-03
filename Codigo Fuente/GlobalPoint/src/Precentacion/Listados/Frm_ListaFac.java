/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * Frm_ListaFac.java
 *
 * Created on 30/12/2010, 12:32:35 AM
 */

package Precentacion.Listados;


import Logica_Negocio.Filtros.Factura.LogN_Class_FilFacturaFecha;
import Logica_Negocio.Filtros.Factura.LogN_Inter_FiltFactura;
import Logica_Negocio.LogN_Class_Fachada;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Reportes.Rep_Class_IniciarReporte;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import net.sf.jasperreports.engine.JRException;



/**
 *
 * @author ary
 */
public class Frm_ListaFac extends javax.swing.JFrame {
    private NumberFormat nf = new DecimalFormat("#,##0.00");
    private LogN_Class_Fachada mObjFachada = LogN_Class_Fachada.getInstancia();
    private LogN_ClassAb_ModeljTabFactura mObjModFac ;
    private ArrayList mColFac;
    /** Creates new form Frm_ListaFac */
    public Frm_ListaFac() {
        this.listar();
        initComponents();
        this.CargarTotales();
        
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        Tab_Factura = new javax.swing.JTable();
        jPanel1 = new javax.swing.JPanel();
        Btn_Listar = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        Dat_Desde = new com.toedter.calendar.JDateChooser();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        Dat_Asta = new com.toedter.calendar.JDateChooser();
        Che_Todo = new javax.swing.JCheckBox();
        jLabel6 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        Lbl_SubTotal = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        Lbl_IVATb = new javax.swing.JLabel();
        Lbl_Total = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        Lbl_IVATm = new javax.swing.JLabel();
        Lbl_Des = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        Btn_Imprimir = new javax.swing.JButton();
        Btn_Salir = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Listar Factura");

        Tab_Factura.setModel(mObjModFac);
        jScrollPane1.setViewportView(Tab_Factura);

        jPanel1.setBackground(new java.awt.Color(207, 228, 228));

        Btn_Listar.setFont(new java.awt.Font("Tahoma", 1, 11)); // NOI18N
        Btn_Listar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Cargar.png"))); // NOI18N
        Btn_Listar.setText("Listar");
        Btn_Listar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_ListarActionPerformed(evt);
            }
        });

        jLabel7.setBackground(new java.awt.Color(13, 151, 239));
        jLabel7.setFont(new java.awt.Font("DejaVu Sans", 1, 13)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(254, 254, 254));
        jLabel7.setText("Búsqueda");
        jLabel7.setOpaque(true);

        Dat_Desde.setOpaque(false);
        Dat_Desde.setDate(new Date());

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        jLabel1.setText("Desde:");

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        jLabel2.setText("Hasta:");

        Dat_Asta.setOpaque(false);
        Dat_Asta.setDate(new Date());

        Che_Todo.setBackground(new java.awt.Color(207, 228, 228));
        Che_Todo.setText("Listar todo");
        Che_Todo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Che_TodoActionPerformed(evt);
            }
        });

        jLabel6.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        jLabel6.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Rainrlendar.png"))); // NOI18N
        jLabel6.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        jLabel6.setVerifyInputWhenFocusTarget(false);
        jLabel6.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(Che_Todo)
                .addGap(29, 29, 29)
                .addComponent(Btn_Listar)
                .addGap(18, 18, 18)
                .addComponent(jLabel6, javax.swing.GroupLayout.DEFAULT_SIZE, 120, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(Dat_Desde, javax.swing.GroupLayout.PREFERRED_SIZE, 107, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel2)
                .addGap(2, 2, 2)
                .addComponent(Dat_Asta, javax.swing.GroupLayout.DEFAULT_SIZE, 128, Short.MAX_VALUE)
                .addContainerGap())
            .addComponent(jLabel7, javax.swing.GroupLayout.DEFAULT_SIZE, 347, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel7)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(Dat_Desde, javax.swing.GroupLayout.DEFAULT_SIZE, 29, Short.MAX_VALUE)
                    .addComponent(Dat_Asta, javax.swing.GroupLayout.DEFAULT_SIZE, 29, Short.MAX_VALUE)
                    .addComponent(jLabel2, javax.swing.GroupLayout.DEFAULT_SIZE, 29, Short.MAX_VALUE)
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, 29, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(Che_Todo)
                            .addComponent(Btn_Listar))
                        .addGap(13, 13, 13))
                    .addComponent(jLabel6, 0, 0, Short.MAX_VALUE)))
        );

        jPanel2.setBackground(new java.awt.Color(207, 228, 228));

        Lbl_SubTotal.setBackground(new java.awt.Color(127, 197, 242));
        Lbl_SubTotal.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        Lbl_SubTotal.setMaximumSize(new java.awt.Dimension(84, 27));
        Lbl_SubTotal.setOpaque(true);

        jLabel3.setBackground(new java.awt.Color(0, 0, 0));
        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 11)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setText("Sub TOTAL");
        jLabel3.setOpaque(true);

        jLabel4.setBackground(new java.awt.Color(0, 0, 0));
        jLabel4.setFont(new java.awt.Font("Tahoma", 1, 11)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setText("IVA Tb        IVA Tm");
        jLabel4.setOpaque(true);

        Lbl_IVATb.setBackground(new java.awt.Color(127, 197, 242));
        Lbl_IVATb.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        Lbl_IVATb.setText("123456");
        Lbl_IVATb.setMaximumSize(new java.awt.Dimension(72, 27));
        Lbl_IVATb.setOpaque(true);

        Lbl_Total.setBackground(new java.awt.Color(255, 102, 102));
        Lbl_Total.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        Lbl_Total.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        Lbl_Total.setMaximumSize(new java.awt.Dimension(72, 27));
        Lbl_Total.setOpaque(true);

        jLabel10.setFont(new java.awt.Font("Lucida Fax", 1, 14)); // NOI18N
        jLabel10.setText("TOTAL");
        jLabel10.setBorder(javax.swing.BorderFactory.createEtchedBorder(javax.swing.border.EtchedBorder.RAISED));
        jLabel10.setOpaque(true);

        Lbl_IVATm.setBackground(new java.awt.Color(127, 197, 242));
        Lbl_IVATm.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        Lbl_IVATm.setText("123456");
        Lbl_IVATm.setMaximumSize(new java.awt.Dimension(72, 27));
        Lbl_IVATm.setOpaque(true);

        Lbl_Des.setBackground(new java.awt.Color(127, 197, 242));
        Lbl_Des.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        Lbl_Des.setMaximumSize(new java.awt.Dimension(84, 27));
        Lbl_Des.setOpaque(true);

        jLabel5.setBackground(new java.awt.Color(0, 0, 0));
        jLabel5.setFont(new java.awt.Font("Tahoma", 1, 11)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(255, 255, 255));
        jLabel5.setText("Descuento");
        jLabel5.setOpaque(true);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel3, javax.swing.GroupLayout.DEFAULT_SIZE, 85, Short.MAX_VALUE)
                    .addComponent(Lbl_SubTotal, javax.swing.GroupLayout.DEFAULT_SIZE, 85, Short.MAX_VALUE)
                    .addComponent(jLabel5, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 85, Short.MAX_VALUE)
                    .addComponent(Lbl_Des, javax.swing.GroupLayout.DEFAULT_SIZE, 85, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel10, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(Lbl_Total, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(Lbl_IVATb, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(Lbl_IVATm, javax.swing.GroupLayout.PREFERRED_SIZE, 60, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel4, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 120, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addGap(5, 5, 5)
                        .addComponent(Lbl_SubTotal, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel4)
                        .addGap(5, 5, 5)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(Lbl_IVATb, javax.swing.GroupLayout.PREFERRED_SIZE, 17, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(Lbl_IVATm, javax.swing.GroupLayout.PREFERRED_SIZE, 17, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 16, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(1, 1, 1)
                        .addComponent(Lbl_Total, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(Lbl_Des, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );

        Btn_Imprimir.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/Print.png"))); // NOI18N
        Btn_Imprimir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_ImprimirActionPerformed(evt);
            }
        });

        Btn_Salir.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Iconos/salir.png"))); // NOI18N
        Btn_Salir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Btn_SalirActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(2, 2, 2)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(Btn_Salir, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(Btn_Imprimir, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
            .addComponent(jScrollPane1)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 292, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Btn_Imprimir, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(Btn_Salir, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void Btn_ImprimirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_ImprimirActionPerformed
        try {
            Rep_Class_IniciarReporte.imprimirLisFac(mColFac);
        } catch (JRException ex) {
            JOptionPane.showMessageDialog(this, ex.getLocalizedMessage());
        }

    }//GEN-LAST:event_Btn_ImprimirActionPerformed

    private void Che_TodoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Che_TodoActionPerformed
        // TODO add your handling code here:
        enableDate(!Che_Todo.isSelected());
    }//GEN-LAST:event_Che_TodoActionPerformed

    private void Btn_SalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_SalirActionPerformed
        try {
            // TODO add your handling code here:
            this.clone();
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(Frm_ListaFac.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_Btn_SalirActionPerformed

    private void Btn_ListarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Btn_ListarActionPerformed
        // TODO add your handling code here:
        LogN_Inter_FiltFactura ObjFiltroF;
        if (this.Che_Todo.isSelected()){
            ObjFiltroF = null;
        }else {
            ArrayList<Date> ColFech = new ArrayList<Date>();
            ColFech.add(Dat_Desde.getDate());
            ColFech.add(Dat_Asta.getDate());
            ObjFiltroF = new LogN_Class_FilFacturaFecha(true, ColFech);
        }
        mObjModFac.setFlitro(ObjFiltroF);
        CargarTotales();
    }//GEN-LAST:event_Btn_ListarActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Frm_ListaFac().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Btn_Imprimir;
    private javax.swing.JButton Btn_Listar;
    private javax.swing.JButton Btn_Salir;
    private javax.swing.JCheckBox Che_Todo;
    private com.toedter.calendar.JDateChooser Dat_Asta;
    private com.toedter.calendar.JDateChooser Dat_Desde;
    private javax.swing.JLabel Lbl_Des;
    private javax.swing.JLabel Lbl_IVATb;
    private javax.swing.JLabel Lbl_IVATm;
    private javax.swing.JLabel Lbl_SubTotal;
    private javax.swing.JLabel Lbl_Total;
    private javax.swing.JTable Tab_Factura;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables

    public void enableDate (boolean xEstado){
        Dat_Asta.setEnabled(xEstado);
        Dat_Desde.setEnabled(xEstado);
    }

    public void listar (){
        mObjModFac = mObjFachada.getModelLf(true);
    }

    private void CargarTotales() {
        float SubT, Des, IvaTb, IvaTm;
        SubT = mObjModFac.getSubTotal();
        Des = mObjModFac.getDescuento();
        IvaTb= mObjModFac.getIvaTb();
        IvaTm = mObjModFac.getIvaTm();
        
        Lbl_SubTotal.setText("" + nf.format(SubT));
        Lbl_Des.setText("" + nf.format(Des));
        Lbl_IVATb.setText("" + nf.format(IvaTb));
        Lbl_IVATm.setText("" + nf.format(IvaTm));
        Lbl_Total.setText("" + nf.format((SubT - Des + IvaTb + IvaTm )));
    }

    }
