<jsp:include page="/layout/header.jsp" flush="true" />
<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<%
		String address_id = request.getParameter("id"); 
		Map<String, String> user = UserAction.getCurrentUser(request);
		
		if(user==null){
			response.sendRedirect("/");	
			return;
		}
		if (address_id == null || address_id.length() < 1) {
			response.sendRedirect("/");
			return;
		}

		Map<String, List<String>> address_old = AddressAction.getAddress(address_id);
		String address_1_old = "";
		String address_2_old = "";
		String city_old = "";
		String state_old = "";
		String zipcode_old = "";
		String phone_old = "";
		String user_id = "";
		String type = "";
		if (address_old == null) {
			response.sendRedirect("/");
			return;
		}
		address_1_old = address_old.get("Address1").get(0);
		address_2_old = address_old.get("Address2").get(0);
		city_old = address_old.get("Province").get(0);
		state_old = address_old.get("State").get(0);
		zipcode_old = address_old.get("Zip").get(0);
		phone_old = address_old.get("Phone").get(0);
		 user_id = address_old.get("User_ID").get(0);
		 type = address_old.get("Type").get(0);
		if (user.get("ID").compareTo(user_id) != 0 || type.compareTo("1") != 0){
			response.sendRedirect("/");
			return;
		}
	if (request.getMethod().equals("POST")) {
		String address1 = request.getParameter("inputAddress1");
		String address2 = request.getParameter("inputAddress2");
		String zipcode = request.getParameter("inputZipcode");
		String province = request.getParameter("inputProvince");
		String state = request.getParameter("inputState");
		String phone = request.getParameter("inputPhone");
			boolean result = AddressAction.updateAddress(Integer.parseInt(address_id), address1, address2, province, state, zipcode, phone, AddressAction.ShippingAddress);
			if(result == true){
				response.sendRedirect("/address");
				return;
			}
			
		 	else{ %>
	
		<div class="alert alert-error">This Address Already Exists!</div>
		<% 		}
		}
		%>
		
<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h3></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li class="active"><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>

	<div class="span9 well">
		<h3>Edit address</h3>
		<div class="btn-toolbar">
			<a href="/address" class='btn btn-inverse'>All addresses</a>
		</div>
		<br>
		<form class="form-horizontal" method="POST">
			<div class="control-group">
				<label class="control-label" for="inputAddress1">Address 1</label>
				<div class="controls">
					<input type="text" id="inputAddress1" name="inputAddress1" value="<%=address_1_old%>"> 
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputAddress2">Address 2</label>
				<div class="controls">
					<input type="text" id="inputAddress2" name="inputAddress2" value="<%=address_2_old%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputProvince">City</label>
				<div class="controls">
					<input type="text" id="inputProvince" name="inputProvince" value="<%=city_old%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputZipcode">Zipcode</label>
				<div class="controls">
					<input type="text" id="inputZipcode" name="inputZipcode" value="<%=zipcode_old%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputState">State</label>
				<div class="controls">
					<select name="inputState" id="inputState" class="required">
						<option value="AL" <% if(state_old.equals("AL")){ out.print("selected='true'");} %>>Alabama</option>
						<option value="AK" <% if(state_old.equals("AK")){ out.print("selected='true'");} %>>Alaska</option>
						<option value="AZ" <% if(state_old.equals("AZ")){ out.print("selected='true'");} %>>Arizona</option>
						<option value="AR" <% if(state_old.equals("AR")){ out.print("selected='true'");} %>>Arkansas</option>
						<option value="CA" <% if(state_old.equals("CA")){ out.print("selected='true'");} %>>California</option>
						<option value="CO" <% if(state_old.equals("CO")){ out.print("selected='true'");} %>>Colorado</option>
						<option value="CT" <% if(state_old.equals("CT")){ out.print("selected='true'");} %>>Connecticut</option>
						<option value="DE" <% if(state_old.equals("DE")){ out.print("selected='true'");} %>>Delaware</option>
						<option value="FL" <% if(state_old.equals("FL")){ out.print("selected='true'");} %>>Florida</option>
						<option value="GA" <% if(state_old.equals("GA")){ out.print("selected='true'");} %>>Georgia</option>
						<option value="HI" <% if(state_old.equals("HI")){ out.print("selected='true'");} %>>Hawaii</option>
						<option value="ID" <% if(state_old.equals("ID")){ out.print("selected='true'");} %>>Idaho</option>
						<option value="IL" <% if(state_old.equals("IL")){ out.print("selected='true'");} %>>Illinois</option>
						<option value="IN" <% if(state_old.equals("IN")){ out.print("selected='true'");} %>>Indiana</option>
						<option value="IA" <% if(state_old.equals("IA")){ out.print("selected='true'");} %>>Iowa</option>
						<option value="KS" <% if(state_old.equals("KS")){ out.print("selected='true'");} %>>Kansas</option>
						<option value="KY" <% if(state_old.equals("KY")){ out.print("selected='true'");} %>>Kentucky</option>
						<option value="LA" <% if(state_old.equals("LA")){ out.print("selected='true'");} %>>Louisiana</option>
						<option value="ME" <% if(state_old.equals("ME")){ out.print("selected='true'");} %>>Maine</option>
						<option value="MD" <% if(state_old.equals("MD")){ out.print("selected='true'");} %>>Maryland</option>
						<option value="MA" <% if(state_old.equals("MA")){ out.print("selected='true'");} %>>Massachusetts</option>
						<option value="MI" <% if(state_old.equals("MI")){ out.print("selected='true'");} %>>Michigan</option>
						<option value="MN" <% if(state_old.equals("MN")){ out.print("selected='true'");} %>>Minnesota</option>
						<option value="MS" <% if(state_old.equals("MS")){ out.print("selected='true'");} %>>Mississippi</option>
						<option value="MO" <% if(state_old.equals("MO")){ out.print("selected='true'");} %>>Missouri</option>
						<option value="MT" <% if(state_old.equals("MT")){ out.print("selected='true'");} %>>Montana</option>
						<option value="NE" <% if(state_old.equals("NE")){ out.print("selected='true'");} %>>Nebraska</option>
						<option value="NV" <% if(state_old.equals("NV")){ out.print("selected='true'");} %>>Nevada</option>
						<option value="NH" <% if(state_old.equals("NH")){ out.print("selected='true'");} %>>New Hampshire</option>
						<option value="NJ" <% if(state_old.equals("NJ")){ out.print("selected='true'");} %>>New Jersey</option>
						<option value="NM" <% if(state_old.equals("NW")){ out.print("selected='true'");} %>>New Mexico</option>
						<option value="NY" <% if(state_old.equals("NY")){ out.print("selected='true'");} %>>New York</option>
						<option value="NC" <% if(state_old.equals("NC")){ out.print("selected='true'");} %>>North Carolina</option>
						<option value="ND" <% if(state_old.equals("ND")){ out.print("selected='true'");} %>>North Dakota</option>
						<option value="OH" <% if(state_old.equals("OH")){ out.print("selected='true'");} %>>Ohio</option>
						<option value="OK" <% if(state_old.equals("OK")){ out.print("selected='true'");} %>>Oklahoma</option>
						<option value="OR" <% if(state_old.equals("OR")){ out.print("selected='true'");} %>>Oregon</option>
						<option value="PA" <% if(state_old.equals("PA")){ out.print("selected='true'");} %>>Pennsylvania</option>
						<option value="RI" <% if(state_old.equals("RI")){ out.print("selected='true'");} %>>Rhode Island</option>
						<option value="SC" <% if(state_old.equals("SC")){ out.print("selected='true'");} %>>South Carolina</option>
						<option value="SD" <% if(state_old.equals("SD")){ out.print("selected='true'");} %>>South Dakota</option>
						<option value="TN" <% if(state_old.equals("TN")){ out.print("selected='true'");} %>>Tennessee</option>
						<option value="TX" <% if(state_old.equals("TX")){ out.print("selected='true'");} %>>Texas</option>
						<option value="UT" <% if(state_old.equals("UT")){ out.print("selected='true'");} %>>Utah</option>
						<option value="VT" <% if(state_old.equals("VT")){ out.print("selected='true'");} %>>Vermont</option>
						<option value="VA" <% if(state_old.equals("VA")){ out.print("selected='true'");} %>>Virginia</option>
						<option value="WA" <% if(state_old.equals("WA")){ out.print("selected='true'");} %>>Washington</option>
						<option value="DC" <% if(state_old.equals("DC")){ out.print("selected='true'");} %>>Washington D.C.</option>
						<option value="WV" <% if(state_old.equals("WV")){ out.print("selected='true'");} %>>West Virginia</option>
						<option value="WI" <% if(state_old.equals("WI")){ out.print("selected='true'");} %>>Wisconsin</option>
						<option value="WY" <% if(state_old.equals("WY")){ out.print("selected='true'");} %>>Wyoming</option>
					</select>
				</div>
			</div>		
			<div class="control-group">
				<label class="control-label" for="inputPhone">Phone</label>
				<div class="controls">
					<input type="text" id="inputPhone" name="inputPhone" value="<%=phone_old%>">
				</div>
			</div>	
			<div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary">Update</button>
				</div>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />