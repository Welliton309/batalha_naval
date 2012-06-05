/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

/**
 *
 * @author Larissa
 */
import java.util.ArrayList;

public class Navio {

    private String nome;
    private ArrayList<ParteNavio> partes;

    //construtor
    public Navio(String nome) {

        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public ArrayList<ParteNavio> getPartes() {
        return partes;
    }

    public void setPartes(ArrayList<ParteNavio> partes) {
        this.partes = partes;
    }

    public int getTamanho() {
        return partes.size();

    }

    public boolean getDestruido() {
        for (ParteNavio parte : partes) {
            if (parte.isDestruida() == false) {
                return false;
            }
        }
        return true;
    }
}
