/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Larissa
 */
public class BatalhaNavalCliente {

    private List<String> ordemNavios;
    private List<String> coordenadas;
    private List<String> campos;
    private List<String> mensagens;
    private IBatalhaNaval batalhaNaval;
    private String id;
    private String nome;
    private boolean jogoAtivo;
    
    public BatalhaNavalCliente(String url) throws NotBoundException, MalformedURLException, RemoteException {
        batalhaNaval = (IBatalhaNaval) Naming.lookup(url);
        ordemNavios = batalhaNaval.getOrdemNavios();
        coordenadas = new ArrayList<String>(ordemNavios.size());
        mensagens = new ArrayList<String>();
        campos = new ArrayList<String>();
        jogoAtivo = false;
    }
    
    public void jogar(String nome) throws Exception {
        if (ordemNavios.size() != coordenadas.size()) {
            throw new Exception("É necessário adicionar mais navios");
        }
        this.nome = nome;
        this.id = batalhaNaval.jogar(nome, coordenadas);
        jogoAtivo = batalhaNaval.isAtivo(id);
        campos.add(batalhaNaval.imprimirCampos(id, nome));
    }
    
    public void adicionarCoordenadas(String coordenada) throws Exception {
        if (ordemNavios.size() == coordenadas.size()) {
            throw new Exception("Todos os navios foram adicionados.");
        }
        coordenadas.add(coordenada);
    }
    
    public void atacar(String coordenada) throws RemoteException {
        String mensagem = batalhaNaval.atacar(id, nome, coordenada);
        mensagens.add(mensagem);
        
        String campo = batalhaNaval.imprimirCampos(id, nome);
        campos.add(campo);
        jogoAtivo = batalhaNaval.isAtivo(id);
    }

    public List<String> getCampos() {
        return campos;
    }


    public List<String> getMensagens() {
        return mensagens;
    }
    
    public boolean isAtivo() {
        return jogoAtivo;
    }
    
    public List<String> getOrdemNavios() {
        return ordemNavios;
    }
    
    public String getUltimaMensagem() {
        return mensagens.get(mensagens.size() - 1);
    }
    
    public String getUltimoCampo() {
        return campos.get(campos.size() - 1);
    }
    
}
