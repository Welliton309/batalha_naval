/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.util.ArrayList;

/**
 *
 * @author Larissa
 */
public class FabricaNavio {

    //Esse metodo e estatico, pode ser acessado como FabricaNavio.construirNavio
    public static Navio construirNavio(String tipo) {

        int tamanho = 0;

        if (tipo.equals(NomesNavio.PORTA_AVIOES)) {
            tamanho = 6;
        } else if (tipo.equals(NomesNavio.FRAGATA)) {
            tamanho = 5;

        } else if (tipo.equals(NomesNavio.CRUZADORES)) {
            tamanho = 4;

        } else if (tipo.equals(NomesNavio.DESTROYER)) {
            tamanho = 3;
        } else if (tipo.equals(NomesNavio.SUBMARINO)) {
            tamanho = 2;
        } else {
            throw new IllegalArgumentException("Tipo inválido");
        }

        Navio navio = new Navio(tipo);
        ArrayList<ParteNavio> partes = new ArrayList<ParteNavio>();

        for (int i = 0; i < tamanho; i++) {
            ParteNavio p = new ParteNavio(navio);
            partes.add(p);
        }

        navio.setPartes(partes);
        return navio;
    }
}
