package batalhanaval;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Marcos
 */
public class Regra {

    private int tamanhox;
    private int tamanhoy;
    private List<String>navios;

    public Regra(int tamanhox, int tamanhoy, ArrayList<String> navios) {
        this.tamanhox = tamanhox;
        this.tamanhoy = tamanhoy;
        this.navios = navios;
    }


    public Regra(){
        tamanhox=10;
        tamanhoy=10;
        navios = new ArrayList<String>();
        navios.add(NomesNavio.PORTA_AVIOES);
        navios.add(NomesNavio.FRAGATA);
        navios.add(NomesNavio.CRUZADORES);
        navios.add(NomesNavio.DESTROYER);
        navios.add(NomesNavio.SUBMARINO);
    }

    public List<String> getNavios() {
        return navios;
    }

    public void setNavios(ArrayList<String> navios) {
        this.navios = navios;
    }

    public int getTamanhox() {
        return tamanhox;
    }

    public void setTamanhox(int tamanhox) {
        this.tamanhox = tamanhox;
    }

    public int getTamanhoy() {
        return tamanhoy;
    }

    public void setTamanhoy(int tamanhoy) {
        this.tamanhoy = tamanhoy;
    }




}
