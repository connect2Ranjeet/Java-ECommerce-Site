<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>


<%
	/*
	 */
	Map<String, String> user = UserAction.getCurrentUser(request);	
	/// Make sure user has logged in
	if(user==null){
		response.sendRedirect("/");
	}
	
	//// Adding product to cart
	if ((request.getMethod().equals("POST"))
			&& (request.getParameter("product_id") != null)) {

		String product_id = request.getParameter("product_id");
		String quantity = request.getParameter("quantity");
		
		CartAction.add(session, product_id, quantity);
	}
	
	/// Empty the cart
	if ((request.getMethod().equals("POST"))
			&& (request.getParameter("empty_cart") != null)) {
		if (request.getParameter("empty_cart").equals("1")) {
			CartAction.emptyCart(request.getSession());
		}
	}
	
	//// Remove a product
	if ((request.getMethod().equals("POST"))
			&& (request.getParameter("removed_product") != null)) {
		String product_id = request.getParameter("removed_product");
		CartAction.remove(request.getSession(), product_id);
	}

	//// Update product quantity 
	if ((request.getMethod().equals("POST"))
			&& (request.getParameter("updated_product_id") != null)) {
		String product_id = request.getParameter("updated_product_id");
		String quantity = request.getParameter("updated_quantity");

		CartAction.update(request.getSession(), product_id, quantity);
		
		response.sendRedirect("/cart");
	}

	//// List all products
	Map<String, List<String>> products = CartAction.getCart(session);
	
	int total_items = 0;
	int total_prices = 0;
	
	if (products != null) {
		total_items = products.get("product_id").size();
	}

	//// Add to wishlist
	if ((request.getMethod().equals("POST"))) {
		
		String wishlist_product_id = request.getParameter("wishlist_product_id");

		if (wishlist_product_id != null) {
			WishlistAction.add(user.get("ID"), wishlist_product_id);
			CartAction.remove(request.getSession(), wishlist_product_id);
			
			response.sendRedirect("/wishlist");
		}
	}
	
%>

<jsp:include page="/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/js/cart.js"></script>
<link href="/css/cart.css" rel="stylesheet">

<h3>
	My Cart (<%=total_items%>)
	<div class="pull-right">
	<form action="/cart/" method="post"
		onsubmit="return confirm('Do you want to empty the cart ?');">
		<input type="hidden" name="empty_cart" value="1" /> <input
			type="submit" class="btn btn-inverse pull-right"
			value="Empty the cart" />
	</form>
	</div>
</h3>

<div class="row-fluid">
	<div class="span8">
		<%
			if (products != null && total_items > 0) {
		%>
		<table class="table table-hove table-striped">
			<thead>
				<tr>
					<th class="span1"></th>
					<th class="span2"></th>
					<th class="span3"></th>
					<th class="span1">Price</th>
					<th class="span1">Quantity</th>
					<th class="span1">Total</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < products.get("product_id").size(); ++i) {
							String product_id = products.get("product_id").get(i);
							int quantity = Integer.parseInt(products.get("quantity")
									.get(i));
							
							String product_name = ProductAction.getProductName(Integer.parseInt(product_id));
							String product_price = ProductAction.toPrice(ProductAction.getProductPrice(Integer.parseInt(product_id)));
							int product_price_full = Integer.parseInt(ProductAction.getProductPrice(Integer.parseInt(product_id)));							
							Map<String, List<String>> product_images = ImageAction.getImages(product_id);
							
				%>

				<tr>
					<td>
						<form action="/cart/" method="post"
							onsubmit="return confirm('Do you want to remove this product from cart ?');">
							<input type="hidden" name="removed_product"
								value="<%=product_id%>" />
							<button type="submit" style="font-size: 16px;"
								class="btn btn-mini btn-inverse product-remove-btn"
								rel="tooltip" data-placement="right"
								data-original-title="Remove this item">
								<i class="icon-remove"></i>
							</button>
						</form>
						<form action="/cart/" method="post"
							onsubmit="return confirm('Do you want to add this product to wishlist ?');">
							<input type="hidden" name="wishlist_product_id"
								value="<%=product_id%>" />
							<button type="submit" style="font-size: 16px; margin-top: 5px"
								class="btn btn-mini btn-inverse product-cart-btn"
								style="margin-top:10px" rel="tooltip" data-placement="right"
								data-original-title="Move to wishlist">
								<i class="icon-gift"></i>
							</button>
						</form>
					</td>
					<td>
					
					<% if(product_images!=null) {
						if(product_images.get("ID").size()>0){
						for (int j = 0; j < 1; ++j) {
							String url = product_images.get("Image").get(0);
					
							out.print("<img src=\""+ url + "\" alt=\"thumb-nail\" width='100px'>");
						}
						}else{
							out.print("<img src='http://placehold.it/100x100' alt=\"thumb-nail\" width='100px'>");
						}
					 } %>
					
					</td>
					<td><a href="/product?id=<%=product_id%>"><%=product_name%></a></td>
					<td>$<%=ProductAction.toPrice(product_price_full).trim()%></td>
					<td>
						<form method="post">
							<input type="hidden" name="updated_product_id"
								value="<%=product_id%>" /> <input type="number" style="width:50px"
								name="updated_quantity" value="<%=quantity%>" min='1' max='100' />
							<div>
								<button type="submit" class='btn btn-mini btn-inverse'>Update</a>
							</div>
						</form>
					</td>
					<td>$<%
					
						int local_total = product_price_full * quantity;
								out.println(ProductAction.toPrice(local_total).trim());
								total_prices += local_total;
								
					%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<%
			} else {
		%>

		<p>Your Cart is empty</p>

		<%
			}
		%>

	</div>
	<div class="span4 well well-small"
		style="text-align: center">
		<h3>
			Total: $<%
		
			
			out.println(ProductAction.toPrice(total_prices).trim());
		%>
		</h3>
		<a href="/cart/checkout.jsp" class="btn btn-info btn-large">Checkout</a>
	</div>
</div>

<!-- 
<div class="row">
	<div class="span12">
		<h4>Customers who bought this product also bought</h4>
		<div id="alsobought" class="flexslider">
			<ul class="slides">
				<li><img src="http://placehold.it/200x150" alt="thumb-nail">
					<h5>
						<a href="/product">Apple iPhone 4 32GB (Black) - AT&T</a>
					</h5>
					<div class="rateit" data-rateit-value="2.5"
						data-rateit-ispreset="true" data-rateit-readonly="true"></div>
					<h5>$480.0</h5></li>
				<li><img src="http://placehold.it/200x150" alt="thumb-nail">
					<h5>
						<a href="/product">Apple iPhone 4 32GB (Black) - AT&T</a>
					</h5>
					<div class="rateit" data-rateit-value="2.5"
						data-rateit-ispreset="true" data-rateit-readonly="true"></div>
					<h5>$480.0</h5></li>
			</ul>
		</div>
	</div>
</div>
 -->

<jsp:include page="/layout/footer.jsp" flush="true" />