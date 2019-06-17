<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "bd.dbos.*, bd.daos.*, criptoslyde.*"
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
		String nome      = request.getParameter("nome");
		String sobrenome = request.getParameter("sobrenome");
		String usuario   = request.getParameter("usuario");
		String senha     = request.getParameter("senha");
		String host      = request.getParameter("host");
		int portaR        = Integer.parseInt(request.getParameter("portaR"));
		int portaE        = Integer.parseInt(request.getParameter("portaE"));
		String seg       = request.getParameter("seguranca");
		String conta     = (String)session.getAttribute("usuario");
		
		Seguranca seguranca;
		Host host_certo;
		
		if(seg.equals("SSL"))
			seguranca = Segurancas.getSeguranca(2);
		else
			seguranca = Segurancas.getSeguranca(1);
		
		
		if(host.equals("POP3"))
			host_certo = Hosts.getHost(1);
		else
			host_certo = Hosts.getHost(2);
		
		String servidor = usuario.substring(usuario.indexOf("@")+1, usuario.length());
		
		Email email = new Email(usuario, CriptoSlyDe.gerarSenhaCriptografada(senha), portaR, portaE, seguranca, host_certo, nome, sobrenome, servidor, 
								LoginMails.getUsuario(conta), 0);
		
		Emails.alterar(email);
		
		if(session.getAttribute("i") != null)
		{
			session.setAttribute("Email" + session.getAttribute("i"), Emails.getEmail(usuario, conta));
			response.sendRedirect("inbox.jsp");
		}
		else
			response.sendRedirect("ativarEmail.jsp");
	}
	catch(Exception e)
	{
		session.setAttribute("errorMessageAlteracao", "Um ou mais campos inválidos!");
		
		response.sendRedirect("alterarEmail.jsp");
	}

%>		
</body>
</html>