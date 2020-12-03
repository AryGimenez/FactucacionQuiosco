/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Utilidades;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JOptionPane;
import javax.swing.text.JTextComponent;

/**
 *
 * @author Ary
 */
public class Util_Class_Utilitario {

    /**
     * Retorna fase si el mDir ingresado no cumple con los
     * Comprueba que xVal no sea una cadena null o vacía (Sin caracteres que no sean espacios en blanco)
     * @param xVal Cadena de caracteres a Comparar
     * @return flase en caso que la cadena no cumpla con las condiciones y true en caso contrario 
     */
    public static  boolean ValidarString (String xVal){
        if (xVal == null) return false;
        String ValT = xVal.trim();
        if (ValT.equals("")) return false;
        return true;
    }

    /**
     * Determina si se puede pasar la cadena a Long
     * @param xLong
     * @return
     */
    public static boolean Comp_Long (String xLong){
        try{
            long val = Long.parseLong(xLong.trim());
            return true;
        }catch (NumberFormatException ex){
            return false;
        }
    }
    /**
     * Combierte el primer caracter de una cadena a mayuscula y le saca los espacios
     * en blanco a los lados
     * @param s Cadena a modificar
     * @return Cadena modificada
     */
    public static String PasarPM (String s){
        s = s.trim(); //Saca los espacios en blanco a los lados
        if (s.equals("")) return s; // Determina que s no sea una cadena vasia
        String ValM = ("" + s.charAt(0)).toUpperCase(); // Saca el primer caracter de mNom y lo convierte a mayuscula
        return ValM + s.substring(1); // Concatena el primer caracter convertido y el resto del texto
    }




    public static float Redondear_Sifras(int  decimales_a_dejar ,double Ynumero){
        String esqueletoF="#.";

        for(int i=0;i< decimales_a_dejar;i++)esqueletoF+="0";
        
        DecimalFormat formato=new DecimalFormat(esqueletoF);

        return Float.parseFloat(formato.format(Ynumero).replace(",", "."));

    }
    
    public static void SeleccionarTodoTexto(JTextComponent ObjTxt){
         ObjTxt.setSelectionStart(0);
         ObjTxt.setSelectionEnd(ObjTxt.getText().length());
    }

    public static String getFecha (String xTipiado, Date xFecha){
        if (xTipiado == null || xTipiado.trim().equals(""))xTipiado = "dd/MM/yyyy";
        SimpleDateFormat FromFech = new SimpleDateFormat(xTipiado);

        return FromFech.format(xFecha);
    }
}

