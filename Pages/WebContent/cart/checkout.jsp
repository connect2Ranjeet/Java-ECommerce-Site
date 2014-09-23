<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/*
	Process:
		- get user
		- Display address, payment
		- Choose addresses
		- Then submit 
	 */

	Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> addresses = null;

	if (user == null) {
		response.sendRedirect("/");
	}

	///// Get Addresses from current user
	if (user != null) {
		addresses = AddressAction.getAddresses(Integer.parseInt(user
				.get("ID")));
	}
	
	//// Get payment method
	int payment_id = 1;
	String p_card_type = "1";
	String p_card_name = "";
	String p_expr_date = "";
	String p_card_number = "";
	String p_security_number = "";
	String p_user_accessible = "";
	String p_address_id = "";
	
	String p_address_1 = "";
	String p_address_2 = "";
	String p_city = "";
	String p_state = "";	
	String p_zipcode = "";
	String p_phone = "";
	
	//// Loading payment settings
	Map<String, List<String>> payment = PaymentAction.getPayment(Integer.parseInt(user.get("ID")));
	
	if(payment!=null){
		payment_id = Integer.parseInt(payment.get("ID").get(0));
		p_card_type = payment.get("Card_type").get(0);
		p_card_name = payment.get("Card_name").get(0);
		p_expr_date = payment.get("Exr_date").get(0);
		p_card_number = payment.get("Card_number").get(0);
		p_card_number = p_card_number.substring(p_card_number.length()-4,p_card_number.length());
		
		p_security_number = payment.get("Security_number").get(0);
		p_user_accessible = payment.get("User_accessible").get(0);
		p_address_id = payment.get("Billing_address_ID").get(0);
		
		Map<String, List<String>> address = AddressAction.getAddress(p_address_id);
		
		p_address_1 = address.get("Address1").get(0);
		p_address_2 = address.get("Address2").get(0);
		p_city = address.get("Province").get(0);
		p_state = address.get("State").get(0);
		p_zipcode = address.get("Zip").get(0);
		p_phone = address.get("Phone").get(0);
	}
	
	String payment_name = "";
	int card_type_int = Integer.parseInt(p_card_type);
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
	
	//// List all products
	Map<String, List<String>> products = CartAction.getCart(session);
	if(products==null || products.get("product_id").size()==0){
		response.sendRedirect("/");
	}
	
	int total_prices = 0;

%>

<jsp:include page="/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/js/cart.js"></script>
<link href="/css/cart.css" rel="stylesheet" type="text/css">

<div>
<form action="/cart/complete.jsp" method="post" onsubmit="return confirm('Are you ready to complete transaction ?');">

<div class="row-fluid">
	<div class="span12 well well-small">
		<button id="complete-btn" type="submit" class="center btn btn-warning btn-large">Complete</button>
	</div>
</div>
<div class="row-fluid">
	<div class="span6 well well-small">
		<h4>Choose your address</h4>
		<%
			if (addresses != null && addresses.get("ID").size() > 0) {
		%>
		<%
			for (int i = 0; i < addresses.get("ID").size(); ++i) {
				if (Integer.parseInt(addresses.get("Type").get(i)) == 1) {
					String address_id = addresses.get("ID").get(i);
					String address_1 = addresses.get("Address1").get(i);
					String address_2 = addresses.get("Address2").get(i);
					String zipcode = addresses.get("Zip").get(i);
					String province = addresses.get("Province").get(i);
					String state = addresses.get("State").get(i);
					String phone = addresses.get("Phone").get(i);
		%>
		<div>
			<label class="radio"> <input type="radio"
				name="shipping_address_id" value="<%= address_id %>">
				<address>
					<%=address_1 %>, <%= address_2 %><br> <%= province %>, <%= state %> <%= zipcode %><br>
					<abbr title="Phone">P:</abbr> <%= phone %>
				</address>
			</label>
		</div>
		<%
			}
			}
			} else {
		%>
		<h3>
			You don't have an address , please add one <a href="/address">here</a>
		</h3>
		<%
			}
		%>
	</div>

	<div class="span6 well wells-mall">
		<h4>Your payment method</h4>

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
					<td>************<%=p_card_number %></td>
				</tr>
				<tr>
					<td>Exp. Date:</td>
					<td><%= p_expr_date %></td>
				</tr>
				<tr>
					<td>Security #:</td>
					<td><%= p_security_number %></td>
				</tr>
				<tr>
					<td>Card holder</td>
					<td><%= p_card_name %></td>
				</tr>				
				<tr>
					<td>Billing address:</td>
					<td><address>
							<%= p_address_1 %>, <%= p_address_2 %><br>
							<%= p_city %>, <%= p_state %> <%= p_zipcode %><br> <abbr title="Phone">P:</abbr>
							<%= p_phone %>
						</address></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</form>

<div class="row-fluid">
	<div class="span8">
		<%
			if (products != null && products.get("product_id").size() > 0) {
		%>
		<table class="table table-hove table-striped">
			<thead>
				<tr>
					<th class="span2"></th>
					<th class="span3"></th>
					<th class="span1">Price</th>
					<th class="span1">Quantity</th>
					<th class="span1">Total</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < products.get("product_id").size(); ++i) {
							String product_id = products.get("product_id").get(i);
							int quantity = Integer.parseInt(products.get("quantity")
									.get(i));
							
							String product_name = ProductAction.getProductName(Integer.parseInt(product_id));
							String product_price = ProductAction.toPrice(ProductAction.getProductPrice(Integer.parseInt(product_id)));
							int product_price_full = Integer.parseInt(ProductAction.getProductPrice(Integer.parseInt(product_id)));							
							Map<String, List<String>> product_images = ImageAction.getImages(product_id);
							
				%>

				<tr>
					<td>
					
					<% if(product_images!=null) {
						if(product_images.get("ID").size()>0){
						for (int j = 0; j < 1; ++j) {
							String url = product_images.get("Image").get(0);
					
							out.print("<img src=\""+ url + "\" alt=\"thumb-nail\" width='64px'>");
						}
						}else{
							out.print("<img src='http://placehold.it/64x64' alt=\"thumb-nail\" width='64px'>");
						}
					 } %>
					
					</td>
					<td><a href="/product?id=<%=product_id%>"><%=product_name%></a></td>
					<td>$<%=product_price%></td>
					<td><%=quantity%></td>
					<td>$<%
					
						int local_total = product_price_full * quantity;
								
								out.println(ProductAction.toPrice(local_total));
								total_prices += local_total;
								
					%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<%
			} else {
		%>

		<p>Your cart is empty.</p>

		<%
			}
		%>

	</div>
	<div class="span4 well well-small"
		style="text-align: center">
		<h3>
			Total: $<%
		
			
			out.println(ProductAction.toPrice(total_prices));
		%>
		</h3>
	</div>
</div>

</div>
<jsp:include page="/layout/footer.jsp" flush="true" />