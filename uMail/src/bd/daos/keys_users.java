package bd.daos;

import java.sql.SQLException;

import bd.BDSQLServer;
import bd.core.MeuResultSet;
import bd.dbos.key_user;

public class keys_users 
{
	public static boolean cadastrado (String usuario, String conta) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM key_user " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, usuario);
            BDSQLServer.COMANDO.setString(2, conta);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar key_user.");
        }

        return retorno;
    }

    public static void incluir (key_user key_user) throws Exception
    {
        if (key_user == null)
            throw new Exception ("key_user nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO key_user " +
            	  "(usuario, conta, chave)" +
                  "VALUES " +
                  "(?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString(1, key_user.getUsuario());
            BDSQLServer.COMANDO.setString(2, key_user.getConta());
            BDSQLServer.COMANDO.setString(3, key_user.getChave());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir key_user.");
        }
    }

    public static void excluir (String usuario, String conta) throws Exception
    {
        if (!cadastrado (usuario, conta))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM key_user " +
                  "WHERE usuario=? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, usuario);
            BDSQLServer.COMANDO.setString(2, conta);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir key_user.");
        }
    }

    public static key_user getKey_user (String usuario, String conta) throws Exception
    {
        key_user key_user = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM key_user " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, conta);
            
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado.");

            key_user = new key_user(resultado.getString("usuario"), resultado.getString("conta"), resultado.getString("chave"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar key_user.");
        }

        return key_user;
    }

    public static MeuResultSet getKey_users () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM key_user";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar key_users.");
        }

        return resultado;
    }

}
