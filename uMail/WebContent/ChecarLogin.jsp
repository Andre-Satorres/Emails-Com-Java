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
   		if(!LoginMails.cadastrado(usuario))
   		{
   			request.setAttribute("errorMessage", "Usu�rio ou senha inv�lidos!");
   			request.getRequestDispatcher("/index.jsp").forward(request, response);
   		}
   		else
   		{
   			session.setAttribute("usuario", usuario);
   			response.sendRedirect("mail/index.jsp");
   		}
   }
   catch(Exception e)
   {}
    
%>
	
</body>
</html>