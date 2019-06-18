<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, 
                         bd.core.*, java.io.*, java.util.Properties, javax.mail.search.*, md5util.*, bd.daos.*, bd.dbos.*, emailmanipulator.*, 
                         java.util.Date, java.util.Calendar, java.util.GregorianCalendar"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" sizes="16x16" href="https://www.wrappixel.com/demos/admin-templates/materialart/assets/images/favicon.png">
    <link rel="stylesheet" type="text/css" href="../css/master.css">
    <link href="./Materialart Admin Template_files/style.css" rel="stylesheet">
    <link href="./Materialart Admin Template_files/email.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" type="text/css" id="u0" href="./Materialart Admin Template_files/skin.min.css"></head>   
    <script src="https://cdn.ckeditor.com/ckeditor5/12.2.0/classic/ckeditor.js"></script>
    
     <style>
            .thumb 
            {
              height: 75px;
              border: 1px solid #000;
              margin: 10px 5px 0 0;
            }
          </style>
    
    <%
	if(session.getAttribute("usuario") == null)
	{
		response.sendRedirect("../index.jsp");
		return;
	}

	//String host = "pop.gmail.com";
	//String user = "mommavalos@gmail.com";
	//String password = "Sem1seiji";
	
	if(session.getAttribute("Email1") == null)
		response.sendRedirect("CadastrarEmail.jsp");
	
	Email em;
	
	int atu = (int)session.getAttribute("atual");
	
	if(session.getAttribute("atual") == null)
		em = (Email)session.getAttribute("Email"+session.getAttribute("QtdEmailsUsuario"));
	else
		em = (Email)session.getAttribute("Email"+ session.getAttribute("atual"));
	
	if(em == null)
	{
		response.sendRedirect("CadastrarEmail.jsp");
		return;
	}
	
	EmailManipulator email = new EmailManipulator(em);
%>
<title><%=session.getAttribute("usuario")%> - uMail</title>
<body>
        <div class="preloader" style="display: none;">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label"><%=email.getNome() %></p>
            </div>
        </div> 
		
        <div class="page-wrapper">
            <div class="app-container">
                <div class="email-app">
                    <div class="left-part scrollable ps ps--theme_default" data-ps-id="69b3cb40-fd65-5233-42d0-89bf43298b9b">
                        <div class="p-15">
                            <a id="compose_mail" class="waves-effect waves-light btn red db" href="javascript: void(0)">Escrever</a>
                        </div>
                        <div class="divider"></div>
                        <ul class="list-group">
                            <li>
                                <small class="p-15 grey-text text-lighten-1 db">Pastas</small>
                            </li>
                            <%
                            	Folder[] pastas = email.obterTodasAsPastas();
                            	if(pastas != null)
                            		session.setAttribute("pastaAtual", pastas[0].getName());
                            	
                            	if(pastas!=null)
                            	for(Folder fd:pastas)
                            	{
                            		%>
                            			<li class="list-group-item">
                            			<%if(fd.equals(pastas[0])) 
                            			  {
                            			  	%>
                                			<a href="javascript:void(0)" class="active">
                                			<i class="material-icons">inbox</i><%=fd.getName().substring(0, 1).toUpperCase() + fd.getName().substring(1).toLowerCase() %>
                                			<span class="label label-success right"><%=(email.quantidadeNaoLidas(fd.getName())==0?"":email.quantidadeNaoLidas(fd.getName()))%></span></a>
                                			<%
                                		  }else {%>
                                			<a href="javascript:void(0)">
                                			<i class="material-icons">inbox</i><%=fd.getName().substring(0, 1).toUpperCase() + fd.getName().substring(1).toLowerCase() %>
                                			<span class="label label-success right"><%=(email.quantidadeNaoLidas(fd.getName())==0?"":email.quantidadeNaoLidas(fd.getName()))%></span></a>
                                			<%} %>
                            			</li>
                            		<%
                            	}
                            
                            %>
                            <li class="list-group-item">
                                <a href="javascript:void(0)"> <i class="material-icons">star</i> Arquivado </a>
                            </li>
                            <li class="list-group-item">
                                <a href="javascript:void(0)"> <i class="material-icons">send</i> Rascunho <span class="label label-danger right">3</span></a>
                            </li>
                            <li>
                                <div class="divider m-t-10  m-b-10"></div>
                            </li>
                            <li class="list-group-item">
                                <a href="javascript:void(0)"> <i class="material-icons">block</i> Spam </a>
                            </li>
                            <li class="list-group-item">
                                <a href="javascript:void(0)"> <i class="material-icons">delete</i> Lixeira </a>
                            </li>
                            <li>
                                <div class="divider m-t-10  m-b-10"></div>
                            </li>
                            
                            <li class="list-group-item">
                                <a href="CadastrarEmail.jsp"> <i class="material-icons">add</i> Adicionar Email </a>
                            </li>
                            
                            <li class="list-group-item">
                                <a href="ativarEmail.jsp"> <i class="material-icons">verified_user</i> Ativar Email </a>
                            </li>
                            
                            <%
                            int qtdEmailsUsuario = (int)(session.getAttribute("QtdEmailsUsuario"));
                            
                            for(int a=qtdEmailsUsuario; a>0; a--)
                            {
                            	if(session.getAttribute("Email"+a) == null)
                            		continue;
                            	
                            	Email umEmail = (Email)session.getAttribute("Email"+a);
                            	String nomeUsuario = umEmail.getUsuario();
                            	int atual = (int)(session.getAttribute("atual"));
                            	
                            	%>
                            	<div class="conteiner">
                            	<li class="list-group-item">
                            	<%if(a==atual)
                            	{	
                            		%>
                                	<span class="active" id="linkEmail"> <i class="material-icons">email</i>
                                							<%=nomeUsuario%></span>
                                	<%
                                }
                            	else
                            	{
                            		%><span id="linkEmail"> <i class="material-icons">email</i>
                                							<%=nomeUsuario%></span>
                                	<%
                            	}
                            	%>
                            	
 								<a id="inEmail" href="mudar.jsp?i=<%=a %>"> <i class="material-icons">contact_mail</i>Entrar</a>
 								<a id="altEmail" href="alterarEmail.jsp?i=<%=a %>"> <i class="material-icons">edit</i>Editar</a>		
                            	<a id="delEmail" href="deslogarEmail.jsp?i=<%=a %>"> <i class="material-icons">unsubscribe</i>Deletar</a>		
 
                            	</li>
                            	</div>
                            	<%
                            } %>
                            
                            
                            <li>
                                <div class="divider m-t-10  m-b-10"></div>
                            </li>
                        </ul>
                    <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                    	<div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                    </div>
                    <div class="ps__scrollbar-y-rail" style="top: 0px; height: 0px; right: 0px;">
                    	<div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                    </div>
                   </div>
                   
                   <label class="logoutLblPos">
					  <span class="glyphicon glyphicon-search"></span>
					  <a href="deslogar.jsp" id="sair">Deslogar</a>
					  </label>
                   
                    <div class="right-part mail-list">
                        <div class="p-15 b-b">
                            <div class="d-flex align-items-center">
                                <div>
                                    <h4>uMail Mailbox <i class="ti-menu ti-close right show-left-panel hide-on-med-and-up"></i></h4>
                                    <span>Lista de todos os emails</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="grey lighten-5 p-15 d-flex no-block">
                            <label>
                                <input type="checkbox" class="sl-all"><span>Marcar Todos</span></label>
                            <div class="ml-auto">
                                <a class="dropdown-trigger font-20" href="" data-target="dme"><i class="material-icons">folder</i><i class="material-icons op-5">expand_more</i></a>

                                <a class="font-20 m-l-5" href=""><i class="material-icons">delete</i></a>
                                <a class="font-20 m-l-10" href="inbox.jsp"><i class="material-icons">refresh</i></a>
                            </div>
                        </div>
                       
                       
<div class="table-responsive">
<table class="email-table no-wrap">
<tbody>                
<%
	try
	{
		Message[] emails = email.mensagens("inbox");
		
		//session.setAttribute("emails", emails);
		
		int qtd = 0;
		
		if(request.getParameter("i") != null)
			qtd = Integer.parseInt(request.getParameter("i"));
		
		session.setAttribute("qtd", qtd);
		
		int max = emails.length - qtd*10 - 1;
			
		for(int i =max; max-i<10; i--)
		{   
            if(i > emails.length-1 || i<0)
            	break;
            
             if(i==i/*!email.isMessageRead("inbox", emails[i])*/){%>
            <tr class="unread">            
            <%}else{ %>
            <tr><%} %>
                <td class="chb">
                    <label>
                        <input type="checkbox"><span></span>
                    </label>
                </td>
                <td class="starred"><i class="fa fa-star-o"></i></td>
                <td class="user-image"><img src="https://www.gravatar.com/avatar/<%=MD5Util.md5Hex(((InternetAddress)emails[i].getFrom()[0]).getAddress()) %>" alt="user" class="circle" width="30"></td>
                <td class="user-name" id="<%=i%>">
                <% String address = ((InternetAddress)emails[i].getFrom()[0]).getAddress();
                if(address.equals(email.getUsuario()))
                		address = "Eu";
                else
                {
                	address = ((InternetAddress)emails[i].getFrom()[0]).getPersonal();
                	if(address == null)
                		address = ((InternetAddress)emails[i].getFrom()[0]).getAddress();
                }
                %>
                    <h6 class="m-b-0"><%=address%></h6>
                </td>
                <td class="max-texts"><a id="mail" class="<%=i%>" href="verEmail.jsp?i=<%=i%>"><%=emails[i].getSubject() %></a></td>
                <td class="clip"><i class="fa fa-paperclip"></i></td>
                <%
	                Date date = new Date();
	                Calendar calendar = new GregorianCalendar();
	                calendar.setTime(date);
	                int year = calendar.get(Calendar.YEAR);
	                //Add one to month {0 - 11}
	                int month = calendar.get(Calendar.MONTH) + 1;
	                int day = calendar.get(Calendar.DAY_OF_MONTH);
	                
	                Date dataMsg = emails[i].getSentDate();
	                Calendar calendario2 = new GregorianCalendar();
	                calendario2.setTime(dataMsg);
	                int anoMsg = calendario2.get(Calendar.YEAR);
	                //Add one to month {0 - 11}
	                int mesMsg = calendario2.get(Calendar.MONTH) + 1;
	                int diaMsg = calendario2.get(Calendar.DAY_OF_MONTH);
	                
	                String retorno = "";
	                
	                if(year > anoMsg)
	                	retorno = diaMsg + "/" + mesMsg + "/" +anoMsg;
	                else if(month >= mesMsg && day!=diaMsg)
	                {
	                	switch(mesMsg)
	                	{
	                		case 0: retorno = diaMsg + " de " + "jan";break;
	                		case 1: retorno = diaMsg + " de " + "fev";break;
	                		case 2: retorno = diaMsg + " de " + "mar";break;
	                		case 3: retorno = diaMsg + " de " + "abr";break;
	                		case 4: retorno = diaMsg + " de " + "mai";break;
	                		case 5: retorno = diaMsg + " de " + "jun";break;
	                		case 6: retorno = diaMsg + " de " + "jul";break;
	                		case 7: retorno = diaMsg + " de " + "ago";break;
	                		case 8: retorno = diaMsg + " de " + "set";break;
	                		case 9: retorno = diaMsg + " de " + "out";break;
	                		case 10: retorno = diaMsg + " de " + "nov";break;
	                		case 11: retorno = diaMsg + " de " + "dez";break;
	                	}
	                	
	                }
	                else //dia da msg eh o dia de hj
	                {
	                	int minutos = dataMsg.getMinutes();
	                	
	                	if(minutos<10)
	                		retorno = dataMsg.getHours() + ":0" + dataMsg.getMinutes();
	                	else
	                		retorno = dataMsg.getHours() + ":" + dataMsg.getMinutes();
	                }
                %>
                <td class="time"><%=retorno %></td>
            </tr>
            
            <%
		}
%>
</tbody>
</table>

</div>

    <div class="p-15 center-align m-t-30">
        <ul class="pagination">
        <%int menorPag = 0; int qtdPags = (int)(emails.length/10)+1;

        if(emails.length % 10 == 0)
        	qtdPags = emails.length/10;
        else
        	qtdPags = (int)(emails.length/10)+1;
        
		
        if(qtd==0) {%>
            <li class="disabled"><a href="#"><i class="material-icons">chevron_left</i></a></li>
	        <%}else{ %>
	        <li class="waves-effect"><a href="?i=<%=qtd>0?qtd-1:0%>"><i class="material-icons">chevron_left</i></a></li>
	        <%} 
           
            if(qtd<3) //0, 1 ou 2, porque n vou girar o bglh se ainda nem chegou no meio (2)
   	        	for(int i=0; i<5; i++)
   	        	{
   	        		if(i<qtdPags)
   	        		{
   	        			if(i==qtd){%><li class="active"><a href="?i=<%=i %>"><%=i+1 %></a></li><%}
   	        			else{%><li class="waves-effect"><a href="?i=<%=i %>"><%=i+1 %></a></li><%}
   	        		}
   	        	}
           
            if(qtd>=3)
        	   	for(int i=0; i<5; i++)
        	   	{
        		   	if(qtdPags == qtd+2) //penultima pag
        		   	{
        		   		if(i==3){%><li class="active"><a href="?i=<%=qtd-3+i %>"><%=qtd-2+i %></a></li><%}
        		   		else{%><li class="waves-effect"><a href="?i=<%=qtd-3+i %>"><%=qtd-2+i %></a></li><%}
        		   	}
  	        		else
  	        			if(qtdPags == qtd+1) //ultima pag
  	  	        		{
  	        				if(i==4){%><li class="active"><a href="?i=<%=qtd-4+i %>"><%=qtd-3+i %></a></li><%}
  	        		   		else{%><li class="waves-effect"><a href="?i=<%=qtd-4+i %>"><%=qtd-3+i %></a></li><%}
  	  	        		}
  	        		else
  	        		{
  	        			if(qtd + (i - 2)==qtd){%><li class="active"><a href="?i=<%=qtd-2+i %>"><%=qtd-1+i %></a></li><%}
        		   		else{%><li class="waves-effect"><a href="?i=<%=qtd-2+i %>"><%=qtd-1+i %></a></li><%}
  	        		}
        	   	}

			if(qtd+1==qtdPags){%>
				<li class="disabled"><a href="#"><i class="material-icons">chevron_right</i></a></li><%}
			else{%>
        	<li class="waves-effect"><a href="?i=<%=qtd<qtdPags?qtd+1:qtdPags%>"><i class="material-icons">chevron_right</i></a></li>
        	<%}
            
           }
    	catch (NoSuchProviderException e) 
    	{}  
        %>
    </ul>
    </div>
</div>
<div class="right-part mail-compose" style="display: none;">
   <div class="card">
       <div class="card-content">
           <div class="d-flex align-items-center">
               <div>
                   <h5 class="card-title">Escrever Novo Email</h5>
               </div>
               <div class="ml-auto">
                   <button id="cancel_compose" class="btn grey darken-4">Cancelar</button>
               </div>
           </div>
           <form action="http://localhost:8080/uMail/FileUpload" method="post" class="dropzone" enctype="multipart/form-data">
           
          <!-- -----------------PARA, CC, CCO --------------------->
               <div class="Input-field">
                   <input placeholder="Para:" name="para" id="para" required>
               </div>
               <div class="Input-field">
                   <input placeholder="CC:" name="cc" id="cc">
               </div>
               <div class="Input-field">
                   <input placeholder="CCO:" name="cco" id="cco">
               </div>                       
          <!-- -----------------PARA, CC, CCO --------------------->
          
               <div class="Input-field">
                   <input placeholder="Assunto:" name="assunto" id="assunto" required>
               </div>
               
                <div class="Input-field">
                   <input type="hidden" name="emailarea" id="emailarea">
               </div>
               
               <!-- ----------------------------------------------------------------------------- -->
               
				    <textarea name="content" id="htmleditor" name="htmleditor">
				        &lt;p&gt;This is some sample content.&lt;/p&gt;
				    </textarea>
				    <script>
				    ClassicEditor
		            .create( document.querySelector( '#htmleditor' ) )
		            .catch( error => {
		                console.error( error );
		            } );
				    </script>
                  	
                <h5 class="card-title"><i class="ti-link"></i>Anexo</h5>
                <div class="file-field input-field">
                    <div class="btn">
                        <span>Arquivo</span>
                        <input type="file" name="arqs" id="arqs" multiple="true">
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text" placeholder="Axene um ou mais arquivos" name="anexos">
                    </div>
                    
                    <output id="list"></output>
                    
                </div>
                <button type="submit" class="btn green m-t-20">Enviar</button>
                <button id="descartar" onClick="javascript:void(0)" class="btn grey darken-4 m-t-20">Descartar</button>
                <label id="erro"><%=session.getAttribute("erroEnvio")==null?"":session.getAttribute("erroEnvio") %></label>
            </form>
        </div>
    </div>
</div>

<!-- -------------------------------------------------------------------------------------------------------------- -->
          

<!-- ------------------------------------------------------------------------------------------------------------ -->

        </div>
    </div>
</div>
        
        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" data-target="right-slide-out" class="sidenav-trigger right-side-toggle btn-floating btn-large waves-effect waves-light red"><i class="material-icons">settings</i></a>
        <aside class="right-sidebar">
            <ul id="right-slide-out" class="sidenav right-sidenav p-t-10 right-aligned ps ps--theme_default ps--active-y" data-ps-id="f70c6c61-d014-18b7-4cb9-2b1f3bf51a11">
                <li>
                    <div class="row">
                        <div class="col s12">
                            <ul class="tabs">
                                <li class="tab col s4"><a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#settings" class="active"><span class="material-icons">build</span></a></li>
                                <li class="tab col s4"><a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#chat"><span class="material-icons">chat_bubble</span></a></li>
                                <li class="tab col s4"><a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#activity"><span class="material-icons">local_activity</span></a></li>
                            <li class="indicator" style="left: 0px; right: 186px;"></li></ul>
                        </div>
                        <div id="settings" class="col s12 active">
                            <div class="m-t-10 p-10 b-b">
                                <h6 class="font-medium">Layout Settings</h6>
                                <ul class="m-t-15">
                                    <li class="m-b-10">
                                        <label>
                                            <input type="checkbox" name="theme-view" id="theme-view">
                                            <span>Dark Theme</span>
                                        </label>
                                    </li>
                                    <li class="m-b-10">
                                        <label>
                                            <input type="checkbox" class="nav-toggle" name="collapssidebar" id="collapssidebar">
                                            <span>Collapse Sidebar</span>
                                        </label>
                                    </li>
                                    <li class="m-b-10">
                                        <label>
                                            <input type="checkbox" name="sidebar-position" id="sidebar-position">
                                            <span>Fixed Sidebar</span>
                                        </label>
                                    </li>
                                    <li class="m-b-10">
                                        <label>
                                            <input type="checkbox" name="header-position" id="header-position">
                                            <span>Fixed Header</span>
                                        </label>
                                    </li>
                                    <li class="m-b-10">
                                        <label>
                                            <input type="checkbox" name="boxed-layout" id="boxed-layout">
                                            <span>Boxed Layout</span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                            <div class="p-10 b-b">
                                <h6 class="font-medium">Logo Backgrounds</h6>
                                <ul class="m-t-15 theme-color">
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin1"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin2"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin3"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin4"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin5"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-logobg="skin6"></a></li>
                                </ul>
                            </div>
                            <div class="p-10 b-b">
                                <h6 class="font-medium">Navbar Backgrounds</h6>
                                <ul class="m-t-15 theme-color">
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin1"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin2"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin3"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin4"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin5"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-navbarbg="skin6"></a></li>
                                </ul>
                            </div>
                            <div class="p-10 b-b">
                                <h6 class="font-medium">Sidebar Backgrounds</h6>
                                <ul class="m-t-15 theme-color">
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin1"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin2"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin3"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin4"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin5"></a></li>
                                    <li class="theme-item"><a href="javascript:void(0)" class="theme-link" data-sidebarbg="skin6"></a></li>
                                </ul>
                            </div>
                        </div>
                        
                        <div id="chat" class="col s12" style="display: none;">
                            <ul class="mailbox m-t-20">
                                <li>
                                    <div class="message-center ps ps--theme_default" data-ps-id="48a56881-dfb2-0d5a-23ac-b65515f12c0f">
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_1" data-user-id="1">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/1.jpg" alt="user" class="circle">
                                                <span class="profile-status online pull-right" data-status="online"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Chris Evans</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:30 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_2" data-user-id="2">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/2.jpg" alt="user" class="circle">
                                                <span class="profile-status busy pull-right" data-status="busy"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Ray Hudson</h5>
                                                <span class="mail-desc">I've sung a song! See you at</span>
                                                <span class="time">9:10 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_3" data-user-id="3">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/3.jpg" alt="user" class="circle">
                                                <span class="profile-status away pull-right" data-status="away"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Lb James</h5>
                                                <span class="mail-desc">I am a singer!</span>
                                                <span class="time">9:08 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_4" data-user-id="4">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/4.jpg" alt="user" class="circle">
                                                <span class="profile-status offline pull-right" data-status="offline"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Don Andres</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:02 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_5" data-user-id="5">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/1.jpg" alt="user" class="circle">
                                                <span class="profile-status online pull-right" data-status="online"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Chris Evans</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:30 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_6" data-user-id="6">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/2.jpg" alt="user" class="circle">
                                                <span class="profile-status busy pull-right" data-status="busy"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Ray Hudson</h5>
                                                <span class="mail-desc">I've sung a song! See you at</span>
                                                <span class="time">9:10 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_7" data-user-id="7">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/3.jpg" alt="user" class="circle">
                                                <span class="profile-status away pull-right" data-status="away"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Lb James</h5>
                                                <span class="mail-desc">I am a singer!</span>
                                                <span class="time">9:08 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_8" data-user-id="8">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/4.jpg" alt="user" class="circle">
                                                <span class="profile-status offline pull-right" data-status="offline"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Don Andres</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:02 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_9" data-user-id="9">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/1.jpg" alt="user" class="circle">
                                                <span class="profile-status online pull-right" data-status="online"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Chris Evans</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:30 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_10" data-user-id="10">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/2.jpg" alt="user" class="circle">
                                                <span class="profile-status busy pull-right" data-status="busy"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Ray Hudson</h5>
                                                <span class="mail-desc">I've sung a song! See you at</span>
                                                <span class="time">9:10 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_11" data-user-id="11">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/3.jpg" alt="user" class="circle">
                                                <span class="profile-status away pull-right" data-status="away"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Lb James</h5>
                                                <span class="mail-desc">I am a singer!</span>
                                                <span class="time">9:08 AM</span>
                                            </span>
                                        </a>
                                        <a href="https://www.wrappixel.com/demos/admin-templates/materialart/html/ltr/inbox-email.html?email-body=#" class="user-info" id="chat_user_12" data-user-id="12">
                                            <span class="user-img">
                                                <img src="./Materialart Admin Template_files/4.jpg" alt="user" class="circle">
                                                <span class="profile-status offline pull-right" data-status="offline"></span>
                                            </span>
                                            <span class="mail-contnet">
                                                <h5>Don Andres</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:02 AM</span>
                                            </span>
                                        </a>
                                        
                                    <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                                    	<div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                                    </div>
                                    <div class="ps__scrollbar-y-rail" style="top: 0px; right: 0px;">
                                    	<div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                                    </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div id="activity" class="col s12" style="display: none;">
                            <div class="m-t-10 p-10">
                                <h6 class="font-medium">Activity Timeline</h6>
                                <div class="steamline">
                                    <div class="sl-item">
                                        <div class="sl-left green"> <i class="ti-user"></i></div>
                                        <div class="sl-right">
                                            <div class="font-medium">Meeting today <span class="sl-date"> 5pm</span></div>
                                            <div class="desc">you can write anything </div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left blue"><i class="fa fa-image"></i></div>
                                        <div class="sl-right">
                                            <div class="font-medium">Send documents to Clark</div>
                                            <div class="desc">Lorem Ipsum is simply </div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left"> <img class="circle" alt="user" src="./Materialart Admin Template_files/2.jpg"> </div>
                                        <div class="sl-right">
                                            <div class="font-medium">Go to the Doctor <span class="sl-date">5 minutes ago</span></div>
                                            <div class="desc">Contrary to popular belief</div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left"> <img class="circle" alt="user" src="./Materialart Admin Template_files/1.jpg"> </div>
                                        <div class="sl-right">
                                            <div><a href="javascript:void(0)">Stephen</a> <span class="sl-date">5 minutes ago</span></div>
                                            <div class="desc">Approve meeting with tiger</div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left teal"> <i class="ti-user"></i></div>
                                        <div class="sl-right">
                                            <div class="font-medium">Meeting today <span class="sl-date"> 5pm</span></div>
                                            <div class="desc">you can write anything </div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left purple"><i class="fa fa-image"></i></div>
                                        <div class="sl-right">
                                            <div class="font-medium">Send documents to Clark</div>
                                            <div class="desc">Lorem Ipsum is simply </div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left"> <img class="circle" alt="user" src="./Materialart Admin Template_files/4.jpg"> </div>
                                        <div class="sl-right">
                                            <div class="font-medium">Go to the Doctor <span class="sl-date">5 minutes ago</span></div>
                                            <div class="desc">Contrary to popular belief</div>
                                        </div>
                                    </div>
                                    <div class="sl-item">
                                        <div class="sl-left"> <img class="circle" alt="user" src="./Materialart Admin Template_files/6.jpg"> </div>
                                        <div class="sl-right">
                                            <div><a href="javascript:void(0)">Stephen</a> <span class="sl-date">5 minutes ago</span></div>
                                            <div class="desc">Approve meeting with tiger</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>

		</ul>
		</aside>
            <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
            	<div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
            </div>
            <div class="ps__scrollbar-y-rail" style="top: 0px; height: 0px; right: 0px;">
            	<div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div></div>
        <div class="chat-windows"></div>
    <script src="./Materialart Admin Template_files/jquery.min.js.download"></script>
    <script src="./Materialart Admin Template_files/materialize.min.js.download"></script>
    <script src="./Materialart Admin Template_files/perfect-scrollbar.jquery.min.js.download"></script>
    <script src="./Materialart Admin Template_files/app.js.download"></script>
    <script src="./Materialart Admin Template_files/app.init.js.download"></script>
    <script src="./Materialart Admin Template_files/app-style-switcher.js.download"></script>
    <script src="./Materialart Admin Template_files/custom.min.js.download"></script>
    <script src="./Materialart Admin Template_files/email.js.download"></script>
    <script src="../js/angular.js"></script>
    <script src="../js/js.js"></script>
    
    <script>
    $(".ck.ck-content.ck-editor__editable.ck-rounded-corners.ck-editor__editable_inline.ck-blurred").keyup(function() 
    	    {
    			$("#htmleditor").html(document.activeElement.innerHTML);
    	   		minhaFuncao();
    	    
    	    });
    </script>
    
    <script>
    	function minhaFuncao()
    	{
    		var s = document.activeElement.innerHTML;
    		$("#htmleditor").val(s);
    		$("#emailarea").val(s);
    		console.log(s);
    	}
    	
       function handleFileSelect(evt) 
       {
           var files = evt.target.files; // FileList object

           // files is a FileList of File objects. List some properties.
           var output = [];
           
           for (var i = 0, f; f = files[i]; i++) 
           {
               // Only process image files.
               if (!f.type.match('image.*')) 
                   continue;

               var reader = new FileReader();

               // Closure to capture the file information.
               reader.onload = (function(theFile) 
               {
                   return function(e) 
                   {
                       // Render thumbnail.
                       var span = document.createElement('span');
                       span.innerHTML = ['<img class="thumb" src="', e.target.result,
                                           '" title="', escape(theFile.name), '"/>'].join('');
                       document.getElementById('list').insertBefore(span, null);
                   };
               })(f);

               // Read in the image file as a data URL.
               reader.readAsDataURL(f);
           }

           document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
       }

   	document.getElementById('arqs').addEventListener('change', handleFileSelect, false);
   </script>
<div class="sidenav-overlay"></div><div class="drag-target"></div>
<div class="sidenav-overlay"></div><div class="drag-target right-aligned"></div>


<div class="material-tooltip"><div class="tooltip-content"></div></div>
<div class="material-tooltip"><div class="tooltip-content"></div></div>
<div class="material-tooltip"><div class="tooltip-content"></div></div>

</body></html>