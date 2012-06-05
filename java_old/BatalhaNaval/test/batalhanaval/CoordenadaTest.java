/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author welliton
 */
public class CoordenadaTest {
    
    @Test
    public void testExtrairVertical() throws Exception {
        Coordenada c = Coordenada.parse("1d|");
        assertEquals(c.getX(), 0);
        assertEquals(c.getY(), 3);
        assertEquals(OrientacaoEnum.VERTICAL, c.getOrientacaoEnum());
    }
}
