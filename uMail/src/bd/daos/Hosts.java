package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Hosts
{
    public static boolean cadastrado (int id) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM host " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar host.");
        }

        return retorno;
    }

    public static void incluir (Host host) throws Exception
    {
        if (host == null)
            throw new Exception ("Host nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO Host " +
            	  "(id, nome)" +
                  "VALUES " +
                  "(?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setInt   (1, host.getId());
            BDSQLServer.COMANDO.setString(2, host.getNome());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir host.");
        }
    }

    public static void excluir (int id) throws Exception
    {
        if (!cadastrado (id))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM host " +
                  "WHERE id=? ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, id);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir host.");
        }
    }

    public static void alterarNome (Host host) throws Exception 
    {
        if (host==null)
            throw new Exception ("Host nao fornecido");

        if (!cadastrado (host.getId()))
            throw new Exception ("Nao cadastrado.");

        try
        {
            String sql;

            sql = "UPDATE Host " +
                  "SET nome=? " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, host.getId());
            BDSQLServer.COMANDO.setString (2, host.getNome());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar host!");
        }
    }

    public static Host getHost (int id) throws Exception
    {
        Host host = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM host " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, id);
            
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado.");

            host = new Host (resultado.getInt("id"), resultado.getString("nome"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar host.");
        }

        return host;
    }

    public static MeuResultSet getHosts () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM host";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar hosts.");
        }

        return resultado;
    }
}