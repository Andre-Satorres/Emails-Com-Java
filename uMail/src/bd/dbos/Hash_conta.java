package bd.dbos;

public class Hash_conta 
{
	private String conta;
	private String hash;
	
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
	
	public Hash_conta()
	{}
	
	public Hash_conta(String hash, String conta) 
	{
		super();
		this.conta = conta;
		this.hash = hash;
	}
	
	@Override
	public String toString() {
		return "key_user [conta=" + conta + ", hash=" + hash + "]";
	}
	@Override
	public int hashCode() 
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((hash == null) ? 0 : hash.hashCode());
		result = prime * result + ((conta == null) ? 0 : conta.hashCode());
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
		Hash_conta other = (Hash_conta) obj;
		if (hash == null) 
		{
			if (other.hash != null)
				return false;
		} 
		else if (!hash.equals(other.hash))
			return false;
		
		if (conta == null) 
		{
			if (other.conta != null)
				return false;
		} 
		else if (!conta.equals(other.conta))
			return false;

		return true;
	}
	
	public Object clone()
	{
		Hash_conta hash = null;
		
		try
		{
			hash = new Hash_conta(this);
		}
		catch(Exception e)
		{}
		
		return hash;
	}
	
	public Hash_conta(Hash_conta hash) throws Exception
	{
		this.conta = hash.conta;
		this.hash = hash.hash;
	}
}
