package bd.dbos;

public class Email implements Cloneable
{
	private String    usuario;
	private String    senha;
	private String    nome;
	private String    sobrenome;
    private int       porta;
    private Seguranca seguranca; //tls, ssl
    private Host      host;      // pop3, imap, smtp
    private String    servidor; // gmail.com --> dominio
    
    static final String pattern = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$";
  
	public Host getHost() 
    {
		return host;
	}
	
	public void setHost(Host host) throws Exception 
	{
		if(host == null)
			throw new Exception("Host invalido!");
		
		this.host = host;
	}
	
	public String getServidor() 
    {
		return servidor;
	}
	
	public void setServidor(String server) throws Exception 
	{
		if(server == null)
			throw new Exception("Servidor invalido!");
		
		this.servidor = server;
	}

	public Seguranca getSeguranca() 
	{
		return seguranca;
	}
	
	public void setSeguranca(Seguranca seguranca) throws Exception 
	{
		if(seguranca == null)
			throw new Exception("Seguranca inv�lida!");
		
		this.seguranca = seguranca;
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
			throw new Exception("Porta inv�lida!");
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
			throw new Exception ("Senha inv�lida ou pequena demais!");
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
			throw new Exception ("Usu�rio inv�lido!");
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
			throw new Exception ("Nome inv�lido!");
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
			throw new Exception ("Sobrenome inv�lido!");
	}

	public Email (String nome, String sobrenome, String usuario, String senha, int porta, Seguranca seguranca, Host host, String servidor) throws Exception
    {
		this.setNome(nome);
		this.setSobrenome(sobrenome);
    	this.setUsuario(usuario);
    	this.setSenha(senha);
    	this.setPorta(porta);
    	this.setHost(host);
    	this.setSeguranca(seguranca);
    	this.setServidor(servidor);
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
        ret+="Servidor.: "+this.servidor   +"\n";
        ret+="Host.....: "+this.host;

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

        if (!(this.seguranca.equals(em.seguranca)))
            return false;
        
        if (!(this.host.equals(em.host)))
            return false;
        
        if (!(this.servidor.equals(em.servidor)))
            return false;

        return true;
    }

    public int hashCode ()
    {
        int ret=666;

        ret = 7*ret + new Integer(this.porta).hashCode();
        ret = 7*ret + this.seguranca.hashCode();
        ret = 7*ret + this.host.hashCode();
        ret = 7*ret + this.usuario.hashCode();
        ret = 7*ret + this.senha.hashCode();
        ret = 7*ret + this.nome.hashCode();
        ret = 7*ret + this.sobrenome.hashCode();
        ret = 7*ret + this.servidor.hashCode();

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
        this.servidor  = modelo.servidor;
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