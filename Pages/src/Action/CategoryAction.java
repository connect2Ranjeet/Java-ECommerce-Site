package Action;

import java.util.List;
import java.util.Map;

import org.jdom2.Document;


import DAO.CategoryDAO;
import DAO.Category_descriptionDAO;

public class CategoryAction {
	

	
	public static Document getXMLDocumentByID(int category_ID){
		Category_descriptionDAO CDD = Category_descriptionDAO.getInstance();
		Document doc =CDD.getXMLDocument(category_ID);
		return doc;
	}
	
	public static String getCategoryName(int category_ID) {
		CategoryDAO CD = CategoryDAO.getInstance();
		return CD.getCategoryName(category_ID);
	}
	
	public static Map<String, List<String>> getCategoryMap() {
		CategoryDAO CD = CategoryDAO.getInstance();
		return CD.getCategoryMap();
	}
	
	public static int addCategory (String category_name) {
		CategoryDAO CD = CategoryDAO.getInstance();
		return CD.addCategory(category_name);
	}
	public static int addCategoryDescription(String value, int Category_ID){
		Category_descriptionDAO CDD = Category_descriptionDAO.getInstance();
		return CDD.addCategoryDescription(value, Category_ID);
	}
	public static int getCategoryDescID (String category_ID) {
		Category_descriptionDAO CDD = Category_descriptionDAO.getInstance();
		return CDD.getCategoryDescID(Integer.parseInt(category_ID));
	}
}
