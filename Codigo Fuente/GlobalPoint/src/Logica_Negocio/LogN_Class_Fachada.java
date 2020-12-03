/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Logica_Negocio;

import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_Contacto;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Cel;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Fax;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Mail;
import Logica_Negocio.Dominio.Contacto.Dom_Class_Tel;
import Logica_Negocio.Dominio.Dom_Class_Categoria;
import Logica_Negocio.Dominio.Dom_Class_IVA;
import Logica_Negocio.Dominio.Dom_Class_Moneda;
import Logica_Negocio.Dominio.Dom_Class_Pais;
import Logica_Negocio.Dominio.Dom_Class_ProductoComp;
import Logica_Negocio.Dominio.Dom_Class_ProductoElavo;
import Logica_Negocio.Dominio.Dom_Class_ProvinDepar;
import Logica_Negocio.Dominio.Dom_Class_Resibo;
import Logica_Negocio.Dominio.Dom_Class_Saldo;
import Logica_Negocio.Dominio.Dom_Class_SubProducto;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacCom;
import Logica_Negocio.Dominio.Facturacion.Dom_Class_FacVen;
import Logica_Negocio.Dominio.Personas.Dom_Class_Cliente;
import Logica_Negocio.Dominio.Personas.Dom_Class_Proveedor;
import Logica_Negocio.Filtros.Producto.LogN_Inter_FlitPorducto;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabFactura;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabProd;
import Logica_Negocio.Manejadora.LogN_Class_FACHADAmanej;
import Logica_Negocio.Manejadora.LogN_Inter_FACHADAmanej;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabClienteMysql;
import Logica_Negocio.Manejadora.MYSQL.jTabModel.Persona.LogN_Class_ModeljTabProveedorMysql;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;
import Logica_Negocio.MiExepcion.InputException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observer;

/**
 *
 * @author ary
 */
public class LogN_Class_Fachada implements LogN_Inter_FACHADAmanej {
    
    //Atributos_________________________________________________________________
    
    private LogN_Class_FACHADAmanej mObjFachMan = new LogN_Class_FACHADAmanej();
    private static LogN_Class_Fachada instancia;
    
    //Constructor_______________________________________________________________
    
    private LogN_Class_Fachada (){
        
    }
    
    //Metodos___________________________________________________________________


    //Metodos internos**************************************************************************

    public static LogN_Class_Fachada getInstancia() {
        if (instancia == null) {
            CrearInstancia();
        }

        return instancia;
    }

    private synchronized static void CrearInstancia() {
        if (instancia == null) {
            instancia = new LogN_Class_Fachada();
        }
    }

 
    public void bajaContacto (LogN_ClassAb_PerExterna ObjPer, LogN_ClassAb_Contacto ObjCon) throws InputException{
        if(ObjCon instanceof Dom_Class_Tel) this.bajaTel(ObjPer,(Dom_Class_Tel) ObjCon);
        
        else if (ObjCon instanceof Dom_Class_Cel) this.bajaCel(ObjPer, (Dom_Class_Cel) ObjCon);
        
        else if (ObjCon instanceof Dom_Class_Fax) this.bajaFax(ObjPer, (Dom_Class_Fax) ObjCon);
        
        else if (ObjCon instanceof Dom_Class_Mail) this.bajaMail(ObjPer, (Dom_Class_Mail) ObjCon);
        
        
    }
    
    @Override
    public void altaContacto(LogN_ClassAb_PerExterna xObjPerEx, LogN_ClassAb_Contacto xObjCon) throws InputException {
        
        if(xObjCon instanceof Dom_Class_Tel) this.altaTel(xObjPerEx,(Dom_Class_Tel) xObjCon);
        
        else if (xObjCon instanceof Dom_Class_Cel) this.altaCel(xObjPerEx, (Dom_Class_Cel) xObjCon);
        
        else if (xObjCon instanceof Dom_Class_Fax) this.altaFax(xObjPerEx, (Dom_Class_Fax) xObjCon);
        
        else if (xObjCon instanceof Dom_Class_Mail) this.altaMail(xObjPerEx, (Dom_Class_Mail) xObjCon);
        
        else mObjFachMan.altaContacto(xObjPerEx, xObjCon);
    }
    
    
    //Metodos Delegados****************************************************************************

    public void setMonedaLocal(Dom_Class_Moneda xObjMoneda) throws InputException {
        mObjFachMan.setMonedaLocal(xObjMoneda);
    }

    public void removObservadorProducto(Observer xObjObser) {
        mObjFachMan.removObservadorProducto(xObjObser);
    }

    public void removObservadorPersona(Observer xObjObser) {
        mObjFachMan.removObservadorPersona(xObjObser);
    }

    public void removObservadorPais(Observer xObjObser) {
        mObjFachMan.removObservadorPais(xObjObser);
    }

    public void removObservadorMovimiento(Observer xObjObser) {
        mObjFachMan.removObservadorMovimiento(xObjObser);
    }

    public void removObservadorMoneda(Observer xObjObser) {
        mObjFachMan.removObservadorMoneda(xObjObser);
    }

    public void removObservadorFactura(Observer xObjObser) {
        mObjFachMan.removObservadorFactura(xObjObser);
    }

    public boolean removObservadorCategoria(Observer xObj) {
        return mObjFachMan.removObservadorCategoria(xObj);
    }

    public void modificarSubProducto(Dom_Class_SubProducto xObjProdNu, Dom_Class_SubProducto xObjProdAn) throws InputException {
        mObjFachMan.modificarSubProducto(xObjProdNu, xObjProdAn);
    }

    public void modificarProdElav(Dom_Class_ProductoElavo xObjProdNu, Dom_Class_ProductoElavo xObjProdAn) throws InputException {
        mObjFachMan.modificarProdElav(xObjProdNu, xObjProdAn);
    }

    public void modificarProdCom(Dom_Class_ProductoComp xObjProdNu, Dom_Class_ProductoComp xObjProdAn) throws InputException {
        mObjFachMan.modificarProdCom(xObjProdNu, xObjProdAn);
    }

    public void modificarPord(LogN_ClassAb_Producto xObjProdAn, LogN_ClassAb_Producto xObjProdNue) throws InputException {
        mObjFachMan.modificarPord(xObjProdAn, xObjProdNue);
    }

    public void modificarCategoria(Dom_Class_Categoria xObjCatAn, Dom_Class_Categoria xObjCatNu) throws InputException {
        mObjFachMan.modificarCategoria(xObjCatAn, xObjCatNu);
    }

    public void modifcarCategoria(String NomCatAn, String NomCatNu) throws InputException {
        mObjFachMan.modifcarCategoria(NomCatAn, NomCatNu);
    }

    public void modifTel(Dom_Class_Tel xObjTelAn, Dom_Class_Tel xObjTelNu) throws InputException {
        mObjFachMan.modifTel(xObjTelAn, xObjTelNu);
    }

    public void modifSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
        mObjFachMan.modifSaldo(xObjPer, xObjSaldo);
    }

    public void modifPais(Dom_Class_Pais xObjPaisAn, Dom_Class_Pais xObjPaNu) throws InputException {
        mObjFachMan.modifPais(xObjPaisAn, xObjPaNu);
    }

    public void modifMail(Dom_Class_Mail xObjCelAn, Dom_Class_Mail xObjCelNu) throws InputException {
        mObjFachMan.modifMail(xObjCelAn, xObjCelNu);
    }

    public void modifFax(Dom_Class_Fax xObjFaxAn, Dom_Class_Fax xObjFaxNu) throws InputException {
        mObjFachMan.modifFax(xObjFaxAn, xObjFaxNu);
    }

    public void modifContacto(LogN_ClassAb_Contacto xObjConAn, LogN_ClassAb_Contacto xObjConNu) throws InputException {
        mObjFachMan.modifContacto(xObjConAn, xObjConNu);
    }

    public void modifCel(Dom_Class_Cel xObjCelAn, Dom_Class_Cel xObjCelNu) throws InputException {
        mObjFachMan.modifCel(xObjCelAn, xObjCelNu);
    }

    public void modiProvDep(Dom_Class_ProvinDepar xObjProvDepAn, Dom_Class_ProvinDepar xObjProvDepNu) throws InputException {
        mObjFachMan.modiProvDep(xObjProvDepAn, xObjProvDepNu);
    }

    public void modiMoneda(Dom_Class_Moneda xObjMonedaAn, Dom_Class_Moneda xObjMonedaNu) throws InputException {
        mObjFachMan.modiMoneda(xObjMonedaAn, xObjMonedaNu);
    }

    public ArrayList<Dom_Class_Resibo> listarRecibos() throws InputException {
        return mObjFachMan.listarRecibos();
    }

    public ArrayList<Dom_Class_ProductoComp> listarProducto() {
        return mObjFachMan.listarProducto();
    }

    public ArrayList<Dom_Class_ProductoComp> listarProStokMin() throws InputException {
        return mObjFachMan.listarProStokMin();
    }

    public ArrayList<Dom_Class_Pais> listarPais() {
        return mObjFachMan.listarPais();
    }

    public ArrayList<Dom_Class_Moneda> listarMondeda() {
        return mObjFachMan.listarMondeda();
    }

    public ArrayList<Dom_Class_IVA> listarIVA() {
        return mObjFachMan.listarIVA();
    }

    public ArrayList<Dom_Class_FacVen> listarFacturaVen(Date FechIn, Date FechFin) {
        return mObjFachMan.listarFacturaVen(FechIn, FechFin);
    }

    public ArrayList<Dom_Class_FacCom> listarFacturaCom(Date FechIn, Date FechFin) {
        return mObjFachMan.listarFacturaCom(FechIn, FechFin);
    }

    public ArrayList<LogN_ClassAb_Factura> listarFactura() {
        return mObjFachMan.listarFactura();
    }

    public ArrayList<LogN_ClassAb_Factura> listarFactura(Date FechIn, Date FechFin) {
        return mObjFachMan.listarFactura(FechIn, FechFin);
    }

    public LogN_ClassAb_ModeljTabProd listarDetalleProducto(LogN_Inter_FlitPorducto xObjFiltro) {
        return mObjFachMan.listarDetalleProducto(xObjFiltro);
    }

    public ArrayList<Dom_Class_Categoria> listarCat() {
        return mObjFachMan.listarCat();
    }

    public Dom_Class_SubProducto getSubProd(int xNumP) throws InputException {
        return mObjFachMan.getSubProd(xNumP);
    }

    public Dom_Class_Resibo getResibo(int xNumR) throws InputException {
        return mObjFachMan.getResibo(xNumR);
    }

    public Dom_Class_Proveedor getProveedor(int NumProv) {
        return mObjFachMan.getProveedor(NumProv);
    }

    public Dom_Class_ProvinDepar getProvDep(int xNumProvDep) {
        return mObjFachMan.getProvDep(xNumProvDep);
    }

    public LogN_ClassAb_Producto getProducot(int xNumP) throws InputException {
        return mObjFachMan.getProducot(xNumP);
    }

    public Dom_Class_ProductoElavo getProdElav(int xNumP) throws InputException {
        return mObjFachMan.getProdElav(xNumP);
    }

    public Dom_Class_ProductoComp getProdCom(int xNumP) throws InputException {
        return mObjFachMan.getProdCom(xNumP);
    }

    public Dom_Class_Pais getPais(int xNumP) {
        return mObjFachMan.getPais(xNumP);
    }

    public int getNumRecibo() throws InputException {
        return mObjFachMan.getNumRecibo();
    }

    public int getNumProv() {
        return mObjFachMan.getNumProv();
    }

    public int getNumProd() {
        return mObjFachMan.getNumProd();
    }

    public int getNumMovimiento() {
        return mObjFachMan.getNumMovimiento();
    }

    public int getNumCli() {
        return mObjFachMan.getNumCli();
    }

    public Dom_Class_Moneda getMonedaLoc() {
        return mObjFachMan.getMonedaLoc();
    }

    public Dom_Class_Moneda getMoneda(int NumM) {
        return mObjFachMan.getMoneda(NumM);
    }

    public LogN_ClassAb_ModeljTabCuentas getModeljTabCuentas() {
        return mObjFachMan.getModeljTabCuentas();
    }

    public LogN_ClassAb_ModeljTabFactura getModelLf(boolean xTipoF) {
        return mObjFachMan.getModelLf(xTipoF);
    }

    public LogN_Class_ModeljTabProveedorMysql getModJtabProvMysql() {
        return mObjFachMan.getModJtabProvMysql();
    }

    public LogN_Class_ModeljTabClienteMysql getModJtabClienteMysql() {
        return mObjFachMan.getModJtabClienteMysql();
    }

    public Dom_Class_IVA getIVA(int pNum) throws InputException {
        return mObjFachMan.getIVA(pNum);
    }

    public Dom_Class_IVA getIVA(float pPorcentaje) throws InputException {
        return mObjFachMan.getIVA(pPorcentaje);
    }

    public Dom_Class_FacVen getFacVen(int NumFac, char Car) {
        return mObjFachMan.getFacVen(NumFac, Car);
    }

    public Dom_Class_FacCom getFacCom(int NumFac, char Car) {
        return mObjFachMan.getFacCom(NumFac, Car);
    }

    public Dom_Class_Cliente getCliente(int NumCli) {
        return mObjFachMan.getCliente(NumCli);
    }

    public Dom_Class_Categoria getCategoria(String NomCat) {
        return mObjFachMan.getCategoria(NomCat);
    }

    public Dom_Class_Categoria getCategoria(Dom_Class_Categoria xObjCat) {
        return mObjFachMan.getCategoria(xObjCat);
    }

    public String existeCodBarProd(int xCodPro, String xCodBarr) {
        return mObjFachMan.existeCodBarProd(xCodPro, xCodBarr);
    }

    public boolean existeCat(Dom_Class_Categoria xObjCategoria) {
        return mObjFachMan.existeCat(xObjCategoria);
    }

    public boolean existeCat(String NomCat) {
        return mObjFachMan.existeCat(NomCat);
    }

    public boolean existeCanEnPro(Dom_Class_Categoria xObjCat) {
        return mObjFachMan.existeCanEnPro(xObjCat);
    }

    public void consCategoria(String nomCat) throws InputException {
        mObjFachMan.consCategoria(nomCat);
    }

    public void bajaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjCel) throws InputException {
        mObjFachMan.bajaTel(xObjPerEx, xObjCel);
    }

    public void bajaSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
        mObjFachMan.bajaSaldo(xObjPer, xObjSaldo);
    }

    public void bajaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
        mObjFachMan.bajaProvDep(xObjPais, xObjProvDep);
    }

    public void bajaProv(Dom_Class_Proveedor xObjProv) throws InputException {
        mObjFachMan.bajaProv(xObjProv);
    }

    public boolean bajaProducto(LogN_ClassAb_Producto xObjProducto) throws InputException {
        return mObjFachMan.bajaProducto(xObjProducto);
    }

    public void bajaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
        mObjFachMan.bajaPersonaEx(xObjPerEx);
    }

    public void bajaPais(Dom_Class_Pais xObjPais) throws InputException {
        mObjFachMan.bajaPais(xObjPais);
    }

    public void bajaMoneda(Dom_Class_Moneda xObjMoneda) throws InputException {
        mObjFachMan.bajaMoneda(xObjMoneda);
    }

    public void bajaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjCel) throws InputException {
        mObjFachMan.bajaMail(xObjPerEx, xObjCel);
    }

    public void bajaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjCel) throws InputException {
        mObjFachMan.bajaFax(xObjPerEx, xObjCel);
    }

    public void bajaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
        mObjFachMan.bajaCliente(xObjCLi);
    }

    public void bajaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
        mObjFachMan.bajaCel(xObjPerEx, xObjCel);
    }

    public void bajaCategoria(String NomCat) throws InputException {
        mObjFachMan.bajaCategoria(NomCat);
    }

    public void bajaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
        mObjFachMan.bajaCategoria(xObjCat);
    }

    public void asignarSubProd(Dom_Class_ProductoComp xObjProdCom) throws InputException {
        mObjFachMan.asignarSubProd(xObjProdCom);
    }

    public void altaTel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Tel xObjCel) throws InputException {
        mObjFachMan.altaTel(xObjPerEx, xObjCel);
    }

    public void altaSubProducto(Dom_Class_SubProducto xObjSubP) throws InputException {
        mObjFachMan.altaSubProducto(xObjSubP);
    }

    public void altaSaldo(LogN_ClassAb_Persona xObjPer, Dom_Class_Saldo xObjSaldo) throws InputException {
        mObjFachMan.altaSaldo(xObjPer, xObjSaldo);
    }

    public void altaRecibo(Dom_Class_Resibo xObjRecibo) throws InputException {
        mObjFachMan.altaRecibo(xObjRecibo);
    }

    public void altaProvDep(Dom_Class_Pais xObjPais, Dom_Class_ProvinDepar xObjProvDep) throws InputException {
        mObjFachMan.altaProvDep(xObjPais, xObjProvDep);
    }

    public void altaProv(Dom_Class_Proveedor xObjProv) throws InputException {
        mObjFachMan.altaProv(xObjProv);
    }

    public void altaProductoElav(Dom_Class_ProductoElavo xObjProdElav) throws InputException {
        mObjFachMan.altaProductoElav(xObjProdElav);
    }

    public void altaProductoCom(Dom_Class_ProductoComp xObjProduto) throws InputException {
        mObjFachMan.altaProductoCom(xObjProduto);
    }

    public void altaPersonaEx(LogN_ClassAb_PerExterna xObjPerEx) throws InputException {
        mObjFachMan.altaPersonaEx(xObjPerEx);
    }

    public void altaPais(Dom_Class_Pais xObjPais) throws InputException {
        mObjFachMan.altaPais(xObjPais);
    }

    public void altaMovimiento(LogN_ClassAb_Movimiento xObjMov) throws InputException {
        mObjFachMan.altaMovimiento(xObjMov);
    }

    public void altaMoneda(Dom_Class_Moneda xObjMoneda, boolean xLocal) throws InputException {
        mObjFachMan.altaMoneda(xObjMoneda, xLocal);
    }

    public void altaMail(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Mail xObjCel) throws InputException {
        mObjFachMan.altaMail(xObjPerEx, xObjCel);
    }

    public void altaFax(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Fax xObjCel) throws InputException {
        mObjFachMan.altaFax(xObjPerEx, xObjCel);
    }

    public void altaFactura(LogN_ClassAb_Factura xObjFactura, boolean xPresupuesto) throws InputException {
        mObjFachMan.altaFactura(xObjFactura, xPresupuesto);
    }

    public void altaFacVen(Dom_Class_FacVen xObjFacVen, boolean xPresupuesto) throws InputException {
        mObjFachMan.altaFacVen(xObjFacVen, xPresupuesto);
    }

    public void altaFacCom(Dom_Class_FacCom xObjFacCom) throws InputException {
        mObjFachMan.altaFacCom(xObjFacCom);
    }



    public void altaCliente(Dom_Class_Cliente xObjCLi) throws InputException {
        mObjFachMan.altaCliente(xObjCLi);
    }

    public void altaCel(LogN_ClassAb_PerExterna xObjPerEx, Dom_Class_Cel xObjCel) throws InputException {
        mObjFachMan.altaCel(xObjPerEx, xObjCel);
    }

    public void altaCategoria(Dom_Class_Categoria xObjCat) throws InputException {
        mObjFachMan.altaCategoria(xObjCat);
    }

    public void addObservadorProducto(Observer xObjObser) {
        mObjFachMan.addObservadorProducto(xObjObser);
    }

    public void addObservadorPersona(Observer xObjObser) {
        mObjFachMan.addObservadorPersona(xObjObser);
    }

    public void addObservadorPais(Observer xObjObservador) {
        mObjFachMan.addObservadorPais(xObjObservador);
    }

    public void addObservadorMovimiento(Observer xObjObser) {
        mObjFachMan.addObservadorMovimiento(xObjObser);
    }

    public void addObservadorMoneda(Observer xObjObser) {
        mObjFachMan.addObservadorMoneda(xObjObser);
    }

    public void addObservadorFactura(Observer xObjObser) {
        mObjFachMan.addObservadorFactura(xObjObser);
    }

    public boolean addObservadorCategoria(Observer xObj) {
        return mObjFachMan.addObservadorCategoria(xObj);
    }

    public Dom_Class_Categoria RetornarOCrearCategoria(String NomCat) throws InputException {
        return mObjFachMan.RetornarOCrearCategoria(NomCat);
    }

    public Dom_Class_Categoria RetornarOCrarCategoria(Dom_Class_Categoria xobjCat) throws InputException {
        return mObjFachMan.RetornarOCrarCategoria(xobjCat);
    }

    public Dom_Class_FacVen NuevaFachVen() {
        return mObjFachMan.NuevaFachVen();
    }

    public void ModProv(Dom_Class_Proveedor xObjProvAn, Dom_Class_Proveedor xObjProvNu) throws InputException {
        mObjFachMan.ModProv(xObjProvAn, xObjProvNu);
    }

    public void ModPersonaEx(LogN_ClassAb_PerExterna xObjPerExAn, LogN_ClassAb_PerExterna xObjPerExNu) throws InputException {
        mObjFachMan.ModPersonaEx(xObjPerExAn, xObjPerExNu);
    }

    public void ModCliente(Dom_Class_Cliente xObjCLiAn, Dom_Class_Cliente xObjCLiNu) throws InputException {
        mObjFachMan.ModCliente(xObjCLiAn, xObjCLiNu);
    }

    
    
    
    
    
    
    
    
 
}

  

