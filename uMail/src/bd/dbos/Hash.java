package bd.dbos;

public class Hash 
{
	private String usuario;
	private String conta;
	private String hash;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getConta() {
		return conta;
	}
	public void setConta(String conta) {
		this.conta = conta;
	}
	public String getHash() {
		return hash;
	}
	public void setHash(String hash) {
		this.hash = hash;
	}
	
	public Hash()
	{}
	
	public Hash(String usuario, String hash, String conta) 
	{
		super();
		this.usuario = usuario;
		this.conta = conta;
		this.hash = hash;
	}
	
	@Override
	public String toString() {
		return "key_user [usuario=" + usuario + ", conta=" + conta + ", hash=" + hash + "]";
	}
	@Override
	public int hashCode() 
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((hash == null) ? 0 : hash.hashCode());
		result = prime * result + ((conta == null) ? 0 : conta.hashCode());
		result = prime * result + ((usuario == null) ? 0 : usuario.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) 
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Hash))
			return false;
		Hash other = (Hash) obj;
		if (hash == null) {
			if (other.hash != null)
				return false;
		} else if (!hash.equals(other.hash))
			return false;
		if (conta == null) {
			if (other.conta != null)
				return false;
		} else if (!conta.equals(other.conta))
			return false;
		if (usuario == null) {
			if (other.usuario != null)
				return false;
		} else if (!usuario.equals(other.usuario))
			return false;
		return true;
	}
}
