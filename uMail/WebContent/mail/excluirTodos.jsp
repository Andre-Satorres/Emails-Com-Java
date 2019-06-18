<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, emailmanipulator.*, bd.dbos.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	int qtd = (int)session.getAttribute("qtd");
	
	Message[] msgs = (Message[])session.getAttribute("emails");
	
	Email em = (Email)session.getAttribute("Email"+session.getAttribute("atual"));
	EmailManipulator email = new EmailManipulator(em);
	
	String pasta = (String)session.getAttribute("pastaAtual");
	
	for(int i=0; i<=qtd; i++)
		email.deletarEmail(msgs[i], pasta);
	
	response.sendRedirect("inbox.jsp?i="+qtd);
%>
</body>
</html>