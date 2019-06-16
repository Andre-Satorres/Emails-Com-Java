<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.security.Key, javax.crypto.Cipher, 
																	javax.crypto.KeyGenerator, bd.dbos.*, bd.daos.*,
																	bd.core.*"
    pageEncoding="ISO-8859-1"%>

<%
	try
	{
		String conta   = (String)session.getAttribute("usuario");
		String chave   = request.getParameter("chave");
		String usuario = request.getParameter("usuario");
		
		key_user chave_usuario = keys_users.getKey_user(usuario, conta);
		
		if(!(chave.equals(chave_usuario.getChave()))) //chave nao bate com o BD
		{
			session.setAttribute("erroAtivacao", "Chave invalida para este email. Verifique se a senha e chave estão corretas!");
			response.sendRedirect("ativarEmail.jsp");
		}
		else //chave digitada confere com a do BD
		{
			Emails.autenticar(usuario, conta);
			keys_users.excluir(usuario, conta);
			response.sendRedirect("inbox.jsp");
		}
	}
	catch(Exception e)
	{
		session.setAttribute("erroAtivacao", "Erro inesperado!");
		response.sendRedirect("ativarEmail.jsp");
	}
%>