<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.Multipart, javax.mail.internet.MimeBodyPart"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String i = request.getParameter("i");
	int index = Integer.parseInt(i);
	Multipart multipart = (Multipart)session.getAttribute("multipart");
	MimeBodyPart part = (MimeBodyPart)multipart.getBodyPart(index);
	part.saveFile((String)session.getAttribute("path"+index));
	
	int ql = (int)session.getAttribute("ql");
	response.sendRedirect("verEmail.jsp?i="+ql);
%>
</body>
</html>