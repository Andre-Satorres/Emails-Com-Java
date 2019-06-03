<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

<%

/*try {
String[] to = { "mommavalos@gmail.com" };
	String[] cc = { "aa.satorres@gmail.com" };
String[] cco = { "cc17162@g.unicamp.br" };
String[] an = { "C:\\Users\\User\\Pictures\\Saved Pictures\\1.png" };
EmailManipulator em = new EmailManipulator("andre", "satorres", "mommavalos@gmail.com", "Sem1seiji", 465, Segurancas.getSeguranca(2), Hosts.getHost(3), "gmail.com");
em.createEmailMessage(to, cc, cco, "DEU CERTO?", "MEGALOVANIAAAA", an);
} catch (Exception e) {
// TODO Auto-generated catch block
e.printStackTrace();
}*/

   String result;
   
   // Recipient's email ID needs to be mentioned.
   String to = request.getParameter("para");

   // Sender's email ID needs to be mentioned
   String from = (String)session.getAttribute("usuario");

   // Assuming you are sending email from localhost
   String host = "localhost"; 

   // Get system properties object
   Properties properties = System.getProperties();

   // Setup mail server
   properties.setProperty("mail.smtp.host", host);

   // Get the default Session object.
   Session mailSession = Session.getDefaultInstance(properties);

   try {
	      // Create a default MimeMessage object.
	      MimeMessage message = new MimeMessage(mailSession);
	      
	      // Set From: header field of the header.
	      message.setFrom(new InternetAddress(from));
	      
	      // Set To: header field of the header.
	      message.addRecipient(Message.RecipientType.TO,
	                               new InternetAddress(to));
	      // Set Subject: header field
	      message.setSubject(request.getParameter("assunto"));
	      
	      // Now set the actual message
	      message.setText(request.getParameter("conteudo"));
	      
	      // Send message
	      Transport.send(message);
	      result = "Sent message successfully....";
	   } catch (MessagingException mex) {
	      mex.printStackTrace();
	      result = "Error: unable to send message....";
	   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	 <h1>Send Email using JSP</h1>      
      <p align = "center">
         <% 
            out.println("Result: " + result + "\n");
         %>
      </p>

</body>
</html>