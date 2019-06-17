<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "bd.dbos.*, bd.daos.*, senhaaltamentesegura.*"
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
		String senha     = request.getParameter("senha");
		String confSenha = request.getParameter("confsenha");
		
		if(!(senha.equals(confSenha)))
		{
			request.setAttribute("errorMessageCad", "Senhas não coincidem!");
			response.sendRedirect("index.jsp");
		}
		
		if(!(LoginMails.cadastrado(usuario)))	
		{
			LoginMail new_user = new LoginMail(usuario, SenhaAltamenteSegura.gerarSenhaForte(senha));
			LoginMails.incluir(new_user);
			session.setAttribute("usuario", usuario);
			session.setAttribute("QtdEmailsUsuario", 0);
			session.setAttribute("atual", 0);
			response.sendRedirect("mail/CadastrarEmail.jsp");
		}
		else 
		{
			request.setAttribute("errorMessageCad", "Este usuário já existe!");
			
			response.sendRedirect("index.jsp");	
		}
	}
	catch(Exception e)
	{
		request.setAttribute("errorMessageCad", e.getMessage());
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>