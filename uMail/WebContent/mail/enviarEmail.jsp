<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="emailmanipulator.*, bd.daos.*"
    pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

<%
try
{

   String result;
   
   // Recipient's email ID needs to be mentioned.
   String[] to = request.getParameter("para").trim().split(";");
   String[] cc = request.getParameter("cc").trim().split(";");
   String[] cco= request.getParameter("cco").trim().split(";");
   String[] an = request.getParameter("anexos").trim().split(",");
   String assunto = request.getParameter("assunto").trim();
   
   String conta = (String)session.getAttribute("usuario");
   
   EmailManipulator em = new EmailManipulator("andre", "satorres", "mommavalos@gmail.com", "Sem1seiji", 465, 
		   									Segurancas.getSeguranca(2), Hosts.getHost(3), "gmail.com", conta);
   
   em.createEmailMessage(to, cc, cco, assunto, "MEGALOVANIAAAA", an);
}
catch(Exception e)
{
	e.printStackTrace();
	request.setAttribute("errorMessageEnv", e.getMessage());
}
   
	request.getRequestDispatcher("/inbox.jsp").forward(request, response);
%>
