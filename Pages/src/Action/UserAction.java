package Action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;

/*
 * UserAction
 * Method: parameters need to be adjusted
 * Url: is the link to where the action method needs to be called
 * Return: need to be adjusted
 * 
 * Updates:
 *  Status:
 *  1 : Active
 *  2 : Deactive
 *  3 : Banned
 */

public class UserAction {
	public static int BanID = 3;
	public static int RegularID=1;

	/*
	 * Sign up Url: /user/sign_up.jsp
	 */
	public static int signUp(String Name, String Username, String Email, String Password) {
		UserDAO UD = UserDAO.getInstance();
		return UD.addUser(Name, Username, Password, Email, null, RegularID);
	}

	/*
	 * Login Url: none
	 */
	public static boolean login(HttpSession session, String userName,
			String password) {

		String nullString = null;
		Map<String, String> user = new HashMap<String, String>();
		
		UserDAO userDAO = UserDAO.getInstance();
		int login_ID = userDAO.loginUser(userName, password, nullString);
		if (login_ID != 0) {
			user.put("ID", Integer.toString(login_ID));
			user.put("Username", userName);
			session.setAttribute("user", user);
			return true;
		} else
			return false;
	}

	/*
	 * Login
	 */
	public static void deactivateUser() {

	}

	/*
	 * get single user by user id URL: /user?id=3
	 */
	public static Map<String, List<String>> getUserById(String user_id) {
		UserDAO user = UserDAO.getInstance();
		return user.getUserMap(Integer.parseInt(user_id));
	}
	
	public static String getUsernameById(String user_id) {
		UserDAO user = UserDAO.getInstance();
		Map<String, List<String>> usermap = user.getUserMap(Integer.parseInt(user_id));
		if (usermap != null)
			return usermap.get("Username").get(0);
		else
			return null; 
	}

	/*
	 * get single user by user id Url: user/settings.jsp
	 */
	public static void getSettings() {

	}

	/*
	 * get single user by user id Url: /user/payment.jsp
	 */
	public void getPayment() {

	}

	/*
	 * Desc: get current user by session Return: Map if user has logged in, null
	 * otherwise - Trung: For my convenience to do other actions, I make this
	 * Two things stored in user: user.get("ID") , and user.get("Username")
	 */
	public static Map<String, String> getCurrentUser(HttpServletRequest request) {

		if (!request.isRequestedSessionIdValid()) {
			return null;
		}

		@SuppressWarnings("unchecked")
		Map<String, String> user = (Map<String, String>) request.getSession()
				.getAttribute("user");

		return user;
	}
	
	/*
	 * 	
	 * 	Get all users for management
	 */
	public static Map<String, List<String>> getAllUsers(){
		UserDAO user = UserDAO.getInstance();
		return user.getAllUsers();
	}
	
	/*
	 *  Update status
	 */
	public static boolean updateStatus(String User_ID, String status){
		UserDAO user = UserDAO.getInstance();
		return user.updateStatus(User_ID, status);	
	}
}
