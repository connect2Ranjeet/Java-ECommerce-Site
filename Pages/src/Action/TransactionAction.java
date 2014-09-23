package Action;

import java.util.List;
import java.util.Map;

import DAO.Order_numberDAO;
import DAO.TransactionsDAO;

public class TransactionAction {
	
	public static int createTransaction(String quantity, String date, String order_status, 
			String product_id, String user_ID, String address_id, String order_number) {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.createTransaction(quantity, date, order_status, product_id, user_ID, address_id, order_number);	
	}
	
	public static int addOrder(String status, String user_id) {
		Order_numberDAO OND = Order_numberDAO.getInstance();
		return OND.addOrder(status, Integer.parseInt("0"+user_id));
	}
	public static Map<String, List<String>> getOrdersByUserID(String user_id) {
		Order_numberDAO OND = Order_numberDAO.getInstance();
		return OND.getOrdersByUserID(Integer.parseInt("0"+user_id));
	}
	
	public static boolean updateTransaction(String trans_id, String order_status) {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.updateTransaction(trans_id, order_status);
	}

	public static Map<String, List<String>> getATransaction(String trans_id) {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.getATransaction(trans_id);
	}
	public static Map<String, List<String>> getTransactionsByOrder(String order_id) {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.getTransactionsByOrder(order_id);
	}

	public static Map<String, List<String>> getAllTransactions() {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.getAllTransactions();
	}

	public static Map<String, List<String>> getUserTransactions(String user_id) {
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.getUserTransactions(user_id);
	}
	
	public static Map<String, List<String>> getShippingAddresses(){
		TransactionsDAO trans = TransactionsDAO.getInstance();
		return trans.getShippingAddresses();
	}
}
