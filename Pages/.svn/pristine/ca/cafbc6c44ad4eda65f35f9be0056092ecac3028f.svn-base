<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	/*
	*  Complete transaction
	*/

	Map<String, String> user = UserAction.getCurrentUser(request);
	int order_number =0;
	if (user == null) {
		response.sendRedirect("/");
	}
	
	boolean error_message = false;
	if(request.getMethod().equals("POST")){
		String shipping_address_id = request.getParameter("shipping_address_id");
		if(shipping_address_id==null){
			error_message = true;
		}else{
			//// Get products in cart again
			Map<String, List<String>> products = CartAction.getCart(session);
			if(products==null){
				response.sendRedirect("/");
				return;
			}
			
			String user_id = user.get("ID");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date creation_date = new Date();
			
			if (products != null && products.get("product_id").size() > 0) {
				order_number = TransactionAction.addOrder("1", user_id);
				for (int i = 0; i < products.get("product_id").size(); ++i) {
					String product_id = products.get("product_id").get(i);
					String quantity = products.get("quantity").get(i);
					
					TransactionAction.createTransaction(quantity,dateFormat.format(creation_date) ,"1",product_id,user_id, shipping_address_id, Integer.toString(order_number));
				}
			}
			
		}
	}
%>

<jsp:include page="/layout/header.jsp" flush="true" />
<div class="row">
	<div class="span12">
<%if(error_message) {%>
<div class="alert alert-error">There is some thing wrong</div>
<ul>
	<li>You tried to complete without choosing address</li>
	<li>Your have not logged in</li>
	<li>Your cart is empty</li>
</ul>
<p>Contact admin for technical issues</p>
<% }else{ %>
<h2>You have completed the transaction !</h2>
<div class="fluid-row">
<h4>Transaction ID: <%=order_number %></h4>
</div>
<div class="fluid-row">
<div class="span4">
<div class="well">
<%		Map<String, List<String>> payment = PaymentAction.getPayment(Integer.parseInt(user.get("ID")));
		String p_card_type = payment.get("Card_type").get(0);
		String p_card_name = payment.get("Card_name").get(0);
		String p_expr_date = payment.get("Exr_date").get(0);
		String p_card_number = payment.get("Card_number").get(0);
		p_card_number = p_card_number.substring(p_card_number.length()-4,p_card_number.length());
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
%>
<h5>Your payment method</h5>

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
					<td>Card holder</td>
					<td><%= p_card_name %></td>
				</tr>				
			</tbody>
		</table>
</div>
</div></div>

<div class="span4">
<div class="well">
			<%Map<String, List<String>> address = AddressAction.getAddress(request.getParameter("shipping_address_id")); 
			
			String address_1 = address.get("Address1").get(0);
			String address_2 = address.get("Address2").get(0);
			String zipcode = address.get("Zip").get(0);
			String province = address.get("Province").get(0);
			String state = address.get("State").get(0);
			String phone = address.get("Phone").get(0);
			%>
				<h5>Shipping Address</h5>
				<address>
					<%=address_1 %>, <%= address_2 %><br> <%= province %>, <%= state %> <%= zipcode %><br>
					<abbr title="Phone">P:</abbr> <%= phone %>
				</address>
</div>
</div>
		
</div></div>
<div class="fluid-row">
<div class="well">
	
	
	<table class="table table-striped">
	<thead>
					<tr>
						<th class="span1"></th>
						<th class="span3">Name</th>
						<th class="span1">Quantity</th>
						<th class="span1"></th>
						<th class="span1">Price</th>
						<th class="span1"></th>
						<th class="span1"></th>
					</tr>
				</thead>
				
				<% Map<String, List<String>> products = CartAction.getCart(session);
				int sub_total=0;
				int total = 0;
				for (int i = 0; i < products.get("product_id").size(); ++i) {
					String product_id = products.get("product_id").get(i);
					String quantity = products.get("quantity").get(i);
					String product_name = ProductAction.getProductName(Integer.parseInt(product_id));
					String product_price = ProductAction.toPrice(ProductAction.getProductPrice(Integer.parseInt(product_id)));
					int product_price_full = Integer.parseInt(ProductAction.getProductPrice(Integer.parseInt(product_id)));							
					Map<String, List<String>> product_images = ImageAction.getImages(product_id);
					String url = product_images.get("Image").get(0);
					if (url == null || url.length() < 1)
						url = "http://placehold.it/64x64";
					sub_total = Integer.parseInt("0" + quantity) * product_price_full;
					total+=sub_total;
					
				
				%><tbody>
				<tr>
				<td><a href="/product.jsp?id=<%=product_id%>"><img src=<%=url%> width="64px"></a></td>
				<td><a href="/product.jsp?id=<%=product_id%>"><%=product_name %></a></td>
				<td><%=quantity %></td>
				<td>x</td>
				<td>$<%=product_price%></td>
				<td>=</td>
				<td>$<%=ProductAction.toPrice(sub_total)%></td></tr>
				
				</tbody>
				<% } %>
				
	</table>
	
</div>
</div>
<div class="fluid-row">
<div class="well span2">
<h4>Total Price: $<%=ProductAction.toPrice(total) %></h4>
</div>
</div>
<div class="fluid-row">
<div class="span12">
	<h4>Click <a href="/order/list.jsp" style="color:red">here</a> to view order status.</h4>
	<div>
		<a href="/" class="btn btn-inverse">Continue shopping</a>
	</div>
	</div></div>
<% 
CartAction.emptyCart(request.getSession());
} %>

</div>
</div>
<jsp:include page="/layout/footer.jsp" flush="true" />