<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*, bd.core.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
<%
   try
   {
	    String usuario = request.getParameter("usuarioL");
   		if(!LoginMails.cadastrado(usuario) || !(LoginMails.getUsuario(usuario).getSenha().equals(request.getParameter("senhaL"))))
   		{
   			request.setAttribute("errorMessage", "Usuário ou senha inválidos!");
   			request.getRequestDispatcher("/index.jsp").forward(request, response);
   		}
   		else
   		{
   			session.setAttribute("usuario", usuario);
   			
   			MeuResultSet contasVinculadas = Emails.contaTemEmails(usuario);
   			
   			if(!contasVinculadas.first())
   			{
   				response.sendRedirect("mail/CadastrarEmail.jsp");
   				session.setAttribute("QtdEmailsUsuario", 0);
   			}
   			else
   			{
   				contasVinculadas.beforeFirst();
   				int i=0;
   				Email em = null; 
   				while(contasVinculadas.next())
   				{
   					em = new Email(contasVinculadas.getString("usuario"), contasVinculadas.getString("SENHA"), 
   							             contasVinculadas.getInt   ("Porta"), contasVinculadas.getInt   ("PortaSMTP"), Segurancas.getSeguranca(contasVinculadas.getInt("Seguranca")), 
   		            		             Hosts.getHost(contasVinculadas.getInt ("HOST")), contasVinculadas.getString("nome"), 
   		            		             contasVinculadas.getString("sobrenome"), contasVinculadas.getString("servidor"), 
   		            		             LoginMails.getUsuario(contasVinculadas.getString("conta")));
   					
   					i++;
   					session.setAttribute("Email"+i, em); 	
   					//usuario nesse caso eh o de email, tipo mommavalos@gmail.com
   				}
   				
   				//sessionei tds as contas de email vinculadas a esta conta de usuario
   				session.setAttribute("QtdEmailsUsuario", i);
   				session.setAttribute("atual", i);
   				response.sendRedirect("mail/inbox.jsp");
   			}
   		}
   }
   catch(Exception e)
   {
	   request.setAttribute("errorMessage", e.getMessage());
   	   request.getRequestDispatcher("/index.jsp").forward(request, response);
   }
    
%>
	
</body>
</html>