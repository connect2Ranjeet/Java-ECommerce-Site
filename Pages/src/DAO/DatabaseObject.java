package DAO;

/*
 * 
 * 			This class creates instances of all tables in the database.  This is
 *  to avoid re-creating them multiple times.
 * 		
 * 
 */

import java.util.*;

import Database.Table;
import Database.TableObjects;

public abstract class DatabaseObject{
	private static Map <String, TableObjects> map = new HashMap<String, TableObjects>();
	private static final String[] implementedTables = {
						"Category_description",
						"Category",
						"Cart",
						"Product",
						"Featured",
						"Review",
                        "Product_description",
               	        "Images",
                       	"Website_settings",
                        "Transactions",
                        "Order_number",
                        "Payment_method",
                        "Address",
                        "Wishlist",
                        "Management",
                        "Security_answer",
                        "Security_question",
                        "Priviledge_level",
                        "Users"
						};
	
	private TableObjects tableInterface = null;
	
	public DatabaseObject(){
		
		if(map.isEmpty()){
			for(String i : implementedTables){
				map.put(i, new Table(i));
			}
		}
		if(map.containsKey(this.getName())){
			tableInterface=map.get(this.getName());
		}
	}
	
	public abstract String getName();
	
	//TODO: change the return type of ResultSet to something useful.
	public  Map<String,List<String>> select(Map<String, List<String>> conditions, boolean exactMatch){
		if(tableInterface == null) return null;
		
		return tableInterface.select(conditions, exactMatch);
	}
	
	public int insert(Map<String,List<String>> newData) {
		if(tableInterface == null) return 0;
		return tableInterface.insert(newData);
	}
	
	public boolean update(Map<String, List<String>> Identifiers, Map<String, List<String>> newData) {
		if(tableInterface == null) return false;
		return tableInterface.update(Identifiers, newData);
	}
	
	public  boolean remove(Map<String, List<String>> condition){
		if(tableInterface == null) return false;
		return tableInterface.remove(condition);
	}
	
	public Map<String, List<String>> sql_query(String queryString, String preparedString, boolean DATACHANGER){
		if (tableInterface == null) return null;
		return tableInterface.sql_query(queryString, preparedString, DATACHANGER);
	}
	
	public boolean populate_columns (Map<String, List<String>> map) {
		if (tableInterface == null) return false;
		return tableInterface.populate_columns(map);
	}
	
}