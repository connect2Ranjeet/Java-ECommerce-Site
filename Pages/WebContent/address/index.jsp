<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> addresses = null;

	///// Get Addresses from current user
	if (user != null) {
		addresses = AddressAction.getAddresses(Integer.parseInt(user.get("ID")));
	}else{
		response.sendRedirect("/"); /// send user back if not logged in
	}
	
	///// delete address
	if(request.getMethod().equals("POST")){
		String deleted_address_id = request.getParameter("deleted_address_id");
		if(deleted_address_id!=null){
			AddressAction.deactivateAddress(Integer.parseInt(deleted_address_id));
			response.sendRedirect("/address");
		}
	}
	 
%>

<jsp:include page="/layout/header.jsp" flush="true" />

<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h4></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li class="active"><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>

	<div class="span9 well">
		<h3>Address</h3>
		<div class="btn-toolbar">
			<a href="/address/add.jsp" class='btn btn-inverse'>Enter new
				address</a>
		</div>
		<%
			if (addresses != null && addresses.get("ID").size() > 0) {
		%>
		<table class="table">
			<thead>
				<tr>
					<th class="span6"></th>
					<th class="span1"></th>
					<th class="span1"></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < addresses.get("ID").size(); ++i) {
						if (Integer.parseInt(addresses.get("Type").get(i)) == 1) {
							String address_id = addresses.get("ID").get(i);
							String address_1 = addresses.get("Address1").get(i);
							String address_2 = addresses.get("Address2").get(i);
							String zipcode = addresses.get("Zip").get(i);
							String province = addresses.get("Province").get(i);
							String state = addresses.get("State").get(i);
							String phone = addresses.get("Phone").get(i);
				%>
				<tr>
					<td>
						<address>
							<%=address_1%>,
							<%=address_2%><br>
							<%=province%>,
							<%=state%>
							<%=zipcode%><br> <abbr title="Phone">P:</abbr>
							<%=phone%>
						</address>
					</td>
					<td><a href="/address/edit?id=<%=address_id%>"
						class="btn btn-inverse"> <i class="icon-wrench"></i>
					</a></td>
					<td>
						<form method="POST" onsubmit="return confirm('Do you want to remove this address ?');">
							<input type="hidden" name="deleted_address_id" value="<%=address_id%>"/>
							<button type="submit" class="btn btn-inverse">
								<i class="icon-trash"></i>
							</button>
						</form>
					</td>
				</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<p>You don't have an address !</p>
		<%
			}
		%>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />