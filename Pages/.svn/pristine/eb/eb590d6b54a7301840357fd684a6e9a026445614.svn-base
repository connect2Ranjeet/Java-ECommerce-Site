<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/*
		Updates:
		- 
	*/
	Map<String, String> user = UserAction.getCurrentUser(request);
	if(user==null){
		response.sendRedirect("/");	
		return;
	}
	
	int payment_id = 1;
	String card_type = "1";
	String card_name = "";
	String expr_date = "";
	String card_number = "";
	String security_number = "";
	String user_accessible = "";
	String address_id = "";
	
	String address_1 = "";
	String address_2 = "";
	String city = "";
	String state = "";	
	String zipcode = "";
	String phone = "";
	String type = "";
	
	//// Loading payment settings
	Map<String, List<String>> payment = PaymentAction.getPayment(Integer.parseInt(user.get("ID")));
	
	if(payment!=null){
		payment_id = Integer.parseInt(payment.get("ID").get(0));
		card_type = payment.get("Card_type").get(0);
		card_name = payment.get("Card_name").get(0);
		expr_date = payment.get("Exr_date").get(0);
		card_number = payment.get("Card_number").get(0);
		String append = "";
		for (int i=0;i<card_number.length()-4; i++)
			append +="*";
		card_number = append + card_number.substring(card_number.length()-4,card_number.length());
		
		security_number = payment.get("Security_number").get(0);
		user_accessible = payment.get("User_accessible").get(0);
		address_id = payment.get("Billing_address_ID").get(0);
		
		Map<String, List<String>> address = AddressAction.getAddress(address_id);
		
		address_1 = address.get("Address1").get(0);
		address_2 = address.get("Address2").get(0);
		city = address.get("Province").get(0);
		state = address.get("State").get(0);
		zipcode = address.get("Zip").get(0);
		phone = address.get("Phone").get(0);
		type = address.get("Type").get(0);
		
	}
	
	String payment_name = "";
	int card_type_int = Integer.parseInt(card_type);
	switch(card_type_int){
	case 1:
		payment_name = "Visa";
		break;
	case 2:
		payment_name = "Master";
		break;
	case 3:
		payment_name = "American express";
		break;
	}
%>


<jsp:include page="/layout/header.jsp" flush="true" />

<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h4></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li><a href="/address">Address</a></li>
			<li class="active"><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>
	<div class="span9 well">
		<h3>Payment</h3>
		<div class="btn-toolbar">
		<% if (payment != null) { %>
			<a href="/user/change_payment.jsp" class='btn btn-inverse'>Change
				payment</a>
		<%}else if (payment==null){ %>
			<a href="/user/change_payment.jsp" class='btn btn-inverse'>Add
				payment</a>
		<%} %>
		</div>

		<table class="table">
			<thead>
				<tr>
					<th class="span2"></th>
					<th class="span3"></th>
					<th class="span1"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Type:</td>
					<td><%=payment_name %></td>
				</tr>
				<tr>
					<td>Number:</td>
					<td><%=card_number %></td>
				</tr>
				<tr>
					<td>Exp. Date:</td>
					<td><%= expr_date %></td>
				</tr>
				<tr>
					<td>Security #:</td>
					<td><%= security_number %></td>
				</tr>
				<tr>
					<td>Card holder</td>
					<td><%= card_name %></td>
				</tr>				
				<tr>
					<td>Billing address:</td>
					<%
					String full_address = "";
					if (payment != null) {
						full_address = address_1 + ", " + address_2 + "<br>"
								+ city + ", " + state + " " + zipcode + "<br>"
								+ "<abbr title=\"Phone\">P:</abbr>" + phone;
					}
					%>
					<td><address>
							<%=full_address%>
						</address></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />