<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%

	///Map<String, String> user = UserAction.getCurrentUser(request);

	Map<String, List<String>> user = null;

	///// Get current user
	String user_id = request.getParameter("id");

	if (user_id != null) {
		user = UserAction.getUserById(user_id);
	}
	
	if (user == null) {
		response.sendRedirect("/");
		return;
	}

	String status = "Active"; /// case 1 is default
	int status_id = Integer.parseInt(user.get("Status").get(0));

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

	///// Get Addresses from current user
	Map<String, List<String>> addresses = AddressAction
			.getAddresses(Integer.parseInt(user.get("ID").get(0)));
	
	///// Update user status
	if(request.getMethod().equals("POST")){
		String status_str = request.getParameter("user_status");
		UserAction.updateStatus(user_id, status_str);
		response.sendRedirect("/management/user?id="+user_id);
	}
%>


<jsp:include page="/management/layout/header.jsp" flush="true" />

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
			<div>
				<div class="btn-group" style="margin-right: 20px;margin-bottom: 20px;">
					<a href="/management/user/list.jsp"
						class="btn btn-inverse">Back</a>
				</div>
				<div class="btn-group">
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="user_status" value="1">
						<input type="hidden" name="id" value="<%= user_id %>">
						<button type="submit" class="btn <% if(status_id==1){ out.print("active"); } %>">Active</button>
					</form>
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="user_status" value="2">
						<input type="hidden" name="id" value="<%= user_id %>">
						<button type="submit" class="btn <% if(status_id==2){ out.print("active"); } %>">Deactive</button>
					</form>
					<form method="post" style="float:left; margin-left:5px">
						<input type="hidden" name="user_status" value="3">
						<input type="hidden" name="id" value="<%= user_id %>">
						<button type="submit" class="btn <% if(status_id==3){ out.print("active"); } %>">Banned</button>
					</form>
				</div>
			</div>
			<br> <br>
			<h4>User info</h4>
			<table class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span2"></th>
						<th class="span10"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Username</td>
						<td><%= user.get("Username").get(0) %></td>
					</tr>
					<tr>
						<td>Join date</td>
						<td><%= user.get("Join_date").get(0) %></td>
					</tr>
					<tr>
						<td>IP</td>
						<td><%= user.get("IP").get(0) %></td>
					</tr>
					<tr>
						<td>Host</td>
						<td><%= user.get("Host").get(0) %></td>
					</tr>					
					<tr>
						<td>Status</td>
						<td><span class="label label-success"><%= status %></span></td>
					</tr>
					<tr>
						<td>Email</td>
						<td><a href="mailto:<%= user.get("Email").get(0) %>"><%= user.get("Email").get(0) %></a></td>
					</tr>
				</tbody>
			</table>

			<h4>Addresses</h4>
			<%
				if (addresses != null && addresses.get("ID").size() > 0) {
			%>
			<table class="table table-bordered table-stripped">
				<tbody>
					<%
						for (int i = 0; i < addresses.get("ID").size(); ++i) {
								String address_id = addresses.get("ID").get(i);
								String address_1 = addresses.get("Address1").get(i);
								String address_2 = addresses.get("Address2").get(i);
								String zipcode = addresses.get("Zip").get(i);
								String province = addresses.get("Province").get(i);
								String state = addresses.get("State").get(i);
								String phone = addresses.get("Phone").get(i);

								int type = Integer.parseInt(addresses.get("Type").get(i));
								String type_name = "Shipping address";
								
								switch (type) {
								case 1:
									type_name = "Shipping address";
									break;
								case 2:
									type_name = "Billing address";
									break;
								}
					%>
					<tr>
						<td>
							<address>
								<b>Type: <%= type_name %> </b> ,
								<%=address_1%>,
								<%=address_2%><br>
								<%=province%>,
								<%=state%>
								<%=zipcode%><br> <abbr title="Phone">P:</abbr>
								<%=phone%>
							</address>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				} else {
			%>
			<p>You have not yet added an address to this account.</p>
			<%
				}
			%>
		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />