<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	///Map<String, String> user = UserAction.getCurrentUser(request);

	Map<String, List<String>> order = null;
	
	String order_id = request.getParameter("id");
	
	if (order_id != null) {
		order = TransactionAction.getATransaction(order_id);
	}
	
	if (order == null) {
		response.sendRedirect("/");
		return;
	}

	String order_status = "";
	int order_status_id = Integer.parseInt(order.get("Order_status")
			.get(0));

	switch (order_status_id) {
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
	int decimal_part = price % 100;
	int number_part = price / 100;
	int quantity = Integer.parseInt(order.get("Quantity").get(0));
	
	//// Update order
	if(request.getMethod().equals("POST")){
		String new_status = request.getParameter("order_status");
		TransactionAction.updateTransaction(order_id, new_status);
		response.sendRedirect("/management/order?id="+order_id);
	}
%>

<jsp:include page="/management/layout/header.jsp" flush="true" />

<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li class="active"><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<div>
				<div class="btn-group" style="margin-right: 20px;margin-bottom: 20px;">
					<a href="/management/order/list.jsp"
						class="btn btn-inverse">Back</a>
				</div>
				<div class="btn-group">
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="order_status" value="1">
						<input type="hidden" name="id" value="<%= order_id %>">
						<button type="submit" class="btn <% if(order_status_id==1){ out.print("active"); } %>">Shipping</button>
					</form>
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="order_status" value="2">
						<input type="hidden" name="id" value="<%= order_id %>">
						<button type="submit" class="btn <% if(order_status_id==2){ out.print("active"); } %>">Delivered</button>
					</form>
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="order_status" value="3">
						<input type="hidden" name="id" value="<%= order_id %>">
						<button type="submit" class="btn <% if(order_status_id==3){ out.print("active"); } %>">Returned</button>
					</form>
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="order_status" value="4">
						<input type="hidden" name="id" value="<%= order_id %>">
						<button type="submit" class="btn <% if(order_status_id==4){ out.print("active"); } %>">Canceled</button>
					</form>
				</div>
			</div>
			
			<table class="table table-bordered table-stripped">
				<tbody>
					<tr>
						<td>Order#</td>
						<td><%=order.get("ID").get(0)%></td>
					</tr>
					<tr>
						<td>Date</td>
						<td><%=order.get("Date").get(0)%></td>
					</tr>
					<tr>
						<td>Status</td>
						<td><span class="label label-success"><%=order_status%></span></td>
					</tr>
					<tr>
						<td>Product title</td>
						<td><a href="/product?id=<%=order.get("Product_ID").get(0)%>"><%=order.get("Name").get(0)%></a></td>
					</tr>
					<tr>
						<td>Quantity</td>
						<td><%=quantity%></td>
					</tr>
					<tr>
						<td>Price</td>
						<td>$<%=number_part%>.<%=decimal_part%></td>
					</tr>
					<tr>
						<td>Total Price</td>
						<td>$<%
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

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />