<%@page contentType="application/json"%>
<%@ page import="Action.*"%>
<%@page import="org.json.simple.*"%>
<%@ page import="java.util.*"%>

<%
	//Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> orders = null;

	///// Get ORders from current user
	//if (user != null) {
	orders = TransactionAction.getShippingAddresses();
	//}else{
	//	response.sendRedirect("/"); /// send user back if not logged in
	//}

	if (orders == null) {
		response.sendRedirect("/");
		return;
	}

	JSONArray address_list = new JSONArray();
	
	for (int i = 0; i < orders.get("Username").size(); ++i) {
		String username = orders.get("Username").get(i);
		String address_2 = " ";
		String zip = " ";
		String state = " ";
		String province = " ";
		
		if(orders.get("Address2").get(i)!=null){
			address_2 = orders.get("Address2").get(i);
		}
		
		if(orders.get("Zip").get(i)!=null){
			zip = orders.get("Zip").get(i);
		}
		
		if(orders.get("State").get(i)!=null){
			state = orders.get("State").get(i);
		}
		
		if(orders.get("Province").get(i)!=null){
			province = orders.get("Province").get(i);
		}
		
		JSONObject obj = new JSONObject();
		obj.put("User", new String(username));
		obj.put("Address1", new String(orders.get("Address1").get(i)));
		obj.put("Address2", new String(address_2));
		obj.put("Province", new String(province));
		obj.put("State", new String(state));
		obj.put("Zip", new String(zip));
		
		address_list.add(obj);
	}
	
	out.print(address_list);
	out.flush();	
%>