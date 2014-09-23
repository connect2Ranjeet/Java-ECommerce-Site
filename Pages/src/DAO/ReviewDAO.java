package DAO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * 
 * TODO
 * 
 * 
 * 
 */

public class ReviewDAO extends DatabaseObject{
	
	private static final String name = "Review";
	private static ReviewDAO instance = null;
	
	protected ReviewDAO(){
		super();
	}
	
	public static ReviewDAO getInstance() {
		if (instance == null) 
		{
			instance = new ReviewDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public Map<String, List<String>> getReviews(String productId){
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		find.get("Product_ID").add(productId);
		
		return select(find, true);	
	}
	
	
	public Map<String, List<String>> getByUserId(String user_id){
		
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		find.get("User_ID").add(user_id);
		
		return select(find, true);	
	}
	
	
	public int addReview (String user_id, String product_id, String comment, String rating){
		
		Map<String, List<String>> newReview = new HashMap<String, List<String>>();
		
		populate_columns(newReview);
		newReview.get("ID").add(null);
		newReview.get("Product_ID").add(product_id);
		newReview.get("User_ID").add(user_id);
		newReview.get("Comment").add(comment);		
		newReview.get("Rating").add(rating);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date join_date = new Date();
		
		newReview.get("Review_date").add(dateFormat.format(join_date));
		int review_result = insert(newReview);
		if (review_result > 0)
			updateProductReviews(product_id);
		return review_result;
	}
	
	public int deleteReview (){
		return 0;
	}
	private boolean updateProductReviews(String product_id) {
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		ProductDAO PD = ProductDAO.getInstance();
		populate_columns(find);
		find.get("Product_ID").add(product_id);
		Map<String, List<String>> result = select(find, true);
		int total = 0;
		int total_reviews=0;
		double avg=0;
		if (result!=null) {
			for (int x=0;x<result.get("Product_ID").size(); x++) {
				total += Integer.parseInt("0" + result.get("Rating").get(x));
				total_reviews+=1;
			}
			avg = (double)total/(double)result.get("Product_ID").size();
			return PD.updateProduct(Integer.parseInt("0" + product_id), null, null, null, 
					Integer.toString((int)avg), Integer.toString(total_reviews) , null);
		}else
			return false;
		}
}