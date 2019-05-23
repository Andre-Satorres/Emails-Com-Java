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
   		String usuario = request.getParameter("usuario");
		String senha   = request.getParameter("senha");
	
		try
		{
			if(Emails.cadastrado(usuario))
			{
				session.setAttribute("usuario", usuario);
				response.sendRedirect("mail/index.jsp");
			}
			else
				request.setAttribute("errorMessage", "Senhas não coincidem!");
			
			response.sendRedirect("index.jsp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	%>
 
</body>
</html>