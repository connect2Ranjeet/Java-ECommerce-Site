<%@ page import="Action.*"%>

<%
	/// Upload image
	if(request.getMethod().equals("POST")){
		String url = ImageAction.uploadImage(request,response);
		System.out.println("Images uploaded at "+url);
	}


%>

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
			<div class="btn-toolbar">
				<a href="/management/product/list.jsp" class="btn btn-inverse">Back</a>
			</div>
			<h4>Product info</h4>
			<table class="table table-bordered table-stripped">
				<thead>
					<tr>
						<th class="span2"></th>
						<th class="span10"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Product title</td>
						<td><a href="/product/" target="_blank">Samsung Galaxy S
								III 4G Android Phone, Blue 16GB (Sprint)</a></td>
					</tr>
					<tr>
						<td>Price</td>
						<td>$480</td>
					</tr>
					<tr>
						<td>In stock</td>
						<td>3</td>
					</tr>
					<tr>
						<td>Status</td>
						<td><span class="label label-success">Published/Hidden</span></td>
					</tr>
				</tbody>
			</table>

			<h4>Images</h4>
			<div class="btn-toolbar">
				<form method="post" enctype="multipart/form-data">
					<input type="file" name="photo" />
					<button type="submit">Upload</button>
				</form>
			</div>
			
			<table class="table table-bordered table-stripped"
				style="width: 400px">
				<thead>
					<tr>
						<th class="span4">Name</th>
						<th class="span1"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>abcd.jpg</td>
						<td><button class="btn btn-inverse">
								<i class="icon-trash"></i>
							</button></td>
					</tr>
				</tbody>
			</table>

		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />