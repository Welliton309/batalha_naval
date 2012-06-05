/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.util.Random;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author welliton
 */
public class BatalhaNavalClientTest {

    @Test
    public void testAtacar() throws Exception {
        JogadorRun r1 = new JogadorRun("Steve");
        Thread t1 = new Thread(r1);
        t1.start();
        
        JogadorRun r2 = new JogadorRun("Bill");
        Thread t2 = new Thread(r2);
        t2.start();
        
        t1.join();
        t2.join();
        
        assertTrue(r1.isOk());
        assertTrue(r2.isOk());
    }
}

class JogadorRun implements Runnable {

    private boolean ok = false;
    private String nome;
    
    public JogadorRun(String nome) {
        this.nome = nome;
    }
    
    public void run() {
        try {
            BatalhaNavalCliente c1 = criarCliente(nome);
            c1.atacar("a1");
            ok = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    public boolean isOk() {
        return ok;
    }

    private BatalhaNavalCliente criarCliente(String nome) throws Exception {
        String url = "//localhost:1099/batalhanaval";
        BatalhaNavalCliente objeto = new BatalhaNavalCliente(url);
        objeto.adicionarCoordenadas("1a");
        objeto.adicionarCoordenadas("2b");
        objeto.adicionarCoordenadas("3c");
        objeto.adicionarCoordenadas("4d");
        objeto.adicionarCoordenadas("5e");

        objeto.jogar(nome);
        return objeto;
    }
}