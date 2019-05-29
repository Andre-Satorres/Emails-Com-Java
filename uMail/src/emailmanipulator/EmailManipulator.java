package emailmanipulator;

import bd.dbos.*;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailManipulator extends Email
{
	private static final String PROTOCOLO_IMAP = "imap";
	private static final String PROTOCOLO_POP3 = "pop3";
	private static final String PROTOCOLO_SMTP = "smtp";
	
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
	
	public void createEmailMessage(String[] toEmails, String emailSubject, String emailBody) throws AddressException, MessagingException 
	{
		emailMessage = new MimeMessage(mailSession);
		
		for (int i = 0; i < toEmails.length; i++) 
		{
			emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
		}
		
		emailMessage.setSubject(emailSubject);
		emailMessage.setContent(emailBody, "text/html");//for a html email
	}
	
	public void sendEmail() throws AddressException, MessagingException 
	{

		String emailHost = "smtp.gmail.com";
		String fromUser = "your emailid here";//just the id alone without @gmail.com
		String fromUserEmailPassword = "your email password here";

		Transport transport = mailSession.getTransport("smtp");

		transport.connect(emailHost, fromUser, fromUserEmailPassword);
		transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
		transport.close();
		System.out.println("Email sent successfully.");
	}
	
	public void receberEmail()
	{}
	
	public void criarPasta(String nomePasta, String diretorio)
	{}
	
	public void removerPasta(String diretorio, String nome)
	{}
	
	public void alterarNomePasta(String diretorio, String nome)
	{}
	
	public
	