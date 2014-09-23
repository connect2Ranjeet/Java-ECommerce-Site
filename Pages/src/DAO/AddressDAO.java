package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * TODO
 * 
 * Important:
 *  Type in table is defined as followed
 * -1 : this address is deactivated 
 *  1 : this is shipping address
 *  2 : this is billing address
 *  Hard coded
 */

public class AddressDAO extends DatabaseObject{
	private static final String name = "Address";
	private static AddressDAO instance = null;
	
	protected AddressDAO(){
		
		super();
	}
	
	public static AddressDAO getInstance() {
		if (instance == null) {
			instance = new AddressDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public int addAddress (int userID, String address1, String address2, String zip, String province, String state, String phone, int type){
		//create new Address map and populate columns
		Map<String, List<String>> newAddress = new HashMap<String, List<String>>();
		populate_columns(newAddress);
		
		//fill the map with our data
		//must add null in for ID to avoid malformed table
		newAddress.get("ID").add(null);
		newAddress.get("Address1").add(address1);
		newAddress.get("Address2").add(address2);
		newAddress.get("Zip").add(zip);
		newAddress.get("Province").add(province);
		newAddress.get("State").add(state);
		newAddress.get("User_ID").add(Integer.toString(userID));
		newAddress.get("Type").add(Integer.toString(type));
		newAddress.get("Phone").add(phone);
		//Insert into the database
		//return 0 = fail, return -ID = already exists at +ID, return +ID = inserted
		return insert(newAddress);	
	}
	
	public boolean getAddressExistence (int userID, String address1, String address2, String zip, String province, String state, String phone, int type){
		//create new Address map and populate columns
		Map<String, List<String>> findAddress = new HashMap<String, List<String>>();
		populate_columns(findAddress);
		
		//fill the map with our data
		//must add null in for ID to avoid malformed table
		findAddress.get("ID").add(null);
		findAddress.get("Address1").add(address1);
		findAddress.get("Address2").add(address2);
		findAddress.get("Zip").add(zip);
		findAddress.get("Province").add(province);
		findAddress.get("State").add(state);
		findAddress.get("User_ID").add(Integer.toString(userID));
		findAddress.get("Type").add(Integer.toString(type));
		findAddress.get("Phone").add(phone);
		Map<String,List<String>> result = select(findAddress,true);
		if (result != null)
			return true;
		else
			return false;
	}
	
	public boolean updateAddress (int address_ID, String address1, String address2, String city, String state, String zipcode, String phone, int type){
		
		//first we make the identifier map
		Map<String, List<String>> addressIdentifier = new HashMap<String, List<String>>();
		populate_columns(addressIdentifier);
		
		//add address ID
		addressIdentifier.get("ID").add(Integer.toString(address_ID));
		
		//Make our updated address map
		Map<String, List<String>> newAddress = new HashMap<String, List<String>>();
		populate_columns(newAddress);
		newAddress.get("Address1").add(address1);
		newAddress.get("Address2").add(address2);
		newAddress.get("Zip").add(zipcode);
		newAddress.get("Province").add(city);
		newAddress.get("State").add(state);
		newAddress.get("Phone").add(phone);
		newAddress.get("Type").add(Integer.toString(type));
		
		//Update the address in the database
		//Returns true if successful, false otherwise
		return update(addressIdentifier, newAddress);	
	}
	
	
	public Map<String, List<String>> getAddressMap(int userID){
		//Create our map and populate
		Map<String, List<String>> findAddress = new HashMap<String, List<String>>();
		populate_columns(findAddress);
		
		//We are searching by userID, so we add that to the map
		findAddress.get("User_ID").add(Integer.toString(userID));
		
		//Now we create a results map
		Map<String, List<String>> results = select(findAddress, true); //second argument means exact match
		
		//Return our results
		return results;	
	}

	//TODO
	//How exactly are we handling this?  As discussed, we still want the user's past transactions to be linked to their address
	public boolean deactivateAddress (int address_ID){
		return this.updateAddress(address_ID, null, null, null, null, null, null, -1);
	}
	
	public boolean deactivateBillingAddress (int address_ID){
		return this.updateAddress(address_ID, null, null, null, null, null, null, -2);
	}
	
	public Map<String, List<String>> getAddressByID(int address_id){
		
		Map<String, List<String>> findAddress = new HashMap<String, List<String>>();
		populate_columns(findAddress);
		
		//We are searching by userID, so we add that to the map
		findAddress.get("ID").add(Integer.toString(address_id));
		
		//Now we create a results map
		Map<String, List<String>> results = select(findAddress, true);
		
		return results;
	}
	
}