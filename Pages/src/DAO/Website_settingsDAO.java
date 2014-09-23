package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Website_settingsDAO extends DatabaseObject{
	private static final String name = "Website_settings";
	private static Website_settingsDAO instance = null;
	
	public static Website_settingsDAO getInstance() {
		if (instance == null) {
			instance = new Website_settingsDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public Map<String, List<String>> getSettings(){
		
		Map<String, List<String>> find = new HashMap<String, List<String>>();
		
		populate_columns(find);
		
		return select(find, true);	
	}
	
	public boolean updateSettings (String site_id, String template_id, String site_name, String email, String address_1, String address_2, String city, String zipcode, String phone, String mission){
		
		Map<String, List<String>> identifier = new HashMap<String, List<String>>();
		populate_columns(identifier);		
		identifier.get("ID").add(site_id);
		
		Map<String, List<String>> newSettings = new HashMap<String, List<String>>();
		populate_columns(newSettings);
		newSettings.get("Template").add(template_id);
		newSettings.get("Site_name").add(site_name);	
		newSettings.get("Contact_email").add(email);		
		newSettings.get("Address_1").add(address_1);		
		newSettings.get("Address_2").add(address_2);
		newSettings.get("City").add(city);		
		newSettings.get("Zipcode").add(zipcode);	
		newSettings.get("Phone").add(phone);
		newSettings.get("Mission").add(mission);
		
		return update(identifier, newSettings);
	}
	
	public boolean updateTheme (String site_id, String template_id){
		
		Map<String, List<String>> identifier = new HashMap<String, List<String>>();
		populate_columns(identifier);		
		identifier.get("ID").add(site_id);
		
		Map<String, List<String>> newSettings = new HashMap<String, List<String>>();
		populate_columns(newSettings);
		newSettings.get("Template").add(template_id);
		
		return update(identifier, newSettings);
	}
	
	public boolean uploadLogo (String logo_url){
		
		String query = "UPDATE Website_settings SET Logo_image = '"+logo_url+"';";
		String prep_query = "UPDATE Website_settings SET Logo_image = ?;";
		sql_query(query,prep_query,true);
		
		return true;
	}	
}