<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="emailmanipulator.*, bd.daos.*"
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
		   									Segurancas.getSeguranca(2), Hosts.getHost(3), "gmail.com", LoginMails.getUsuario(conta));
   
   em.createEmailMessage(false, to, cc, cco, assunto, message, an);
   
   response.sendRedirect("inbox.jsp");
}
catch(Exception e)
{
	e.printStackTrace();
	request.setAttribute("errorMessageEnv", e.getMessage());
}

	response.sendRedirect("inbox.jsp");
%>
