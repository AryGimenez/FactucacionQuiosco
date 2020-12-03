/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica_Negocio.Manejadora.Implementados.MYSQL.jTabModel;




import Logica_Negocio.LogN_Inter_DocCon;
import Logica_Negocio.Manejadora.jTabModel.LogN_ClassAb_ModeljTabCuentas;
import Persistencia.Per_Class_ConecElPam;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
     
    public void actualizar (){
        try {
            
            
            mObjMYsql.closeConecction();
            String Con = this.TraducirFlitro();
            if (!Con.equals("")) Con = " WHERE " + Con;
            
            state = (Statement) mObjMYsql.AbrirConection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
           String SetSal= mConSql + Con;
           rec = state.executeQuery(SetSal);
           
           super.fireTableDataChanged();
           
        } catch (SQLException ex) {
          
        }
    }
    
    
    private String TraducirFlitro (){
//        LogN_ClassAb_FilDocCon ObjFil = super.getFiltro();
//
//         
//         String Condicion = "";
//         if (ObjFil instanceof LogN_ClassAb_FilDocCon){
//             LogN_ClassAb_FilDocCon ObjFilF = (LogN_Class_FilFacturaFecha) ObjFil; 
//             ArrayList<java.util.Date> ColF = ObjFilF.getmCondicion();
//             java.sql.Date ObjF1 = new Date (ColF.get(0).getTime())
//                     , ObjF2 = new Date (ColF.get(1).getTime());
//             
//             Condicion = "Fac_Fech >= '" + ObjF1 + "' AND Fac_Fech <= '" + ObjF2 + "'";
//         }


//         return Condicion ;
        return "";
    }
    
}
