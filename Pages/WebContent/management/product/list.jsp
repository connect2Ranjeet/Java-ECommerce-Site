<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	//Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> products = null;

	//if (user != null) {
	products = ProductAction.getAllProducts();
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
	 
	    $('#products_table').dataTable( {
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
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li class="active"><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<a href="/management/product/add.jsp" class="btn btn-inverse">Add new product</a>
			</div>
			<%
				if (products != null && products.get("ID").size() > 0) {
			%>
			<table id="products_table" class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span3">Product title</th>
						<th class="span2">Price</th>
						<th class="span1">In stock</th>
						<th class="span1">Status</th>
						<th class="span1">View</th>
						<th class="span1">Edit</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < products.get("ID").size(); ++i) {
								String product_id = products.get("ID").get(i);
								String product_name = products.get("Name").get(i);
								int price = Integer.parseInt(products.get("Price").get(i));
								

								int in_stock = Integer.parseInt(products.get("Quantity")
										.get(i));

								int status = Integer
										.parseInt(products.get("Public").get(i));
								String status_str = (status == 1) ? "Public" : "Hidden";
					%>
					<tr>
						<td><!--<a href="/management/product?id=<%=product_id%>"><%=product_name%></a> -->
						<a href="javascript:alert('This feature has been deferred.')"><%=product_name%></a></td>
						<td>$<%=ProductAction.toPrice(price).trim()%></td>
						<td><%=in_stock%></td>
						<td><span class="label label-success"><%=status_str%></span></td>
						<td><a href="/product?id=<%=product_id%>"><i
								class="icon-search icon-large"></i></a></td>
						<td><!-- <a
							href="/product/edit.jsp?id=<%=product_id%>"><i
								class="icon-wrench icon-large"></i></a>-->
								<a href="javascript:alert('This feature has been deferred.')"><i class="icon-wrench icon-large"></i></a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				}
			%>
		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />