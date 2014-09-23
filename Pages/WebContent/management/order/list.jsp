<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	//Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> orders = null;

	///// Get ORders from current user
	//if (user != null) {
	orders = TransactionAction.getAllTransactions();
	//}else{
	//	response.sendRedirect("/"); /// send user back if not logged in
	//}
%>

<jsp:include page="/management/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/libs/table/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="/libs/table/extras/TableTools/media/js/TableTools.min.js"></script>
<link href="/libs/table/extras/TableTools/media/css/TableTools.css" rel="stylesheet">
<link href="/libs/table/css/demo_page.css" rel="stylesheet">
<link href="/libs/table/css/demo_table.css" rel="stylesheet">
<style>
.DTTT_print_info{
	z-index:1000;
}
</style>

<script type="text/javascript">
 $(document).ready(function(){
	 
	    $('#orders_table').dataTable( {
	        "sDom": 'T<"clear">lfrtip',
	        "oTableTools": {
	            "sSwfPath": "/libs/table/extras/TableTools/media/swf/copy_csv_xls_pdf.swf"
	        }
	    } );
 });
 
</script>
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
			<%
				if (orders != null && orders.get("ID").size() > 0) {
			%>
			<!-- <div class="btn-toolbar" style="margin-bottom: 30px">
				<a href="/management/order/analysis.jsp" class="btn btn-inverse"><i class="icon-map-marker icon-large"></i>  Shipping addresses</a>
			</div> -->

			<table id="orders_table" class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span1">Order</th>
						<th class="span1">Date</th>
						<th class="span2">Customer</th>
						<th class="span1">Status</th>
						<th class="span3">Product name</th>
						<th class="span1">Quantity</th>
						<th class="span1">Price</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < orders.get("ID").size(); ++i) {
								String order_id = orders.get("ID").get(i);
								String user_id = orders.get("User_ID").get(i);
								String product_id = orders.get("Product_ID").get(i);
								
								String quantity = orders.get("Quantity").get(i);
								String username = orders.get("Username").get(i);
								String name = orders.get("Name").get(i);
								int price = Integer.parseInt(orders.get("Price").get(i));
								String date = orders.get("Date").get(i);
								String order_status = orders.get("Order_status").get(i);
								int order_status_id = Integer.parseInt(order_status);

								int decimal_part = price % 100;
								int number_part = price / 100;

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
					%>

					<tr>
						<td><a href="/management/order?id=<%=order_id%>"><%=order_id%></a></td>
						<td><%=date%></td>
						<td><a href="/management/user?id=<%=user_id%>"><%=username %></td>
						<td><span class="label label-success"><%=order_status%></span></td>
						<td><a href="/product?id=<%=product_id%>"><%=name%></a></td>
						<td><%=quantity%></td>
						<td>$<%=number_part%>.<%=decimal_part%>/product</td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>
			<%
				} else {
			%>
			<p>You don't have any order.</p>
			<%
				}
			%>
		</div>
	</div>
</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />