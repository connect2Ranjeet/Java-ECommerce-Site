<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	Map<String, List<String>> user = null;

	///// Get user_id
	String user_id = request.getParameter("id");
	
	if (user_id != null) {
		user = UserAction.getUserById(user_id);
	}

	if (user == null) {
		response.sendRedirect("/");
		return;
	}

	Map<String, List<String>> wishlist = null;
	if (user != null) {
		wishlist = WishlistAction.getWishlist(user.get("ID").get(0));
	}
	
	//// Displaying reviews
	Map<String, List<String>> product_reviews = ReviewAction.getByUserId(user.get("ID").get(0));
	
%>

<jsp:include page="/layout/header.jsp" flush="true" />
<div class="row-fluid">
	<div class="span5 well well-small">
		<h3><%=user.get("Username").get(0)%>
			<small> joins on <%=user.get("Join_date").get(0)%></small>
		</h3>
		<!-- 
		<div style="text-align:center">
			<img alt="" src="/img/avatar.png" width="100" height="100">
		</div>
		 -->
		<h4>Wishlist</h4>
		<%
			if (wishlist != null && wishlist.get("Product_ID").size() > 0) {
		%>
		<table id="wishlist_table" class="table">
			<thead>
				<tr>
					<th class="span1"></th>
					<th class="span3"></th>
					<th class="span1">Price</th>
				</tr>
			</thead>

			<tbody>
				<%
					for (int i = 0; i < wishlist.get("Product_ID").size(); ++i) {
							String product_id = wishlist.get("Product_ID").get(i);
							String name = wishlist.get("Name").get(i);
							String price = wishlist.get("Price").get(i); //// edit this again
				%>
				<tr>
					<td><img src="http://placehold.it/64x64" class="img-rounded"></td>
					<td><a href="/product"><%=name%></a></td>
					<td><%=price%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<%
			} else {
		%>
		<p>Wishlist is empty !</p>
		<%
			}
		%>
		
	</div>
	<div class="span7 well well-small">
		<h4>Reviews</h4>
		<%
			if (product_reviews != null && product_reviews.get("ID").size() > 0) {
		%>

		<ul id="content_pagination" class="clearfix">
			<%
			
				for (int i = 0; i < product_reviews.get("ID").size(); ++i) {
						String rating = product_reviews.get("Rating").get(i);
						String comment = product_reviews.get("Comment").get(i);
						String product_id = product_reviews.get("Product_ID").get(i);
						String product_name = ProductAction.getProductName(Integer.parseInt("0" + product_id));
						
						String date_str = product_reviews.get("Review_date").get(i);
						SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
						Date date = sdf.parse(date_str);
						
						sdf.applyPattern("MM-dd-yyyy");
						String formated_date = sdf.format (date );
			%>
			<li>
				<div>
					Product: <b><a href="/product?id=<%= product_id %>"> <%=product_name %></a></b>
					&nbsp;
					<div class="rateit" data-rateit-value="<%=rating%>"
						data-rateit-ispreset="true" data-rateit-readonly="true"></div>
					&nbsp;on&nbsp; <span><%=formated_date%></span>
				</div>
				<p class="product-review"><%=comment%></p>
			</li>
			<%
				}
			%>
		</ul>

		<div class="pagination pagination-centered">
			<ul id='page_navigation'>

			</ul>
		</div>
		
		<input type='hidden' id='current_page' /> <input type='hidden'
			id='show_per_page' />
			
		<%
			} else {
		%>

		<p>There is no reviews</p>
		
		<%
			}
		%>

	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />