package Action;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import DAO.ImageDAO;

public class ImageAction {

	@SuppressWarnings("deprecation")
	public static String uploadImage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String file_full_name = "";
		
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			try {
				List items = upload.parseRequest(request);
				Iterator iterator = items.iterator();
				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
		
					if (!item.isFormField()) {
							String fileName = item.getName();
							String root = request.getRealPath("/");
							File path = new File(root + "/img/products");
							
							if (!path.exists()) {
									boolean status = path.mkdirs();
							}
							
							String imageURL = path + "/" + fileName;
							
							File uploadedFile = new File(imageURL);
							System.out.println(uploadedFile.getAbsolutePath());
							item.write(uploadedFile);
							
							file_full_name = "/img/products/"+fileName;
							
							ImageDAO imageDAO = ImageDAO.getInstance();
							imageDAO.addImage(file_full_name);
							
							return file_full_name;
					}
				}
			} catch (FileUploadException e) {
					e.printStackTrace();
			}
			
			
		}
		
		/*
		List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		for (FileItem item : items) {
		    if (!item.isFormField()) {
		        // <input type="file">
		        System.out.println("Field name: " + item.getFieldName());
		        System.out.println("File name: " + item.getName());
		        System.out.println("File size: " + item.getSize());
		        System.out.println("File type: " + item.getContentType());
		    } else {
		        // <input type="text|submit|hidden|password|button">, <select>, <textarea>, <button>
		        System.out.println("Field name: " + item.getFieldName());
		        System.out.println("Field value: " + item.getString());
		    }            
		}*/
		return null;
	}
	
	public static Map<String, List<String>> getImages(String product_id){
		ImageDAO image = ImageDAO.getInstance();
		return image.getImages(product_id);
	}
	
	public static int addImage(String imageURL, String Product_ID) {
		ImageDAO image = ImageDAO.getInstance();
		return image.addImage(imageURL, Integer.parseInt("0" + Product_ID));
	}
}
