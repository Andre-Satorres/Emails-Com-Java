package bd.dbos;

public class Seguranca 
{
	private int id;
	private String nome;
	
	public int getId()
	{
		return this.id;
	}
	
	public String getNome()
	{
		return this.nome;
	}
	
	public void setId(int id) throws Exception
	{
		if(id == 1 || id==2)
			this.id = id;
		else
			throw new Exception("Id invalido!");
	
	}
	
	public void setNome(String nome) throws Exception
	{
		if(nome != null)
			this.nome= nome;
		else
			throw new Exception("Nome invalido!");
	}
	
	public Seguranca()
	{}
	
	public Seguranca(int id, String nome) throws Exception
	{
		if(id == 1|| id ==2)
			this.id = id;
		else
			throw new Exception("Id invalido!");
		
		if(nome == null)
			throw new Exception("Nome invalido!");
		
		if(!(nome.equalsIgnoreCase("tls")) && !(nome.equalsIgnoreCase("ssl")))
			throw new Exception ("Nome invalido!!");
		
		this.nome = nome;
	}
	
	public String toString()
	{
		return "{Id: " + id + "; nome:" + nome + "}";
	}
	
	public int hashCode()
	{
		int ret = 7;
		
		ret = ret*7 + id;
		return (ret*7 + new Integer(this.nome.hashCode()));
	}
	
	public boolean equals(Object obj)
	{
		if(this==obj)
			return true;
		
		if(obj == null)
			return false;
		
		if(!(this.getClass().equals(obj.getClass())))
			return false;
		
		Seguranca hst = (Seguranca)obj;
		
		if(this.id != hst.id)
			return false;
		
		if(!(this.nome.equals(hst.getNome())))
			return false;
		
		return true;
	}
	
	public Seguranca(Seguranca modelo) throws Exception
	{
		if(modelo == null)
			throw new Exception ("Modelo invalido");
		
		this.id = modelo.id;
		this.nome = modelo.nome;
	}
	
	public Object clone()
	{
		Seguranca ret = null;
		
		try
		{
			ret = new Seguranca(this);
		}
		catch(Exception e)
		{}
		
		return ret;
	}
}
