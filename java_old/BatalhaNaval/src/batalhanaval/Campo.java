/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

//import batalhanaval.Quadrante;
import java.util.ArrayList;

/**
 *
 * @author Larissa
 */
public class Campo {

    private Quadrante grade[][];
    private ArrayList<Navio> navios;

    public Campo(Quadrante grade[][]) {
        this.grade = grade;
        this.navios = new ArrayList<Navio>();
    }
    //Padrão de projeto expert information 

    public void posicionarNavio(Navio navio, Coordenada coordenada) {

        int x = coordenada.getX();
        int y = coordenada.getY();
        ArrayList<ParteNavio> partes = navio.getPartes();
        if (coordenada.getOrientacaoEnum().equals(OrientacaoEnum.HORIZONTAL)) {
            for (int i = 0; i < navio.getTamanho(); i++) {
                grade[x][y + i].setOcupado(partes.get(i));
            }
        } else if (coordenada.getOrientacaoEnum().equals(OrientacaoEnum.VERTICAL)) {
            for (int i = 0; i < navio.getTamanho(); i++) {
                grade[x + i][y].setOcupado(partes.get(i));
            }
        }
        getNavios().add(navio);
    }

    public String atacar(int x, int y) {
        String mensagem = "";
        Quadrante quadrante = grade[x][y];
        quadrante.setAtacado(true);
        ParteNavio parteNavio = quadrante.getOcupado();
        if (parteNavio != null) {
            mensagem = "Um Navio inimigo foi atingido durante o ataque";
            Navio navio = parteNavio.getPertence();
            if (navio.getDestruido()) {
                mensagem = "O navio " + navio.getNome() + " foi destruido";
            }
        } else {
            mensagem = "Nenhum navio foi atingido durante o ataque";
        }
        return mensagem;
    }

    public ArrayList<Navio> getNavios() {
        return navios;
    }

    public void setNavios(ArrayList<Navio> navios) {
        this.navios = navios;
    }

    
    public String imprimirCampo() {
        String saida = "\n";
        String header = "     ";
        int count = 1;
        for (int i = 0; i < grade.length; ++i) {
            saida += String.format("%2d ", count);
            header += String.format("%s   ", Coordenada.num2char(count - 1));
            count += 1;
            for (int j = 0; j < grade.length; ++j) {
                String c;
                Quadrante q = grade[i][j];
                if (q.getOcupado() == null) {
                    if (q.isAtacado()) {
                        c = " O ";
                    } else {
                        c = "   ";
                    }
                } else {
                    if (q.isAtacado()) {
                        c = "[X]";
                    } else {
                        c = "[ ]";
                    }
                }
                saida += String.format("|%s", c);
            }
            saida += "|\n";
        }
        return header + saida;
    }

    public String imprimirRival() {
        String saida = "\n";
        String header = "     ";
        int count = 1;
        for (int i = 0; i < grade.length; ++i) {
            saida += String.format("%2d ", count);
            header += String.format("%s   ", Coordenada.num2char(count - 1));
            count += 1;
            for (int j = 0; j < grade.length; ++j) {
                String c;
                Quadrante q = grade[i][j];
                if (q.isAtacado()) {
                    if (q.getOcupado() == null) {
                        c = "O";
                    } else {
                        c = "X";
                    }
                } else {
                    c = " ";
                }
                saida += String.format("| %s ", c);
            }
            saida += "|\n";
        }
        return header + saida;
    }
    
    public Quadrante[][] getGrade() {
        return grade;
    }
}
