<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link rel="stylesheet" type="text/css" href="css.css">
<%
	String host = "pop.mail.yahoo.com";
	String user = "USER";
	String password = "PASS";
	
	// connect to my pop3 inbox in read-only mode
	Properties properties = System.getProperties();
	Session session = Session.getDefaultInstance(properties);
	Store store = session.getStore("pop3");
	store.connect(host, user, password);
	Folder inbox = store.getFolder("inbox");
	inbox.open(Folder.READ_ONLY);
	
	// search for all "unseen" messages
	Flags seen = new Flags(Flags.Flag.SEEN);
	FlagTerm unseenFlagTerm = new FlagTerm(seen, false);
	Message messages[] = inbox.search(unseenFlagTerm);
	
	if (messages.length == 0) System.out.println("No messages found.");
	
	for (int i = 0; i < messages.length; i++) {
	  // stop after listing ten messages
	  if (i > 10) {
	    System.exit(0);
	    inbox.close(true);
	    store.close();
	  }
	
	  System.out.println("Message " + (i + 1));
	  System.out.println("From : " + messages[i].getFrom()[0]);
	  System.out.println("Subject : " + messages[i].getSubject());
	  System.out.println("Sent Date : " + messages[i].getSentDate());
	  System.out.println();
	}
	
	inbox.close(true);
	store.close();
%>
<title>Entrada (n emails n lidos) - <%=session.getAttribute("usuario")%></title>
</head>
<body>
	<nav class="navigation">
  <ul class="mainmenu">
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

</body>
</html>