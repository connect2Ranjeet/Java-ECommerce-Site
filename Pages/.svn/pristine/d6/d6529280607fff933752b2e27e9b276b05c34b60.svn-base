package Action;

import java.util.List;
import java.util.Map;

import DAO.Payment_methodDAO;
import DAO.Website_settingsDAO;

public class PaymentAction {

	public static Map<String, List<String>> getPayment(int user_id) {
		Payment_methodDAO payment = Payment_methodDAO.getInstance();
		return payment.getPayment(user_id);
	}
	
	public static int addPaymentMethod_DeactivateOld(String card_type, String card_name, String expr_date,
			String card_number, String security_number, int address_id, int user_id, int old_payment_id) {
		Payment_methodDAO PMD = Payment_methodDAO.getInstance();
		boolean result_dea = false;
		int result_add = 0;
		result_add = PMD.addPaymentMethod(card_type, card_name, expr_date, card_number, security_number, address_id, user_id);
		if (result_add > 0){
			if (old_payment_id!=0) {
			result_dea = PMD.deactivatePaymentMethod(old_payment_id);
			if (result_dea == true)
				return result_add;
			else
				return 0;
			}else
				return result_add;
		}else
			return result_add;
	}
	public static boolean getPaymentMethodExistence(String card_type, String card_name, String expr_date,
			String card_number, String security_number, int address_id, int user_id) {
		Payment_methodDAO PMD = Payment_methodDAO.getInstance();
		return PMD.getPaymentMethodExistence(card_type, card_name, expr_date, card_number, security_number, address_id, user_id);
	}
	
}
