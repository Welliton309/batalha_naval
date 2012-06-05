package batalhanaval;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

public interface IBatalhaNaval extends Remote{
	
	public String jogar(String nome, List<String> cordenadas) throws RemoteException;

	public String atacar(String id, String nome, String cordenadas) throws RemoteException;
	
	public String imprimirCampos(String id, String nome) throws RemoteException;

        public List<String> getOrdemNavios()throws RemoteException;
        
        public boolean isAtivo(String id) throws RemoteException;

}