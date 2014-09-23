<jsp:include page="/layout/header.jsp" flush="true" />
<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/**
	 * Updates:
	 * 	1. Added site name to bottom header
	 */
	Map<String, List<String>> site = SiteAction.getSettings();
%>
<link href="/css/index.css" rel="stylesheet">

<!-- carousel 2 -->
<link rel="stylesheet" type="text/css" href="circularCarousel/css/style.css">
<link rel="stylesheet" type="text/css" href="circularCarousel/css/jquery.jscrollpane.css">
<!-- carousel 2 -->

<div class="header-bottom">
	<hr class="top-divider">
	<div class="inner-header">
		<ul class="header-right">
			<li> <a href="/home/contact.jsp">Contact</a></li>
			<li> <a href="/home/about.jsp">About Us</a></li>
		</ul>
		<ul class="header-left">
			<li><span style="font-weight: bolder;font-size: 16px;">Welcome to the <% if(site!=null){ %> 
					  <%= site.get("Site_name").get(0) %> <% } %>
					  Store</span></li>
		</ul>
	</div>
	<hr class="bottom-divider">
</div>

<%
Map<String, List<String>> feats = ProductAction.getFeatured();
if(feats != null){
%>

<h3>Featured Items</h3>
<div class="thumbnail">
	<div class="container-fluid" style="width:100%">
		<div class="row-fluid">
			<div class="carousel slide" id="myCarousel">
				<div class="carousel-inner">
				<%
					List<String> featProductIDs = feats.get("Product_ID");
					System.out.println(featProductIDs.size());
					int i = 0;
				/*1*/	while(i<featProductIDs.size()){
						Map<String, List<String>> featProduct;
						Map<String, List<String>> featProductImage;
						String img = "http://placehold.it/200x200";
						String title = "Title";
						String link = "/product/list.jsp";
				%>
					<div class="item<%= i==0 ? " active" : "" %>">
						<ul class="thumbnails">
						<% /*2*/ for(int j=0; j < 4; j++) {
							if(i < featProductIDs.size()){
								System.out.println(i);
								System.out.println(j);
								featProduct = ProductAction.getProductByID(Integer.parseInt(featProductIDs.get(i)));
								featProductImage = ImageAction.getImages(featProductIDs.get(i));
								if(featProductImage != null){
									img = featProductImage.get("Image").get(0);
									title = featProduct.get("Name").get(0);
									link = featProductIDs.get(i);
								}
								i++;
							}%>
	                        <li class="span3">
								<div class="thumbnail">
									<img src="<%= img %>" alt="">
								</div>
								<div class="caption">
									<h5 style="text-align: center">
										<a href="/product?id=<%= link %>">
											<%= title%>
										</a>
									</h5>
								</div>
							</li>
						<% img = "http://placehold.it/200x200";
						title = "Title";
						link = "/product/list.jsp";} /*2*/ %>
						</ul>	
					</div>
					<%}/*1*/  %>
					<%} %>
				</div>
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">&#139;</a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next">&#155;</a>
			</div>
		</div>
	</div>
</div>
<!-- 
<h3>Trending Items</h3>
<div class="row-fluid">
	<ul class="thumbnails">
		<li class="span3">
			<div class="thumbnail">
				<img src="http://placehold.it/220x200" alt="thumb-nail"
					class="img-rounded">
				<div class="caption">
					<h5>
						<a href="/product?id=2">Product title</a>
					</h5>
					<div class="rateit" data-rateit-value="2.5"
						data-rateit-ispreset="true" data-rateit-readonly="true"></div>
					<div class="product-price">$20</div>
					<p class="thumbnail-description">Product description</p>
				</div>
				<ul class="thumbnail-comments">
					<li class="clearfix"><a href="/user"><img
							src="http://placehold.it/32x32" alt="avatar" class="pull-left"></a>
						<p class="thumbnail-comment">
							<a href="/user">Name</a>: This product is awesome !
						</p></li>
				</ul>
			</div>
		</li>		
	</ul>
</div>
 -->
<jsp:include page="/layout/footer.jsp" flush="true" />