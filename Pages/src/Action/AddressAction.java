package Action;

import java.util.List;
import java.util.Map;


import DAO.AddressDAO;


/*
 *  Updates
 *  - 
 */

public class AddressAction {
	public static int BillingAddress = 2;
	public static int ShippingAddress = 1;
	public static int DeactivatedShippingAddress=-1;
	public static int DeactivatedBillingAddress=-2;
	/*
	 *   get addresses to display in profile
	 *   Url: /address/
	 */
	public static Map<String, List<String>> getAddresses(int user_id){
		AddressDAO address = AddressDAO.getInstance();
		return address.getAddressMap(user_id);
	}
	
	/*
	 *   Add address
	 *   Url: /address/add.jsp
	 */
	public static int addAddress(int userID, String address1, String address2, String zip, String province, String state, int type, String phone){
		AddressDAO address = AddressDAO.getInstance();
		return address.addAddress(userID, address1, address2, zip, province, state, phone, type);	
	}
	
	/*
	 *   Delete address
	 *   Url: /address/index.jsp
	 */
	public static boolean deactivateAddress(int address_ID){
		AddressDAO address = AddressDAO.getInstance();
		return address.deactivateAddress(address_ID);
	}
	
	
	
	/*
	 *   Delete address
	 *   Url: /user/payment.jsp
	 */
	public static boolean deactivateBillingAddress(int address_ID){
		AddressDAO address = AddressDAO.getInstance();
		return address.deactivateBillingAddress(address_ID);
	}
	
	
	public static boolean updateAddress(int old_address_id, String address_1, String address_2, String province, String state, String zipcode, String phone, int type){
		AddressDAO address = AddressDAO.getInstance();
		return address.updateAddress(old_address_id, address_1, address_2, province, state, zipcode, phone, type);
	}
	public static boolean getAddressExistence (int userID, String address1, String address2, String zip, String province, String state, String phone, int type){
		AddressDAO address = AddressDAO.getInstance();
		return address.getAddressExistence(userID, address1, address2, zip, province, state, phone, type);	
	}
	/*
	 * 
	 *   Get address
	 */
	public static Map<String, List<String>> getAddress(String address_id){
		AddressDAO address = AddressDAO.getInstance();
		return address.getAddressByID(Integer.parseInt(address_id));	
	}
}
