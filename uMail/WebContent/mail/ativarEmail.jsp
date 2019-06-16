<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="bd.daos.*, bd.dbos.*, bd.core.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%String conta = (String)session.getAttribute("usuario"); %>
<title>Ativar Conta - <%=conta%></title>
</head>
<link rel="stylesheet" type="text/css" href="../css/master.css">
<body>
<div class="flex-form">
        <form class="main-form" action="ativar.jsp" method="post">
          <h3>Ativar Conta</h3>
          <%
          	MeuResultSet emailsNAuth = Emails.naoAutenticadosDaConta(conta);
          
      		if(!emailsNAuth.first())
      		{%><h2>Sua conta não possui autenticações pendentes.</h2><%}
      		else{%>
	          <div class="form-group">
	            <select class="form-control" name="usuario" id="usuario" required>
	            <%     		
	            	emailsNAuth.beforeFirst();	
	            	while(emailsNAuth.next())
	            		{%><option><%=emailsNAuth.getString("usuario")%></option><%}%>
	            </select>
	          </div>  
	          
			  <div class="form-group">
	            <input type="text" class="form-control" placeholder="Chave" id="chave" name = "chave" required>
	          </div>
	          
	          <div class="form-group">
	            <input type="button" class="btn-submit" value="Voltar" onClick="window.history.back()">
	            <input type="reset" class="btn-submit" value="Limpar Dados">
	            <input type="reset" class="btn-submit" value="Excluir Email">
	            <input type="reset" class="btn-submit" value="Alterar Email" onClick="window.location='/alterarEmail?i='<%=0/*por enqt zero*/%>">
	            <input type="submit" class="btn-submit" value="Ativar">
	          </div>
	          
	          <div class="form-group">
	              <label id="erro"><%=(session.getAttribute("erroAtivacao")==null?"":session.getAttribute("erroAtivacao"))%></label>
	         </div>
	         <%}%>
         
       </form>
      </div>
	 <%session.removeAttribute("erroAtivacao"); %>
</body>
</html>