package DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * @author Trung
 *
 */
public class WishlistDAO extends DatabaseObject{
	private static final String name = "Wishlist";
	private static WishlistDAO instance = null;
	
	protected WishlistDAO(){
		
		super();
	}
	
	public static WishlistDAO getInstance() {
		if (instance == null) {
			instance =  new WishlistDAO();
			return instance;
		}
		else
			return instance;
	}

	public String getName() {
	   return name;
	}
	
	public int add(String user_id, String product_id){
		
		Map<String, List<String>> newWish = new HashMap<String, List<String>>();
		populate_columns(newWish);
		
		newWish.get("ID").add(null);
		newWish.get("User_ID").add(user_id);
		newWish.get("Product_ID").add(product_id);
		return insert(newWish);			
	}
	
	public Map<String, List<String>> getWishlist(String user_id) {
		
		String query = "SELECT * FROM Wishlist JOIN Product ON Product.ID = Wishlist.Product_ID WHERE User_ID = '"+user_id+"'";
		String prep_query = "SELECT * FROM Wishlist JOIN Product ON Product.ID = Wishlist.Product_ID WHERE User_ID = ?";
		Map<String, List<String>> products = sql_query(query, prep_query, false);		
		
		return products;			
	}
	
	public boolean delete(String ID){
		Map<String, List<String>> condition = new HashMap<String, List<String>>();
		condition.put("Product_ID", new ArrayList<String>());
		condition.get("Product_ID").add(ID);
		
		return remove(condition);
	}
	
}