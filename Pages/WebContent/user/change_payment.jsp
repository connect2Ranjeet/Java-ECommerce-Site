<jsp:include page="/layout/header.jsp" flush="true" />
<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/*
		Updates:
		- 
	 */
	 
	Map<String, String> user = UserAction.getCurrentUser(request);
	if (user == null) {
		response.sendRedirect("/");
		return;
	}
	String user_id = user.get("ID");
	int payment_id = 1;
	String card_type = "1";
	String card_name = "";
	String expr_date = "";
	String card_number = "";
	String card_number_full = "";
	String security_number = "";
	String user_accessible = "";
	String address_id = "";

	String address_1 = "";
	String address_2 = "";
	String city = "";
	String state = "";
	String zipcode = "";
	String phone = "";

	/// update site details
	

	//// Loading payment settings
	Map<String, List<String>> payment = PaymentAction.getPayment(Integer.parseInt(user.get("ID")));

	if (payment != null) {
		payment_id = Integer.parseInt(payment.get("ID").get(0));
		System.out.println("Get payment");
		System.out.println(payment);
		card_type = payment.get("Card_type").get(0);
		card_name = payment.get("Card_name").get(0);
		expr_date = payment.get("Exr_date").get(0);
		String append = "";
		card_number = payment.get("Card_number").get(0);
		for (int i=0;i<card_number.length()-4; i++)
			append +="*";
		card_number = append + card_number.substring(card_number.length() - 4,
				card_number.length()) ;

		security_number = payment.get("Security_number").get(0);
		user_accessible = payment.get("User_accessible").get(0);
		address_id = payment.get("Billing_address_ID").get(0);

		Map<String, List<String>> address = AddressAction.getAddress(address_id);

		address_1 = address.get("Address1").get(0);
		address_2 = address.get("Address2").get(0);
		city = address.get("Province").get(0);
		state = address.get("State").get(0);
		zipcode = address.get("Zip").get(0);
		phone = address.get("Phone").get(0);
		
	}
	
	String payment_name = "";
	
	int card_type_int = Integer.parseInt(card_type);
	
	switch (card_type_int) {
	case 1:
		payment_name = "Visa";
		break;
	case 2:
		payment_name = "Master";
		break;
	case 3:
		payment_name = "American express";
		break;
	}
%>



<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h4></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li><a href="/address">Address</a></li>
			<li class="active"><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>
	
	<div class="span9 well">
		<h3>Payment</h3>
		<div class="btn-toolbar">
			<a href="/user/payment.jsp" class='btn btn-inverse'>Back</a>
		</div>
		<br>
		<%
	if (request.getMethod().equals("POST")) {
		
		
		payment_id = Integer.parseInt("0" + request.getParameter("payment_id"));
		card_type = request.getParameter("card_type");
		card_name = request.getParameter("card_name");
		expr_date = request.getParameter("ex_date");
		card_number = request.getParameter("card_number");
		security_number = request.getParameter("security_number");
		address_1 = request.getParameter("address_1");
		address_2 = request.getParameter("address_2");
		city = request.getParameter("city");
		state = request.getParameter("state");
		zipcode = request.getParameter("zipcode");
		phone = request.getParameter("phone");
		boolean result_payment=PaymentAction.getPaymentMethodExistence(card_type, card_name, expr_date, card_number, security_number, Integer.parseInt("0" + address_id), Integer.parseInt(user_id));
		boolean result_address =AddressAction.getAddressExistence(Integer.parseInt(user_id), address_1, address_2, zipcode, city, state, phone, AddressAction.BillingAddress);
		int address_old_id_int = Integer.parseInt("0" + address_id);
		System.out.println("Old address: " + address_old_id_int);
		if (result_payment == false && result_address == false){
			int address_new = AddressAction.addAddress(Integer.parseInt(user_id), address_1, address_2, zipcode, city, state, AddressAction.BillingAddress, phone);
			PaymentAction.addPaymentMethod_DeactivateOld(card_type, card_name, expr_date, card_number, security_number, address_new, Integer.parseInt(user_id), payment_id);
			AddressAction.deactivateBillingAddress(address_old_id_int);
			response.sendRedirect("/user/payment.jsp");
			return;
			
		}else if(result_payment==true && result_address == true){
			%>
			 
			 <div class="alert alert-error">This Payment Method Already Exists!</div>
			 <div class="alert alert-error">This Address Already Exists!</div>
			 
			 <%
		}else if(result_payment == true) {
				%>
				 
				 <div class="alert alert-error">This Payment Method Already Exists!</div>
				 
				 <%
		}else if(result_address == true){
			 %>
			 
			 <div class="alert alert-error">This Address Already Exists!</div>
			 
			 <%
		}
		
	}
	
	%>
		<form class="form-horizontal" method="post">
			<h4>Card info:</h4>
			<input type="hidden" value="<%= payment_id %>" name="payment_id">
			<div class="control-group">
				<label class="control-label" for="inputEmail">Type</label>
				<div class="controls">
					<select name="card_type">
						<% for(int i=1; i<4; ++i){ %>
							<option value="<%= i %>"
							<% if(i==card_type_int) {
								out.print("selected='true'");
							} %>
							>
							<% switch(i) {
							case 1:
								out.print("Visa");
							break;
							case 2:
								out.print("Master");
							break;
							case 3:
								out.print("American express");
							break;
							}
							%>
							</option>
						<% } %>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="card_number">Number</label>
				<div class="controls">
					<input type="text" id="card_number" name="card_number" value="<%=card_number%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="expr_date">Exp. date</label>
				<div class="controls">
					<input type="text" id="expr_date" name="ex_date" value="<%=expr_date%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="security_number">Security #</label>
				<div class="controls">
					<input type="text" id="security_number" name="security_number" value="<%=security_number%>">
				</div>
			</div>			
			<div class="control-group">
				<label class="control-label" for="card_name">Cardholder Name</label>
				<div class="controls">
					<input type="text" id="card_name" name="card_name" value="<%=card_name%>">
				</div>
			</div>
			<h4>Billing address:</h4>
			<div class="control-group">
				<label class="control-label" for="address_1">Address 1</label>
				<div class="controls">
					<input type="text" id="address_1" name="address_1" value="<%=address_1%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="address_2">Address 2</label>
				<div class="controls">
					<input type="text" id="address_2" name="address_2" value="<%=address_2%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="city">City</label>
				<div class="controls">
					<input type="text" id="city" name="city" value="<%=city%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zipcode">Zipcode</label>
				<div class="controls">
					<input type="text" id="zipcode" name="zipcode" value="<%=zipcode%>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="state">State/Locality</label>
				<div class="controls">
					<select name="state" id="state" class="required">
						<option value="" selected="">--Select--</option>
						<option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option>
						<option value="CA">California</option>
						<option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PA">Pennsylvania</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="DC">Washington D.C.</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option>
					</select>
					<!--  <input type="text" name="inputState"  id="inputState" placeholder="State">-->
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="phone">Phone</label>
				<div class="controls">
					<input type="text" id="phone" name="phone" value="<%=phone%>">
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