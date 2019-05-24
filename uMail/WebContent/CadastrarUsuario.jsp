<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "bd.dbos.*, bd.daos.*"
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
		String usuario   = request.getParameter("usuario");
		session.setAttribute("usuario", usuario);
		String senha     = request.getParameter("senha");
		String confSenha = request.getParameter("confsenha");
		
		if(!(senha.equals(confSenha)))
		{
			request.setAttribute("errorMessageCad", "Senhas não coincidem!");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			response.sendRedirect("index.jsp");
		}
		
		if(!(LoginMails.cadastrado(usuario)))	
		{
			LoginMail new_user = new LoginMail(usuario, senha);
			LoginMails.incluir(new_user);
			response.sendRedirect("mail/inbox.jsp");
		}
		else 
		{
			request.setAttribute("errorMessageCad", "Este usuário já existe!");
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			response.sendRedirect("index.jsp");	
		}
	}
	catch(Exception e)
	{
		request.setAttribute("errorMessageCad", e.getMessage());
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
		response.sendRedirect("index.jsp");
		
	}
%>
</body>
</html>