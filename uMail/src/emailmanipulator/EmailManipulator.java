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
import javax.mail.BodyPart;
import javax.mail.Multipart;

public class EmailManipulator extends Email
{
	public EmailManipulator(Email modelo) throws Exception 
	{
		super(modelo);
		// TODO Auto-generated constructor stub
	}

	private Properties emailProperties;
	private Session mailSession;
	private MimeMessage emailMessage;
	
	public int setMailServerProperties() 
	{
		try
		{
			emailProperties = System.getProperties();
			emailProperties.put("mail.smtp.port", this.getPorta());
			emailProperties.put("mail.smtp.auth", "true");
			
			if(this.getSeguranca().getId() == 1)
				emailProperties.put("mail.smtp.starttls.enable", "true");
			else
			{
				emailProperties.put("mail.smtp.socketFactory.port", this.getPorta());
				emailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
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
			String user = this.getUsuario();
			String senha = this.getSenha();
			mailSession = Session.getDefaultInstance(emailProperties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
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
	        
	        Multipart multipart = (Multipart) emailMessage.getContent();
	        
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
			String emailHost = this.getHost() + "." + this.getServidor(); // "smtp.gmail.com";
			String fromUser = this.getUsuario().substring(0, this.getUsuario().indexOf('@')); //just the id alone without @gmail.com
			String fromUserEmailPassword = "your email password here";
			
			Transport transport = mailSession.getTransport("smtp");
	        transport.connect(emailHost, this.getPorta(), fromUser, this.getSenha());
	        transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
	        transport.close();
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
	