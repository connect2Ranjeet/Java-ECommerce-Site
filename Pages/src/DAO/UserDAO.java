package DAO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
/*
 * TODO:
 * Date: year-month-day -> 2012-10-30
 * int addUser(String username, String password, String email, String join_date,
 * String IP, int accountType)	X
 * int banUser(String username)	X
 * int getUser(String username)	X
 * 
 * String loginUser(String username, String password, String current_IP)
 * int updateUser(int User_ID, String new_password, String new_email, String new_IP, String Session_value, String Remember_value, int Login_attempt, int Hack_attempt, int new_accountType)
 * String encryptPassword(String password)				X
 * Map<String, List<String>> getUser(String username)	X
 * Map<String, List<String>> getUser(int UserID)		X
 */

public class UserDAO extends DatabaseObject{
	private static final String name = "Users";
	/*
	 *  User Status
	 *  1. Active
	 *  2. Deactive
	 *  3. Banned
	 */
	
	private static int BanID = 3;
	private static int RegularID=1;

	//Singleton Design
	private static UserDAO instance = null;
	//This will be our interface to the table in MySQL.
	//Declare it locally so we can use it within other methods so we won't have to 
	//Create a new connnection each time.

	protected UserDAO(){
		//Here we instantiate our table object which will connect to MySQL
		super();
	}
	
	//Singleton Design
	public static UserDAO getInstance() {
		if (instance == null) {
			instance = new UserDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public int addUser(String name, String username, String password, String email, String current_IP, int accountType) {
		//First we create our map for newUser to be inserted
		Map<String, List<String>> newUser = new HashMap<String, List<String>>();
		
	
		//Our interface contains a list of all of the columns available.
		//Since we need to know what columns we're filling with new data we need to populate our
		//Map with these columns. However, these columns will be the keys for our map
		populate_columns(newUser);
		
		
		//Now that we've populated the columns we can directly reference keys and the lists
		//that they contain.
		
		//We should note, that since Insert does not allow ANY malformed tables (meaning each column should have
		//the same number of elements). We must fill any row that will be filled by MySQL upon insertion (specifically just ID)
		//with null.
		newUser.get("ID").add(null);
		newUser.get("Name").add(name);
		//Add the rest of the info to our map
		newUser.get("Username").add(username);
		newUser.get("Password").add(password);
		newUser.get("Email").add(email);
		
		//Here we're just using java to grab the current date
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date join_date = new Date();
		
		//Add it to our map
		newUser.get("Join_date").add(dateFormat.format(join_date));
		
		newUser.get("IP").add(current_IP);
		newUser.get("Host").add("0");
		newUser.get("Session_value").add("0");
		newUser.get("Remember_value").add("0");
		newUser.get("Login_attempt").add("0");
		newUser.get("Hack_attempt").add("0");
		newUser.get("Status").add(Integer.toString(accountType));
		
		//Finally we push it to the database..
		return insert(newUser);
		
		//If it failed we get 0, if it already exists. We get a negative number with the ID it exists at. If we get a positive
		//number, we get the new ID. (i.e. -12 = it exists at ID 12.)
	}
	
	public int getUser(String username) {
		//Create our map
		Map<String, List<String>> findUser = new HashMap<String, List<String>>();
		//Populate the columns
		populate_columns(findUser);
		
		//Our map will only contain what we're looking for.. namely a username
		findUser.get("Username").add(username);
		
		//usersInterface will query the Users table with our map, and return a new one with our results
		Map<String, List<String>> results = select(findUser, true);
		
		//Now we just need to return our first hit.
		return Integer.parseInt(results.get("ID").get(0));
		
		//Although our map design allows for multiple hits, by design our Users table MUST have unique usernames.
		//But keep this in mind when you're searching for things in other tables without unique keys. They might receive multiple hits.
	}
	
	public Map<String, List<String>> getUserMap(String username) {
		Map<String, List<String>> findUser = new HashMap<String, List<String>>();
		
		populate_columns(findUser);
		
		findUser.get("Username").add(username);
		
		
		
		return select(findUser, true);
	}
	
	public Map<String, List<String>> getUserMap(int User_ID) {
		Map<String, List<String>> findUser = new HashMap<String, List<String>>();
		
		populate_columns(findUser);
		
		findUser.get("ID").add(Integer.toString(User_ID));
		
		return select(findUser, true);
	}
	
	
	public boolean updateUser(int User_ID, String new_name, String new_password, String new_email, String new_IP, String Session_value, 
					String Remember_value, String Login_attempt, String Hack_attempt, String new_accountType) {
		//First thing we need to a map so we can identify the user we're looking for
		//Since User_ID is always unique and it's an argument, that's what we'll use.
		Map<String, List<String>> user_Identifier = new HashMap<String, List<String>>();
		populate_columns(user_Identifier);
		
		//Our only information to add. After this all we need to worry about is our new information
		user_Identifier.get("ID").add(Integer.toString(User_ID));
		
		//Our new information will again be in a map, but we'll fill out everything we have.
		Map<String, List<String>> user_Update = new HashMap<String, List<String>>();
		populate_columns(user_Update);
		user_Update.get("Name").add(new_name);
		user_Update.get("Password").add(new_password);
		user_Update.get("Email").add(new_email);
		user_Update.get("IP").add(new_IP);
		user_Update.get("Session_value").add(Session_value);
		user_Update.get("Remember_value").add(Remember_value);
		user_Update.get("Login_attempt").add(Login_attempt);
		user_Update.get("Hack_attempt").add(Hack_attempt);
		user_Update.get("Status").add(new_accountType);
		
		
		//Finally we update and return whether we were successful or not.
		return update(user_Identifier, user_Update);
	}
	
	
	public boolean banUser(String username)
	{
		/// Hard coded
		//Why? because java can't pass null arguments
		String nullString = null;
		int User_ID = getUser(username);
		
		//Finally we pass it on to update so we can ban the user
		return this.updateUser(User_ID, nullString, nullString, nullString, nullString, nullString, 
				nullString, nullString, nullString, Integer.toString(BanID));
	}
	
	public int loginUser(String username, String password, String current_IP) {
		Map<String, List<String>> loginUser = new HashMap<String, List<String>>();
		populate_columns(loginUser);
		String nullString = null;
		int login_userID = 0, login_attempt;
		loginUser.get("Username").add(username);
		
		Map<String, List<String>> result = select(loginUser, true);
		if (result != null) {
			login_userID = Integer.parseInt(result.get("ID").get(0));
			if (result.get("Password").get(0).compareTo(password) == 0) {
				updateUser(login_userID, nullString, nullString, nullString, nullString, nullString, 
						nullString, "0", nullString, nullString);
				return login_userID;
			}
			else {
				login_attempt = Integer.parseInt(result.get("Login_attempt").get(0)) + 1;
				updateUser(login_userID, nullString, nullString, nullString, nullString, nullString, 
						nullString, Integer.toString(login_attempt), nullString, nullString);
				return 0;
			}
				
		}
		return 0;
	}
	
	/*
	 * 
	 * 	url: /management/user/list.jsp
	 */
	public Map<String, List<String>> getAllUsers(){
		
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);

		return select(find, true);
	}
	
	/*
	 *  Update status
	 */
	public boolean updateStatus(String User_ID, String status){
		
		Map<String, List<String>> user_Identifier = new HashMap<String, List<String>>();
		populate_columns(user_Identifier);
		
		user_Identifier.get("ID").add(User_ID);
		
		Map<String, List<String>> user_Update = new HashMap<String, List<String>>();
		populate_columns(user_Update);
		user_Update.get("Status").add(status);
		
		return update(user_Identifier, user_Update);
	}
	
}