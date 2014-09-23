package DAO;
import java.util.*;

public class FeaturedDAO extends DatabaseObject{
	private static final String name = "Featured";
	private static FeaturedDAO instance = null;
	
	protected FeaturedDAO(){
		super();
	}
	
	public String getName() {
	   return name;
	}
	
	public static FeaturedDAO getInstance() {
		if (instance == null) {
			instance =  new FeaturedDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public Map<String, List<String>> getFeatured() {
		
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		
		return select(find, true);	
	}
	
	public Map<String, List<String>> getFeatured(int categoryID) {
		ProductDAO prodDAO = ProductDAO.getInstance();
		Map<String, List<String>> featuredlist = getFeatured();
		Map<String, List<String>> productlist = prodDAO.getProductByCategoryID(categoryID);
		Map<String, List<String>> purify = new HashMap<String, List<String>>();
		populate_columns(purify);
		int results = 0;
		if (productlist != null & featuredlist !=null) {
			for (int i=0;i<productlist.get("ID").size(); i++){
				for (int j=0;j<featuredlist.get("ID").size();j++) {
					if (productlist.get("ID").get(i).compareTo(featuredlist.get("Product_ID").get(j)) == 0){
						purify.get("ID").add(featuredlist.get("ID").get(j));
						purify.get("Product_ID").add(featuredlist.get("ID").get(j));
						results +=1;
					}
				
				}
			}
			if (results > 0)
				return purify;
			else
				return null;
		}else
			return null;	
	}
}
