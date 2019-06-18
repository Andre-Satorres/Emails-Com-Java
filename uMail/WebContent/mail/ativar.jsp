<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.security.Key, javax.crypto.Cipher, 
																	javax.crypto.KeyGenerator, bd.dbos.*, bd.daos.*,
																	bd.core.*, emailmanipulator.*, criptoslyde.*"
    pageEncoding="ISO-8859-1"%>

<%
	try
	{
		String conta   = (String)session.getAttribute("usuario");
		String chave   = request.getParameter("chave").trim();
		String usuario = request.getParameter("usuario").trim();
		
		key_user chave_usuario = keys_users.getKey_user(usuario, conta);
		
		if(!(chave.equals(chave_usuario.getChave()))) //chave nao bate com o BD
		{
			session.setAttribute("erroAtivacao", "Chave invalida para este email. Verifique se a chave está correta!");
			response.sendRedirect("ativarEmail.jsp");
		}
		else //chave digitada confere com a do BD
		{
			Email email = Emails.getEmail(usuario, conta);		
			email.setSenha(CriptoSlyDe.descriptografar(email.getSenha()));	
			EmailManipulator em = new EmailManipulator(email);
	
			em.authenticate(1);
			
			try
			{
				em.setStore();
				em.abrirPasta("INBOX", 0);
				
			}
			catch(Exception e)
			{
				session.setAttribute("erroAtivacao", "Falha de autenticação. Senha e/ou porta de recepção erradas.");
				response.sendRedirect("ativarEmail.jsp");
				return;
			}
			
			em.authenticate(0);
			try
			{
				em.setStore();
				em.testarConexao();
			}
			catch(Exception e)
			{
				e.getMessage();
				session.setAttribute("erroAtivacao", "Falha de autenticação. Senha e/ou porta de envio (SMTP) erradas.");
				response.sendRedirect("ativarEmail.jsp");
				return;
			}
		
			Emails.autenticar(usuario, conta);
			keys_users.excluir(usuario, conta);

			session.setAttribute("QtdEmailsUsuario", (int)(session.getAttribute("QtdEmailsUsuario"))+1);
			session.setAttribute("atual", session.getAttribute("QtdEmailsUsuario"));
			session.setAttribute("Email"+session.getAttribute("QtdEmailsUsuario"), email);
			response.sendRedirect("inbox.jsp");
		}
	}
	catch(Exception e)
	{
		session.setAttribute("erroAtivacao", e.getMessage());
		response.sendRedirect("ativarEmail.jsp");
	}
%>