package Action;

import java.util.*;

import javax.servlet.http.HttpSession;

/*
 * Author: Trung
 * Status: 90%, wait for ProductAction to be done
 * 
 */

public class CartAction {

	public static Map<String, List<String>> getCart(HttpSession session) {
		Map<String, List<String>> cart = (Map<String, List<String>>) session
				.getAttribute("cart");
		return cart;
	}

	public static void add(HttpSession session, String product_id,String quantity) {

		Map<String, List<String>> cart = (Map<String, List<String>>) session
				.getAttribute("cart");

		if (cart == null) {
			cart = new HashMap<String, List<String>>();
			cart.put("product_id", new ArrayList<String>());
			cart.put("quantity", new ArrayList<String>());
		}

		if (cart.get("product_id").indexOf(product_id) == -1) {
			cart.get("product_id").add(product_id);
			cart.get("quantity").add(quantity);

		} else {
			int index = cart.get("product_id").indexOf(product_id);
			int current_total = Integer.parseInt(cart.get("quantity")
					.get(index));
			current_total += Integer.parseInt(quantity);
			cart.get("quantity").set(index, Integer.toString(current_total));
		}

		session.setAttribute("cart", cart);
	}

	public static boolean remove(HttpSession session, String product_id) {

		@SuppressWarnings("unchecked")
		Map<String, List<String>> cart = (Map<String, List<String>>) session
				.getAttribute("cart");

		List<String> products = cart.get("product_id");
		if (products.lastIndexOf(product_id) != -1) {
			int index = products.lastIndexOf(product_id);
			cart.get("product_id").remove(index);
			cart.get("quantity").remove(index);

			session.setAttribute("cart", cart);
			return true;
		}

		return false;
	}

	public static void emptyCart(HttpSession session) {
		@SuppressWarnings("unchecked")
		Map<String, List<String>> cart = (Map<String, List<String>>) session
				.getAttribute("cart");
		if (cart != null) {
			cart.get("product_id").clear();
			cart.get("quantity").clear();
			
			session.setAttribute("cart", cart);
		}
	}

	public static void update(HttpSession session, String product_id,
			String quantity) {

		@SuppressWarnings("unchecked")
		Map<String, List<String>> cart = (Map<String, List<String>>) session
				.getAttribute("cart");

		List<String> products = cart.get("product_id");

		if (products.lastIndexOf(product_id) != -1) {

			int index = products.lastIndexOf(product_id);
			cart.get("quantity").set(index, quantity);

			session.setAttribute("cart", cart);
		}

	}
}