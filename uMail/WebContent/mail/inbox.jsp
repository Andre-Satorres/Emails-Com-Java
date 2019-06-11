<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, 
                         bd.core.*, java.io.*, java.util.Properties, javax.mail.search.*, md5util.*, bd.daos.*, bd.dbos.*, emailmanipulator.*"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/master.css">
    <link rel="icon" type="image/png" sizes="16x16" href="https://www.wrappixel.com/demos/admin-templates/materialart/assets/images/favicon.png">
    <link href="./Materialart Admin Template_files/style.css" rel="stylesheet">
    <link href="./Materialart Admin Template_files/email.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" type="text/css" id="u0" href="./Materialart Admin Template_files/skin.min.css"></head>   
    
    <%
	if(session.getAttribute("usuario") == null)
		response.sendRedirect("../index.jsp");

	//String host = "pop.gmail.com";
	//String user = "mommavalos@gmail.com";
	//String password = "Sem1seiji";
	
	if(session.getAttribute("Email1") == null)
		request.getRequestDispatcher("CadastrarEmail.jsp").forward(request, response);
	
	Email em;
	
	if(session.getAttribute("atual") == null)
		em = (Email)session.getAttribute("Email"+session.getAttribute("QtdEmailsUsuario"));
	else
		em = (Email)session.getAttribute("Email"+ session.getAttribute("atual"));
	
	EmailManipulator email = new EmailManipulator(em);
	
	//EmailManipulator email = new EmailManipulator("Felipe", "Seiji", user, password, 465, new Seguranca(1, "ssl"), 
		//						new Host(1, "pop3"), "gmail.com", "d");
	
	//session.setAttribute("Email1", email);
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
                            	session.setAttribute("pastaAtual", "inbox");
                            	for(Folder fd:pastas)
                            	{
                            		%>
                            			<li class="list-group-item">
                            			<%if(fd.equals(pastas[0])) 
                            			  {
                            			  	%>
                                			<a href="javascript:void(0)" class="active">
                                			<i class="material-icons">inbox</i><%=fd.getName().substring(0, 1).toUpperCase() + fd.getName().substring(1).toLowerCase() %>
                                			<span class="label label-success right"><%=email.quantidadeNaoLidas(fd.getName()) %></span></a>
                                			<%
                                		  }else {%>
                                			<a href="javascript:void(0)">
                                			<i class="material-icons"><%=fd.getName() %></i><%=fd.getName().substring(0, 1).toUpperCase() + fd.getName().substring(1).toLowerCase() %>
                                			<span class="label label-success right"><%=email.quantidadeNaoLidas(fd.getName()) %></span></a>
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
                            
                            <%
                            int qtdEmailsUsuario = (int)(session.getAttribute("QtdEmailsUsuario"));
                            
                            for(int a=qtdEmailsUsuario; a>0; a--)
                            {
                            	Email umEmail = (Email)session.getAttribute("Email"+a);
                            	String nomeUsuario = umEmail.getUsuario();
                            	int atual = (int)(session.getAttribute("atual"));
                            	
                            	%>
                            	<li class="list-group-item">
                            	<%if(a==atual)
                            	{	
                            		%>
                                	<a href="mudar.jsp?i=<%=a%>" class="active"> <i class="material-icons">email</i>
                                							<%=nomeUsuario%></a>
                                	<%
                                }
                            	else
                            	{
                            		%><a href="mudar.jsp?i=<%=a%>"> <i class="material-icons">email</i>
                                							<%=nomeUsuario%></a>
                                	<%
                            	}
                            	%>				
                            	
                            	</li>
                            	<%
                            } %>
                            
                            <li>
                                <div class="divider m-t-10  m-b-10"></div>
                            </li>
                        </ul>
                    <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                    	<div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                    </div>
                    <div class="ps__scrollbar-y-rail" style="top: 0px; height: 676px; right: 0px;">
                    	<div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                    </div>
                   </div>
                    <div class="right-part mail-list">
                    
					  <label class="logoutLblPos">
					  <span class="glyphicon glyphicon-search"></span>
					  <a href="deslogar.jsp" id="sair">Deslogar</a>
					  </label>
                    
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
                                <a class="font-20 m-l-10" href=""><i class="material-icons">refresh</i></a>
                            </div>
                        </div>
                       
                       
<div class="table-responsive">
<table class="email-table no-wrap">
<tbody>                
<%
	try
	{
		Message[] emails = email.mensagens("inbox");
		
		session.setAttribute("emails", emails);
		
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
                    <h6 class="m-b-0"><%=((InternetAddress)emails[i].getFrom()[0]).getPersonal() == null?((InternetAddress)emails[i].getFrom()[0]).getAddress():((InternetAddress)emails[i].getFrom()[0]).getPersonal() %></h6>
                </td>
                <td class="max-texts"><a id="mail" href="verEmail.jsp?i=<%=i%>"><%=emails[i].getSubject() %></a></td>
                <td class="clip"><i class="fa fa-paperclip"></i></td>
                <td class="time"><%=emails[i].getSentDate() %></td>
            </tr>
            
            <%
		}
%>                            
</tbody>
</table>

<%! public void chamar(int i)
	{
		System.out.print(i);
	}
%>

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
           <form action="enviarEmail.jsp" method="post" class="dropzone">
           
          <!-- -----------------PARA, CC, CCO --------------------->
               <div class="Input-field">
                   <input placeholder="Para:" name="para" id="para">
               </div>
               <div class="Input-field">
                   <input placeholder="CC:" name="cc" id="cco">
               </div>
               <div class="Input-field">
                   <input placeholder="CCO:" name="cco" id="cco">
               </div>                       
          <!-- -----------------PARA, CC, CCO --------------------->
          
               <div class="Input-field">
                   <input placeholder="Assunto:" name="assunto" id="assunto">
               </div>
               
               
               <div class="Input-field m-t-20 m-b-20">
                <div id="mceu_15" class="mce-tinymce mce-container mce-panel" 
                	 hidefocus="1" tabindex="-1" role="application" style="visibility: hidden; 
                	 border-width: 1px; width: 100%;">
                	 <div id="mceu_15-body" class="mce-container-body mce-stack-layout">
                	  <div id="mceu_16" class="mce-top-part mce-container mce-stack-layout-item mce-first">
                	   <div id="mceu_16-body" class="mce-container-body">
                	    <div id="mceu_17" class="mce-container mce-menubar mce-toolbar mce-first" role="menubar" style="border-width: 0px 0px 1px;">
                	     <div id="mceu_17-body" class="mce-container-body mce-flow-layout">
                	      <div id="mceu_18" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-first mce-btn-has-text" 
                	 	       tabindex="-1" aria-labelledby="mceu_18" role="menuitem" aria-haspopup="true">
       	 	       
                	       <button id="mceu_18-open" role="presentation" type="button" tabindex="-1">
                	        <span class="mce-txt">Arquivo</span> 
                	        <i class="mce-caret"></i>
                	       </button>
       
                	      </div>
                	      <div id="mceu_19" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" 
                	           tabindex="-1" aria-labelledby="mceu_19" role="menuitem" aria-haspopup="true">
                	           <button id="mceu_19-open" role="presentation" type="button" tabindex="-1">
                	            <span class="mce-txt">Editar</span> 
                	            <i class="mce-caret"></i>
                	           </button>
                	      </div>
                	      <div id="mceu_20" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" 
                	           tabindex="-1" aria-labelledby="mceu_20" role="menuitem" aria-haspopup="true">
                	           <button id="mceu_20-open" role="presentation" type="button" tabindex="-1">
                	            <span class="mce-txt">Ver</span> 
                	            <i class="mce-caret"></i>
                	           </button>
                	      </div>
                	      <div id="mceu_21" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" 
                	           tabindex="-1" aria-labelledby="mceu_21" role="menuitem" aria-haspopup="true">
                	       <button id="mceu_21-open" role="presentation" type="button" tabindex="-1">
                	        <span class="mce-txt">Inserir</span> 
                	        <i class="mce-caret"></i>
                	       </button>
                	      </div>
                	      <div id="mceu_22" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" tabindex="-1" 
                	           aria-labelledby="mceu_22" role="menuitem" aria-haspopup="true">
                	           <button id="mceu_22-open" role="presentation" type="button" tabindex="-1">
                	            <span class="mce-txt">Formato</span> 
                	            <i class="mce-caret"></i>
                	           </button>
                	          </div>
                	          <div id="mceu_23" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" 
                	               tabindex="-1" aria-labelledby="mceu_23" role="menuitem" aria-haspopup="true">
                	               <button id="mceu_23-open" role="presentation" type="button" tabindex="-1">
                	               <span class="mce-txt">Ferramentas</span> 
                	               <i class="mce-caret"></i></button></div>
                	               
                	          <div id="mceu_24" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-last mce-btn-has-text" 
                	               tabindex="-1" aria-labelledby="mceu_24" role="menuitem" aria-haspopup="true">
                	               <button id="mceu_24-open" role="presentation" type="button" tabindex="-1">
                	               <span class="mce-txt">Tabela</span> 
                	               <i class="mce-caret"></i></button>
                	          </div>
                	       </div>
                	      </div>
                	      
                	      <div id="mceu_25" class="mce-toolbar-grp mce-container mce-panel mce-last" hidefocus="1" tabindex="-1" role="group">
                	      <div id="mceu_25-body" class="mce-container-body mce-stack-layout">
                	      <div id="mceu_26" class="mce-container mce-toolbar mce-stack-layout-item mce-first mce-last" role="toolbar">
                	      <div id="mceu_26-body" class="mce-container-body mce-flow-layout">
                	      <div id="mceu_27" class="mce-container mce-flow-layout-item mce-first mce-btn-group" role="group">
                	      <div id="mceu_27-body">
                	      <div id="mceu_0" class="mce-widget mce-btn mce-first mce-disabled" tabindex="-1" role="button" aria-label="Undo" 
                	           aria-disabled="true">
                	           <button id="mceu_0-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-undo"></i>
                	           </button>
                	      </div>
                	      <div id="mceu_1" class="mce-widget mce-btn mce-last mce-disabled" tabindex="-1" role="button" aria-label="Redo" 
                	           aria-disabled="true">
                	           <button id="mceu_1-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-redo"></i>
                	           </button>
                	      </div>
                	      </div>
                	      </div>
                	      <div id="mceu_28" class="mce-container mce-flow-layout-item mce-btn-group" role="group">
                	      <div id="mceu_28-body">
                	      <div id="mceu_2" class="mce-widget mce-btn mce-menubtn mce-first mce-last mce-btn-has-text" tabindex="-1" 
                	           aria-labelledby="mceu_2" role="button" aria-haspopup="true">
                	           <button id="mceu_2-open" role="presentation" type="button" tabindex="-1">
                	           <span class="mce-txt">Formatos</span> 
                	           <i class="mce-caret"></i></button>
                	      </div>
                	      </div>
                	      </div>
                	      
                	      <div id="mceu_29" class="mce-container mce-flow-layout-item mce-btn-group" role="group">
                	      <div id="mceu_29-body">
                	      <div id="mceu_3" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" aria-label="Bold">
                	       <button id="mceu_3-button" role="presentation" type="button" tabindex="-1">
                	       <i class="mce-ico mce-i-bold"></i>
                	       </button>
                	      </div>
                	      <div id="mceu_4" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Italic">
                	           <button id="mceu_4-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-italic"></i>
                	           </button>
                	      </div>
                	      </div>
                	      </div>
                	      
                	      <div id="mceu_30" class="mce-container mce-flow-layout-item mce-btn-group" role="group">
                	      <div id="mceu_30-body">
                	      <div id="mceu_5" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Align left">
                	           <button id="mceu_5-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-alignleft"></i></button></div>
                	           
                	      <div id="mceu_6" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Align center">
                	           <button id="mceu_6-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-aligncenter"></i></button></div>
                	           
                	      <div id="mceu_7" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Align right">
                	           <button id="mceu_7-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-alignright"></i></button></div>
                	           
                	      <div id="mceu_8" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Justify">
                	           <button id="mceu_8-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-alignjustify"></i></button></div>
                	      </div>
                	      </div>
                	      
                	      <div id="mceu_31" class="mce-container mce-flow-layout-item mce-btn-group" role="group">
                	      <div id="mceu_31-body">
                	      <div id="mceu_9" class="mce-widget mce-btn mce-splitbtn mce-menubtn mce-first" role="button" 
                	           aria-pressed="false" tabindex="-1" aria-label="Bullet list" aria-haspopup="true">
                	           <button type="button" hidefocus="1" tabindex="-1">
                	           <i class="mce-ico mce-i-bullist"></i></button>
                	           <button type="button" class="mce-open" hidefocus="1" tabindex="-1"> 
                	           <i class="mce-caret"></i></button>
                	      </div>
                	      
                	      <div id="mceu_10" class="mce-widget mce-btn mce-splitbtn mce-menubtn" role="button" aria-pressed="false" 
                	           tabindex="-1" aria-label="Numbered list" aria-haspopup="true">
                	           <button type="button" hidefocus="1" tabindex="-1">
                	           <i class="mce-ico mce-i-numlist"></i></button>
                	           <button type="button" class="mce-open" hidefocus="1" tabindex="-1"> 
                	           <i class="mce-caret"></i></button></div>
                	      
                	      <div id="mceu_11" class="mce-widget mce-btn" tabindex="-1" role="button" aria-label="Decrease indent">
                	      	<button id="mceu_11-button" role="presentation" type="button" tabindex="-1">
                	      	<i class="mce-ico mce-i-outdent"></i></button></div>
                	      	
                	      <div id="mceu_12" class="mce-widget mce-btn mce-last" tabindex="-1" role="button" aria-label="Increase indent">
                	      <button id="mceu_12-button" role="presentation" type="button" tabindex="-1">
                	      <i class="mce-ico mce-i-indent"></i></button></div>
                	      
                	      </div>
                	      </div>
                	      <div id="mceu_32" class="mce-container mce-flow-layout-item mce-last mce-btn-group" role="group">
                	      <div id="mceu_32-body">
                	      <div id="mceu_13" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Insert/edit link">
                	           <button id="mceu_13-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-link"></i></button></div>
                	      
                	      <div id="mceu_14" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" 
                	           aria-label="Insert/edit image">
                	           <button id="mceu_14-button" role="presentation" type="button" tabindex="-1">
                	           <i class="mce-ico mce-i-image"></i></button>
                	           
                	     </div></div></div></div></div></div></div></div></div>
                	     
                	     <div id="mceu_33" class="mce-edit-area mce-container mce-panel mce-stack-layout-item" hidefocus="1" tabindex="-1" 
                	          role="group" style="border-width: 1px 0px 0px;">
                	          <iframe id="mymce_ifr" frameborder="0" allowtransparency="true" title="Rich Text Area. Press ALT-F9 for menu. Press ALT-F10 for toolbar. Press ALT-0 for help" 
                	          style="width: 100%; height: 250px; display: block;" src="./Materialart Admin Template_files/saved_resource.html">
                	          </iframe>
                	      </div>
                	      
                	      <div id="mceu_34" class="mce-statusbar mce-container mce-panel mce-stack-layout-item mce-last" hidefocus="1" tabindex="-1" 
                	           role="group" style="border-width: 1px 0px 0px;">
                	           <div id="mceu_34-body" class="mce-container-body mce-flow-layout">
                	           <div id="mceu_35" class="mce-path mce-flow-layout-item mce-first">
                	           <div class="mce-path-item">&nbsp;</div>
                	           </div>
                	           <span id="mceu_38" class="mce-wordcount mce-widget mce-label mce-flow-layout-item">0 words</span>
                	           <div id="mceu_36" class="mce-flow-layout-item mce-resizehandle">
                	                <i class="mce-ico mce-i-resize"></i>
                	           </div>
                	           </div>
                	      </div>
                	   </div>
                	</div>

                	<!--  TEXT AREA -->
                   	<textarea id="emailarea" name="emailarea"
                   	placeholder="Insira seu texto aqui" cols="30" rows="35"></textarea>
                </div>
                <h5 class="card-title"><i class="ti-link"></i>Anexo</h5>
                <div class="file-field input-field">
                    <div class="btn">
                        <span>Arquivo</span>
                        <input type="file" multiple>
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text" placeholder="Axene um ou mais arquivos" name="anexos">
                    </div>
                </div>
                <button type="submit" class="btn green m-t-20">Enviar</button>
                <button class="btn grey darken-4 m-t-20">Descartar</button>
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
                                    <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;"><div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__scrollbar-y-rail" style="top: 0px; right: 0px;"><div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div></div></div>
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
            <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;"><div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__scrollbar-y-rail" style="top: 0px; height: 800px; right: 0px;"><div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 280px;"></div></div>
        <div class="chat-windows"></div>
    <script src="./Materialart Admin Template_files/jquery.min.js.download"></script>
    <script src="./Materialart Admin Template_files/materialize.min.js.download"></script>
    <script src="./Materialart Admin Template_files/perfect-scrollbar.jquery.min.js.download"></script>
    <script src="./Materialart Admin Template_files/app.js.download"></script>
    <script src="./Materialart Admin Template_files/app.init.js.download"></script>
    <script src="./Materialart Admin Template_files/app-style-switcher.js.download"></script>
    <script src="./Materialart Admin Template_files/custom.min.js.download"></script>
    <script src="./Materialart Admin Template_files/email.js.download"></script>
    <script src="./Materialart Admin Template_files/tinymce.min.js.download"></script>
    <script>
    $(function() {
        if ($("#emailarea").length > 0) {
            tinymce.init({
                selector: "textarea#mymce",
                theme: "modern",
                height: 250,
                plugins: [
                    "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
                    "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                    "save table contextmenu directionality emoticons template paste textcolor"
                ],
                toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
            });
        }
    });
    </script>


<div class="sidenav-overlay"></div><div class="drag-target"></div><div class="sidenav-overlay"></div><div class="drag-target right-aligned"></div><div class="material-tooltip"><div class="tooltip-content"></div></div><div class="material-tooltip"><div class="tooltip-content"></div></div><div class="material-tooltip"><div class="tooltip-content"></div></div>
</body></html>