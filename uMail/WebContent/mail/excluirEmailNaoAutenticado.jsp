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
		String email = request.getParameter("u");
		String conta = (String)session.getAttribute("usuario");
		Emails.excluir(email, conta);
		keys_users.excluir(email, conta);
	}
	catch(Exception e)
	{
		session.setAttribute("erroExcluirN", "Erro ao excluir este email." + e.getMessage());
	}

	response.sendRedirect("ativarEmail.jsp");
%>
</body>
</html>