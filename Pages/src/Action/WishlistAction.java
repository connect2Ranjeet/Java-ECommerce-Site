package Action;

import java.util.List;
import java.util.Map;

import DAO.WishlistDAO;

/*
 * @author Trung
 * Status: almost done
 *
 */

public class WishlistAction {
	
	public static Map<String, List<String>> getWishlist(String user_id){
		WishlistDAO wishlist = WishlistDAO.getInstance();
		return wishlist.getWishlist(user_id);
	}
	
	public static int add(String user_id, String product_id){
		WishlistDAO wishlist = WishlistDAO.getInstance();
		return wishlist.add(user_id, product_id);	
	}
	
	public static boolean delete(String ID){
		WishlistDAO wishlist = WishlistDAO.getInstance();
		return wishlist.delete(ID);
	}
}
