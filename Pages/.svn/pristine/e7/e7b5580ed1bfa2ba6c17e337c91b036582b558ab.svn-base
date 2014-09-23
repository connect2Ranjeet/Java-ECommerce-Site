package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Priviledge_levelDAO extends DatabaseObject{
	private static final String name = "Priviledge_level";
	private static Priviledge_levelDAO instance = null;
	
	protected Priviledge_levelDAO(){
		super();
	}
	
	public static Priviledge_levelDAO getInstance() {
		if (instance == null){
			instance = new Priviledge_levelDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public int getLevel(int levelID)
	{
		//Create a map
		Map<String, List<String>> findLevelID = new HashMap<String, List<String>>();
		
		//Populate the columns
		populate_columns(findLevelID);
		
		//Map containing ID
		findLevelID.get("ID").add(Integer.toString(levelID));
		
		//query the Priviledge_level table with our map, and return a new one with our results
		Map<String, List<String>> results = select(findLevelID, true);
		
		return Integer.parseInt(results.get("Priviledge").get(0));
	}
	
}