package Action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.ManagementDAO;

public class ManagementAction {
	
	/*
	 * Login Url: none
	 */
	public static boolean login(HttpSession session, String managerName,
			String password) {
		
		String nullString = null;
		Map<String, String> manager = new HashMap<String, String>();
		
		ManagementDAO managerDAO = ManagementDAO.getInstance();
		int login_ID = managerDAO.loginManagement(managerName, password, nullString);
		if (login_ID != 0) {
			manager.put("ID", Integer.toString(login_ID));
			manager.put("managerName", managerName);
			session.setAttribute("manager", manager);
			return true;
		} else
			return false;
	}
}
