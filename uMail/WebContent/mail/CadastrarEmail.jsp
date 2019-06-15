<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/master.css">
<title>Cadastro de contas email - <%=session.getAttribute("usuario")%></title>
</head>
<body>
<div class="flex-form">
        <form class="main-form" action="cadastrar.jsp" method="post">
          <h3>Cadastro</h3>
          <div class="flex-content">
            <div class="form-group name-box">
              <input type="text" class="form-control" placeholder="Nome" id="nome" name="nome"
              value = "<%= (request.getParameter("nome")!= null?request.getParameter("nome"):"")%>" required>
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Sobrenome" id="sobrenome" name="sobrenome"
              value = "<%= (request.getParameter("sobrenome")!= null?request.getParameter("sobrenome"):"")%>" required>
            </div>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Email" id="usuario" name = "usuario"
            value = "<%= (request.getParameter("usuario")!= null?request.getParameter("usuario"):"")%>" required>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="Senha" id="senha" name = "senha" required>
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Recepção" min="1" max="65535" id="portaR" name="portaR"
            value = "<%= (request.getParameter("portaR")!= null?request.getParameter("portaR"):"")%>" required>
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Envio" min="1" max="65535" id="portaE" name="portaE"
            value = "<%= (request.getParameter("portaE")!= null?request.getParameter("portaE"):"")%>" required>
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
            <input type="button" class="btn-submit" value="Voltar">
            <input type="reset" class="btn-submit" value="Limpar Dados">
            <input type="submit" class="btn-submit" value="Cadastrar">
          </div>
          
          <div class="form-group">
              <label><%=session.getAttribute("errorMessageCadastro")==null?"":session.getAttribute("errorMessageCadastro")%></label>
         </div>
         
       </form>
      </div>
	 <%session.removeAttribute("errorMessageAlteracao"); %>
</body>
</html>