package bd.daos;

import java.sql.SQLException;

import bd.BDSQLServer;
import bd.core.MeuResultSet;
import bd.dbos.Hash_conta;

public class Hashs_contas
{
	public static boolean cadastrado (String conta) throws Exception
    {
        boolean retorno = false;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM hash_conta " +
                  "WHERE and conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, conta);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            retorno = resultado.first();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hash_conta.");
        }

        return retorno;
    }
	
	public static MeuResultSet pegarHash_conta(String hash) throws Exception
	{
		MeuResultSet retorno = null;
		
		try
		{
			String sql;
			
			sql = "SELECT * FROM hash_conta where hash = ?";
			
			BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, hash);

            retorno = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
		}
		catch(SQLException erro)
		{
			throw new Exception("Erro ao procurar hash_conta!");
		}
		
		return retorno;
	}
	
	public static String getHash(String conta) throws Exception
	{
		MeuResultSet retorno = null;
		
		try
		{
			String sql;
			
			sql = "SELECT * FROM hash_conta where conta = ?";
			
			BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, conta);

            retorno = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
		}
		catch(SQLException erro)
		{
			throw new Exception("Erro ao procurar hash_conta!");
		}
		
		return retorno.getString("hash");
	}

    public static void incluir (Hash_conta hash_conta) throws Exception
    {
        if (hash_conta == null)
            throw new Exception ("Hash_conta nao fornecido");

        try
        {
            String sql;

            sql = "INSERT INTO hash_conta " +
            	  "(conta, hash)" +
                  "VALUES " +
                  "(?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString(1, hash_conta.getConta());
            BDSQLServer.COMANDO.setString(2, hash_conta.getHash());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir hash_conta.");
        }
    }
    
    public static void alterar (Hash_conta hash_conta) throws Exception
    {
        if (hash_conta == null)
            throw new Exception ("Hash_conta nao fornecido");

        try
        {
            String sql;

            sql = "update hash_conta " +
            	  "set hash = ? " +
                  "where conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);
            
            BDSQLServer.COMANDO.setString(1, hash_conta.getConta());
            BDSQLServer.COMANDO.setString(2, hash_conta.getHash());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir hash_conta.");
        }
    }

    public static void excluir (String conta, String hash) throws Exception
    {
        if (!cadastrado (conta))
            throw new Exception ("Nao cadastrado");

        try
        {
            String sql;

            sql = "DELETE FROM hash_conta " +
                  "WHERE conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, conta);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();        
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir hash_conta.");
        }
    }

    public static Hash_conta getHash_conta (String conta, String hash) throws Exception
    {
        Hash_conta hash_conta = null;

        try
        {
            String sql;

            sql = "SELECT * " +
                  "FROM hash_conta " +
                  "WHERE conta=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, conta);
            
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado.");

            hash_conta = new Hash_conta(resultado.getString("conta"), resultado.getString("hash"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar hash_conta.");
        }

        return hash_conta;
    }

    public static MeuResultSet getHash_contas () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "SELECT * " + "FROM hash_conta";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar hash_contas.");
        }

        return resultado;
    }

}
