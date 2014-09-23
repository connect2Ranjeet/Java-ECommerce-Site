<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> order = null;

	///// Get Orders from current user
	String order_id = request.getParameter("id");
	if (user != null && order_id!=null) {
		order = TransactionAction.getTransactionsByOrder(order_id);
	}else{
		response.sendRedirect("/"); /// send user back if not logged in
		return;
	}
	
	if(order==null){
		response.sendRedirect("/");
		return;
	}
	
	String order_status = "";
	int order_status_id = Integer.parseInt(order.get("Order_status").get(0));
	
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
	
	
	int price = Integer.parseInt(order.get("Price").get(0));	
	int quantity  = Integer.parseInt(order.get("Quantity").get(0));
%>

<jsp:include page="/layout/header.jsp" flush="true" />

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
		<div class="btn-toolbar clearfix">
			<div class="btn-group" style="margin-right: 20px">
				<a href="/order/list.jsp" type="button" class="btn btn-inverse">Back</a>
			</div>
		</div>
		
		<table class="table table-bordered table-stripped">
			<tbody>
				<tr>
					<td>Order#</td>
					<td><%= order.get("ID").get(0) %></td>
				</tr>
				<tr>
					<td>Date</td>
					<td><%= order.get("Date").get(0) %></td>
				</tr>
				<tr>
					<td>Status</td>
					<td><span class="label label-success"><%= order_status %></span></td>
				</tr>
				<tr>
					<td>Product title</td>
					<td><a href="/product?id=<%= order.get("Product_ID").get(0) %>"><%= order.get("Name").get(0) %></a></td>
				</tr>
				<tr>
					<td>Quantity</td>
					<td><%= quantity %></td>
				</tr>
				<tr>
					<td>Price</td>
					<td>$<%= ProductAction.toPrice(price) %></td>
				</tr>
				<tr>
					<td>Total Price</td>
					<td>
					$<%
						int local_total = price * quantity;
								int n_part = local_total / 100;
								int dec_part = local_total % 100;
								out.println(n_part + "." + dec_part);
					%>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>