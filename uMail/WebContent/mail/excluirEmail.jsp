<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*,
																			emailmanipulator.*, bd.dbos.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	int qual = Integer.parseInt(request.getParameter("i"));

	Email em = (Email)session.getAttribute("Email"+session.getAttribute("atual"));
	EmailManipulator email = new EmailManipulator(em);
	
	String pasta = (String)session.getAttribute("pastaAtual");
	
	Message msg = email.getMensagem(pasta, qual);
	
	email.deletarEmail(msg, pasta);
	
	response.sendRedirect("inbox.jsp?i="+session.getAttribute("qtd"));
%>
</body>
</html>