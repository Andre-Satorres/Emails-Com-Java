package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Emails
{
	
    public static boolean cadastrado (String usuario, String conta) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL " +
                  "WHERE USUARIO = ? and conta = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, conta);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar email.");
        }

        return retorno;
    }

    public static void incluir (Email email) throws Exception
    {
        if (email == null)
            throw new Exception ("Email nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO Email " +
            	  "(Usuario, senha, porta, seguranca, host, nome, sobrenome, servidor, conta, portaSMTP, autenticado)" +
                  "VALUES " +
                  "(?,?,?,?,?,?,?,?,?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString (1, email.getUsuario  ());
            BDSQLServer.COMANDO.setString (2, email.getSenha    ());
            BDSQLServer.COMANDO.setInt    (3, email.getPortaRecepcao());
            BDSQLServer.COMANDO.setInt    (4, email.getSeguranca().getId());
            BDSQLServer.COMANDO.setInt    (5, email.getHost     ().getId());
            BDSQLServer.COMANDO.setString (6, email.getNome     ());
            BDSQLServer.COMANDO.setString (7, email.getSobrenome());
            BDSQLServer.COMANDO.setString (8, email.getServidor());
            BDSQLServer.COMANDO.setString (9, email.getConta().getUsuario());
            BDSQLServer.COMANDO.setInt    (10,email.getPortaEnvio());
            BDSQLServer.COMANDO.setInt    (11,email.getAutenticado());
            
            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir email.");
        }
    }

    public static void excluir (String usuario, String conta) throws Exception
    {
        if (!cadastrado (usuario, conta))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM Email " +
                  "WHERE USUARIO=? and CONTA = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, conta);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir email.");
        }
    }
    
    public static void alterarSenha (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET senha=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getSenha());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar senha!");
        }
    }
    
    public static void alterar (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET senha=?, porta=?, seguranca=?, host=?, nome=?, sobrenome=?, portaSMTP=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getSenha());
            BDSQLServer.COMANDO.setInt    (2, email.getPortaR());
            BDSQLServer.COMANDO.setInt    (3, email.getSeguranca().getId());
            BDSQLServer.COMANDO.setInt    (4, email.getHost().getId());
            BDSQLServer.COMANDO.setString (5, email.getNome());
            BDSQLServer.COMANDO.setString (6, email.getSobrenome());
            BDSQLServer.COMANDO.setInt    (7, email.getPortaE());
            BDSQLServer.COMANDO.setString (8, email.getUsuario());
            BDSQLServer.COMANDO.setString (9, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar informações!");
        }
    }
    
    public static void alterarPortaRecepcao (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET porta=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getPortaRecepcao());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar porta!");
        }
    }
    
    public static void alterarPortaEnvio (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET portaSMTP=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getPortaEnvio());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar porta!");
        }
    }
    
    public static void alterarSeguranca (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET seguranca=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, email.getSeguranca().getId());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar a segurança!");
        }
    }
    
    public static void alterarHost (Email email) throws Exception //HOST = POP3, IMAP ou SMTP 
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(),email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET host=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getHost().getId());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar host!");
        }
    }
    
    public static void alterarServidor (Email email) throws Exception //SERVIDOR = gmail.com = dominio
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET servidor=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getServidor());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar servidor!");
        }
    }
    
    
    public static void alterarNome (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET nome=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getNome());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar nome!");
        }
    }
    
    public static void alterarSobrenome (Email email) throws Exception 
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET sobrenome=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getSobrenome());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar sobrenome!");
        }
    }
    
    public static void autenticar (Email email) throws Exception 
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario(), email.getConta().getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET autenticado=? " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getAutenticado());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());
            BDSQLServer.COMANDO.setString (3, email.getConta().getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar sobrenome!");
        }
    }
    
    public static void autenticar (String email, String conta) throws Exception 
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email, conta))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET autenticado=1 " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email);
            BDSQLServer.COMANDO.setString (2, conta);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar sobrenome!");
        }
    }
   
    public static Email getEmail (String usuario, String conta) throws Exception
    {
        Email email = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Email " +
                  "WHERE USUARIO = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, conta);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            email = new Email (resultado.getString("usuario"), resultado.getString("SENHA"), resultado.getInt   ("Porta"), resultado.getInt   ("PortaSMTP"), Segurancas.getSeguranca(resultado.getInt("Seguranca")), 
            		Hosts.getHost(resultado.getInt ("HOST")), resultado.getString("nome"), resultado.getString("sobrenome"), resultado.getString("servidor"), LoginMails.getUsuario(resultado.getString("conta")),
            		resultado.getInt("autenticado"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar email.");
        }

        return email;
    }
    
    public static MeuResultSet contaTemEmails(String conta) throws Exception
	{
		MeuResultSet resultado = null;
		
		try
		{
			String sql;
			
			sql = "SELECT * " + "FROM EMAIL " + "WHERE CONTA = ? and autenticado = 1";	
			
			BDSQLServer.COMANDO.prepareStatement(sql);
			
			BDSQLServer.COMANDO.setString (1, conta);
			
			resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();
		}
		catch(SQLException erro)
		{
			throw new Exception("Erro ao procurar emails não autenticados da conta.");
		}
		
		return resultado;
	}
    
    public static MeuResultSet naoAutenticadosDaConta(String conta) throws Exception
	{
		MeuResultSet resultado = null;
		
		try
		{
			String sql;
			
			sql = "SELECT * " + "FROM EMAIL " + "WHERE CONTA = ? and autenticado=0";	
			
			BDSQLServer.COMANDO.prepareStatement(sql);
			
			BDSQLServer.COMANDO.setString (1, conta);
			
			resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();
		}
		catch(SQLException erro)
		{
			throw new Exception("Erro ao procurar emails da conta.");
		}
		
		return resultado;
	}

    public static MeuResultSet getUsuarios () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM Email";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar emails.");
        }

        return resultado;
    }
}