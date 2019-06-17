package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

public class LoginMails
{
    public static boolean cadastrado (String usuario) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM loginMail " +
                  "WHERE USUARIO = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuario.");
        }

        return retorno;
    }

    public static void incluir (LoginMail uMail) throws Exception
    {
        if (uMail == null)
            throw new Exception ("Usuario nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO loginMail " +
            	  "(usuario, senha)" +
                  "VALUES " +
                  "(?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString (1, uMail.getUsuario  ());
            BDSQLServer.COMANDO.setString (2, uMail.getSenha    ());
            
            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir usuario.");
        }
    }

    public static void excluir (String usuario) throws Exception
    {
        if (!cadastrado (usuario))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM LoginMmail " +
                  "WHERE USUARIO=? ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir usuario.");
        }
    }

    public static void alterarSenha (LoginMail uMail) throws Exception
    {
        if (uMail==null)
            throw new Exception ("Usuario nao fornecido");

        if (!cadastrado (uMail.getUsuario()))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "UPDATE loginMmail " +
                  "SET senha=? " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, uMail.getSenha());
            BDSQLServer.COMANDO.setString (2, uMail.getUsuario());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar senha!");
        }
    }
    
    public static String getSenha (String usuario) throws Exception
    {
        if (usuario==null)
            throw new Exception ("Usuario nao fornecido");

        if (!cadastrado (usuario))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "select senha from loginMail " +
                  "WHERE usuario = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            return resultado.getString("senha");
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar senha!");
        }
    }
    
    public static LoginMail getUsuario (String usuario) throws Exception
    {
        LoginMail uMail = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM loginMail " +
                  "WHERE USUARIO = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            uMail = new LoginMail ( resultado.getString("usuario"),
            					resultado.getString("senha"));
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }

        return uMail;
    }

    public static MeuResultSet getUsuarios () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM loginMail";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar usuarios.");
        }

        return resultado;
    }
}