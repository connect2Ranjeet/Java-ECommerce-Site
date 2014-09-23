package Action;

import java.util.List;
import java.util.Map;

import DAO.Website_settingsDAO;

public class SiteAction {

	public static Map<String, List<String>> getSettings() {
		Website_settingsDAO site = Website_settingsDAO.getInstance();
		return site.getSettings();
	}
	
	public static boolean updateSettings(String site_id, String site_name,
			String site_email, String template_id,
			String address_1, String address_2, String city, String zipcode,
			String phone, String mission) {

		Website_settingsDAO site = Website_settingsDAO.getInstance();
		
		return site.updateSettings(site_id, template_id, site_name,
						site_email, address_1, address_2, city, zipcode, phone,
						mission);
	}
	
	public static boolean updateTheme(String site_id, String template_id){
		Website_settingsDAO site = Website_settingsDAO.getInstance();
		return site.updateTheme(site_id, template_id);
	}
	
	public static boolean uploadLogo(String logo_url){
		Website_settingsDAO site = Website_settingsDAO.getInstance();
		return site.uploadLogo( logo_url);
	}	
	
}
