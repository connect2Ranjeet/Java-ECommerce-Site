<jsp:include page="/layout/header.jsp" flush="true" />
<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4>
					<p class="text-info">My account</p>
				</h4></li>
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li class="active"><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>

	<div class="span9 well">
		<h3>Enter new address</h3>
		<%
			if (request.getMethod().equals("POST")) {
				String address1 = request.getParameter("inputAddress1");
				String address2 = request.getParameter("inputAddress2");
				String zipcode = request.getParameter("inputZipcode");
				String city = request.getParameter("inputCity");
				String state = request.getParameter("inputProvince");
				String phone = request.getParameter("inputPhone");

				Map<String, String> user = UserAction.getCurrentUser(request);
				if(user==null){
					response.sendRedirect("/");
				}
				
				
				if (user != null) {
					int result = AddressAction.addAddress(
							Integer.parseInt(user.get("ID")), address1,
							address2, zipcode, city, state, 1, phone);
					if (result > 0) {
						response.sendRedirect("/address");
						return;
					}

					else {
		%>

		<div class="alert alert-error">This Address Already Exists!</div>
		<%
			}
				}
			}
		%>
		<div class="btn-toolbar">
			<a href="/address" class='btn btn-inverse'>All addresses</a>
		</div>
		<br>
		<form class="form-horizontal" method="POST">
			<div class="control-group">
				<label class="control-label" for="inputAddress1">Address 1</label>
				<div class="controls">
					<input type="text" id="inputAddress1" name="inputAddress1">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputAddress2">Address 2</label>
				<div class="controls">
					<input type="text" id="inputAddress2" name="inputAddress2">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputCity">City</label>
				<div class="controls">
					<input type="text" id="inputCity" name="inputCity">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputZipcode">Zipcode</label>
				<div class="controls">
					<input type="text" id="inputZipcode" name="inputZipcode">
				</div>
			</div>
			<!-- 
			<div class="control-group">
				<label class="control-label" for="inputProvince">State/Locality</label>
				<div class="controls">
					<input type="text" id="inputProvince" name="inputProvince">
				</div>
			</div>			
			 -->
			<div class="control-group">
				<label class="control-label" for="inputProvince">State/Locality</label>
				<div class="controls">
					<select name="inputProvince" id="inputProvince" class="required">
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
				<label class="control-label" for="inputPhone">Phone</label>
				<div class="controls">
					<input type="text" id="inputPhone" name="inputPhone">
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary">Add</button>
				</div>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />