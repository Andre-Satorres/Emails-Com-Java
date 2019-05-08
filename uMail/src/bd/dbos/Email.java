package bd.dbos;

public class Email implements Cloneable
{
	private String usuario;
	private String senha;
	private String nome;
	private String sobrenome;
    private int    porta;
    private int    seguranca;
    private int    host;
    static final String pattern = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$";
  
	public int getHost() 
    {
		return host;
	}

	public void setHost(int host) throws Exception 
	{
		if(host == 1 || host == 2 || host == 3)
			this.host = host;
		else
			throw new Exception ("Servidor inválido!");
	}

	public int getSeguranca() 
	{
		return seguranca;
	}

	public void setSeguranca(int seguranca) throws Exception 
	{
		if(seguranca == 1 || seguranca == 2)
			this.seguranca = seguranca;
		else
			throw new Exception("Criptografia inválida!");
	}

	public int getPorta() 
	{
		return porta;
	}

	public void setPorta(int porta) throws Exception 
	{
		if(porta > 0 && porta <= 65536)
			this.porta = porta;
		else
			throw new Exception("Porta inválida!");
	}

	public String getSenha() 
	{
		return senha;
	}

	public void setSenha(String senha) throws Exception 
	{
		if(senha != null && senha.length() >= 8)
			this.senha = senha;
		else
			throw new Exception ("Senha inválida ou pequena demais!");
	}

	public String getUsuario() 
	{
		return usuario;
	}

	public void setUsuario(String usuario) throws Exception
	{
		if(usuario!= null && usuario.matches(pattern))
			this.usuario = usuario;
		else
			throw new Exception ("Usuário inválido!");
	}
    

    public String getNome() 
    {
		return nome;
	}

	public void setNome(String nome) throws Exception 
	{
		if(nome!= null)
			this.nome = nome;
		else
			throw new Exception ("Nome inválido!");
	}

	public String getSobrenome() 
	{
		return sobrenome;
	}

	public void setSobrenome(String sobrenome) throws Exception
	{
		if(sobrenome!= null)
			this.sobrenome = sobrenome;
		else
			throw new Exception ("Sobrenome inválido!");
	}

	public Email (String nome, String sobrenome, String usuario, String senha, int porta, int seguranca, int host) throws Exception
    {
		this.setNome(nome);
		this.setSobrenome(sobrenome);
    	this.setUsuario(usuario);
    	this.setSenha(senha);
    	this.setPorta(porta);
    	this.setHost(host);
    	this.setSeguranca(seguranca);
    }

    public String toString ()
    {
        String ret="";
        
        ret+="Nome.....: "+this.nome       +"\n";
        ret+="Sobrenome: "+this.sobrenome  +"\n";
        ret+="Usuario..: "+this.usuario    +"\n";
        ret+="Senha....: "+this.senha      +"\n";
        ret+="Porta....: "+this.porta      +"\n";
        ret+="Seguranca: "+this.seguranca  +"\n";
        ret+="Servidor.: "+this.host;

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

        Email em = (Email)obj;

        if (this.porta!=em.porta)
            return false;
        
        if (!(this.nome.equals(em.nome)))
            return false;
        
        if (!(this.sobrenome.equals(em.sobrenome)))
            return false;

        if (!(this.usuario.equals(em.usuario)))
            return false;
        
        if (!(this.senha.equals(em.senha)))
            return false;

        if (this.seguranca!= em.seguranca)
            return false;
        
        if (this.host!= em.host)
            return false;

        return true;
    }

    public int hashCode ()
    {
        int ret=666;

        ret = 7*ret + new Integer(this.porta).hashCode();
        ret = 7*ret + new Integer(this.seguranca).hashCode();
        ret = 7*ret + new Integer(this.host).hashCode();
        ret = 7*ret + this.usuario.hashCode();
        ret = 7*ret + this.senha.hashCode();
        ret = 7*ret + this.nome.hashCode();
        ret = 7*ret + this.sobrenome.hashCode();

        return ret;
    }


    public Email (Email modelo) throws Exception
    {
        this.usuario   = modelo.usuario;
        this.seguranca = modelo.seguranca; 
        this.senha     = modelo.senha;
        this.porta     = modelo.porta;
        this.host      = modelo.host;
        this.nome      = modelo.nome;
        this.sobrenome = modelo.sobrenome;
    }

    public Object clone ()
    {
        Email ret=null;

        try
        {
            ret = new Email (this);
        }
        catch (Exception erro)
        {}

        return ret;
    }
}