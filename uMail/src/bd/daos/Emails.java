package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Emails
{
    public static boolean cadastrado (String usuario) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL " +
                  "WHERE USUARIO = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

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
                  "(Nome,Sobrenome,Usuario,Senha,seguranca,porta,servidor) " +
                  "VALUES " +
                  "(?,?,?,?,?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString (1, email.getNome     ());
            BDSQLServer.COMANDO.setString (2, email.getSobrenome());
            BDSQLServer.COMANDO.setString (3, email.getUsuario  ());
            BDSQLServer.COMANDO.setString (4, email.getSenha    ());
            BDSQLServer.COMANDO.setInt    (5, email.getSeguranca());
            BDSQLServer.COMANDO.setInt    (6, email.getPorta    ());
            BDSQLServer.COMANDO.setInt    (7, email.getHost     ());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir email.");
        }
    }

    public static void excluir (String usuario) throws Exception
    {
        if (!cadastrado (usuario))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM Email " +
                  "WHERE USUARIO=? ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

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

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET senha=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getSenha());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar senha!");
        }
    }
    
    public static void alterarPorta (Email email) throws Exception
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET porta=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getPorta());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

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

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET seguranca=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, email.getSeguranca());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar a segurança!");
        }
    }
    
    public static void alterarServidor (Email email) throws Exception //SERVIDOR = POP3, IMAP ou SMTP 
    {
        if (email==null)
            throw new Exception ("Email nao fornecido");

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET host=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, email.getHost());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

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

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET nome=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getNome());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

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

        if (!cadastrado (email.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE Email " +
                  "SET sobrenome=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email.getSobrenome());
            BDSQLServer.COMANDO.setString (2, email.getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar sobrenome!");
        }
    }

    public static Email getLivro (String usuario) throws Exception
    {
        Email email = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Email " +
                  "WHERE USUARIO = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            email = new Email ( resultado.getString("nome"),
            					resultado.getString("sobrenome"),
            					resultado.getString("usuario"), 
            					resultado.getString("SENHA"),
            					resultado.getInt   ("Porta"),
                                resultado.getInt("Seguranca"),
                                resultado.getInt ("HOST"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar email.");
        }

        return email;
    }

    public static MeuResultSet getLivros () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM Email";

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