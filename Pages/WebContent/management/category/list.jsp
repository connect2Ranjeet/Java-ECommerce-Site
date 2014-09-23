<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<jsp:include page="/management/layout/header.jsp" flush="true" />
<%
Map<String, List<String>> cat_map = CategoryAction.getCategoryMap();
%>
<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li class="active"><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content span6">
		<div class="tab-pane active">
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div class="btn-group">
					<a href="/management/category/add.jsp" class="btn btn-inverse">Add
						category</a>
				</div>
			</div>

			<table class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span4">Name</th>
						<th class="span1">Edit</th>
					</tr>
				</thead>
				<%  
				for (int x=0; x < cat_map.get("Name").size(); x++) {
					String cat_name = cat_map.get("Name").get(x);
					String cat_id = cat_map.get("ID").get(x);
					out.print("<tbody>");
					out.print("<tr>");
					out.print("<td><a href=\"/product/list.jsp?cat=" + cat_id + "\">" + cat_name + "</a></td>");
					out.print("<td><a href=\"javascript:alert('This feature has been deferred.')\" class=\"btn btn-inverse\">");
					
					///out.print("<td><a href=\"/management/category/edit.jsp?id="+ cat_id +"\" class=\"btn btn-inverse\">");
					out.print("<i class=\"icon-wrench\"></i></a></td>");
					out.print("</tr>");
					out.print("</tbody>");
				}
				
				%>
			</table>

		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />