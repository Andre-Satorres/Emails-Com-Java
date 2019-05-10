<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String seg       = request.getParameter("seguranca");
		int porta        = Integer.parseInt(request.getParameter("porta"));
		String host      = request.getParameter("host");
		String nome      = request.getParameter("nome");
		String sobrenome = request.getParameter("sobrenome");
		String usuario   = request.getParameter("usuario");
		String senha     = request.getParameter("senha");
		String confSenha = request.getParameter("confSenha");
		
		try
		{
			if(!(senha.equals(confSenha)))
				response.sendError(500, "Senhas diferentes!");
			
			int seguranca, servidor;
			
			if(seg.equals("SSL"))
				seguranca = 2;
			else
				seguranca = 2;
			
			if(host.equals("POP3"))
				servidor = 1;
			else
				servidor = 2;
			
			Email email = new Email(nome, sobrenome, usuario, senha, porta, seguranca, servidor);
			
			Emails.incluir(email);
		
			response.sendRedirect("mail/index.jsp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	%>
</body>
</html>