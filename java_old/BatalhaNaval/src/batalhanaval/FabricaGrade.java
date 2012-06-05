/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

/**
 *
 * @author Larissa
 */
public class FabricaGrade {

    public static Quadrante[][] construirGrade(int x, int y) {
        Quadrante[][] quadrante = new Quadrante[x][y];
        for (int i = 0; i < x; i++) {
            for (int w = 0; w < y; w++) {
                quadrante[i][w] = new Quadrante();
            }

        }
        return quadrante;

    }
}
