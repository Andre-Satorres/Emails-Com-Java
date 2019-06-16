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

		Emails.excluir(email, (String)session.getAttribute("usuario"));
	}
	catch(Exception e)
	{
		session.setAttribute("erroExcluirN", "Erro ao excluir este email." + e.getMessage());
	}

	response.sendRedirect("ativarEmail.jsp");
%>
</body>
</html>