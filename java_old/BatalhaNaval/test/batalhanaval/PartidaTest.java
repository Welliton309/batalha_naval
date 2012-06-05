/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

/**
 *
 * @author welliton
 */
public class PartidaTest {
    
    @Test
    public void testAtacar() throws Exception {
        Partida p = new Partida(new Regra());
        String nome1 = "Bill";
        String nome2 = "Steve";
        
        List<String> coordenadas = new ArrayList<String>();
        coordenadas.add("1a");
        coordenadas.add("2b");
        coordenadas.add("3c");
        coordenadas.add("4d");
        coordenadas.add("5e");
        
        p.entrar(nome1, coordenadas);
        p.entrar(nome2, coordenadas);
        
        p.iniciar();
        
        String mensagem = p.atacar(nome1, "1a");
        System.out.println(mensagem);
        
        String campos = p.imprimirCampos(nome1);
        System.out.println(campos);
        
        mensagem = p.atacar(nome2, "2b");
        System.out.println(mensagem);
        
        campos = p.imprimirCampos(nome2);
        System.out.println(campos);
    }
}
