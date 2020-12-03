/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Reportes;


import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_LineaFac;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.MiExepcion.InputException;
import Persistencia.Per_Class_ConecElPam;
import java.io.File;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.view.JasperViewer;


/**
 *
 * @author ary
 */
public class Rep_Class_IniciarReporte {

    

    public static void imprimirFactura (LogN_ClassAb_Factura xObjFac) throws JRException {
        imprimirFactura(xObjFac, xObjFac.getPersona());

    }
    
    
    public static void imprimirFactura(LogN_ClassAb_Factura xObjFac, LogN_ClassAb_Persona pObjPersona)throws JRException {
            
            File archivo = new File ("ConFact.jasper");
//            JasperDesign jDesign = JasperManager.loadXmlDesign("Factura.jasper");
//
            JasperReport masterReport = null;

            masterReport = (JasperReport) JRLoader.loadObject(archivo);

             JasperReport SubReporte = (JasperReport) JRLoader.loadObject(new File ("Factura.jasper"));
              JasperReport SubReporte2 = (JasperReport) JRLoader.loadObject(new File ("Factura1.jasper"));
            Map parametro = new HashMap();

            LogN_ClassAb_Persona ObjPer = pObjPersona;


            parametro.put("Nombre", ObjPer.getmRasSos());
            parametro.put("Rut", ObjPer.getmNumDoc());
            parametro.put("Dir", ObjPer.getmDir());
            
            GregorianCalendar Fech = new GregorianCalendar();
            Fech.setTime(xObjFac.getFech());
            parametro.put("Fecha", Fech);
            parametro.put("ConFin", false);
            parametro.put("FacNum", xObjFac.getNum());
            parametro.put("FacSer", "" + xObjFac.getmSerFac());
            parametro.put("SubReport", SubReporte);
            parametro.put("SubReport", SubReporte2);
            
            Per_Class_ConecElPam mObjMiSql = new Per_Class_ConecElPam();
            
            
            
//
            JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, parametro, mObjMiSql.AbrirConection());

            JasperViewer jviewer= new JasperViewer(jasperPrint,false);

            jviewer.setTitle("Geniz -Reporte");

            jviewer.setVisible(true);
//            JasperPrintManager.printReport(jasperPrint, false);
//            
//            JasperPrintManager.printReport(jasperPrint, false);


            
//            JasperReport jReport = JasperManager.compileReport(jDesign);
//
//
//            JasperPrint jPrint = JasperManager.fillReport(jReport, parametro, ds);
//            JasperPrintManager.printReport( jPrint, true);
    }

    
    
    

    public static void imprimirLisProdIn (ArrayList <Dom_Class_ProductoComp> xColPro, boolean xACli) throws JRException, JRException, JRException {
        
        File archivo;
        if (xACli)archivo = new File ("Lista_Producto_Cliente.jasper");
        else archivo = new File ("Producto.jasper");

        JasperReport masterReport = null;

        masterReport = (JasperReport) JRLoader.loadObject(archivo);

        JRBeanCollectionDataSource ds =new JRBeanCollectionDataSource(xColPro);

        JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, new HashMap(), ds);

        JasperViewer jviewer= new JasperViewer(jasperPrint,false);

        jviewer.setTitle("Geniz -Reporte");

        jviewer.setVisible(true);
    }

    public static void imprimirPresupuesto (ArrayList <LogN_ClassAb_LineaFac> xColPro)throws JRException{

            if (xColPro == null || xColPro.size() == 0 ) return ;
            
            File archivo = new File ("Presupuesto.jasper");

            JasperReport masterReport = null;

            masterReport = (JasperReport) JRLoader.loadObject(archivo);

            Map parametro = new HashMap();


            JRBeanCollectionDataSource ds =new JRBeanCollectionDataSource(xColPro);

            JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, parametro, ds);


            JasperPrintManager.printReport(jasperPrint, false);

    }

        public static void imprimirLisFac (ArrayList <LogN_ClassAb_Factura> xColPro) throws JRException {

            if (xColPro == null || xColPro.size() == 0 ) return ;
            File archivo=  new File ("LisFactura.jasper");

            JasperReport masterReport = null;

            masterReport = (JasperReport) JRLoader.loadObject(archivo);

            JRBeanCollectionDataSource ds =new JRBeanCollectionDataSource(xColPro);

            JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, new HashMap(), ds);

            JasperViewer jviewer= new JasperViewer(jasperPrint,false);

            jviewer.setTitle("Geniz -Reporte");

            jviewer.setVisible(true);
    }

    public static void imprimirLisProd (ArrayList<LogN_ClassAb_Producto> xColPro, boolean xACli) throws JRException {

        File archivo;
        if (xACli)archivo = new File ("Lista_Producto_Cliente.jasper");
        else archivo = new File ("Producto.jasper");

        JasperReport masterReport = null;

        masterReport = (JasperReport) JRLoader.loadObject(archivo);

        JRBeanCollectionDataSource ds =new JRBeanCollectionDataSource(xColPro);

        JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, new HashMap(), ds);

        JasperViewer jviewer= new JasperViewer(jasperPrint,false);

        jviewer.setTitle("Geniz -Reporte");

        jviewer.setVisible(true);
    }

    
    

}
