<jsp:include page="/management/layout/header.jsp" flush="true" />

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
			<h3>Edit product</h3>
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div class="btn-group">
					<a href="/management/product/list.jsp" class="btn btn-inverse">Back</a>
				</div>
			</div>
			<form class="form-horizontal">
				<div class="control-group">
					<label class="control-label" for="inputUsername">Product title</label>
					<div class="controls">
						<input type="text" id="inputUsername" placeholder="">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">Price</label>
					<div class="controls">
						<input type="text" id="inputEmail" placeholder="">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">In stock</label>
					<div class="controls">
						<input type="text" id="inputEmail" placeholder="">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">Status</label>
					<div class="controls">
						<select><option>Hidden</option><option>Published</option></select>
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

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />