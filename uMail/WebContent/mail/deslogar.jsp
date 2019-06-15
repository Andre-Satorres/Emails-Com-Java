<%
session.removeAttribute("usuario"); 
session.invalidate(); 
response.sendRedirect("../index.jsp"); 
return;
