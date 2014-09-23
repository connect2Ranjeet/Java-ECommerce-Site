<%@ page import="Action.*"%>
<%@ page import="Database.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
//Map<String, String> user = UserAction.getCurrentUser(request);
Map<String, List<String>> users = null;

///// Get ORders from current user
//if (user != null) {
users = UserAction.getAllUsers();
//}else{
//	response.sendRedirect("/"); /// send user back if not logged in
//}

Map<Integer,Integer> user_data = new HashMap<Integer,Integer>();

for(int j=0;j<12;++j){
	user_data.put(j,0);
}

//// put users into map ( user_id and month in int )
for (int i = 0; i < users.get("ID").size(); ++i) {
	int user_id = Integer.parseInt(users.get("ID").get(i));
	String str_date = users.get("Join_date").get(i);
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	Date date = (Date)formatter.parse(str_date); 
	int month_int = date.getMonth();
	
	int counter = user_data.get(month_int);
	++counter;
	
	user_data.put(month_int,counter);
}
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

		$('#users_analysis').highchartTable();
	});
</script>

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

			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div>
					<a href="/management/user/list.jsp" class="btn btn-inverse">Back</a>
				</div>
			</div>
			
			<h2>Number of users monthly</h2>
			<%
				if (user_data != null) {
			%>
			<table id="users_analysis" class="hide" data-graph-container-before="1" data-graph-type="line">
				<thead>
					<tr>
						<th class="span2">Month</th>
						<th class="span2">Number of users</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < 12; ++i) {
								int numb = user_data.get(i);
								String month_str = "";

								switch (i) {
								case 0:
									month_str = "January";
									break;
								case 1:
									month_str = "Febuary";
									break;
								case 2:
									month_str = "March";
									break;
								case 3:
									month_str = "April";
									break;
								case 4:
									month_str = "May";
									break;
								case 5:
									month_str = "June";
									break;
								case 6:
									month_str = "July";
									break;
								case 7:
									month_str = "August";
									break;
								case 8:
									month_str = "September";
									break;
								case 9:
									month_str = "October";
									break;
								case 10:
									month_str = "November";
									break;
								case 11:
									month_str = "December";
									break;
								}
					%>
					<tr>
						<td><%=month_str%></td>
						<td><%=numb%></td>
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