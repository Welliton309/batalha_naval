/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.util.List;

/**
 *
 * @author Larissa
 */
public class Jogador {

    private String nome;
    private Campo campo;

    public Jogador(String nome, Campo campo) {
        this.campo = campo;
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;

    }

    public Campo getGrade() {
        return campo;
    }

    public void setGrade(Campo campo) {
        this.campo = campo;
    }

    public String receberAtaque(int x, int y) {
        return campo.atacar(x, y);

    }

    public boolean isPerdeu() {
        boolean perdeu = true;
        List<Navio> navios = campo.getNavios();
        for (Navio navio : navios) {
            if (!navio.getDestruido()) {
                perdeu = false;
                break;
            }

        }
        return perdeu;
    }

    public String imprimirCampo(String nome) {
        if (this.nome.equals(nome)) {
            return this.campo.imprimirCampo();
        } else {
            return this.campo.imprimirRival();
        }
    }
}
