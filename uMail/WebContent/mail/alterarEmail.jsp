<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.dbos.*, bd.daos.*, criptoslyde.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/master.css">
<title>Alterar conta email - <%=session.getAttribute("usuario")%></title>
</head>
<body>
<%
	Email email = (Email)session.getAttribute("Email"+request.getParameter("i"));
	session.setAttribute("i", request.getParameter("i"));
	
	if(email == null) //veio da tela de ativar email
	{
		String e = request.getParameter("u");
		email = Emails.getEmail(e, (String)session.getAttribute("usuario"));
		email.setSenha(CriptoSlyDe.descriptografar(email.getSenha()));
		session.setAttribute("i", null);
	}
%>
<div class="flex-form">
        <form class="main-form" action="alterar.jsp" method="post">
          <h3>Cadastro</h3>
          <div class="flex-content">
            <div class="form-group name-box">
              <input type="text" class="form-control" placeholder="Nome" id="nome" name="nome"
              value = "<%=(email.getNome()!= null?email.getNome():"")%>" required>
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Sobrenome" id="sobrenome" name="sobrenome"
              value = "<%= (email.getSobrenome()!= null?email.getSobrenome():"")%>" required>
            </div>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Email" id="usuario" name = "usuario"
            value = "<%=email.getUsuario()%>" readonly>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="Senha" id="senha" name = "senha" 
            value = "<%= (email.getSenha()!= null?email.getSenha():"")%>" required>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Servidor" id="servidor" name="servidor"
            value = "<%= (request.getParameter("servidor")!= null?request.getParameter("servidor"):"")%>" required>
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Recepção" min="1" max="65535" id="portaR" name="portaR"
            value = "<%= (email.getPortaR()!= 0?email.getPortaR():"")%>" required>
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Envio" min="1" max="65535" id="portaE" name="portaE"
            value = "<%= (email.getPortaE()!= 0?email.getPortaE():"")%>" required>
          </div>
          <div class="form-group">
            <select class="form-control" name="seguranca" id="seguranca" required> 
              <option>SSL</option>
              <option>TLS</option>
            </select>
          </div>
          <div class="form-group">
            <select class="form-control" name="host" id="host" required>
              <option>POP3</option>
              <option>IMAP</option>
            </select>
          </div>  
          <div class="form-group">
            <input type="button" class="btn-submit" value="Voltar" onClick="window.history.back()">
            <input type="reset" class="btn-submit" value="Limpar Dados">
            <input type="submit" class="btn-submit" value="Alterar">
          </div>
          
          <div class="form-group">
              <label><%=session.getAttribute("errorMessageAlteracao")==null?"":session.getAttribute("errorMessageCadastro")%></label>
         </div>
         
       </form>
      </div>
      
      <script>
      		var val = '<%=email.getSeguranca().getNome().toUpperCase()%>';
		    document.getElementById('seguranca').value= val;
	 </script>
	 
	 <script>
		    var val = '<%=email.getHost().getNome()%>';
		    document.getElementById('host').value=val;
	 </script>
	 
	 <%session.removeAttribute("errorMessageAlteracao"); %>

</body>
</html>