<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*"
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
	
	for(int i=0; i<=qtd; i++)
		msgs[qtd+i].setFlag(Flags.Flag.DELETED, true);
	
	response.sendRedirect("inbox.jsp?i="+qtd);
%>
</body>
</html>