package bd.daos;

import java.sql.SQLException;

import bd.BDSQLServer;
import bd.core.MeuResultSet;
import bd.dbos.Hash;

public class Hashs 
{
	public static boolean cadastrado (String usuario, String conta) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM hash " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, usuario);
            BDSQLServer.COMANDO.setString(2, conta);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hash.");
        }

        return retorno;
    }
	
	public static MeuResultSet pegarHash(String hash) throws Exception
	{
		MeuResultSet retorno = null;
		
		try
		{
			String sql;
			
			sql = "SELECT * FROM hash where hash = ?";
			
			BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, hash);

            retorno = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
		}
		catch(SQLException erro)
		{
			throw new Exception("Erro ao procurar hash!");
		}
		
		return retorno;
	}

    public static void incluir (Hash hash) throws Exception
    {
        if (hash == null)
            throw new Exception ("Hash nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO hash " +
            	  "(usuario, hash, conta)" +
                  "VALUES " +
                  "(?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString(1, hash.getUsuario());
            BDSQLServer.COMANDO.setString(2, hash.getHash());
            BDSQLServer.COMANDO.setString(3, hash.getConta());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir hash.");
        }
    }

    public static void excluir (String usuario, String conta) throws Exception
    {
        if (!cadastrado (usuario, conta))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM hash " +
                  "WHERE usuario=? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, usuario);
            BDSQLServer.COMANDO.setString(2, conta);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir hash.");
        }
    }

    public static Hash getHash (String usuario, String conta) throws Exception
    {
        Hash hash = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM hash " +
                  "WHERE usuario = ? and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usuario);
            BDSQLServer.COMANDO.setString (2, conta);
            
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado.");

            hash = new Hash(resultado.getString("usuario"), resultado.getString("hash"), resultado.getString("conta"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hash.");
        }

        return hash;
    }

    public static MeuResultSet getHashs () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM hash";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar hashs.");
        }

        return resultado;
    }

}
