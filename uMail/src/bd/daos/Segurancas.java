package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

public class Segurancas
{
    public static boolean cadastrado (int id) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM seguranca " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar seguranca.");
        }

        return retorno;
    }

    public static void incluir (Seguranca seguranca) throws Exception
    {
        if (seguranca == null)
            throw new Exception ("seguranca nao fornecida");

        try
        {
            String sql;

            sql = "INSERT INTO seguranca " +
            	  "(id, nome)" +
                  "VALUES " +
                  "(?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setInt   (1, seguranca.getId());
            BDSQLServer.COMANDO.setString(2, seguranca.getNome());

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

            sql = "DELETE FROM seguranca " +
                  "WHERE id=? ";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, id);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir seguranca.");
        }
    }

    public static void alterarNome (Seguranca seguranca) throws Exception 
    {
        if (seguranca==null)
            throw new Exception ("Seguranca nao fornecida");

        if (!cadastrado (seguranca.getId()))
            throw new Exception ("Nao cadastrado.");

        try
        {
            String sql;

            sql = "UPDATE seguranca " +
                  "SET nome=? " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt    (1, seguranca.getId());
            BDSQLServer.COMANDO.setString (2, seguranca.getNome());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar seguranca!");
        }
    }

    public static Seguranca getSeguranca (int id) throws Exception
    {
        Seguranca seguranca = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM seguranca " +
                  "WHERE id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, id);
            
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado.");

            seguranca = new Seguranca (resultado.getInt("id"), resultado.getString("nome"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar seguranca.");
        }

        return seguranca;
    }

    public static MeuResultSet getSegurancas () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM seguranca";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar segurancas.");
        }

        return resultado;
    }
}