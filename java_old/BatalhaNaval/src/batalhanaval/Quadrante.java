/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

/**
 *
 * @author Larissa
 */
public class Quadrante {

    private ParteNavio ocupado;
    private boolean atacado;

    public ParteNavio getOcupado() {
        return ocupado;
    }

    public void setOcupado(ParteNavio ocupado) {
        this.ocupado = ocupado;
    }
    //getOcupado

    public boolean isAtacado() {
        return atacado;
    }

    public void setAtacado(boolean atacado) {
        this.atacado = atacado;

        if (ocupado != null) {
            ocupado.setDestruida(true);
        }
    }
}
