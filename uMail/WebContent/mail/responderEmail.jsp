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
	try
	{
		int qual = Integer.parseInt(request.getParameter("i"));
		Message msg = (Message)session.getAttribute("Mensagem");
		Email email = (Email)session.getAttribute("Email1");
		EmailManipulator em = new EmailManipulator(email);
		em.createEmailMessage(true, msg.getRecipients(Message.RecipientType.TO), 
				msg.getRecipients(Message.RecipientType.CC), msg.getRecipients(Message.RecipientType.BCC), 
				"Mano?????", "Respostinha padrao", null);
		
		response.sendRedirect("inbox.jsp");
	}
	catch(Exception e)
	{
		e.printStackTrace();
		request.getRequestDispatcher("inbox.jsp").forward(request, response);
	}
%>
</body>
</html>