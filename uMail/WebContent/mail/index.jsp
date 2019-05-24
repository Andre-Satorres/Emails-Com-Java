<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, java.util.Properties, javax.mail.search.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="../css/master.css">
   <link rel="stylesheet" type="text/css" href="css.css">
<%
	if(session.getAttribute("usuario") == null)
		response.sendRedirect("../index.jsp");

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
  	<li><a href="CadastrarEmail.jsp">Cadastrar Email</a></li>
  	<li><a href="">Escrever</a></li>
  	<li><a href="index.jsp?u=1">Momma Valos</a></li>
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

<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<%
	try
	{
		//if(session.getAttribute("u") != null)
		//{
			Folder emailFolder = store.getFolder("INBOX");
			emailFolder.open(Folder.READ_WRITE);
		
			Message[] emails = emailFolder.getMessages();
		
			for(int i =messages.length-1; i>=0; i--)
			{   
				%><tr><td><%= ((InternetAddress)emails[i].getFrom()[0]).getAddress() %></td> <td><%=emails[i].getSubject() %></td><td><%=emails[i].getSentDate() %></td></tr><% 	
			} 
		//}
	} 
	catch (NoSuchProviderException e) 
	{
		System.out.println("Este provedor de emails é inexistente!");
	}

%>
</table>
</body>
</html>