<jsp:include page="/management/layout/header.jsp" flush="true" />

<div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<h3> Welcome to Management panel</h3>
		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />