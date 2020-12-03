/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL.jTabModel;




import Logica_Negocio.Filtros.DocCont.LogN_ClassAb_FilDocCon;
import Logica_Negocio.LogN_ClassAb_Persona;
import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;
import Persistencia.Per_Class_ConecElPam;
import Precentacion.LogN_Class_Accion;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;



/**
 *
 * @author Ary
 */
public class LogN_Class_ModeljTabCuentasMySql extends LogN_ClassAb_ModeljTabCuentas{
    private static  String mConSql = null;
    private Statement state ;
    private ResultSet rec;
    private Per_Class_ConecElPam mObjMYsql = new Per_Class_ConecElPam();
    private int filas = 0;
    private ArrayList <LogN_ClassAb_FilDocCon> mColDocCont = new ArrayList<>();

    public LogN_Class_ModeljTabCuentasMySql() {
        super();
        
        
        
        
        try {
            CargarCondicionSql();
            actualizar();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(LogN_Class_ModeljTabCuentasMySql.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(LogN_Class_ModeljTabCuentasMySql.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private static String  CargarCondicionSql () throws FileNotFoundException, IOException{
        if (mConSql == null)mConSql = getConSql();
        return mConSql;
    }
    
    private static String getConSql () throws FileNotFoundException, IOException{
        String xConSql = "";

        FileReader Fr = new FileReader("SQL/Pat_Empresa.sql");
        BufferedReader Br = new BufferedReader(Fr);
        String Linea = null;
        while ((Linea = Br.readLine()) != null)
            xConSql += Linea + "\n";
        System.out.print(xConSql);
        return xConSql;
        
    }

    @Override
    public LogN_Inter_DocCon getDocCon(int rowIndes) {
        return null;
    }

    @Override
    public ArrayList<LogN_Inter_DocCon> listarDocCon() {
        return null;
    }

    @Override
    public int getRowCount() {
        try {
            rec.last();
            this.filas = rec.getRow();
        }
        catch (SQLException e) {}
     
        return filas;
    }

    @Override
    public Object getValueAt(int r, int c) {
        Object x=null;
        try {
            rec.absolute(r+1);
            switch (c){
                case 0:
                    x = rec.getString("Doc_Tipo");
                    break;
                case 1:
                    x = rec.getString("Doc_Cod");
                    break;
                case 2:
                    
                    x = rec.getString("Per_Tip") + " || Cod: " +
                            rec.getInt("Per_Num") + 
                            " || " + rec.getString("Per_RasSos");
                    break;
                case 3:
                    x = rec.getTimestamp("Doc_Emision");
                    break;
                case 4:
                    x = rec.getFloat("Doc_Caja");
                    break;
                case 5:
                    x = rec.getString("Doc_Credito");
                    break;    
            }
            
    	}
        catch (SQLException e){}
    	return x;
    }
     
    @Override
    public void actualizar (){
        try {
            
            
            mObjMYsql.closeConecction();
            String Con = this.getCondicion();

            
            state = (Statement) mObjMYsql.AbrirConection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
           String SetSal= mConSql + Con;
           rec = state.executeQuery(SetSal);
           
           super.fireTableDataChanged();
           
        } catch (SQLException ex) {
          
        }
    }
    
    
    
    
    private String getCondicion (){
        String xCondicion, xY;
        xCondicion = "";
        xY = "";
        for (LogN_ClassAb_FilDocCon xObjFil : mColDocCont){
            xCondicion  += xY;
            xCondicion = traducirFlitro(xObjFil);
            xY = " AND ";
        }
        
        if(!xCondicion.equals(""))
            xCondicion = " WHERE " + xCondicion;
        
        return xCondicion;
    }
    
    private String traducirFlitro (LogN_ClassAb_FilDocCon xObjFilDocCont){
        
        if (xObjFilDocCont instanceof LogN_ClassAb_FilDocCon){
            LogN_ClassAb_Persona xObjPer = (LogN_ClassAb_Persona) xObjFilDocCont.getmCondicion();
            
        }
            
        return "";
    }
    
    public void altaFiltro (LogN_ClassAb_FilDocCon xObjFilDocCont){
        if (xObjFilDocCont == null)
            return;
        if (existeFilt(xObjFilDocCont))
            return;
        mColDocCont.add(xObjFilDocCont);
        
        actualizar();
    }
 
    public void bajaFiltro (LogN_ClassAb_FilDocCon xObjFilDocCont){
        if (xObjFilDocCont == null)
            return;
        if (!existeFilt(xObjFilDocCont))
            return;
        mColDocCont.remove(xObjFilDocCont);
        
        actualizar();
    }
    
    public boolean existeFilt (LogN_ClassAb_FilDocCon pObjFilDocCont){
        if (pObjFilDocCont == null)
            return false;
        
        for (LogN_ClassAb_FilDocCon xObjDocCont : mColDocCont)
            if (xObjDocCont.getClass().equals(pObjFilDocCont))
                return true;
        
        return false;
    }
    
    

    @Override
    public void update(Observable o, Object arg) {
        
        if (! (arg instanceof LogN_Class_Accion))
            return;
        LogN_Class_Accion xObjAccion = (LogN_Class_Accion)arg;
        
        if (xObjAccion.getmAccionar() instanceof LogN_Inter_DocCon){
            this.actualizar();
        }
        
        
        
            
    }
    
}
