package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImageDAO extends DatabaseObject{
	private static final String name = "Images";
	private static ImageDAO instance = null;
	
	protected ImageDAO(){
		super();
	}
	
	public String getName() {
	   return name;
	}
	
	public static ImageDAO getInstance() {
		if (instance == null) {
			instance =  new ImageDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public int addImage(String imageURL)
	{
		//Create a map
		Map<String, List<String>> newImage = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(newImage);
		
		//add null to ID
		newImage.get("ID").add(null);
		
		//fill in the Image value in the map
		newImage.get("Image").add(imageURL);
		
		//add image to database
		return insert(newImage);
	}
	
	public int addImage(String imageURL, int Product_ID)
	{
		//Create a map
		Map<String, List<String>> newImage = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(newImage);
		
		//add null to ID
		newImage.get("ID").add(null);
		newImage.get("Product_ID").add(Integer.toString(Product_ID));
		newImage.get("Default").add("1");
		//fill in the Image value in the map
		newImage.get("Image").add(imageURL);
		
		//add image to database
		return insert(newImage);
	}
	
	/* WE have don't this function
	public boolean updateImage(int imageID, String new_imageURL) {
		Map<String, List<String>> old_Image = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(old_Image);
		
		//Map containing ID
		old_Image.get("ID").add(Integer.toString(imageID));
		
		
		//query the Priviledge_level table with our map, and return a new one with our results
		Map<String, List<String>> new_Image = new HashMap<String, List<String>>();
		
		populate_columns(new_Image);
		
		new_Image.get("Image").add(new_imageURL);
		
		return update(old_Image, new_Image);
	}
	*/
	
	public Map<String,List<String>> getImages(String product_id)
	{
		//Create a map
		Map<String, List<String>> findImage = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(findImage);
		
		//Map containing ID
		findImage.get("Product_ID").add(product_id);
		
		//query the Priviledge_level table with our map, and return a new one with our results
		Map<String, List<String>> results = select(findImage, true);
		
		return results;
	}
	
	public String getDefaultImage(String product_id){
		Map<String, List<String>> findImage = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(findImage);
		
		//Map containing ID
		findImage.get("Product_ID").add(product_id);
		findImage.get("Default_image").add("1");
		//query the Priviledge_level table with our map, and return a new one with our results
		Map<String, List<String>> results = select(findImage, true);
		if (results != null)
			return results.get("Image").get(0);
		else
			return "http://placehold.it/220x200";
	}
}