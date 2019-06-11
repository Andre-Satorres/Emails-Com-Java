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
int qualEmail = Integer.parseInt((String)request.getParameter("i"));
int total = (int)(session.getAttribute("QtdEmailsUsuario"));

if(qualEmail < total)
	session.setAttribute("atual", qualEmail);
else
	session.setAttribute("atual", total);

response.sendRedirect("inbox.jsp");
//request.getRequestDispatcher("inbox.jsp").forward(request, response);
	
%>
</body>
</html>