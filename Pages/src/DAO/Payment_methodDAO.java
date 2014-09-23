package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Payment_methodDAO extends DatabaseObject{
	private static final String name = "Payment_method";
	private static Payment_methodDAO instance = null;
	private static int PaymentActive = 1;
	private static int PaymentDeactived=0;
	protected Payment_methodDAO(){
		super();
	}
	
	public static Payment_methodDAO getInstance() {
		if (instance == null)
		{
			instance =  new Payment_methodDAO();
			return instance;
		}
		else
			return instance;
	}
	
	public String getName() {
	   return name;
	}
	
	public Map<String, List<String>> getPayment(int user_id){
		
		Map<String, List<String>> paymentsearch = new HashMap<String, List<String>>();
		populate_columns(paymentsearch);
		paymentsearch.get("User_ID").add(Integer.toString(user_id));
		paymentsearch.get("User_accessible").add(Integer.toString(PaymentActive));

		return select(paymentsearch,true);	
	}
	
	
	
	public int addPaymentMethod(String card_type, String card_name, String expr_date,
			String card_number, String security_number, int address_id, int user_id)
	{
		//Create map
		Map<String, List<String>> newPaymentMethod = new HashMap<String, List<String>>();
		
		//create columns for map
		populate_columns(newPaymentMethod);
		
		//Set ID to null
		newPaymentMethod.get("ID").add(null);
		
		//populate other columns
		newPaymentMethod.get("Card_type").add(card_type);
		newPaymentMethod.get("Card_name").add(card_name);
		newPaymentMethod.get("Exr_date").add(expr_date);//TODO: how is this spelled in the database
		newPaymentMethod.get("Card_number").add(card_number);
		newPaymentMethod.get("Security_number").add(security_number);
		newPaymentMethod.get("User_ID").add(Integer.toString(user_id));
		newPaymentMethod.get("User_accessible").add(Integer.toString(PaymentActive));
		newPaymentMethod.get("Billing_address_ID").add(Integer.toString(address_id));
		
		//push to the database
		return insert(newPaymentMethod);
	}
	
	public boolean getPaymentMethodExistence(String card_type, String card_name, String expr_date,
			String card_number, String security_number, int address_id, int user_id)
	{
		//Create map
		Map<String, List<String>> findPaymentMethod = new HashMap<String, List<String>>();
		
		//create columns for map
		populate_columns(findPaymentMethod);
		
		//Set ID to null
		findPaymentMethod.get("ID").add(null);
		
		//populate other columns
		findPaymentMethod.get("Card_type").add(card_type);
		findPaymentMethod.get("Card_name").add(card_name);
		findPaymentMethod.get("Exr_date").add(expr_date);//TODO: how is this spelled in the database
		findPaymentMethod.get("Card_number").add(card_number);
		findPaymentMethod.get("Security_number").add(security_number);
		findPaymentMethod.get("User_ID").add(Integer.toString(user_id));
		findPaymentMethod.get("User_accessible").add(Integer.toString(PaymentActive));
		findPaymentMethod.get("Billing_address_ID").add(Integer.toString(address_id));
		
		Map<String,List<String>> result = select(findPaymentMethod,true);
		if (result != null)
			return true;
		else 
			return false;
	}
	
	
	private boolean updatePaymentMethod (int payment_id, String card_type, String card_name, String expr_date,
			String card_number, String security_number, int user_accessible, String address_id)
	{
		//Create map
		Map<String, List<String>> oldPaymentMethod = new HashMap<String, List<String>>();
		
		//create columns for map
		populate_columns(oldPaymentMethod);
		
		//Map containing ID
		oldPaymentMethod.get("ID").add(Integer.toString(payment_id));
		
		//Make new map to store new data
		Map<String, List<String>> newPaymentMethod = new HashMap<String, List<String>>();
		
		populate_columns(newPaymentMethod);
		
		//populate other columns
		newPaymentMethod.get("Card_type").add(card_type);
		newPaymentMethod.get("Card_name").add(card_name);
		newPaymentMethod.get("Exr_date").add(expr_date);//TODO: how is this spelled in the database
		newPaymentMethod.get("Card_number").add(card_number);
		newPaymentMethod.get("Security_number").add(security_number);
		newPaymentMethod.get("User_accessible").add(Integer.toString(user_accessible));
		newPaymentMethod.get("Billing_address_ID").add(address_id);
		
		return update(oldPaymentMethod, newPaymentMethod);
	}
	
	
	
	public boolean deactivatePaymentMethod (int payment_id)
	{
		//TODO: am i doing this right?
		//Create map
		Map<String, List<String>> deactivatePaymentMethod = new HashMap<String, List<String>>();
		
		//create columns for map
		populate_columns(deactivatePaymentMethod);
		
		deactivatePaymentMethod.get("ID").add(Integer.toString(payment_id));
		
		return this.updatePaymentMethod(payment_id, null, null, null, null, null, PaymentDeactived , null);
	}
}
