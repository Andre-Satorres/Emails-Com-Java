package emailmanipulator;

import bd.dbos.*;

import java.io.File;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
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
	private boolean isAuthenticated;
	private boolean isStoreSet;
	private String mailServer;
	private Store emailStore;
	
	
	public EmailManipulator(String nome, String sobrenome, String usuario, String senha, int portaR, int portaE, 
			                Seguranca seguranca, Host host, String servidor, LoginMail conta) throws Exception 
	{
		super(usuario, senha, portaR, portaE, seguranca, host, nome, sobrenome, servidor, conta);
		
		this.isAuthenticated = false;
		this.isStoreSet = false;
	}
	
	public EmailManipulator(Email em) throws Exception 
	{
		super(em);
		
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
					if(this.getServidor().contains("yahoo"))
						this.mailServer = "pop" + "." + "mail." + this.getServidor();
					else
						if(this.getServidor().contains("unicamp"))
							this.mailServer = "pop" + ".unicamp.br";
						else
							if(this.getServidor().contains("bol"))
								this.mailServer = "pop3." + this.getServidor();
							else
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
						emailProperties.put("mail.pop3.ssl.trust", this.mailServer);
					}
				}
				else
				{
					if(this.getServidor().contains("yahoo"))
						this.mailServer = "imap" + "." + "mail." + this.getServidor();
					else
						if(this.getServidor().contains("unicamp"))
							this.mailServer = "imap" + ".unicamp.br";
						else
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
				if(this.getServidor().contains("bol"))
					this.mailServer = "smtps" + "." + this.getServidor(); //bol tem esse s
				else
					if(this.getServidor().contains("yahoo"))
						this.mailServer = "smtp" + ".mail." + this.getServidor();
					else
						if(this.getServidor().contains("unicamp"))
							this.mailServer = "smtp" + ".unicamp.br";
						else
							this.mailServer = "smtp" + "." + this.getServidor();

				emailProperties.setProperty("mail.host", this.mailServer);
				
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
			this.setMailServerProperties(modo);
			
			final String user = this.getUsuario();
 			final String senha = this.getSenha();
			emailSession = Session.getInstance(emailProperties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(user, senha);
							
						}
					});
			
			if(emailSession == null)
				this.isAuthenticated = false;
			else
				this.isAuthenticated = true;
			
			return this.isAuthenticated;
		}
		catch(Exception e)
		{
			return false;
		}
	}
	
	public void sendConfirmationEmail(String user, String chave) throws Exception
	{
		try
		{
			if(!this.isAuthenticated)
				this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(new InternetAddress(this.getUsuario()));
			
			if(user==null)
				throw new Exception("A mensagem não possui destinatário!");

			emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(user));

			
			emailMessage.setSubject("Bem vindo ao uMail!");
			String mensagem = "<h3>Agradecemos a preferência!</h3>";
			mensagem += "\n<h4>Seu código de verificação de conta é " + chave + "</h4>";
			mensagem += "\n <p>uMail. Todos os direitos reservados.</p>";
			emailMessage.setText(mensagem, "UTF-8", "html");
			
	        this.sendEmail();
		}
		catch(Exception e)
		{
			throw new Exception("Erro ao criar mensagem! " + e.getMessage());
		}
	}
	
	
	public void createEmailMessage(boolean responder, String[] toEmails, String[] cc, String[] cco, String emailSubject, String emailBody, String[] anexos) throws Exception
	{
		try
		{
			if(!this.isAuthenticated)
				this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails==null)
				throw new Exception("A mensagem não possui destinatários!");
			
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
			
			if(cc!=null)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
			
			if(cco!=null)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, new InternetAddress(cco[i]));
			
			emailMessage.setSubject(emailSubject);
			
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
	        
	        Multipart multipart = new MimeMultipart();
	        
	        multipart.addBodyPart(messageBodyPart);
	        
	        if(anexos!=null)
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
			throw new Exception("Erro ao criar mensagem. " + e.getMessage());
		}
	}
	
	public void createEmailMessage(boolean responder, String[] toEmails, String[] cc, String[] cco,
			   String emailSubject, String emailBody, File[] anexos) throws Exception 
	{
		try
		{
			if(!this.isAuthenticated)
				this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails==null)
				throw new Exception("A mensagem não possui destinatários!");
			
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
			
			if(cc!=null)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
			
			if(cco!=null)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, new InternetAddress(cco[i]));
			
			emailMessage.setSubject(emailSubject);
			emailMessage.setContent(emailBody, "text/html");//for a html email
			
	        BodyPart messageBodyPart = new MimeBodyPart();
	        
	        messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
	        
	        Multipart multipart = new MimeMultipart();
	        
	        multipart.addBodyPart(messageBodyPart);
	        
	        if(anexos!=null)
	        for(int i=0; i< anexos.length; i++)
	        {
	        	messageBodyPart = new MimeBodyPart();
	        	DataSource source = new FileDataSource(anexos[i]);
	        	messageBodyPart.setDataHandler(new DataHandler(source));
	        	messageBodyPart.setFileName(anexos[i].getName());
	        	multipart.addBodyPart(messageBodyPart);
	        }
	
	        emailMessage.setContent(multipart);
	        this.sendEmail();
		}
		catch(Exception e)
		{
			throw new Exception("Erro ao criar mensagem. " + e.getMessage());
		}
	}
	
	public void createEmailMessage(boolean responder, Address[] toEmails, Address[] cc, Address[] cco, String emailSubject, String emailBody, String[] anexos) throws Exception 
	{
		try
		{
			if(!this.isAuthenticated)
			this.authenticate(0);
			
			emailMessage = new MimeMessage(emailSession);
			emailMessage.setFrom(this.getUsuario());
			
			if(responder)
				emailMessage = (MimeMessage) this.emailMessage.reply(false);
			
			if(toEmails==null)
				throw new Exception("A mensagem não possui destinatários!");
			
			for (int i = 0; i < toEmails.length; i++) 
				emailMessage.addRecipient(Message.RecipientType.TO, toEmails[i]);
			
			if(cc!=null)
			for(int i=0; i<cc.length; i++)
				emailMessage.addRecipient(Message.RecipientType.CC, cc[i]);
			
			if(cco!=null)
			for(int i=0; i<cco.length; i++)
				emailMessage.addRecipient(Message.RecipientType.BCC, cco[i]);
			
			emailMessage.setSubject(emailSubject);
			emailMessage.setContent(emailBody, "text/html");//for a html email
			
			BodyPart messageBodyPart = new MimeBodyPart();
			
			messageBodyPart.setContent(emailBody, "text/html; charset=utf-8");
			
			Multipart multipart = new MimeMultipart();
			
			multipart.addBodyPart(messageBodyPart);
				
			if(anexos!=null)
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
			throw new Exception("Erro ao criar mensagem!" + e.getMessage());
		}
	}
	
	public void testarConexao() throws Exception
	{
		Transport tp = emailSession.getTransport();
		tp.connect(getUsuario(), this.getSenha());
	}
	
	public void sendEmail() throws Exception
	{
		try 
		{
			Transport tp = emailSession.getTransport();
			tp.connect(getUsuario(), getSenha());
			tp.sendMessage(this.emailMessage, this.emailMessage.getAllRecipients());
		}
		catch(Exception e)
		{
			throw new Exception("A mensagem não foi criada.");	
		}
	}
	
	public void setStore() throws Exception
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
			throw new Exception("Erro ao abrir pasta. " + e.getMessage());
		}
	}
	
	public void fecharPasta(Folder fd) throws MessagingException
	{
		fd.close();
	}
	
	public void fecharPasta(String fold) throws MessagingException
	{
		Folder fd = this.emailStore.getFolder(fold);
		fd.close();
	}
	
	public int quantidadeMensagens(String nomePasta) throws Exception
	{
		return this.mensagens(nomePasta).length;
	}
	
	public Message[] mensagens(String nomePasta) throws Exception
	{
		Folder fd = this.abrirPasta(nomePasta, 1);
		Flags deletada = new Flags(Flags.Flag.DELETED);
		FlagTerm naoExcluida = new FlagTerm(deletada, false);
		return fd.search(naoExcluida);
	}
	
	public Message[] todasAsMensagens(String nomePasta) throws Exception
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
		try
		{
			if(this.mensagensNaoLidas(nomePasta) == null)
				return 0;

			//fd.getUnreadMessageCount();
			return this.mensagensNaoLidas(nomePasta).length;
		}
		catch(Exception e)
		{
			return 0;
		}
	}
	
	public Message[] mensagensNaoLidas(String nomePasta) throws Exception
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
			throw new Exception("Erro ao abrir pasta." + e.getMessage());
		}
	}
	
	public boolean isMessageRead(String nomePasta, Message msg)
	{
		try
		{
			for(Message m:this.mensagensNaoLidas(nomePasta))
				if(m.equals(msg))
					return true;
		}
		catch(Exception e)
		{}
		
		return false;
	}
	
	public Folder[] obterTodasAsPastas() throws Exception
	{
		if(!this.isAuthenticated)
			this.authenticate(1);

		if(!this.isStoreSet)
			this.setStore();

		return emailStore.getDefaultFolder().list();
	}
	
	public void criarPasta(String novaPasta) throws Exception
	{
		this.authenticate(1);
		this.setStore();
		Folder nova = this.emailStore.getFolder(novaPasta);
			
		if ( !nova.exists())  
		{
			if(nova.create( Folder.HOLDS_FOLDERS | Folder.HOLDS_MESSAGES ))
				nova.setSubscribed(true);
		}
		else
			throw new Exception ("Pasta ja existente!");
	}
	
	public void deletarPasta(String nome, boolean deletarFilhas) throws Exception
	{
		try
		{
			this.authenticate(1);
			this.setStore();
			Folder pasta = this.emailStore.getFolder(nome);
			
			if (!pasta.exists())
				throw new FolderNotFoundException();
			
			if (pasta.isOpen())		
				pasta.close();
			
			pasta.delete(deletarFilhas); //o parâmetro boolean especifica se as pastas filhas devem ser deletadas
		}
		catch(Exception e)
		{}
	}
	
	public void renomearPasta(String nomeOriginal, String nomeFinal) throws Exception
	{
		try
		{
			this.authenticate(1);
			this.setStore();
			Folder pasta = this.emailStore.getFolder(nomeOriginal);
			
			if (!pasta.exists())
				throw new FolderNotFoundException();
			else
				pasta.renameTo(this.abrirPasta(nomeFinal, 1));
		}
		catch(Exception e)
		{}
	}
	
	/**
	 * @param msg
	 * @param nomePasta
	 * @throws Exception
	 */
	public void deletarEmail(Message msg, String nomePasta) throws Exception
	{
		msg.setFlag(Flags.Flag.DELETED, true);
		Folder f = this.abrirPasta(nomePasta, 1);
		f.close(true);
	}
}
	