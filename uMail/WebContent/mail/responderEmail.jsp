<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, 
																	 emailmanipulator.*"
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
	EmailManipulator email = (EmailManipulator)session.getAttribute("Email1");
	
	email.replyEmail(toEmails, emailSubject, emailBody, anexos);

%>
</body>
</html>