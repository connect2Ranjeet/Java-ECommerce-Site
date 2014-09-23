package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* TODO
 * int addProduct(String name, int price, int quantity, int rating, int number_reviews, boolean public, boolean featured, int category) 
 * boolean updateProduct(int product_id, String name, int price, int quantity, int rating, int number_reviews, boolean public, boolean featured, int category)
 * boolean deactivateProduct (int product_id)
 * Map <String, List<String>> getProducts (String search, int category)
 * Map <String, List<String>> getTrending (int category)
 */
public class ProductDAO extends DatabaseObject{
	private static final String name = "Product";
	private static ProductDAO instance = null;
	
	protected ProductDAO(){
		
		super();
	}
	
	public static ProductDAO getInstance() {
		if (instance == null)
		{
			instance =new ProductDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public int addProduct(String name, int price, int quantity, int Public, int category_ID){
				Map<String, List<String>> newProduct = new HashMap<String, List<String>>();
				
			
				//Our interface contains a list of all of the columns available.
				//Since we need to know what columns we're filling with new data we need to populate our
				//Map with these columns. However, these columns will be the keys for our map
				populate_columns(newProduct);
				
				newProduct.get("ID").add(null);
				newProduct.get("Name").add(name);
				//Add the rest of the info to our map
				newProduct.get("Price").add(Integer.toString(price));
				newProduct.get("Quantity").add(Integer.toString(quantity));
				newProduct.get("Rating").add("0");
				newProduct.get("Number_reviews").add("0");
				newProduct.get("Public").add(Integer.toString(Public));
				
				newProduct.get("Category_ID").add(Integer.toString(category_ID));
				
				return insert(newProduct);
	}
	
	public int getCategoryID(int ID) {
		Map<String,List<String>> cond = new HashMap<String, List<String>>();
		populate_columns(cond);
		cond.get("ID").add(Integer.toString(ID));
		Map<String,List<String>> result = select(cond, true);
		if (result != null)
			return Integer.parseInt(result.get("Category_ID").get(0));
		else
			return 0;
		
	}
	
	public String getProductName(int ID){
		Map<String,List<String>> result = getProductByID(ID);
		if (result != null)
			return result.get("Name").get(0);
		else
			return null;
	}
	
	public String getProductPrice(int ID){
		Map<String,List<String>> result = getProductByID(ID);
		if (result != null) {
			return result.get("Price").get(0);
		}else
			return null;
	}

	
	public boolean updateProduct(int ID, String name, String price, String quantity, String rating, String number_reviews, String Public){
		Map<String, List<String>> updProduct = new HashMap<String, List<String>>();
		Map<String, List<String>> oldProduct = new HashMap<String, List<String>>();
	
		//Our interface contains a list of all of the columns available.
		//Since we need to know what columns we're filling with new data we need to populate our
		//Map with these columns. However, these columns will be the keys for our map
		populate_columns(updProduct);
		populate_columns(oldProduct);
		oldProduct.get("ID").add(Integer.toString(ID));
		
		updProduct.get("ID").add(null);
		updProduct.get("Name").add(name);
		//Add the rest of the info to our map
		updProduct.get("Price").add(price);
		updProduct.get("Quantity").add(quantity);
		updProduct.get("Rating").add(rating);
		updProduct.get("Number_reviews").add(number_reviews);
		updProduct.get("Public").add(Public);
		
		
		
		return update(oldProduct, updProduct);
	}
	
	public int getProductReviewCount(int ID) {
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		find.get("ID").add(Integer.toString(ID));
		Map<String, List<String>> result = select(find, true);
		if (result != null){
			String rating = result.get("Number_reviews").get(0);
			return Integer.parseInt("0" + rating);
		}else
			return 0; 
	}
	
	public Map<String, List<String>> getAllProducts(){
		
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		
		return select(find, true);	
		
	}
	
	public Map<String, List<String>> getProductByID(int ID) {
		Map<String, List<String>> cond = new HashMap<String, List<String>>();
		populate_columns(cond);
		cond.get("ID").add(Integer.toString(ID));
		return select(cond, true);
	}
	
	public Map<String, List<String>> getProductByCategoryID(int ID) {
		Map<String, List<String>> cond = new HashMap<String, List<String>>();
		populate_columns(cond);
		cond.get("Category_ID").add(Integer.toString(ID));
		return select(cond, true);
	}
	public String getProductDefaultImage(int ID) {
		return null;
	}
	
	public Map<String, List<String>> SearchProducts(String terms){
		String proper_search = terms.replace(" ", "%");
		String query = "SELECT Product.*, Product_description.XML_description, Product_description.Product_ID FROM Product JOIN Product_description ON Product.ID=Product_description.Product_ID WHERE Product.Name LIKE '%"+proper_search+"%' || Product_description.XML_description LIKE '%" +proper_search+"%';";
		String prep_query ="SELECT Product.*, Product_description.XML_description, Product_description.Product_ID FROM Product JOIN Product_description ON Product.ID=Product_description.Product_ID WHERE  Product.Name LIKE ? || Product_description.XML_description LIKE ?;";
		return this.sql_query(query,prep_query, false);
	}
	
	public Map<String, List<String>> SearchProductsAndCategory(String terms, int Category_ID){
		String proper_search = terms.replace(" ", "%");
		String query = "SELECT Product.*, Product_description.XML_description, Product_description.Product_ID FROM Product JOIN Product_description ON Product.ID=Product_description.Product_ID WHERE Product.Name LIKE '%"+proper_search+"%' || Product_description.XML_description LIKE '%" +proper_search+"%' && Product.Category_ID='" + Category_ID +"';";
		String prep_query ="SELECT Product.*, Product_description.XML_description, Product_description.Product_ID FROM Product JOIN Product_description ON Product.ID=Product_description.Product_ID WHERE  Product.Name LIKE ? || Product_description.XML_description LIKE ? && Product.Category_ID=?;";
		return this.sql_query(query,prep_query, false);
	}
	
	
	
}
