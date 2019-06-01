package emailmanipulator;

import bd.dbos.*;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.BodyPart;
import javax.mail.Multipart;

public class EmailManipulator extends Email
{
	public EmailManipulator(String nome, String sobrenome, String usuario, String senha, int porta, Seguranca seguranca, Host host, String servidor) throws Exception 
	{
		super(nome, sobrenome, usuario, senha, porta, seguranca, host, servidor);
	}
	
	public EmailManipulator(Email em) throws Exception 
	{
		super(em);
	}

	private Properties emailProperties;
	private Session mailSession;
	private MimeMessage emailMessage;
	
	public int setMailServerProperties() 
	{
		try
		{
			emailProperties = System.getProperties();
			emailProperties.put("mail.smtp.port", this.getPorta()); //587 se for tls; 465 se for SSl
			emailProperties.put("mail.smtp.host", "smtp."+this.getServidor());
			emailProperties.put("mail.smtp.auth", "true");
			
			if(this.getSeguranca().getId() == 1)
				emailProperties.put("mail.smtp.starttls.enable", "true");
			else
			{
				emailProperties.put("mail.smtp.socketFactory.port", this.getPorta());
				emailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				emailProperties.put("mail.smtp.ssl.enable", "true");
			}
			
			return 0;
		}
		catch(Exception e)
		{
			return -1;
		}
	}
	
	public boolean authenticate()
	{
		try 
		{
			this.setMailServerProperties();
			final String user = this.getUsuario();
			final String senha = this.getSenha();
			mailSession = Session.getDefaultInstance(emailProperties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							String a = "oi";
							return new PasswordAuthentication(user, senha);
						}
					});
			
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}
	
	public void createEmailMessage(String[] toEmails, String[] cc, String[] cco, String emailSubject, String emailBody, String[] anexos) throws AddressException, MessagingException 
	{
		try
		{
			this.authenticate();
			emailMessage = new MimeMessage(mailSession);
			
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
			
			
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
			
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, new InternetAddress(cco[i]));
			
			emailMessage.setSubject(emailSubject);
			emailMessage.setContent(emailBody, "text/html");//for a html email
			
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
	        
	        Multipart multipart = new MimeMultipart();
	        
	        multipart.addBodyPart(messageBodyPart);
	        
	        
	        for(int i=0; i< anexos.length; i++)
	        {
	        	messageBodyPart = new MimeBodyPart();
	        	DataSource source = new FileDataSource(anexos[i]);
	        	messageBodyPart.setDataHandler(new DataHandler(source));
	        	messageBodyPart.setFileName(anexos[i]);
	        	multipart.addBodyPart(messageBodyPart);
	        }
	
	        emailMessage.setContent(multipart);
	        this.sendEmail();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void sendEmail() throws AddressException, MessagingException 
	{
		try 
		{
			Transport.send(emailMessage);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void receberEmail()
	{}
	
	public void criarPasta(String nomePasta, String diretorio)
	{}
	
	public void removerPasta(String diretorio, String nome)
	{}
	
	public void alterarNomePasta(String diretorio, String nome)
	{}
}
	