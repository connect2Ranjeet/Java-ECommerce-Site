<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> orders = null;
	Map<String, List<String>> all_orders = null;
	///// Get ORders from current user
	if (user != null) {
		
		all_orders = TransactionAction.getOrdersByUserID(user.get("ID")); 
	}else{
		response.sendRedirect("/"); /// send user back if not logged in
	}
	
%>

<jsp:include page="/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/libs/table/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="/js/order.js"></script>
<link href="/libs/table/css/demo_page.css" rel="stylesheet">
<link href="/libs/table/css/demo_table.css" rel="stylesheet">

<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h4></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li class="active"><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>
	<div class="span9 well">
		<h3>Orders</h3>
		<%
			if (all_orders != null && all_orders.get("ID").size() > 0) {
		%>
		<table id="orders_table" class="table">
			<thead>
				<tr>
					<th class="span1">Status</th>
					<th class="span3">Order #</th>
					<th class="span1">Date</th>
					<th class="span1">Total Price</th>
				</tr>
			</thead>
			<tbody>
			<% 
			for (int x=0; x<all_orders.get("ID").size();x++) {
			orders = TransactionAction.getTransactionsByOrder(all_orders.get("ID").get(x));
			String order_number = all_orders.get("ID").get(x);
			String date = null;
			String order_status = all_orders.get("Status").get(x);
			int total = 0;
				for (int i = 0; i < orders.get("ID").size(); ++i) {
						String order_id = orders.get("ID").get(i);
						String quantity = orders.get("Quantity").get(i);
						//String image = orders.get("Image").get(i);
						String name = orders.get("Name").get(i);
						int price = Integer.parseInt(orders.get("Price").get(i));
						total += price;
						date = orders.get("Date").get(i);
						
						
						}
				
				int order_status_id = Integer.parseInt(order_status);
				
				
				
				switch(order_status_id){
				case 1:
					order_status = "Shipping";
					break;
				case 2:
					order_status = "Delivered";
					break;
				case 3:
					order_status = "Returned";
					break;
				case 4:
					order_status = "Canceled";
					break;
				}
			%>
				<tr>
					<td><a href="/order?id=<%= order_number %>"><span class="label label-success"><%=order_status %></span></a></td>
					<td><a href="/order?id=<%= order_number %>">#<%= order_number%></a></td>
					<td><%= date %></td>
					<td>$<%=ProductAction.toPrice(total).trim() %></td>
				</tr>
				<%  
				}%>
			</tbody>
		</table>
		<% }else{ %>
		<p>You don't have any order.</p>
		<% } %>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />