package Action;


import java.util.List;
import java.util.Map;


import org.jdom2.Document;
import org.jdom2.Element;



import DAO.FeaturedDAO;
import DAO.ProductDAO;
import DAO.Product_descriptionDAO;

public class ProductAction {
	
	

	public static List<Element> getXMLChildrenByCategoryID(int category_ID) {
		Product_descriptionDAO PDD = Product_descriptionDAO.getInstance();
		return PDD.getXMLChildrenByCategoryID(category_ID);
	}
		
	public static Document getXMLDocumentByID (int ID) {
		Product_descriptionDAO PDD = Product_descriptionDAO.getInstance();
		return PDD.getXMLDocumentByProductID(ID);
	}
	public static int addProductDescription(String XML, String CategoryDesc_ID, String Product_ID) {
		Product_descriptionDAO PDD = Product_descriptionDAO.getInstance();
		return PDD.addProductDescription(XML, Integer.parseInt("0" + CategoryDesc_ID), Integer.parseInt("0" + Product_ID));
	}
	
	public static int getCategoryID(int ID) {
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getCategoryID(ID);
	}
	
	public static String getProductName(int ID){
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getProductName(ID);
	}

	public static Map<String, List<String>> getProductByID(int ID){
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getProductByID(ID);
	}
	
	public static Map<String, List<String>> getProductByCategoryID(int ID) {
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getProductByCategoryID(ID);
	}
	
	public static String getProductPrice(int ID){
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getProductPrice(ID);
	}
	
	public static  Map<String, List<String>> getFeatured() {
		FeaturedDAO FD = FeaturedDAO.getInstance();
		return FD.getFeatured();
	}
	
	public static Map<String, List<String>> getAllProducts() {
		ProductDAO PD = ProductDAO.getInstance();
		return PD.getAllProducts();
	}
	
	public static String toPrice(String inputPrice){
		Double price_d = Double.parseDouble("0"+ inputPrice)/100;
		return String.format("%10.2f", price_d);
	}
	
	public static String toPrice(int inputPrice){
		Double price_d = (double)inputPrice/100;
		return String.format("%10.2f", price_d);
	}
	public static Map<String, List<String>> SearchProducts(String terms){
		ProductDAO PD = ProductDAO.getInstance();
		return PD.SearchProducts(terms);
	}
	public static Map<String, List<String>> SearchProductsAndCategory(String terms, String Category_ID) {
		ProductDAO PD = ProductDAO.getInstance();
		return PD.SearchProductsAndCategory(terms, Integer.parseInt(Category_ID));
	}
	public static int addProduct(String name, String price, String quantity, String Public, String category_ID){
		ProductDAO PD = ProductDAO.getInstance();
		return PD.addProduct(name, Integer.parseInt(price), Integer.parseInt(quantity), Integer.parseInt(Public), Integer.parseInt(category_ID));
	}
}
