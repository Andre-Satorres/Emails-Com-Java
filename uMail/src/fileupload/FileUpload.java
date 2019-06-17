package fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;

/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/FileUpload")
@MultipartConfig
public class FileUpload extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    public FileUpload() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			Collection<javax.servlet.http.Part> col = request.getParts().stream().filter
												(part -> "arqs".equals(part.getName())).collect(Collectors.toList());
		   	
		   	javax.servlet.http.Part[] fileParts = col.toArray(new javax.servlet.http.Part[col.size()]);
		   	
		   	if(fileParts.length == 0)
		   	{

		   	}
		   	else
		   	{
			   	int i=0;
			   	File[] an = new File[fileParts.length];
			   	
			   	if(fileParts != null)
			    for (javax.servlet.http.Part filePart : fileParts) 
			    {
			        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			        
			        InputStream fileContent = filePart.getInputStream();
			        
			        File f = new File(fileName);
			        
		    		try
		    		{
		    			OutputStream outputStream = new FileOutputStream(f);
		    		    IOUtils.copy(fileContent, outputStream);
		    		    an[i] = f;
		    		}
		    		catch(Exception e)
		    		{}
		    		
			        i++;
			    }
			   	
			   	request.setAttribute("anexos", an);
		    }
		}
		catch(Exception e)
		{
			e.printStackTrace();
			request.setAttribute("error", e.getMessage());
		}
		
		String nextJSP = "/mail/enviarEmail.jsp";
   		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
   		dispatcher.forward(request,response);
	}

}
