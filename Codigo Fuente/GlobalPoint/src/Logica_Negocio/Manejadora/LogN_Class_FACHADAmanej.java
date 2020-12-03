/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio.Manejadora;

import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Logica_Negocio.Dominio.*;
import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacCom;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.LogN_ClassAb_Factura;
import Logica_Negocio.LogN_ClassAb_Movimiento;
import Logica_Negocio.LogN_ClassAb_PerExterna;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_ClassAb_Producto;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabClienteMysql;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabProveedorMysql;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observer;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ary
 */
public class LogN_Class_FACHADAmanej implements LogN_Inter_FACHADAmanej{

    //Atributos_________________________________________________________________

    private LogN_Inter_ManejCategoria mObjManCat;
    private LogN_Inter_ManejProducto mObjManProd;
    private LogN_Inter_ManejMoneda mObjMoneda;
    private LogN_Inter_ManejFactura mObjManFactura;
    private LogN_Inter_ManejMovimiento mObjManMov;
    private LogN_Inter_ManejPais mObjManPais;
    private LogN_Inter_ManejPersona mObjManPer;
    private LogN_Inter_ManejIVA mObjManIVA;
    private LogN_Inter_ManejRecibo mObjManRecibo;
    private LogN_Inter_ManejReportComun mObjManRepComun;


    //Constructor_______________________________________________________________

    public LogN_Class_FACHADAmanej () {
        LogN_Class_ManejConstructor ObjCon = null;

        try {
            ObjCon = new LogN_Class_ManejConstructor();
        } catch (InputException ex) {
            Logger.getLogger(LogN_Class_FACHADAmanej.class.getName()).log(Level.SEVERE, null, ex);
        }

        mObjManCat = ObjCon.getManejCategoria();
        mObjManProd = ObjCon.getManejProducto();
        mObjMoneda = ObjCon.getManejMoneda();
        mObjManFactura = ObjCon.getManejFactura();
        mObjManMov = ObjCon.getMajMovimiento();
        mObjManPais = ObjCon.getMajPais();
        mObjManPer = ObjCon.getManejPersona();
        mObjManIVA = ObjCon.getManejIVA();
        mObjManRecibo = ObjCon.getManejRecibo();
        mObjManRepComun = ObjCon.getmObjManRepComun();
        
    }
    
    //Metodos___________________________________________________________________
    
    // <editor-fold defaultstate="collapsed" desc="Metodo Categoria">
        @Override
        public void modificarCategoria(Dom_Class_Categoria xObjCatAn, Dom_Class_Categoria xObjCatNu) throws InputException {
            mObjManCat.modificarCategoria(xObjCatAn, xObjCatNu);
        }

        @Override
        public void modifcarCategoria(String NomCatAn, String NomCatNu) throws InputException {
            mObjManCat.modifcarCategoria(NomCatAn, NomCatNu);
        }

        @Override
        public ArrayList<Dom_Class_Categoria> listarCat() {
            return mObjManCat.listarCat();
        }

        @Override
        public Dom_Class_Categoria getCategoria(Dom_Class_Categoria xObjCat) {
            return mObjManCat.getCategoria(xObjCat);
        }

        @Override
        public Dom_Class_Categoria getCategoria(String NomCat) {
            return mObjManCat.getCategoria(NomCat);
        }

        @Override
        public boolean existeCat(String NomCat) {
            return mObjManCat.existeCat(NomCat);
        }

        @Override
        public boolean existeCat(Dom_Class_Categoria xObjCategoria) {
            return mObjManCat.existeCat(xObjCategoria);
        }

        @Override
        public void consCategoria(String nomCat) throws InputException {
            mObjManCat.consCategoria(nomCat);
        }

        @Override
        public void bajaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
            mObjManCat.bajaCategoria(xObjCat);
        }

        @Override
        public void bajaCategoria(String NomCat) throws InputException {
            mObjManCat.bajaCategoria(NomCat);
        }

        @Override
        public void altaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
            mObjManCat.altaCategoria(xObjCat);
        }

        @Override
        public Dom_Class_Categoria RetornarOCrearCategoria(String NomCat) throws InputException {
            return mObjManCat.RetornarOCrearCategoria(NomCat);
        }

        @Override
        public Dom_Class_Categoria RetornarOCrarCategoria(Dom_Class_Categoria xobjCat) throws InputException {
            return mObjManCat.RetornarOCrarCategoria(xobjCat);
        }

        @Override
        public boolean removObservadorCategoria(Observer xObj) {
            return mObjManCat.removObservadorCategoria(xObj);
        }

        @Override
        public boolean addObservadorCategoria(Observer xObj) {
            return mObjManCat.addObservadorCategoria(xObj);
        }
    
    // </editor-fold> 
        
    // <editor-fold defaultstate="collapsed" desc="Metodo Producto">
        @Override
        public ArrayList<Dom_Class_ProductoComp> listarProducto() {
            return mObjManProd.listarProducto();
        }

        @Override
        public boolean existeCanEnPro(Dom_Class_Categoria xObjCat) {
            return mObjManProd.existeCanEnPro(xObjCat);
        }

        @Override
        public boolean bajaProducto(LogN_ClassAb_Producto xObjProducto) throws InputException {
            return mObjManProd.bajaProducto(xObjProducto);
        }

        @Override
        public void altaProductoCom(Dom_Class_ProductoComp xObjProduto) throws InputException {
            mObjManProd.altaProductoCom(xObjProduto);
        }

        @Override
        public void altaSubProducto(Dom_Class_SubProducto xObjSubP) throws InputException {
            mObjManProd.altaSubProducto(xObjSubP);
        }

        @Override
        public void asignarSubProd(Dom_Class_ProductoComp xObjProdCom) throws InputException {
            mObjManProd.asignarSubProd(xObjProdCom);
        }

        @Override
        public Dom_Class_ProductoComp getProdCom(int xNumP) throws InputException {
            return mObjManProd.getProdCom(xNumP);
        }

        @Override
        public LogN_ClassAb_Producto getProducot(int xNumP) throws InputException {
            return mObjManProd.getProducot(xNumP);
        }

        @Override
        public Dom_Class_SubProducto getSubProd(int xNumP) throws InputException {
            return mObjManProd.getSubProd(xNumP);
        }
        
        @Override
        public void removObservadorProducto(Observer xObjObser) {
            mObjManProd.removObservadorProducto(xObjObser);
        }

        @Override
        public void addObservadorProducto(Observer xObjObser) {
            mObjManProd.addObservadorProducto(xObjObser);
        }

        @Override
        public void modificarPord(LogN_ClassAb_Producto xObjProdAn, LogN_ClassAb_Producto xObjProdNue) throws InputException {
            mObjManProd.modificarPord(xObjProdAn, xObjProdNue);
        }

        @Override
        public void modificarProdCom(Dom_Class_ProductoComp xObjProdNu, Dom_Class_ProductoComp xObjProdAn) throws InputException {
            mObjManProd.modificarProdCom(xObjProdNu, xObjProdAn);
        }

        @Override
        public void modificarSubProducto(Dom_Class_SubProducto xObjProdNu, Dom_Class_SubProducto xObjProdAn) throws InputException {
            mObjManProd.modificarSubProducto(xObjProdNu, xObjProdAn);
        }
        
        @Override
        public ArrayList<Dom_Class_ProductoComp> listarProStokMin()throws InputException {
            return mObjManProd.listarProStokMin();
        }

        @Override
        public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_FlitPorducto xObjFiltro) {
            return mObjManProd.listarDetalleProducto(xObjFiltro);
        }

        @Override
        public int getNumProd() {
            return mObjManProd.getNumProd();
        }
        
        @Override
        public void altaProductoElav(Dom_Class_ProductoElavo xObjProdElav) throws InputException {
            mObjManProd.altaProductoElav(xObjProdElav);
        }

        @Override
        public void modificarProdElav(Dom_Class_ProductoElavo xObjProdNu, Dom_Class_ProductoElavo xObjProdAn) throws InputException {
            mObjManProd.modificarProdElav(xObjProdNu, xObjProdAn);
        }

        @Override
        public Dom_Class_ProductoElavo getProdElav(int xNumP) throws InputException {
            return mObjManProd.getProdElav(xNumP);
        }

    // </editor-fold> 
        
    // <editor-fold defaultstate="collapsed" desc="Metodo Moneda">
        @Override
        public void removObservadorMoneda(Observer xObjObser) {
            mObjMoneda.removObservadorMoneda(xObjObser);
        }

        @Override
        public void modiMoneda(Dom_Class_Moneda xObjMonedaAn, Dom_Class_Moneda xObjMonedaNu) throws InputException {
            mObjMoneda.modiMoneda(xObjMonedaAn, xObjMonedaNu);
        }

        @Override
        public ArrayList<Dom_Class_Moneda> listarMondeda() {
            return mObjMoneda.listarMondeda();
        }

        @Override
        public Dom_Class_Moneda getMoneda(int NumM) {
            throw new UnsupportedOperationException("Not supported yet.");
        }
        
        @Override
        public Dom_Class_Moneda getMonedaLoc() {
            return mObjMoneda.getMonedaLoc();
        }

        @Override
        public void setMonedaLocal(Dom_Class_Moneda xObjMoneda) throws InputException {
            mObjMoneda.setMonedaLocal(xObjMoneda);
        }
        
        
        @Override
        public void bajaMoneda(Dom_Class_Moneda xObjMoneda) throws InputException {
            mObjMoneda.bajaMoneda(xObjMoneda);
        }

        @Override
        public void altaMoneda(Dom_Class_Moneda xObjMoneda, boolean xLocal) throws InputException {
            mObjMoneda.altaMoneda(xObjMoneda, xLocal);
        }

        @Override
        public void addObservadorMoneda(Observer xObjObser) {
            mObjMoneda.addObservadorMoneda(xObjObser);
        }
    // </editor-fold> 
        
    // <editor-fold defaultstate="collapsed" desc="Metodo Factura">

    public void removObservadorFactura(Observer xObjObser) {
        mObjManFactura.removObservadorFactura(xObjObser);
    }

    public ArrayList<Dom_Class_FacVen> listarFacturaVen(Date FechIn, Date FechFin) {
        return mObjManFactura.listarFacturaVen(FechIn, FechFin);
    }

    public ArrayList<Dom_Class_FacCom> listarFacturaCom(Date FechIn, Date FechFin) {
        return mObjManFactura.listarFacturaCom(FechIn, FechFin);
    }

    public ArrayList<LogN_ClassAb_Factura> listarFactura(Date FechIn, Date FechFin) {
        return mObjManFactura.listarFactura(FechIn, FechFin);
    }

    public ArrayList<LogN_ClassAb_Factura> listarFactura() {
        return mObjManFactura.listarFactura();
    }

    public Dom_Class_FacVen getFacVen(int NumFac, char Car) {
        return mObjManFactura.getFacVen(NumFac, Car);
    }

    public Dom_Class_FacCom getFacCom(int NumFac, char Car) {
        return mObjManFactura.getFacCom(NumFac, Car);
    }

    public void altaFactura(LogN_ClassAb_Factura xObjFactura, boolean xPresupuesto) throws InputException {
        mObjManFactura.altaFactura(xObjFactura, xPresupuesto);
    }

    public void altaFacVen(Dom_Class_FacVen xObjFacVen, boolean xPresupuesto) throws InputException {
        mObjManFactura.altaFacVen(xObjFacVen, xPresupuesto);
    }

    public void altaFacCom(Dom_Class_FacCom xObjFacCom) throws InputException {
        mObjManFactura.altaFacCom(xObjFacCom);
    }

    @Override
    public void addObservadorFactura(Observer xObjObser) {
        mObjManFactura.addObservadorFactura(xObjObser);
    }

    @Override
    public Dom_Class_FacVen NuevaFachVen() {
        return mObjManFactura.NuevaFachVen();
    }

    @Override
    public LogN_ClassAb_ModeljTabFactura getModelLf(boolean xTipoF) {
        return mObjManFactura.getModelLf(xTipoF);
    }    
    

    // </editor-fold> 
    
    // <editor-fold defaultstate="collapsed" desc="Metodo Movimiento">
        @Override
        public int getNumMovimiento() {
            return mObjManMov.getNumMovimiento();
        }

        @Override
        public void altaMovimiento(LogN_ClassAb_Movimiento xObjMov) throws InputException {
            mObjManMov.altaMovimiento(xObjMov);
        }

        @Override
        public void addObservadorMovimiento(Observer xObjObser) {
            mObjManMov.addObservadorMovimiento(xObjObser);
        }
        
        @Override
        public void removObservadorMovimiento(Observer xObjObser) {
            mObjManMov.removObservadorMovimiento(xObjObser);
        }
    // </editor-fold> 

    // <editor-fold defaultstate="collapsed" desc="Metodo Pais">
        @Override
        public void modifPais(Dom_Class_Pais xObjPaisAn, Dom_Class_Pais xObjPaNu) throws InputException {
            mObjManPais.modifPais(xObjPaisAn, xObjPaNu);
        }

        @Override
        public void modiProvDep(Dom_Class_ProvinDepar xObjProvDepAn, Dom_Class_ProvinDepar xObjProvDepNu) throws InputException {
            mObjManPais.modiProvDep(xObjProvDepAn, xObjProvDepNu);
        }

        @Override
        public ArrayList<Dom_Class_Pais> listarPais() {
            return mObjManPais.listarPais();
        }

        @Override
        public Dom_Class_ProvinDepar getProvDep(int xNumProvDep) {
            return mObjManPais.getProvDep(xNumProvDep);
        }

        @Override
        public Dom_Class_Pais getPais(int xNumP) {
            return mObjManPais.getPais(xNumP);
        }

        @Override
        public void bajaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
            mObjManPais.bajaProvDep(xObjPais, xObjProvDep);
        }

        @Override
        public void bajaPais(Dom_Class_Pais xObjPais) throws InputException {
            mObjManPais.bajaPais(xObjPais);
        }

        @Override
        public void altaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
            mObjManPais.altaProvDep(xObjPais, xObjProvDep);
        }

        @Override
        public void altaPais(Dom_Class_Pais xObjPais) throws InputException {
            mObjManPais.altaPais(xObjPais);
        }

        @Override
        public void addObservadorPais(Observer xObjObservador) {
            mObjManPais.addObservadorPais(xObjObservador);
        }
        
        @Override
        public void removObservadorPais(Observer xObjObser) {
            mObjManPais.addObservadorPais(xObjObser);
        }
    // </editor-fold> 

    // <editor-fold defaultstate="collapsed" desc="Metodo Persona">
        @Override
        public int getNumProv() {
            return mObjManPer.getNumProv();
        }

        @Override
        public int getNumCli() {
            return mObjManPer.getNumCli();
        }
        
        @Override
        public Dom_Class_Cliente getCliente(int NumCli) {
            return mObjManPer.getCliente(NumCli);
        }

        @Override
        public Dom_Class_Proveedor getProveedor(int NumProv) {
            return mObjManPer.getProveedor(NumProv);
        }

        @Override
        public void bajaProv(Dom_Class_Proveedor xObjProv) throws InputException {
            mObjManPer.bajaProv(xObjProv);
        }

        @Override
        public void bajaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
            mObjManPer.bajaPersonaEx(xObjPerEx);
        }

        @Override
        public void bajaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
            mObjManPer.bajaCliente(xObjCLi);
        }

        @Override
        public void altaProv(Dom_Class_Proveedor xObjProv) throws InputException {
            mObjManPer.altaProv(xObjProv);
        }

        @Override
        public void altaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
            mObjManPer.altaPersonaEx(xObjPerEx);
        }

        @Override
        public void altaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
            mObjManPer.altaCliente(xObjCLi);
        }

        @Override
        public void ModProv(Dom_Class_Proveedor xObjProvAn, Dom_Class_Proveedor xObjProvNu) throws InputException {
            mObjManPer.ModProv(xObjProvAn, xObjProvNu);
        }

        @Override
        public void ModPersonaEx(LogN_ClassAb_PerExterna xObjPerExAn, LogN_ClassAb_PerExterna xObjPerExNu) throws InputException {
            mObjManPer.ModPersonaEx(xObjPerExAn, xObjPerExNu);
        }

        @Override
        public void ModCliente(Dom_Class_Cliente xObjCLiAn, Dom_Class_Cliente xObjCLiNu) throws InputException {
            mObjManPer.ModCliente(xObjCLiAn, xObjCLiNu);
        }

        @Override
        public LogN_Class_ModeljTabClienteMysql getModJtabClienteMysql() {
            return mObjManPer.getModJtabClienteMysql();
        }

        @Override
        public LogN_Class_ModeljTabProveedorMysql getModJtabProvMysql() {
            return mObjManPer.getModJtabProvMysql();
        }

        @Override
        public void addObservadorPersona(Observer xObjObser) {
            mObjManPer.addObservadorPersona(xObjObser);
        }

        @Override
        public void removObservadorPersona(Observer xObjObser) {
            mObjManPer.removObservadorPersona(xObjObser);
        }

        @Override
        public String existeCodBarProd(int xCodPro, String xCodBarr) {
            return mObjManProd.existeCodBarProd(xCodPro, xCodBarr);
        }
        
        
        
        // <editor-fold defaultstate="collapsed" desc="Metodo Contacto"> 
            
            // Mentodos Alta contacto *************************************
            @Override
            public void altaContacto(LogN_ClassAb_PerExterna xObjPerEx, LogN_ClassAb_Contacto xObjCon) throws InputException {
                mObjManPer.altaContacto(xObjPerEx, xObjCon);
            }

            @Override
            public void altaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
                mObjManPer.altaCel(xObjPerEx, xObjCel);
            }

            @Override
            public void altaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjCel) throws InputException {
                mObjManPer.altaTel(xObjPerEx, xObjCel);
            }

            @Override
            public void altaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjCel) throws InputException {
                mObjManPer.altaMail(xObjPerEx, xObjCel);
            }

            @Override
            public void altaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjCel) throws InputException {
                mObjManPer.altaFax(xObjPerEx, xObjCel);
            }

             // Mentodos baja contacto *************************************
            


            @Override
            public void bajaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
                mObjManPer.bajaCel(xObjPerEx, xObjCel);
            }

            @Override
            public void bajaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjCel) throws InputException {
                mObjManPer.bajaTel(xObjPerEx, xObjCel);
            }

            @Override
            public void bajaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjCel) throws InputException {
                mObjManPer.bajaMail(xObjPerEx, xObjCel);
            }

            @Override
            public void bajaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjCel) throws InputException {
                mObjManPer.bajaFax(xObjPerEx, xObjCel);
            }

            
            // Mentodos modificar contacto *************************************
            
                @Override
                public void modifContacto(LogN_ClassAb_Contacto xObjConAn, LogN_ClassAb_Contacto xObjConNu) throws InputException {
                    mObjManPer.modifContacto(xObjConAn, xObjConNu);
                }

                @Override
                public void modifCel(Dom_Class_Cel xObjCelAn, Dom_Class_Cel xObjCelNu) throws InputException {
                    mObjManPer.modifCel(xObjCelAn, xObjCelNu);
                }

                @Override
                public void modifTel(Dom_Class_Tel xObjTelAn, Dom_Class_Tel xObjTelNu) throws InputException {
                    mObjManPer.modifTel(xObjTelAn, xObjTelNu);
                }

                @Override
                public void modifMail(Dom_Class_Mail xObjCelAn, Dom_Class_Mail xObjCelNu) throws InputException {
                    mObjManPer.modifMail(xObjCelAn, xObjCelNu);
                }

                @Override
                public void modifFax(Dom_Class_Fax xObjFaxAn, Dom_Class_Fax xObjFaxNu) throws InputException {
                    mObjManPer.modifFax(xObjFaxAn, xObjFaxNu);
                }
  
        // </editor-fold>
           
        // <editor-fold defaultstate="collapsed" desc="Metodo Saldo"> 
            @Override
            public void altaSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
                mObjManPer.altaSaldo(xObjPer, xObjSaldo);
            }

            @Override
            public void bajaSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
                mObjManPer.bajaSaldo(xObjPer, xObjSaldo);
            }

            @Override
            public void modifSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
                mObjManPer.modifSaldo(xObjPer, xObjSaldo);
            }
        // </editor-fold>
            
   
                
    // </editor-fold> 
            
    // <editor-fold defaultstate="collapsed" desc="Metodo IVA">
        
        @Override
        public ArrayList<Dom_Class_IVA> listarIVA() {
            return mObjManIVA.listarIVA();
        }

        @Override
        public Dom_Class_IVA getIVA(float pPorcentaje) throws InputException {
            return mObjManIVA.getIVA(pPorcentaje);
        }

        @Override
        public Dom_Class_IVA getIVA(int pNum) throws InputException {
            return mObjManIVA.getIVA(pNum);
        }
        
        
    // </editor-fold> 
        
    // <editor-fold defaultstate="collapsed" desc="Metodo Recibo">   
        @Override
        public void altaRecibo(Dom_Class_Resibo xObjRecibo) throws InputException {
            mObjManRecibo.altaRecibo(xObjRecibo);
        }

        @Override
        public ArrayList<Dom_Class_Resibo> listarRecibos() throws InputException {
            return mObjManRecibo.listarRecibos();
        }

        @Override
        public Dom_Class_Resibo getResibo(int xNumR) throws InputException {
            return mObjManRecibo.getResibo(xNumR);
        }

        @Override
        public int getNumRecibo() throws InputException {
            return mObjManRecibo.getNumRecibo();
        }

    // </editor-fold> 

    @Override
    public LogN_ClassAb_ModeljTabCuentas getModeljTabCuentas() {
        return mObjManRepComun.getModeljTabCuentas();
    }
        
        
        

   
            
            
            





}
