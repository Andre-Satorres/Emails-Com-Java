<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="javax.mail.Multipart, javax.mail.internet.MimeBodyPart,
java.io.InputStream, java.io.FileOutputStream, java.io.File"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String i = request.getParameter("i");
	int index = Integer.parseInt(i);
	Multipart multipart = (Multipart)session.getAttribute("multipart");
	MimeBodyPart part = (MimeBodyPart)multipart.getBodyPart(index);
	
	InputStream is = part.getInputStream();
	
	File f = new File("C:\\temp\\" + part.getFileName());
    FileOutputStream fos = new FileOutputStream(f);
    byte[] buf = new byte[4096];
    int bytesRead;
    while((bytesRead = is.read(buf))!=-1) {
        fos.write(buf, 0, bytesRead);
    }
    fos.close();
	part.saveFile((String)session.getAttribute("path"+index));
	
	int ql = (int)session.getAttribute("ql");
	response.sendRedirect("verEmail.jsp?i="+ql);
%>
</body>
</html>