import java.io.*;
import java.nio.file.*;
import java.sql.DriverManager;
import java.util.Arrays;
import java.util.UUID;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/ImageUpdateServlet")
@MultipartConfig
public class ImageUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String p_num = request.getParameter("p_num");
		String updatePath = getServletContext().getRealPath("") + File.separator + "updates";
		File updateDir = new File(updatePath);
		if (!updateDir.exists()) {
			updateDir.mkdir();
		}

		String updatedFileName = null;
		for (Part part : request.getParts()) {
			String fileName = part.getSubmittedFileName();
			if (fileName != null && !fileName.isEmpty()) {
				
				String hashedFileName = Integer.toHexString(fileName.hashCode()) + "_" + fileName;
				
				try (InputStream fileContent = part.getInputStream()) {
					//File file = new File(updatePath + File.separator + fileName);
					
					File file = new File(updatePath + File.separator + hashedFileName);
					
					Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
					updatedFileName = file.getName();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}

		request.setAttribute("updatedFileName", updatedFileName);
		request.setAttribute("p_num", p_num);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Product_UpdatePro.jsp");
		dispatcher.forward(request, response);
	}
}