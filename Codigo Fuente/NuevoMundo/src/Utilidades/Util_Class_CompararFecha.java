/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Utilidades;


import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Ary
 */
public class Util_Class_CompararFecha implements Comparator<Date> {

    public int compare(Date t, Date t1) {

        
        GregorianCalendar xt = new GregorianCalendar();
        xt.setTime(t);

        GregorianCalendar xt1 = new GregorianCalendar();
        xt.setTime(t1);

        int Dia_t = xt.get(Calendar.DAY_OF_WEEK);
        int Dia_t1 = xt1.get(Calendar.DAY_OF_WEEK);
        
        int Mes_t = xt.get(Calendar.MONTH);
        int Mes_t1 = xt1.get(Calendar.MONTH);

        int Anio_t = xt.get(Calendar.YEAR);
        int Anio_t1 = xt1.get(Calendar.YEAR);

        // Compara los anios
        if (Anio_t < Anio_t1) return 1;
        else  if (Anio_t > Anio_t1) return -1;
        //Compara los meses
        else  if (Mes_t < Mes_t1) return 1;
        else  if (Mes_t > Mes_t1) return -1;
        //Compara lod dias
        else  if (Dia_t < Dia_t1) return 1;
        else  if (Dia_t > Dia_t1) return -1;
        // Determina que es igual
        return 0;
    }


}