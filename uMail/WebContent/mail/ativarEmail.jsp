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
<script src="./Materialart Admin Template_files/jquery.min.js.download"></script>
<body>
<div class="flex-form">
        <form class="main-form" action="ativar.jsp" method="post">
          <h3>Ativar Conta</h3>
          <%
          	MeuResultSet emailsNAuth = Emails.naoAutenticadosDaConta(conta);
          
      		if(!emailsNAuth.first())
      		{%><h2>Sua conta não possui autenticações pendentes.</h2>
      			<input type="button" class="btn-submit" value="Voltar" id="voltar"><%}
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
	            <input type="button" class="btn-submit" value="Voltar" id="voltar">
	            <input type="reset" class="btn-submit" value="Limpar Dados">
	            <input type="reset" class="btn-submit" value="Excluir Email" id="excluir">
	            <input type="reset" class="btn-submit" value="Alterar Email" id="alterar">
	            <input type="submit" class="btn-submit" value="Ativar">
	          </div>
	          
	          <div class="form-group">
	              <label id="erro"><%=(session.getAttribute("erroAtivacao")==null?"":session.getAttribute("erroAtivacao"))%></label>
	              <label id="erro"><%=(session.getAttribute("erroExcluirN")==null?"":session.getAttribute("erroExcluirN"))%></label>
	         </div>
	         <%}%>
         
       </form>
      </div>
      
      <div class="divmensagem" style="display:none;">Confira em seu email o código de ativação que lhe enviamos!</div>
      
	 <%session.removeAttribute("erroAtivacao"); %>
	 
	 <script>
	 	$('#alterar').click(function() 
	 	{
	 		 window.location.href =  "alterarEmail.jsp?u="+$('select').val();
		});
	 	
	 	$('#excluir').click(function() 
	 	{
	 		 window.location.href = "excluirEmailNaoAutenticado.jsp?u="+$('select').val();
		});
	 	
	 	$('#voltar').click(function() 
	 	{
	 		 window.location.href = "inbox.jsp";
		});
	 		 	
	 	
		$(document).ready(function(){
            $('#divmensagem').fadeIn('slow', function(){
               $('#divmensagem').delay(5000).fadeOut(); 
            });
        });
	 </script>
</body>
</html>