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
int i = Integer.parseInt(request.getParameter("i"));
int qtd = (int)session.getAttribute("QtdEmailsUsuario");
session.setAttribute("QtdEmailsUsuario", qtd-1);

Email em = (Email)session.getAttribute("Email"+i);
session.removeAttribute("Email"+i);

Emails.excluir(em.getUsuario(), em.getConta().getUsuario());

response.sendRedirect("inbox.jsp");
%>
</body>
</html>