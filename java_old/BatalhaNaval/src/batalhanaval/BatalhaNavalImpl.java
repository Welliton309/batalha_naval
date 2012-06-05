package batalhanaval;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BatalhaNavalImpl extends UnicastRemoteObject implements IBatalhaNaval {

    private Partida partidaEspera;
    private String idPartida;
    private Map<String, Partida> partidas;
    private Regra regra;
    private ArrayList<String> partidasEspera;
    private boolean debug = false;

    public BatalhaNavalImpl() throws RemoteException {
        partidaEspera = null;
        idPartida = null;
        partidas = new HashMap<String, Partida>();
        regra = new Regra();
        partidasEspera = new ArrayList<String>();
    }

    public String jogar(String nome, List<String> coordenadas) throws RemoteException {
        try {
            if (partidaEspera == null) {
                partidaEspera = new Partida(regra);
                idPartida = String.valueOf(partidas.keySet().size());
                partidas.put(idPartida, partidaEspera);
                debug("Partida " + idPartida + " criada por " + nome);
                entrar(nome, coordenadas);
            } else {
                entrar(nome, coordenadas);
                partidaEspera.iniciar();
                debug("Partida " + idPartida + " iniciada por " + nome);
                partidaEspera = null;
            }
            esperarJogador(idPartida);
            return idPartida;
        } catch (Exception ex) {
            debug(ex.getMessage());
            throw new RemoteException(ex.getMessage());
        }
    }

    private synchronized void entrar(String nome, List<String> coordenadas) throws Exception {
        partidaEspera.entrar(nome, coordenadas);
    }

    private void esperarJogador(String idPartida) throws InterruptedException {
        try {
            if (partidasEspera.contains(idPartida)) {
                int i = partidasEspera.indexOf(idPartida);
                partidasEspera.remove(i);
            } else {
                partidasEspera.add(idPartida);
                while (partidasEspera.contains(idPartida)) {
                    Thread.sleep(1000);
                    debug("Esperando...");
                }
            }
        }  catch (Exception ex) {
            debug("#esperarJogador: " + ex.getMessage());
        }
    }

    public String atacar(String id, String nome, String coordenada) throws RemoteException {
        try {
            debug("Partida " + id + ": Jogador " + nome + " atacou as coordenadas " + coordenada);
            Partida partida = getPartida(id);
            String mensagem;
            synchronized (this) {
                mensagem = partida.atacar(nome, coordenada);
            }
            esperarJogador(id);
            return mensagem;
        } catch (Exception ex) {
            Writer writer = new StringWriter();
            ex.printStackTrace(new PrintWriter(writer));
            debug("#atacar: " + writer.toString());
            throw new RemoteException(ex.getMessage());
        }
    }

    public String imprimirCampos(String id, String nome) throws RemoteException {
        try {
            String campos = getPartida(id).imprimirCampos(nome);
            return campos;
        } catch (Exception ex) {
            debug("#imprimirCampos: " + ex.getMessage());
            throw new RemoteException(ex.getMessage());
        }
    }

    private Partida getPartida(String id) {
        return partidas.get(id);

    }

    public List<String> getOrdemNavios() throws RemoteException {
        return regra.getNavios();
    }

    public boolean isAtivo(String id) throws RemoteException {
        return getPartida(id).isAtiva();
    }

    void setDebug(boolean b) {
        this.debug = b;
    }

    private void debug(String string) {
        if (debug) {
            System.err.println(string);
        }
    }
}
