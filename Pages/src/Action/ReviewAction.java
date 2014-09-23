package Action;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import DAO.ReviewDAO;
import Database.Table;


public class ReviewAction {
	
	/*
	 *   get reviews to display in product
	 *   Url: /product/
	 */
	public static Map<String, List<String>> getByProductId(String product_id){
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		return reviewDAO.getReviews(product_id);
	}

	/*
	 *  Get reviews by user id
	 *  url: /user
	 */
	public static Map<String, List<String>> getByUserId(String user_id){
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		return reviewDAO.getByUserId(user_id);
	}
	
	/*
	 *   Add review
	 *   Url: /product
	 */
	public static int addReview(String user_id, String product_id, String comment, String rating){
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		return reviewDAO.addReview(user_id, product_id, comment, rating);		
	}
	
	/*
	 *  
	 */
}
