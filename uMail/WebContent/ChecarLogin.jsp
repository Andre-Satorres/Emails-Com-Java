<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*, bd.core.*, senhaaltamentesegura.*, criptoslyde.*"
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
	    String senha = request.getParameter("senhaL");
	    
   		if(!LoginMails.cadastrado(usuario))
   		{
   			request.setAttribute("errorMessage", "Usuário ou senha inválidos!");
   			request.getRequestDispatcher("/index.jsp").forward(request, response);
   		}
   		else
   		{
   			boolean checarSenha = SenhaAltamenteSegura.validarSenha(senha, LoginMails.getSenha(usuario));
   			
   			if(!checarSenha)
   			{
   				request.setAttribute("errorMessage", "Usuário ou senha inválidos!");
   	   			request.getRequestDispatcher("/index.jsp").forward(request, response);
   			}
   			else
   			{
   			
	   			session.setAttribute("usuario", usuario);
	   			
	   			MeuResultSet contasVinculadas = Emails.contaTemEmails(usuario);
	   			MeuResultSet nAutenticados = Emails.naoAutenticadosDaConta(usuario);
	   			
	   			if(!contasVinculadas.first())
	   			{
	   				session.setAttribute("QtdEmailsUsuario", 0);
	   				
	   				if(!(nAutenticados.first()))	
	   					response.sendRedirect("mail/CadastrarEmail.jsp");
	   				else
	   					response.sendRedirect("mail/ativarEmail.jsp");
	   			}
	   			else
	   			{
	   				contasVinculadas.beforeFirst();
	   				int i=0;
	   				Email em = null; 
	   				while(contasVinculadas.next())
	   				{
	   					em = new Email(contasVinculadas.getString("usuario"), CriptoSlyDe.descriptografar(contasVinculadas.getString("SENHA")), 
	   							             contasVinculadas.getInt   ("Porta"), contasVinculadas.getInt("PortaSMTP"), Segurancas.getSeguranca(contasVinculadas.getInt("Seguranca")), 
	   		            		             Hosts.getHost(contasVinculadas.getInt ("HOST")), contasVinculadas.getString("nome"), 
	   		            		             contasVinculadas.getString("sobrenome"), contasVinculadas.getString("servidor"), 
	   		            		             LoginMails.getUsuario(contasVinculadas.getString("conta")), contasVinculadas.getInt("autenticado"));
	   					
	   					i++;
	   					
	   					if(em.getAutenticado() == 1)
	   						session.setAttribute("Email"+i, em); 
	   					else
	   						i--;
	   					
	   					//usuario nesse caso eh o de email, tipo mommavalos@gmail.com
	   				}
	   				
	   				//sessionei tds as contas de email vinculadas a esta conta de usuario
	   				session.setAttribute("QtdEmailsUsuario", i);
	   				session.setAttribute("atual", i);
	   				response.sendRedirect("mail/inbox.jsp");
	   			}
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