<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="emailmanipulator.*, bd.daos.*, bd.dbos.*"
    pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*, java.nio.file.Paths"%>

<%
try
{
   	String result;
   	
   	String[] to, cc, cco = null;
   	File an[] = null;
   	String assunto="";

   	an = (File[])request.getAttribute("anexos");
    
   	if(request.getParameter("para").trim().length()>0)
   		to = request.getParameter("para").trim().split(";");
   	else
   		to = new String[0];
   
   	if( request.getParameter("cc").trim().length()>0)
   		cc= request.getParameter("cc").trim().split(";");
   	else
   		cc = new String[0];
   	
   	if( request.getParameter("cc").trim().length()>0)
   		cco= request.getParameter("cco").trim().split(";");
   	else
   		cco = new String[0];
   	
   assunto = request.getParameter("assunto").trim();
  String text = new String(request.getParameter("emailarea"));
  
  String message = text.toString();
  
  Email email = (Email)session.getAttribute("Email"+session.getAttribute("atual"));
   
  EmailManipulator em = new EmailManipulator(email);
   
   em.createEmailMessage(false, to, cc, cco, assunto, message, an);
   
   response.sendRedirect("mail/inbox.jsp");
}
catch(Exception e)
{
	session.setAttribute("erroEnvio", e.getMessage());
}

%>
