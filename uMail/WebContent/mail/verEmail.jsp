<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.internet.*, javax.mail.*, 
                         java.io.*, java.util.Properties, javax.mail.search.*, md5util.*, bd.dbos.*, emailmanipulator.*"
    pageEncoding="ISO-8859-1"%>
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
Email em = (Email)session.getAttribute("Email1");

EmailManipulator email = new EmailManipulator(em);
Message[] emails = email.mensagens("inbox");
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
            	class="active"><i class="material-icons">cloud</i>Clear All</a></li>
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
	if (bodyPart.isMimeType("text/plain"))
	{
		return result + "\n" + bodyPart.getContent();
	}
	else if (bodyPart.isMimeType("text/html"))
	{
		String html = (String) bodyPart.getContent();
		return result + "\n" + org.jsoup.Jsoup.parse(html).text();
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
						String fileName = part.getFileName();
						fileName = fileName.substring(fileName.lastIndexOf('\\')+1, fileName.length());
						
						%>
						<p><%=fileName%></p>
						<button onclick="<%part.saveFile("c:\\temp" + File.separator +fileName);%>" value="Baixar">Baixar</button>
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


</body>
</html>