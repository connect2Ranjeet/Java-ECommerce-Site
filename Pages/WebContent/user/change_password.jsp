<jsp:include page="/layout/header.jsp" flush="true" />

<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4><p class="text-info">My account</p></h4></li>
			<li class="active"><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li><a href="/wishlist">Wishlist</a></li>
			<li><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>
	<div class="span9 well">
		<h3>Change password</h3>
		<div class="btn-toolbar">
			<a href="/user/settings.jsp" class='btn btn-inverse'>Back</a>
		</div>
		<br>
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" for="inputCurrent">Current password</label>
				<div class="controls">
					<input type="password" id="inputCurrent">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputNew">New password</label>
				<div class="controls">
					<input type="password" id="inputNew">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputRetype">Re-type password</label>
				<div class="controls">
					<input type="password" id="inputRetype">
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