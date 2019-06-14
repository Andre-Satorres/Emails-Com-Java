<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int i = (int)request.getAttribute("i");
int qtd = (int)session.getAttribute("QtdEmailsUsuario");
session.setAttribute("QtdEmailsUsuario", qtd-1);

session.removeAttribute("Email"+i);

response.sendRedirect("inbox.jsp");
%>
</body>
</html>