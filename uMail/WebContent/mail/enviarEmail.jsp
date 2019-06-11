<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="emailmanipulator.*, bd.daos.*"
    pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

<%
try
{
   	String result;
   
   	String[] to, cc, cco, an;
   	String assunto="";
   
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
   	
   	if( request.getParameter("cc").trim().length()>0)
   		 an = request.getParameter("anexos").trim().split(",");
   	else
   		an = new String[0];
   	
   assunto = request.getParameter("assunto").trim();
   StringBuffer text = new StringBuffer(request.getParameter("emailarea"));
  
   int loc = (new String(text)).indexOf('\n');
   while(loc > 0)
   {
       text.replace(loc, loc+1, "<BR>");
       loc = (new String(text)).indexOf('\n');
  }
   
  String message = text.toString();
   
   String conta = (String)session.getAttribute("usuario");
   
   EmailManipulator em = new EmailManipulator("andre", "satorres", "mommavalos@gmail.com", "Sem1seiji", 995, 465, 
		   									Segurancas.getSeguranca(2), Hosts.getHost(3), "gmail.com", conta);
   
   em.createEmailMessage(false, to, cc, cco, assunto, message, an);
}
catch(Exception e)
{
	e.printStackTrace();
	request.setAttribute("errorMessageEnv", e.getMessage());
}
	request.getRequestDispatcher("inbox.jsp").forward(request, response);
%>
