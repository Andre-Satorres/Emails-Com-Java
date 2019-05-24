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
	    String usuario = request.getParameter("usuarioL");
   		if(!LoginMails.cadastrado(usuario) || !(LoginMails.getUsuario(usuario).getSenha().equals(request.getParameter("senhaL"))))
   		{
   			request.setAttribute("errorMessage", "Usuário ou senha inválidos!");
   			request.getRequestDispatcher("/index.jsp").forward(request, response);
   		}
   		else
   		{
   			session.setAttribute("usuario", usuario);
   			response.sendRedirect("mail/inbox.jsp");
   			
   		}
   }
   catch(Exception e)
   {
	   request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/index.jsp").forward(request, response);
   }
    
%>
	
</body>
</html>