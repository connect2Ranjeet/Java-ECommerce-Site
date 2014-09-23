<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/*
	 Updates:
	 - get wishlist
	 - All features are almost done
	 - need testing
	 
	 */
	 
	//// Get wishlist
	Map<String, String> user = UserAction.getCurrentUser(request);
	if(user==null){
		response.sendRedirect("/");
	}
	
	//// Add to wishlist
	if (request.getMethod().equals("POST")) {
		if (user != null) {
	String wishlist_product_id = request
	.getParameter("wishlist_product_id");
	WishlistAction.add(user.get("ID"), wishlist_product_id);
		}
	}

	Map<String, List<String>> wishlist = null;
	if (user != null) {
		wishlist = WishlistAction.getWishlist(user.get("ID"));
	}
	
	//// Move to cart
	if (request.getMethod().equals("POST")) {
		String cart_product_id = request
		.getParameter("cart_product_id");
		if (cart_product_id != null) {
	/// delete from wishlist first
	WishlistAction.delete(cart_product_id);
	
	//// add to cart
	String quantity = "1";
	
	CartAction.add(session, cart_product_id, quantity);
	response.sendRedirect("/cart"); /// send to cart page
		}
	}
	
	/// Delete wish
	if (request.getMethod().equals("POST")) {
		String deleted_product_id = request
		.getParameter("deleted_product_id");
		if (deleted_product_id != null) {
	WishlistAction.delete(deleted_product_id);
	response.sendRedirect("/wishlist"); ///refresh the page again
		}
	}
%>

<jsp:include page="/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/libs/table/js/jquery.dataTables.js"></script>
<link href="/libs/table/css/demo_page.css" rel="stylesheet">
<link href="/libs/table/css/demo_table.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		$('#wishlist_table').dataTable();
	});
</script>

<div class="row-fluid">
	<div class="span3">
		<ul class="nav nav-list well">
			<li class="nav-header"><h4>
					<p class="text-info">My account</p>
				</h4></li> 
			<li><a href="/user/settings.jsp">Settings</a></li>
			<li><a href="/order/list.jsp">Orders</a></li>
			<li class="active"><a href="/wishlist">Wishlist</a></li>
			<li><a href="/address">Address</a></li>
			<li><a href="/user/payment.jsp">Payment</a></li>
		</ul>
	</div>
	<div class="span9 well">
		<h3>Wishlist</h3>
		<%
			if (wishlist != null && wishlist.get("Product_ID").size() > 0) {
		%>
		<table id="wishlist_table" class="table">
			<thead>
				<tr>
					<th class="span1"></th>
					<th class="span3"></th>
					<th class="span1">Price</th>
					<th class="span2"></th>
					<th class="span1"></th>
				</tr>
			</thead>

			<tbody>
				<%
					for (int i = 0; i < wishlist.get("Product_ID").size(); ++i) {
							String product_id = wishlist.get("Product_ID").get(i);
							String name = wishlist.get("Name").get(i);
							String price = wishlist.get("Price").get(i); //// edit this again
				
							Map<String, List<String>> product_images = ImageAction.getImages(product_id);
							
				%>
				<tr>
					<td>
					<% if(product_images!=null) {
						if(product_images.get("ID").size()>0){
						for (int j = 0; j < 1; ++j) {
							String url = product_images.get("Image").get(0);
					
							out.print("<img src=\""+ url + "\" alt=\"thumb-nail\" width='64px'>");
						}
						}else{
							out.print("<img src='/img/blank_product.jpg' alt=\"thumb-nail\" width='64px'>");
						}
					 } %>
					</td>
					<td><a href="/product?id=<%=product_id%>"><%=name%></a></td>
					<td>$<%=ProductAction.toPrice(price)%></td>
					<td>
						<form method="POST"
							onsubmit="return confirm('Do you want to add this product to cart ?');">
							<input type="hidden" name="cart_product_id"
								value="<%=product_id%>"> <input type="hidden"
								name="name" value="<%=name%>"> <input type="hidden"
								name="price" value="<%=price%>"> <input type="hidden"
								name="image" value="tobe added">

							<button type="submit" class="btn btn-inverse">
								Add to cart <i class="icon-shopping-cart"></i>
							</button>
						</form>
					</td>
					<td>
						<form method="POST"
							onsubmit="return confirm('Do you want to remove the product from wishlist ?');">
							<input type="hidden" name="deleted_product_id"
								value="<%=product_id%>">
							<button class="btn btn-inverse">
								<i class="icon-trash"></i>
							</button>
						</form>
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
		<p>Your wishlist is empty !</p>
		<%
			}
		%>
		
		
		
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />