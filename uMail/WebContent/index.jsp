<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*"
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
          <form class="main-form" action="login.jsp" method="post">
            <h3>Entrar</h3>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Endere�o de email" id="usuario" name="usuario">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Senha" id="senha" name="senha">
            </div>
            <div class="form-group">
              <input type="submit" class="btn-submit" value="Entrar">
            </div>
          </form>
        </div>
        <div class="pad-content-main pad-content">
          <form class="pad-content thank-form" action="index.html" method="post">
            <h3 class="pad-content-1">Est�o gostando de nossos servi�os?</h3>
            <h3 class="pad-content">Obrigado por utilizar nossos servi�os.</h3>
            <h3 class="pad-content">uMail, todos os direitos reservados.</h3>
          </form>
        </div>
      </div>
      <div class="flex-form">
        <form class="main-form" action="index.html">
          <img src="img/mail.png" alt="">
        </form>
      </div>
      <div class="flex-form">
        <form class="main-form" action="cadastrar.jsp" method="post">
          <h3>Cadastro</h3>
          <div class="flex-content">
            <div class="form-group name-box">
              <input type="text" class="form-control" placeholder="Nome" id="nome" name="nome">
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Sobrenome" id="sobrenome" name="sobrenome">
            </div>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Email" id="usuario" name = "usuario">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="Senha" id="senha" name = "senha">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="Confirmar senha" id="confSenha" name="confSenha">
          </div>
          <div class="form-group">
            <input type="number" class="form-control" placeholder="Porta" min="1" max="65535" id="porta" name="porta">
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
            <input type="submit" class="btn-submit" value="Cadastrar">
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
