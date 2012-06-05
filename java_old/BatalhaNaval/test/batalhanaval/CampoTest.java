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
public class CampoTest {

    @Test
    public void testPosicionarNavioVertical() {
        Quadrante[][] grade = FabricaGrade.construirGrade(10, 10);
        Campo campo = new Campo(grade);
        Navio n = FabricaNavio.construirNavio(NomesNavio.FRAGATA);
        Coordenada coordenada = new Coordenada(0, 0, OrientacaoEnum.VERTICAL);
        campo.posicionarNavio(n, coordenada);
        int i = 0;
        for (ParteNavio pn : n.getPartes()) {
            assertNotNull(String.format("%d %d", i,0), campo.getGrade()[i][0].getOcupado());
            i += 1;
        }
    }
}
