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
	try
	{
		String seg       = request.getParameter("seguranca");
		int porta        = Integer.parseInt(request.getParameter("porta"));
		String host      = request.getParameter("host");
		String nome      = request.getParameter("nome");
		String sobrenome = request.getParameter("sobrenome");
		String usuario   = request.getParameter("usuario");
		String senha     = request.getParameter("senha");
		String confSenha = request.getParameter("confSenha");
		
		if(!(senha.equals(confSenha)))
		{
			request.setAttribute("errorMessageCadastro", "Senhas não coincidem!");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		
		int seguranca, servidor;
		
		if(seg.equals("SSL"))
			seguranca = 2;
		else
			seguranca = 2;
		
		if(host.equals("POP3"))
			servidor = 1;
		else
			servidor = 2;
		
		Email email = new Email(nome, sobrenome, usuario, senha, porta, seguranca, host, servidor);
		
		Emails.incluir(email);
	
		response.sendRedirect("mail/index.jsp");
	}
	catch(Exception e)
	{
		request.setAttribute("errorMessageCadastro", "Um ou mais campos inválidos!");
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>
</body>
</html>