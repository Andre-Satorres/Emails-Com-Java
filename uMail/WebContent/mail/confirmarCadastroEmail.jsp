<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.security.Key, javax.crypto.Cipher, 
																	javax.crypto.KeyGenerator, bd.dbos.*, bd.daos.*,
																	bd.core.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try
	{
		KeyGenerator keyGen = KeyGenerator.getInstance("AES");
		keyGen.init(128);  // Key size
		Key key = keyGen.generateKey();
		
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE,key, cipher.getParameters());
		
		String chaveCriptografada = request.getParameter("c");
		
		byte[] chaveDescriptografada = cipher.doFinal(chaveCriptografada.getBytes());
		
		MeuResultSet result = keys_users.pegarChave(new String(chaveDescriptografada));
		
		if(!result.first())
		{
			%><p>Erro. Esta chave nao existe!</p><%
		}
		else
		{
			Email email = Emails.getEmail(result.getString("usuario"), result.getString("conta"));
			Emails.autenticar(email);
			
			session.setAttribute("QtdEmailsUsuario", (int)session.getAttribute("QtdEmailsUsuario")+1);
			
			session.setAttribute("atual", (int)session.getAttribute("QtdEmailsUsuario"));
				
			session.setAttribute("Email"+session.getAttribute("QtdEmailsUsuario"), email);
			
			response.sendRedirect("inbox.jsp");
		}
	}
	catch(Exception e)
	{
		%><p>ERRO: <%=e.getMessage() %></p>
		<%
	}

%>
</body>
</html>