package saltedmd5;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;

public class SaltedMD5 
{
    public static String[] preparar(String senha) throws NoSuchAlgorithmException, NoSuchProviderException
    {
        byte[] salt = getSalt();
         
        String senhaSegura = obterSenhaSegura(senha, salt);
        
        String[] ret = new String[2];
        ret[0] = senhaSegura;
        ret[1] = salt.toString();
        
        return ret;
    }
     
    private static String obterSenhaSegura(String senha, byte[] salt) throws NoSuchAlgorithmException
    {
        String generatedPassword = null;
        try 
        {
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            md.update(salt);
            
            //Get the hash's bytes
            byte[] bytes = md.digest(senha.getBytes()); //retorna bytes em decimal
            
            //Vamos converter para hexadecimal
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            
            //Obtem a senha criptografada em hexadecimal
            generatedPassword = sb.toString();
        }
        catch (NoSuchAlgorithmException e) 
        {
            throw new NoSuchAlgorithmException(e.getMessage());
        }
        
        return generatedPassword;
    }
     
    //Add salt
    private static byte[] getSalt() throws NoSuchAlgorithmException, NoSuchProviderException
    {
        //Always use a SecureRandom generator
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG", "SUN");
        //Create array for salt
        byte[] salt = new byte[16];
        //Get a random salt
        sr.nextBytes(salt);
        //return salt
        return salt; //tenho que salvar esta valor no bd tambem.
    }
}
