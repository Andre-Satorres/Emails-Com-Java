<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "bd.dbos.*, emailmanipulator.*,
																javax.mail.Folder"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	int j = Integer.parseInt(request.getParameter("i"));	

	Email email = (Email)session.getAttribute("Email"+session.getAttribute("atual"));
	EmailManipulator em = new EmailManipulator(email);
	String folder = (String)session.getAttribute("pastaAtual");
	em.fecharPasta(folder);
	Folder[] f = em.obterTodasAsPastas();
	session.setAttribute("pastaAtual", f[j].getName());
	response.sendRedirect("inbox.jsp");
%>

</body>
</html>