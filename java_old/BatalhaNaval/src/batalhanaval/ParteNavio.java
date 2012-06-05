/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package batalhanaval;

/**
 *
 * @author Larissa
 */
public class ParteNavio {
    private boolean destruida;
    private Navio pertence;


    //construtor
    public ParteNavio(Navio pertence){
        this.pertence= pertence;
        destruida = false;
    }





    public boolean isDestruida() {
        return destruida;
    }

    public void setDestruida(boolean destruida) {
        this.destruida = destruida;
    }

    /**
     * @return the pertence
     */
    public Navio getPertence() {
        return pertence;
    }

    /**
     * @param pertence the pertence to set
     */
    public void setPertence(Navio pertence) {
        this.pertence = pertence;
    }


}
