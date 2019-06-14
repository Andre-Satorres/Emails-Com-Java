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
              value = "<%= (request.getParameter("nome")!= null?request.getParameter("nome"):"")%>">
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Sobrenome" id="sobrenome" name="sobrenome"
              value = "<%= (request.getParameter("sobrenome")!= null?request.getParameter("sobrenome"):"")%>">
            </div>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Email" id="usuario" name = "usuario"
            value = "<%= (request.getParameter("usuario")!= null?request.getParameter("usuario"):"")%>">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="Senha" id="senha" name = "senha">
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Recepção" min="1" max="65535" id="portaR" name="portaR"
            value = "<%= (request.getParameter("portaR")!= null?request.getParameter("portaR"):"")%>">
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta de Envio" min="1" max="65535" id="portaE" name="portaE"
            value = "<%= (request.getParameter("portaE")!= null?request.getParameter("portaE"):"")%>">
          </div>
          <div class="form-group">
            <select class="form-control" name="seguranca" id="seguranca"> 
              <option>SSL</option>
              <option>TSL</option>
            </select>
          </div>
          <div class="form-group">
            <select class="form-control" name="host" id="host">
              <option>POP3</option>
              <option>IMAP</option>
            </select>
          </div>  
          <div class="form-group">
            <input type="button" class="btn-submit" value="Voltar">
          </div>
          <div class="form-group">
            <input type="reset" class="btn-submit" value="Limpar Dados">
          </div>
          <div class="form-group">
            <input type="submit" class="btn-submit" value="Cadastrar">
          </div>
          <div class="form-group">
              <label><%=(request.getAttribute("errorMessageCadastro")!= null?request.getAttribute("errorMessageCadastro"):"") %></label>
            </div>
        </form>
      </div>

</body>
</html>