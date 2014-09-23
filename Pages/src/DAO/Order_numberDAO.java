package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Order_numberDAO extends DatabaseObject{
	private static final String name = "Order_number";
	//Singleton Design
	private static Order_numberDAO instance = null;
	//This will be our interface to the table in MySQL.
	//Declare it locally so we can use it within other methods so we won't have to 
	//Create a new connnection each time.

	protected Order_numberDAO(){
		//Here we instantiate our table object which will connect to MySQL
		super();
	}
	
	//Singleton Design
	public static Order_numberDAO getInstance() {
		if (instance == null) {
			instance = new Order_numberDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public int addOrder(String status, int user_id) {
		//First we create our map for newUser to be inserted
		Map<String, List<String>> newOrder = new HashMap<String, List<String>>();
		
		populate_columns(newOrder);
		
		
		//Now that we've populated the columns we can directly reference keys and the lists
		//that they contain.
		
		//We should note, that since Insert does not allow ANY malformed tables (meaning each column should have
		//the same number of elements). We must fill any row that will be filled by MySQL upon insertion (specifically just ID)
		//with null.
		String query = "INSERT INTO Order_number (Status, User_ID) VALUES ('" +status + "', '" + user_id + "');";
		sql_query(query, query, true);
		newOrder.get("ID").add(null);
		newOrder.get("Status").add(status);
		newOrder.get("User_ID").add(Integer.toString(user_id));
		Map<String, List<String>> result=select(newOrder,true);
		int ID = Integer.parseInt("0" + result.get("ID").get(result.get("ID").size()-1));
		return ID;
	}
	
	public int getOrder(int user_ID) {
		//Create our map
		Map<String, List<String>> findOrder = new HashMap<String, List<String>>();
		//Populate the columns
		populate_columns(findOrder);
		
		//Our map will only contain what we're looking for.. namely a username
		findOrder.get("Status").add(Integer.toString(user_ID));
		
		//usersInterface will query the Users table with our map, and return a new one with our results
		Map<String, List<String>> results = select(findOrder, true);
		
		//Now we just need to return our first hit.
		return Integer.parseInt(results.get("ID").get(0));
		
	}
	
	public Map<String, List<String>> getOrderMap(String status) {
		Map<String, List<String>> findOrder = new HashMap<String, List<String>>();
		
		populate_columns(findOrder);
		
		findOrder.get("Status").add(status);
		
		return select(findOrder, true);
	}
	
	public Map<String, List<String>> getUserMap(int order_ID) {
		Map<String, List<String>> findOrder = new HashMap<String, List<String>>();
		
		populate_columns(findOrder);
		
		findOrder.get("ID").add(Integer.toString(order_ID));
		
		return select(findOrder, true);
	}
	
	public Map<String, List<String>> getOrdersByUserID(int user_ID) {
		Map<String, List<String>> findOrder = new HashMap<String, List<String>>();
		
		populate_columns(findOrder);
		
		findOrder.get("User_ID").add(Integer.toString(user_ID));
		
		return select(findOrder, true);
	}
	
	public boolean updateStatus(int order_number_ID, int status, int user_ID) {
		//First thing we need to a map so we can identify the user we're looking for
		//Since User_ID is always unique and it's an argument, that's what we'll use.
		Map<String, List<String>> order_Identifier = new HashMap<String, List<String>>();
		populate_columns(order_Identifier);
		
		//Our only information to add. After this all we need to worry about is our new information
		order_Identifier.get("ID").add(Integer.toString(order_number_ID));
		
		//Our new information will again be in a map, but we'll fill out everything we have.
		Map<String, List<String>> order_Update = new HashMap<String, List<String>>();
		populate_columns(order_Update);
	
		order_Update.get("Status").add(Integer.toString(status));
		order_Update.get("User_ID").add(Integer.toString(user_ID));
		
		
		//Finally we update and return whether we were successful or not.
		return update(order_Identifier, order_Update);
	}
	
	public Map<String, List<String>> getAllOrders(){
		
		Map<String, List<String>> findOrders = new HashMap<String, List<String>>();
		
		populate_columns(findOrders);
		
		return select(findOrders, true);
	}
}
