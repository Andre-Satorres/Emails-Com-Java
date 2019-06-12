<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, 
                         java.io.*, java.util.Properties, javax.mail.search.*, md5util.*, bd.dbos.*, emailmanipulator.*,
                         javax.*, org.jsoup.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/master.css">
    <link rel="icon" type="image/png" sizes="16x16" href="https://www.wrappixel.com/demos/admin-templates/materialart/assets/images/favicon.png">
    <link href="./Materialart Admin Template_files/style.css" rel="stylesheet">
    <link href="./Materialart Admin Template_files/email.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" type="text/css" id="u0" href="./Materialart Admin Template_files/skin.min.css">

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

<%
	Email em = (Email)session.getAttribute("Email"+(int)session.getAttribute("atual"));
	
	EmailManipulator email = new EmailManipulator(em);
	Message[] emails = email.mensagens((String)session.getAttribute("pastaAtual"));
	int i = Integer.parseInt(request.getParameter("i"));
	Message msg = emails[i]; 
	session.setAttribute("Mensagem", msg);

%>
  

<title><%=msg.getSubject() %></title>
</head>
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
                                <a href="javascript:void(0)"> <i class="material-icons">send</i> Rascunho <span class="label label-danger right">3</span></a></li>
                            <li class="list-group-item">
                                <a href="javascript:void(0)"> <i class="material-icons">email</i> Enviar Email </a>
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
                        </ul>
                    <div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                    <div class="ps__scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div>
                    <div class="ps__scrollbar-y-rail" style="top: 0px; height: 676px; right: 0px;">
                    <div class="ps__scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div></div></div>
                    
<div class="right-part mail-details active" style="display: block;">
					  
<div class="grey lighten-5 p-15 d-flex no-block">
    <a id="back_to_inbox" class="m-l-5 tooltipped" href="inbox.jsp" data-tooltip="back to inbox" data-position="top">
    	<i class="material-icons font-20">arrow_back</i></a>
    <a class="m-l-5 tooltipped" href="responderEmail.jsp?i=<%=i %>" data-tooltip="Reply" data-position="top">
    <i class="material-icons font-20">reply</i></a>
    <a class="m-l-10 tooltipped" href="" data-tooltip="Report Spam" data-position="top">
    <i class="material-icons font-20">sim_card_alert</i></a>
    <div class="ml-auto">
        <a class="dropdown-trigger font-20" href="" data-target="dme">
        <i class="material-icons">folder</i>
        <i class="material-icons op-5">expand_more</i>
        </a><ul id="dme" class="dropdown-content col s4" tabindex="0" style="">
            
            <li tabindex="0"><a href="">Select Read</a></li>
            <li class="divider" tabindex="-1"></li>
            <li tabindex="0"><a href="">Select Unread</a></li>
            <li tabindex="0"><a href=""><i class="material-icons">view_module</i>Action</a></li>
            <li tabindex="0"><a href=""><i class="material-icons">cloud</i>Clear All</a></li>
        </ul>
        <ul id="dme" class="dropdown-content col s4">
            <li><a href="">Select Read</a></li>
            <li class="divider" tabindex="-1"></li>
            <li><a href="">Select Unread</a></li>
            <li><a href=""><i class="material-icons">view_module</i>Action</a></li>
            <li><a href=""><i class="material-icons">cloud</i>Clear All</a></li>
        </ul>
        <a class="font-20 m-l-5" href=""><i class="material-icons">delete</i></a>
        <a class="font-20 m-l-10" href=""><i class="material-icons">refresh</i></a>
    </div>
</div>
<!-- ------------------------------------------------------------------------------------- -->

<div class="email-body" style="display: block;">
<div class="p-15 b-t">
    <h5 class="m-b-0"><%=msg.getSubject() %></h5>
</div>
<div class="divider"></div>
<ul class="collapsible expandable b-0 m-t-0">
    <li class="active">
        <div class="collapsible-header" tabindex="0">
            <div class="d-flex no-block align-items-center">
                <div class="m-r-10">
                	<img src="./Materialart Admin Template_files/1.jpg" alt="user" 
                		 class="circle" width="45"></div>
                <div class="">
                    <h5 class="m-b-0 font-16 font-medium">
                    <%=((InternetAddress)msg.getFrom()[0]).getPersonal() == null?((InternetAddress)msg.getFrom()[0]).getAddress():((InternetAddress)msg.getFrom()[0]).getPersonal()%> 
                    <small> ( <%=((InternetAddress)msg.getFrom()[0]).getAddress() %> )</small>
                    </h5><span>para <%=((InternetAddress)msg.getAllRecipients()[0]).getAddress() %>
                    </span>
                </div>
            </div>
        </div>
        <div class="collapsible-body" style="display: block;">
        <a class="dropdown-trigger font-20 right" href="" data-target="ddme">
        	<i class="material-icons">more_vert</i></a>
        	<ul id="ddme" class="dropdown-content" tabindex="0">
        	
            <li tabindex="0" class="active"><a href="responderEmail.jsp?i=<%=i %>" class="active">Responder</a></li>
            <li class="divider" tabindex="-1"></li>
            <li tabindex="0" class="active"><a href="encaminharEmail.jsp?i=<%=i %>" class="active">Encaminhar</a></li>
            <li tabindex="0" class="active"><a href="excluirEmail.jsp?i=<%=i %>" 
            	class="active"><i class="material-icons">view_module</i>Excluir</a></li>
            <li tabindex="0" class="active"><a href="excluirTodos.jsp" 
            	class="active"><i class="material-icons">cloud</i>Excluir Todos</a></li>
        </ul>

		<%= getTextFromMessage(msg) %>
		
<%!
	private String getTextFromMessage(Message message) throws MessagingException, IOException
	{
		String result = "";
		if (message.isMimeType("text/plain")) //se o conteúdo for meramente textual
		{
			result = message.getContent().toString(); //siplesmente printa o texto
		}
		else if (message.isMimeType("multipart/*")) //se tiver múltiplas partes
		{
			//obtenho o conteúdo como um texto MIME
			MimeMultipart mimeMultipart= (MimeMultipart) message.getContent();
		
			result = getTextFromMimeMultipart(mimeMultipart); //receberá o texto em MIME ou HTML.
		}
	
		return result;
	}
%>

<%!
private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException
{
	String result = "";
	int count = mimeMultipart.getCount();
	for (int i = 0; i < count; i++)
	{
		result += pegaTextoDeCadaParte(mimeMultipart.getBodyPart(i));
	}
	return result;
}
%>

<%!
public String pegaTextoDeCadaParte(BodyPart bodyPart) throws MessagingException, IOException
{
	String result = "";
	if (bodyPart.getContentType().contains("text/plain"))
	{
		return result + "\n" + bodyPart.getContent();
	}
	else if(bodyPart.getContentType().contains("TEXT/HTML"))
	{
	    Object content = bodyPart.getContent();
	    
	    if(content != null)
	        result += Jsoup.parse((String)content).text();
	}  
	else if (bodyPart.getContent() instanceof MimeMultipart)
	{
		return result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
	}
	return result;
}
%>

<%
int qtdAnexos=0; 
if(msg.getContentType().contains("multipart"))
{
		// essa parte é multipart, então pode conter anexos.
		Multipart multiPart= (Multipart) msg.getContent();
		int numberOfParts = multiPart.getCount();
		for (int partCount = 0; partCount < numberOfParts; partCount++)
		{
			//pega uma parte de cada vez no "for"
			MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
			//checa se o "disposition" (descreve como a parte deve ser apresentada ao usuaio e um anexo.
			if (javax.mail.Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 		
			{
				qtdAnexos++;
				String fileName = part.getFileName();
			}
			
		}
}
		if(qtdAnexos>0){%>
		<br>
        <h6 class="m-t-30 font-medium">Anexos (<%=qtdAnexos %>)</h6>
        <div class="row row-minus m-t-20">
        <%
			if(msg.getContentType().contains("multipart"))
			{
				// essa parte é multipart, então pode conter anexos.
				Multipart multiPart= (Multipart) msg.getContent();
				int numberOfParts = multiPart.getCount();
				for (int partCount = 0; partCount < numberOfParts; partCount++)
				{
					//pega uma parte de cada vez no "for"
					MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
					//checa se o "disposition" (descreve como a parte deve ser apresentada ao usuaio e um anexo.
					if (javax.mail.Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 		
					{
						String nomeArq = part.getFileName();
						nomeArq = nomeArq.substring(nomeArq.lastIndexOf('\\')+1, nomeArq.length());				
						
						%>
						<h6><%=nomeArq %></h6>
						<button oncl
						ick="<%part.saveFile("c:\\temp" + File.separator +nomeArq);%>" value="Baixar">Baixar</button>
			            <%
            		}
						
				}}
			}%>
            
        </div>
    </div>
</li>

<%
	if(msg.getReplyTo().length>0) 
	for(int j=0; j<msg.getReplyTo().length; j++)
	{
		%>
		<li>
    		<div class="collapsible-header" tabindex="0">
        		<div class="d-flex no-block align-items-center">
            		<div class="m-r-10"><img src="./Materialart Admin Template_files/4.jpg" alt="user" class="circle" width="45"></div>
            			<div class="">
                			<h5 class="m-b-0 font-16 font-medium"><%=((InternetAddress)msg.getReplyTo()[j]).getPersonal()%>
                				<small> ( <%=((InternetAddress)msg.getReplyTo()[j]).getAddress() %> )</small></h5>
                					<span>to <%=((InternetAddress)msg.getFrom()[0]).getPersonal() == null?((InternetAddress)msg.getFrom()[0]).getAddress():((InternetAddress)msg.getFrom()[0]).getPersonal() %></span>
            			</div>
        			</div>
    			</div>
    		<div class="collapsible-body"><span>NAO SEI EXIBIR MSG AQUI</span></div>
		</li>
		
		<%}%>

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


</body>
</html>