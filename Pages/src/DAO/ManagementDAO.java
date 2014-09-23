package DAO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * 
 */
public class ManagementDAO extends DatabaseObject{
	private static final String name = "Management";
	private static ManagementDAO instance = null;
	
	protected ManagementDAO(){
		
		super();
	}
	
	public static ManagementDAO getInstance() {
		if (instance == null) {
			instance = new ManagementDAO();
			return instance;
		}
		else
			return instance;
	}

	public String getName() {
	   return name;
	}
	
	public boolean updateManagement(int User_ID, String new_name, String new_password, String new_IP, String Session_value, 
					String Remember_value, String Login_attempt, String Hack_attempt, String priviledge) {
		Map<String, List<String>> user_Identifier = new HashMap<String, List<String>>();
		populate_columns(user_Identifier);
		
		//Our only information to add. After this all we need to worry about is our new information
		user_Identifier.get("ID").add(Integer.toString(User_ID));
		
		//Our new information will again be in a map, but we'll fill out everything we have.
		Map<String, List<String>> management_Update = new HashMap<String, List<String>>();
		populate_columns(management_Update);
		management_Update.get("Username").add(new_name);
		management_Update.get("Password").add(new_password);
		management_Update.get("IP").add(new_IP);
		management_Update.get("Session_value").add(Session_value);
		management_Update.get("Remember_value").add(Remember_value);
		management_Update.get("Login_attempt").add(Login_attempt);
		management_Update.get("Hack_attempt").add(Hack_attempt);
		management_Update.get("Priviledge_level_ID").add(priviledge);
		
		
		//Finally we update and return whether we were successful or not.
		return update(user_Identifier, management_Update);
	}
	
	public int loginManagement(String username, String password, String current_IP) {
		Map<String, List<String>> loginUser = new HashMap<String, List<String>>();
		populate_columns(loginUser);
		String nullString = null;
		int login_userID = 0, login_attempt;
		loginUser.get("Username").add(username);
		
		Map<String, List<String>> result = select(loginUser, true);
		if (result != null) {
			login_userID = Integer.parseInt(result.get("ID").get(0));
			if (result.get("Password").get(0).compareTo(password) == 0) {
				updateManagement(login_userID, nullString, nullString, nullString, nullString, 
						nullString, "0", nullString, nullString);
				return login_userID;
			}
			else {
				login_attempt = Integer.parseInt(result.get("Login_attempt").get(0)) + 1;
				updateManagement(login_userID, nullString, nullString, nullString, nullString, 
						nullString, Integer.toString(login_attempt), nullString, nullString);
				return 0;
			}
				
		}
		return 0;
	}

}