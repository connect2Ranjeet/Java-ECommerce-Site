package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*TODO
 * int addCategory(String name, boolean public, int default_image_id)
 * boolean updateCategory (int category_ID, boolean public, int default_image_id)
 * boolean deactivateCategory(int category_ID)
 * boolean emptyCategory (int category_ID)
 * boolean deleteCategory (int category_ID) //double check
 * Map<String, List<String>> getCategoryMap()
 * Map<String, List<String>> getSubCategoryMap(int category_id)
 */
public class CategoryDAO extends DatabaseObject{
	private static final String name = "Category";
	private static CategoryDAO instance = null;
	
	protected CategoryDAO(){
		
		super();
	}
	
	public static CategoryDAO getInstance() {
		if (instance == null) {
			instance = new CategoryDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public String getCategoryName(int ID){
		Map<String, List<String>> cond = new HashMap<String, List<String>>();
		populate_columns(cond);
		cond.get("ID").add(Integer.toString(ID));
		Map<String, List<String>> results = select(cond,true);
		if (results != null)
			return results.get("Name").get(0);
		else
			return null;
	}
	
	public Map<String, List<String>> getCategoryMap() {
		//Purifies our Category table of subcategories
		Map<String, List<String>> results = select(null, true);
		for (int i=0; i <results.get("Subcategory_ID").size(); i++) {
			if (results.get("Subcategory_ID").get(i) != null) {
				results.get("ID").remove(i);
				results.get("Subcategory_ID").remove(i);
				results.get("Name").remove(i);
				results.get("Public").remove(i);
				results.get("Category_description_ID").remove(i);
			}
		}
		
		return results;
	}
	
	public Map<String, List<String>> getSubCategoryMap(int category_id) {
		Map<String, List<String>> results = select(null, true);
		Map<String, List<String>> purify = new HashMap<String, List<String>>();
		populate_columns(purify);
		for (int i=0; i <results.get("ID").size(); i++) {
			if (results.get("Subcategory_ID").get(i) != null) {
				if (results.get("Subcategory_ID").get(i).compareTo(Integer.toString(category_id)) == 0) {
					purify.get("ID").add(results.get("ID").get(i));
					purify.get("Subcategory_ID").add(results.get("Subcategory_ID").get(i));
					purify.get("Name").add(results.get("Name").get(i));
					purify.get("Public").add(results.get("Public").get(i));
					purify.get("Category_description_ID").add(results.get("Category_description_ID").get(i));
			
				}
			}
		}
		return purify;
	}
	
	public int addCategory (String category_name){
		
		Map<String, List<String>> newCategory = new HashMap<String, List<String>>();
		
		populate_columns(newCategory);
		newCategory.get("Subcategory_ID").add(null);
		newCategory.get("Default_image").add(null);
		newCategory.get("ID").add(null);
		newCategory.get("Name").add(category_name);
		newCategory.get("Public").add("1");
		newCategory.get("Category_description_ID").add(null);
		
		return insert(newCategory);
	}
}