<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*, emailmanipulator.*"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
  <title>uMail v1.0</title>
  <link rel="stylesheet" href="css/master.css">
  <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
</head>
<body>
  <div class="main">
    <div class="container">
      <div class="">
        <div class="">
          <form class="main-form" action="ChecarLogin.jsp" method="post">
            <h3>Entrar</h3>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Usuário" id="usuarioL" name="usuarioL" 
              value="<%= (request.getParameter("usuarioL")!= null?request.getParameter("usuarioL"):"")%>">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Senha" id="senhaL" name="senhaL">
            </div>
            <div class="form-group">
              <input type="submit" class="btn-submit" value="Entrar" onclick="">
            </div>
            <div class="form-group">
              <label><%=(request.getAttribute("errorMessage")!= null?request.getAttribute("errorMessage"):"") %></label>
            </div>
          </form>
        </div>
        <div class="pad-content-main pad-content">
          <form class="pad-content thank-form" action="index.html" method="post">
            <h3 class="pad-content-1">Estão gostando de nossos serviços?</h3>
            <h3 class="pad-content">Obrigado por utilizar nossos serviços.</h3>
            <h3 class="pad-content">uMail, todos os direitos reservados.</h3>
          </form>
        </div>
      </div>
      <div class="flex-form">
        <form class="main-form" action="index.html">
          <img src="img/mail.png" alt="">
        </form>
      </div>
      <div class="">
          <form class="main-form" action="CadastrarUsuario.jsp" method="post">
            <h3>Cadastrar</h3>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Usuário" id="usuario" name="usuario"
              value="<%= (request.getParameter("usuario")!= null?request.getParameter("usuario"):"")%>">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Senha" id="senha" name="senha">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Confirmar Senha" id="confsenha" name="confsenha">
            </div>
            <div class="form-group">
              <input type="submit" class="btn-submit" value="Cadastrar">
            </div>
            <div class="form-group">
              <label><%=(request.getAttribute("errorMessageCad")!= null?request.getAttribute("errorMessageCad"):"") %></label>
            </div>
          </form>
        </div>
    </div>
  </div>
</body>
</html>
