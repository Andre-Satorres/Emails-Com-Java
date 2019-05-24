package bd.dbos;

public class LoginMail 
{
	private String usuario;
	private String senha;
	
	public String getUsuario()
	{
		return this.usuario;
	}
	
	public String getSenha()
	{
		return this.senha;
	}
	
	public void setUsuario(String usuario) throws Exception
	{
		if(usuario == null)
			throw new Exception("Usuario invalido!");
		
		this.usuario = usuario;
	}
	
	public void setSenha(String senha) throws Exception
	{
		if(senha == null)
			throw new Exception("Senha invalida!");
		
		this.senha = senha;
	}
	
	public LoginMail()
	{}
		
	
	public LoginMail(String usuario, String senha)
	{
		if(usuario != null && senha != null)
		{
			this.usuario = usuario;
			this.senha = senha;
		}
	}
	
	public String toString()
	{
		String ret="";
		ret += this.usuario + "; " + this.senha;
		
		return ret;
	}
	
	public int hashCode()
	{
		int ret = 567;
		ret = ret*7 + this.usuario.hashCode();
		ret = ret*7 + this.senha.hashCode();
		
		return ret;
	}
	
	public boolean equals (Object obj)
    {
        if (this==obj)
            return true;

        if (obj==null)
            return false;

        if (!(obj instanceof Email))
            return false;

        LoginMail lm = (LoginMail)obj;
        
        if (!(this.usuario.equals(lm.usuario)))
            return false;
        
        if (!(this.senha.equals(lm.senha)))
            return false;

        return true;
    }
	
	public LoginMail (LoginMail modelo) throws Exception
    {
        this.usuario = modelo.usuario;
        this.senha = modelo.senha; 
    }

    public Object clone ()
    {
        LoginMail ret=null;

        try
        {
            ret = new LoginMail (this);
        }
        catch (Exception erro)
        {}

        return ret;
    }

}
