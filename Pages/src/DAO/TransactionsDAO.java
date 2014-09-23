package DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * TODO
 * - Order status is hardcode as followed
 * 1 : Shipping
 * 2 : Delivered
 * 3 : Return
 * 4 : Canceled
 */

public class TransactionsDAO extends DatabaseObject {
	private static final String name = "Transactions";
	private static TransactionsDAO instance = null;

	protected TransactionsDAO() {

		super();
	}

	public static TransactionsDAO getInstance() {

		if (instance == null) {
			instance = new TransactionsDAO();
			return instance;
		}
		else
			return instance;
	}

	public String getName() {
		return name;
	}
	
	public int createTransaction(String quantity, String date, String order_status, 
			String product_id, String user_ID, String address_id, String order_number) {
		
		Map<String, List<String>> newTrans = new HashMap<String, List<String>>();
		
		populate_columns(newTrans);
		
		newTrans.get("ID").add(null);
		
		newTrans.get("Quantity").add(quantity);
		newTrans.get("Date").add(date);
		newTrans.get("Order_status").add(order_status);
		newTrans.get("Product_ID").add(product_id);
		newTrans.get("User_ID").add(user_ID);
		newTrans.get("Shipping_address_ID").add(address_id);
		newTrans.get("Order_number_ID").add(order_number);
		return insert(newTrans);
	}

	public boolean updateTransaction(String trans_id, String order_status) {
		Map<String, List<String>> identifier = new HashMap<String, List<String>>();
		populate_columns(identifier);
		
		identifier.get("ID").add(trans_id);
		
		Map<String, List<String>> newTrans = new HashMap<String, List<String>>();
		populate_columns(newTrans);
		newTrans.get("Order_status").add(order_status);
		
		return update(identifier, newTrans);		
	}

	public Map<String, List<String>> getATransaction(String trans_id) {

		String query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE Transactions.ID = '" + trans_id
				+ "'";
		String prep_query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE Transactions.ID = ?";

		Map<String, List<String>> trans = sql_query(query,prep_query,false);
		
		return trans;
	}
	
	public Map<String, List<String>> getTransactionsByOrder(String order_id) {

		String query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE Transactions.Order_number_ID = '" + order_id
				+ "'";
		String prep_query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE Transactions.Order_number_ID = = ?";

		Map<String, List<String>> trans = sql_query(query,prep_query,false);
		
		return trans;
	}

	public Map<String, List<String>> getAllTransactions() {

		String query ="SELECT Transactions.*, Product.Price, Product.Name, Users.Username FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID JOIN Users ON Transactions.User_ID = Users.ID";
		
		Map<String, List<String>> trans = sql_query(query,query,false);
		
		return trans;
	}

	public Map<String, List<String>> getUserTransactions(String user_id) {

		String query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE User_ID = '" + user_id
				+ "'";
		String prep_query = "SELECT Transactions.*, Product.Price, Product.Name FROM Transactions JOIN Product ON Transactions.Product_ID = Product.ID WHERE User_ID = ?";
		
		Map<String, List<String>> trans = sql_query(query,prep_query,false);

		return trans;
	}
	
	public Map<String, List<String>> getShippingAddresses(){

		String query = "SELECT Users.Username, Address.Address1,Address.Address2,Address.Zip,Address.Province,Address.State FROM Transactions JOIN Address ON Transactions.Shipping_address_ID = Address.ID JOIN Users ON Users.ID = Transactions.User_ID";
		
		Map<String, List<String>> address_of_orders = sql_query(query,query,false);
		
		return address_of_orders;
	}
}