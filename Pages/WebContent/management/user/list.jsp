<%@ page import="Action.*"%>
<%@ page import="Database.*"%>
<%@ page import="java.util.*"%>

<%

	//Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> users = null;

	///// Get ORders from current user
	//if (user != null) {
	users = UserAction.getAllUsers();
	//}else{
	//	response.sendRedirect("/"); /// send user back if not logged in
	//}

%>

<jsp:include page="/management/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/libs/table/js/jquery.dataTables.js"></script>
<script type="text/javascript"
	src="/libs/table/extras/TableTools/media/js/TableTools.min.js"></script>
<link href="/libs/table/extras/TableTools/media/css/TableTools.css"
	rel="stylesheet">
<link href="/libs/table/css/demo_page.css" rel="stylesheet">
<link href="/libs/table/css/demo_table.css" rel="stylesheet">
<style>
.DTTT_print_info {
	z-index: 1000;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		
	    $('#users_table').dataTable( {
	        "sDom": 'T<"clear">lfrtip',
	        "oTableTools": {
	            "sSwfPath": "/libs/table/extras/TableTools/media/swf/copy_csv_xls_pdf.swf"
	        }
	    } );
	    
	});
	
</script>

<!-- Display MODAL WITH USER ANALYSIS -->

<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li class="active"><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<%
				if (users != null && users.get("ID").size() > 0) {
			%>
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div>
					<a href="/management/user/analysis.jsp" class="btn btn-inverse"><i class="icon-bar-chart icon-large"></i> Analysis</a> 
				</div>
			</div>
			<table id="users_table" class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span2">Username</th>
						<th class="span2">Name</th>
						<th class="span1">Join date</th>
						<th class="span1">Status</th>
						<th class="span2">Email</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < users.get("ID").size(); ++i) {
								String user_id = users.get("ID").get(i);
								String name = "No name";
								if (users.get("Name").get(i) != null) {
									name = users.get("Name").get(i);
								}

								int status_id = Integer
										.parseInt(users.get("Status").get(i));
								String username = users.get("Username").get(i);
								String email = users.get("Email").get(i);

								String status = "Active"; /// case 1 is default

								switch (status_id) {
								case 2:
									status = "Deactive";
									break;
								case 3:
									status = "Banned";
									break;
								default:
									status = "Active";
									break;
								}
								
								String date = users.get("Join_date").get(i);
					%>

					<tr>
						<td><a href="/management/user?id=<%=user_id%>"><%=username%></a></td>
						<td><a href="/management/user?id=<%=user_id%>"><%=name%></a></td>
						<td><%=date%></td>
						<td><span class="label label-success"><%=status%></span></td>
						<td><%=email%></td>
					</tr>

					<%
						}
					%>
				</tbody>
			</table>

			<%
				} else {
			%>
			<p>There are currently no registered users to this site.</p>
			<%
				}
			%>
		</div>
	</div>
</div>


<jsp:include page="/management/layout/footer.jsp" flush="true" />