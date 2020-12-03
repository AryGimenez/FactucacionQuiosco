/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Utilidades;

import java.awt.event.FocusEvent;
import javax.swing.JFormattedTextField;

/**
 *
 * @author horacio
 */
public class JFormattedText extends JFormattedTextField {
    public JFormattedText(AbstractFormatter formatter) {
        super(formatter);
    }

    public JFormattedText(){
        super();
    }

    @Override
    protected void processFocusEvent(FocusEvent e) {
        super.processFocusEvent(e);
        if (!e.isTemporary()) {
            selectAll();
        }
    }

}
