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
		System.out.print(usuario);
		System.out.print(senha);
	
		try
		{
			if(Emails.cadastrado(usuario, senha))
			{
				session.setAttribute("usuario", usuario);
				response.sendRedirect("mail/index.jsp");
			}
			else
				out.print("Usuário ou senha inválidos!");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	%>
 
</body>
</html>