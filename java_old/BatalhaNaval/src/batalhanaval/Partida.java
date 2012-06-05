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
public class Partida {

    private Jogador jogador1;
    private Jogador jogador2;
    private Regra regra;
    private boolean ativa;

    public Partida(Regra regra) {
        ativa = false;
        this.regra = regra;
    }

    private Jogador iniciarJogador(String nome, List<String> coordenadas) throws Exception {
        Campo campo = criarCampo();
        iniciarCampo(campo, coordenadas);
        return new Jogador(nome, campo);
    }

    public void iniciarCampo(Campo campo, List<String> coordenadas) throws Exception {
        List<String> list = regra.getNavios();
        for (int i = 0; i < list.size(); ++i) {
            String tipoNavio = list.get(i);
            Navio navio = FabricaNavio.construirNavio(tipoNavio);
            Coordenada coordenada = Coordenada.parse(coordenadas.get(i));
            campo.posicionarNavio(navio, coordenada);
        }
    }

    private Campo criarCampo() {
        int x = regra.getTamanhox();
        int y = regra.getTamanhoy();
        Quadrante[][] grade = FabricaGrade.construirGrade(x, y);

        return new Campo(grade);
    }

    // OK
    public void entrar(String nome, List<String> coordenadas) throws Exception {
        if (jogador1 == null) {
            jogador1 = iniciarJogador(nome, coordenadas);
        } else if (jogador2 == null) {
            jogador2 = iniciarJogador(nome, coordenadas);
        } else {
            throw new Exception("Apenas dois jogadores por partida");
        }
    }

    // OK
    public String atacar(String nome, String coordenada) throws Exception {
        String mensagem;
        if (ativa) {
            Jogador jogador = getJogadorRival(nome);
            Coordenada c = Coordenada.parse(coordenada);
            mensagem = jogador.receberAtaque(c.getX(), c.getY());
            mensagem += verificarPartida(nome);
        } else {
            mensagem = "O JOGO ACABOU!";
        }
        return mensagem;
    }

    private Jogador getJogadorRival(String nome) throws Exception {
        if (jogador1.getNome().equals(nome)) {
            return jogador2;
        } else if (jogador2.getNome().equals(nome)) {
            return jogador1;
        } else {
            throw new Exception("Jogador Inválido");
        }
    }

    private String verificarPartida(String nome) throws Exception {
        if (getJogador(nome).isPerdeu()) {
            ativa = false;
            return "VOCE PERDEU!!!!!!";

        } else if (getJogadorRival(nome).isPerdeu()) {
            ativa = false;
            return "VOCE GANHOU!!!!!!";
        }
        return "";
    }

    private Jogador getJogador(String nome) throws Exception {
        if (jogador1.getNome().equals(nome)) {
            return jogador1;
        } else if (jogador2.getNome().equals(nome)) {
            return jogador2;
        } else {
            throw new Exception("Jogador Inválido");
        }

    }

    public String imprimirCampos(String nome) throws Exception {
        String saida = "Seu campo:\n\n";
        saida += getJogador(nome).imprimirCampo(nome);
        saida += "\nCampo inimigo: \n\n";
        saida += getJogadorRival(nome).imprimirCampo(nome);
        return saida;
    }

    public boolean isAtiva() {
        return ativa;
    }

    public void iniciar() {
        ativa = true;
    }
}
