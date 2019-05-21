<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, java.util.Properties, javax.mail.search.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link rel="stylesheet" type="text/css" href="css.css">
<%
	String host = "pop.gmail.com";
	String user = "mommavalos@gmail.com";
	String password = "Sem1seiji";
	
	// connect to my pop3 inbox in read-only mode
	Properties properties = System.getProperties();
	
	properties.put("mail.pop3.host", host); //indica que será usado o pop3 do GMAIL
    properties.put("mail.pop3.port", "995"); // indica a porta que será utilizada 
    
    properties.put("mail.pop3.socketFactory.class", "javax.net.pop3.SSLSocketFactory");
    properties.put("mail.pop3.ssl.enable", "true");
    
    properties.put("mail.pop3.auth", "true");
    
	Session sessao = Session.getDefaultInstance(properties);
	Store store = sessao.getStore("pop3");
	store.connect(host, user, password);
	Folder inbox = store.getFolder("inbox");
	inbox.open(Folder.READ_ONLY);
	
	// search for all "unseen" messages
	Flags seen = new Flags(Flags.Flag.SEEN);
	FlagTerm unseenFlagTerm = new FlagTerm(seen, false);
	Message messages[] = inbox.search(unseenFlagTerm); //messages.length eh a qtd de n lidas...
%>
<title><%=session.getAttribute("usuario")%> - uMail</title>
</head>
<body>
	<nav class="navigation">
  <ul class="mainmenu">
  	<li><a href="">Escrever</a></li>
    <li><a href="">Caixa de entrada</a></li>
    <li><a href="">Com estrela</a></li>
    <li><a href="">Adiados</a></li>
    <li><a href="">Importante</a></li>
    <li><a href="">Enviados</a></li>
    <li><a href="">Rascunhos</a></li>
    <li><a href="">Categorias</a>
      <ul class="submenu">
        <li><a href="">Social</a></li>
        <li><a href="">Atualizações</a></li>
        <li><a href="">Fóruns</a></li>
        <li><a href="">Promoções</a></li>
      </ul>
    </li>
    <li><a href="">Todos os emails</a></li>
    <li><a href="">Span</a></li>
    <li><a href="">Lixeira</a></li>
  </ul>
</nav>

<table>
	<thead>
	<tr>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Job Title</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>James</td>
		<td>Matman</td>
		<td>Chief Sandwich Eater</td>
	</tr>
	<tr>
		<td>The</td>
		<td>Tick</td>
		<td>Crimefighter Sorta</td>
	</tr>
	</tbody>
</table>
<%
	try
	{
		Folder emailFolder = store.getFolder("INBOX");
		emailFolder.open(Folder.READ_WRITE);
		
		Message[] emails = emailFolder.getMessages();
		
		for (int i = 0, n = messages.length; i < n; i++)
		{
		    Message message = emails[i];
		    String contentType = message.getContentType();
		    
		    //System.out.println("Número do email: " + (i + 1));
		    //System.out.println("Assunto: " + message.getSubject());
		    //System.out.println("De: " + message.getFrom()[0]);
		    //System.out.println(getTextFromMessage(message));
		    
		    String desejo;
		    
		    if (contentType.contains("multipart"))
		    {
		        Multipart multiPart = (Multipart) message.getContent();
		        int numberOfParts = multiPart.getCount();
		        for (int partCount = 0; partCount < numberOfParts; partCount++)
		        {
		            MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
		            
		            if (javax.mail.Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition()))
		            {
		                // Essa parte é um anexo
		                String fileName = part.getFileName();
		            }
		        }
		    }
		}
		
		//close the store and folder objects
		emailFolder.close(false);
	} 
	catch (NoSuchProviderException e) 
	{
		System.out.println("Este provedor de emails é inexistente!");
	}

%>
</body>
</html>