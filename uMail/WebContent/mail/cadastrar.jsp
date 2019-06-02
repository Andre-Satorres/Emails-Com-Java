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
		String nome      = request.getParameter("nome");
		String sobrenome = request.getParameter("sobrenome");
		String usuario   = request.getParameter("usuario");
		String senha     = request.getParameter("senha");
		String confSenha = request.getParameter("confSenha");
		String host      = request.getParameter("host");
		int porta        = Integer.parseInt(request.getParameter("porta"));
		String seg       = request.getParameter("seguranca");
		String conta     = (String)session.getAttribute("usuario");
		
		if(!(senha.equals(confSenha)))
		{
			request.setAttribute("errorMessageCadastro", "Senhas não coincidem!");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		
		Seguranca seguranca;
		Host host_certo;
		
		if(seg.equals("SSL"))
			seguranca = Segurancas.getSeguranca(2);
		else
			seguranca = Segurancas.getSeguranca(1);
		
		
		if(host.equals("POP3"))
			host_certo = Hosts.getHost(1);
		else
			host_certo = Hosts.getHost(2);
		
		String servidor = usuario.substring(usuario.indexOf("@")+1, usuario.length()-1);
		
		Email email = new Email(usuario, senha, porta, seguranca, host_certo, nome, sobrenome, servidor, conta);
		
		Emails.incluir(email);
		
		session.setAttribute("Email"+session.getAttribute("QtdEmailsUsuario"), email);
	
		response.sendRedirect("inbox.jsp");
	}
	catch(Exception e)
	{
		request.setAttribute("errorMessageCadastro", "Um ou mais campos inválidos!");
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>
</body>
</html>