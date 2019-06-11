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
import javax.mail.search.FlagTerm;

public class EmailManipulator extends Email
{
	private Properties emailProperties;
	private Session emailSession;
	private MimeMessage emailMessage;
	private boolean issetServerMailProperties;
	private boolean isAuthenticated;
	private boolean isStoreSet;
	private String mailServer;
	private Store emailStore;
	
	
	public EmailManipulator(String nome, String sobrenome, String usuario, String senha, int portaR, int portaE, 
			                Seguranca seguranca, Host host, String servidor, String conta) throws Exception 
	{
		super(usuario, senha, portaR, portaE, seguranca, host, nome, sobrenome, servidor, conta);
		
		this.issetServerMailProperties = false;
		this.isAuthenticated = false;
		this.isStoreSet = false;
	}
	
	public EmailManipulator(Email em) throws Exception 
	{
		super(em);
		
		this.issetServerMailProperties = false;
		this.isAuthenticated = false;
		this.isStoreSet = false;
	}
	
	public int setMailServerProperties(int modo) 
	{
		try
		{
			emailProperties = System.getProperties();
			
			if(modo == 1) // receber
			{
				if(this.getHost().getId()==1)
				{
					this.mailServer = "pop" + "." + this.getServidor();
					
					emailProperties.put("mail.pop3.port", this.getPortaRecepcao());
					emailProperties.put("mail.pop3.host", this.mailServer);
					emailProperties.put("mail.pop3.socketFactory.fallback", "false");
					
					if(this.getSeguranca().getId() == 1)
						emailProperties.put("mail.pop3.starttls.enable", "true");
					else
					{
						emailProperties.put("mail.pop3.socketFactory.port", this.getPortaRecepcao());
						emailProperties.put("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
						emailProperties.put("mail.pop3.ssl.enable", "true");
					}
				}
				else
				{
					this.mailServer = "imap" + "." + this.getServidor();
					
					emailProperties.put("mail.imap.port", this.getPortaRecepcao());
					emailProperties.put("mail.imap.host", this.mailServer);
				    emailProperties.put("mail.imap.auth", "true");
				    
				    if(this.getSeguranca().getId() == 1)
						emailProperties.put("mail.imap.starttls.enable", "true");
					else
					{
						emailProperties.put("mail.imap.socketFactory.port", this.getPortaRecepcao());
						emailProperties.put("mail.imap.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
						emailProperties.put("mail.imap.ssl.enable", "true");
					}
				}
			} //enviar 
			else
			{
				this.mailServer = "smtp" + "." + this.getServidor();
				emailProperties.put("mail.smtp.port", this.getPortaEnvio());
				emailProperties.put("mail.smtp.host", this.mailServer);
			    emailProperties.put("mail.smtp.auth", "true");
			    
			    if(this.getSeguranca().getId() == 1)
					emailProperties.put("mail.smtp.starttls.enable", "true");
				else
				{
					emailProperties.put("mail.smtp.socketFactory.port", this.getPortaEnvio());
					emailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					emailProperties.put("mail.smtp.ssl.enable", "true");
				}
			}
			
			this.issetServerMailProperties = true;
			return 0;
		}
		catch(Exception e)
		{
			return -1;
		}
	}
	
	public boolean authenticate(int modo)
	{
		try 
		{
			if(!this.issetServerMailProperties)
				this.setMailServerProperties(modo);
			
			final String user = this.getUsuario();
			final String senha = this.getSenha();
			emailSession = Session.getDefaultInstance(emailProperties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(user, senha);
						}
					});
			
			this.isAuthenticated = true;
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}
	
	public void createEmailMessage(boolean responder, String[] toEmails, String[] cc, String[] cco, String emailSubject, String emailBody, String[] anexos) throws AddressException, MessagingException 
	{
		try
		{
			if(!this.isAuthenticated)
				this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails.length>0)
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
			
			if(cc.length>0)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
			
			if(cco.length>0)
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
	
	public void createEmailMessage(boolean responder, String[] toEmails, String[] cc, String[] cco, String emailSubject, String emailBody) throws AddressException, MessagingException 
	{
		try
		{
			if(!this.isAuthenticated)
				this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails.length>0)
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
			
			if(cc.length>0)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
			
			if(cco.length>0)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, new InternetAddress(cco[i]));
			
			emailMessage.setSubject(emailSubject);
			emailMessage.setContent(emailBody, "text/html");//for a html email
			
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
	        
	        Multipart multipart = new MimeMultipart();
	        
	        multipart.addBodyPart(messageBodyPart);
	       
	        emailMessage.setContent(multipart);
	        this.sendEmail();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void createEmailMessage(boolean responder, Address[] toEmails, Address[] cc, Address[] cco, String emailSubject, String emailBody, String[] anexos) throws AddressException, MessagingException 
	{
		try
		{
			if(!this.isAuthenticated)
			this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails.length>0)
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, toEmails[i]);
			
			if(cc.length>0)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, cc[i]);
			
			if(cco.length>0)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, cco[i]);
			
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
	
	public void createEmailMessage_n(boolean responder, Address[] toEmails, Address[] cc, Address[] cco, String emailSubject, String emailBody) throws AddressException, MessagingException 
	{
		try
		{
			if(!this.isAuthenticated)
			this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails.length>0)
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, toEmails[i]);
			
			if(cc.length>0)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, cc[i]);
			
			if(cco.length>0)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, cco[i]);
			
			emailMessage.setSubject(emailSubject);
			emailMessage.setContent(emailBody, "text/html");//for a html email
			
			BodyPart messageBodyPart = new MimeBodyPart();
			
			messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
			
			Multipart multipart = new MimeMultipart();
			
			multipart.addBodyPart(messageBodyPart);
			
			emailMessage.setContent(multipart);
			this.sendEmail();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void sendEmail() throws Exception
	{
		try 
		{
			Transport.send(emailMessage);
		}
		catch(Exception e)
		{
			throw new Exception("A mensagem não foi criada.");	
		}
	}
	
	private void setStore() throws Exception
	{
		this.emailStore = this.emailSession.getStore(this.getHost().getNome().toLowerCase()+"s"); //imaps ou pop3s
		this.emailStore.connect(this.mailServer, this.getUsuario(), this.getSenha());	
		
	}
	
	public Folder abrirPasta(String nomePasta, int modo) throws Exception
	{
		if (nomePasta == null)
			throw new Exception();
		
		if(nomePasta == "")
			throw new Exception();
		
		if(!this.isAuthenticated)
			this.authenticate(1);
		
		try
		{
			if(!this.isStoreSet)
				this.setStore();
			
			Folder fd = this.emailStore.getFolder(nomePasta);
			
			if(modo == 0) //readOnly
				fd.open(Folder.READ_ONLY);
			else
				fd.open(Folder.READ_WRITE);
			
			return fd;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void fecharPasta(Folder fd) throws MessagingException
	{
		fd.close();
	}
	
	public int quantidadeMensagens(String nomePasta) throws Exception
	{
		return this.mensagens(nomePasta).length;
	}
	
	public Message[] mensagens(String nomePasta) throws Exception
	{
		Folder fd = this.abrirPasta(nomePasta, 1);
		return fd.getMessages();
	}
	
	public Message getMensagem(String nomePasta, int index) throws Exception
	{
		Folder fd = this.abrirPasta(nomePasta, 1);
		return fd.getMessages()[index];
	}
	
	public int quantidadeNaoLidas(String nomePasta)
	{
		return this.mensagensNaoLidas(nomePasta).length;
	}
	
	public Message[] mensagensNaoLidas(String nomePasta)
	{
		try
		{
			Folder fd = this.abrirPasta(nomePasta, 1);
			Flags visualizada = new Flags(Flags.Flag.SEEN);
			FlagTerm naoVisualizada = new FlagTerm(visualizada, false);
			return fd.search(naoVisualizada); //messages.length sera a qtd de mensagens nao lidas...
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	public boolean isMessageRead(String nomePasta, Message msg)
	{
		for(Message m:this.mensagensNaoLidas(nomePasta))
			if(m.equals(msg))
				return true;
		
		return false;
	}
	
	public Folder[] obterTodasAsPastas()
	{
		if(!this.isAuthenticated)
			this.authenticate(1);
		
		//props.setProperty("mail.store.protocol", "imaps");
		try
		{
			if(!this.isStoreSet)
				this.setStore();
	
			return emailStore.getDefaultFolder().list();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void criarPasta(String novaPasta) throws Exception
	{
		Folder pastaNova = this.abrirPasta(novaPasta, 1);
			
		if ( !pastaNova.exists())  
			pastaNova.create( Folder.HOLDS_FOLDERS | Folder.HOLDS_MESSAGES );
		else
			throw new Exception ("Pasta ja existente!");
	}
	
	public void deletarPasta(String nome, boolean deletarFilhas) throws Exception
	{
		Folder pasta = this.abrirPasta(nome, 1);
		
		if (!pasta.exists())
			throw new FolderNotFoundException();
		
		if (pasta.isOpen())		
			pasta.close();
		
		pasta.delete(deletarFilhas); //o parâmetro boolean especifica se as pastas filhas devem ser deletadas
	}
	
	public void renomearPasta(String nomeOriginal, String nomeFinal) throws Exception
	{
		Folder pasta = this.abrirPasta(nomeOriginal, 1);
		
		if (!pasta.exists())
			throw new FolderNotFoundException();
		else
			pasta.renameTo(this.abrirPasta(nomeFinal, 1));
	}
}
	