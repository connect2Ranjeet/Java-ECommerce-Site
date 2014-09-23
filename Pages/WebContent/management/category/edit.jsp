<jsp:include page="/management/layout/header.jsp" flush="true" />

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

	<div class="tab-content">
		<div class="tab-pane active">
			<h3>Edit category</h3>
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<div class="btn-group">
					<a href="/management/category/list.jsp" class="btn btn-inverse">Back</a>
				</div>
			</div>
			<form class="form-horizontal">
				<div class="control-group">
					<label class="control-label" for="inputUsername">Name</label>
					<div class="controls">
						<input type="text" id="inputUsername" placeholder="Name">
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

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />