import java.io.*;
import java.nio.file.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/ImageUploadServlet")
@MultipartConfig
public class ImageUploadServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		String uploadedFileName = null;
		for (Part part : request.getParts()) {
			String fileName = part.getSubmittedFileName();
			if (fileName != null && !fileName.isEmpty()) {
				
				String hashedFileName = Integer.toHexString(fileName.hashCode()) + "_" + fileName;
				
				try (InputStream fileContent = part.getInputStream()) {
					//File file = new File(uploadPath + File.separator + fileName);
					
					File file = new File(uploadPath + File.separator + hashedFileName);
					
					Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
					uploadedFileName = file.getName();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}

		request.setAttribute("uploadedFileName", uploadedFileName);
		request.getRequestDispatcher("ProductPro.jsp").forward(request, response);
	}
}