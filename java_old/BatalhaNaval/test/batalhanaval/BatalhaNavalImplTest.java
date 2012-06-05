/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author welliton
 */
public class BatalhaNavalImplTest {
 
    @Test
    public void testJogar() throws Exception {
        BatalhaNavalImpl objeto = new BatalhaNavalImpl();
        
        String nome = "Lito";
        List<String> coordenadas = new ArrayList<String>();
        coordenadas.add("1a");
        coordenadas.add("2b");
        coordenadas.add("3c");
        coordenadas.add("4d");
        coordenadas.add("5e");
        
        String id = objeto.jogar(nome, coordenadas);
        assertNotNull(id);
    }
}
