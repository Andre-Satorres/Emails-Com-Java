<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*, emailmanipulator.*,
																			java.util.UUID, java.security.Key, 
																			javax.crypto.Cipher, javax.crypto.KeyGenerator, saltedmd5.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

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
		
		String[] cripto = SaltedMD5.criptografar(senha);
		//cripto[0] eh a senha criptrografada em hexadecimal
		//cripto[1] eh o salt q tenho q salvar no bd
		
		//Hashs.incluir(usuario, cripto[1], conta);
		
		Email email = new Email(usuario, cripto[0], portaR, portaE, seguranca, host_certo, nome, sobrenome, servidor, 
								LoginMails.getUsuario(conta), 0);
		
		Email admin_mail = Emails.getEmail("noreply.uMail@yahoo.com", "admin");
		
		EmailManipulator em = new EmailManipulator(admin_mail);
		

		StringBuilder builder = new StringBuilder();
		
		for(int f=0; f<7; f++) 
		{
			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}

		keys_users.incluir(new key_user(usuario, conta, builder.toString())); //incluo no BD a chave guard

		em.sendConfirmationEmail(usuario, builder.toString()); //envia email com chave

		Emails.incluir(email);
			
		response.sendRedirect("inbox.jsp");
	}
	catch(Exception e)
	{
		session.setAttribute("erroCadastro", "Um ou mais campos inválidos!");
		
		response.sendRedirect("CadastrarEmail.jsp");
	}
	%>
</body>
</html>