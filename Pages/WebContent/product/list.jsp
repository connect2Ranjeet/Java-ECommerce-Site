<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.Attribute"%>
<%@ page import="XML.XMLParser"%>
<%@ page import="XML.XMLParser.XMLType"%>
<%@ page import="XML.XMLParser.DisplayType"%>
<jsp:include page="/layout/header.jsp" flush="true" />
<script type="text/javascript" src="/js/product.js"></script>
<link href="/css/product.css" rel="stylesheet">
<div class="row-fluid">
	<div class="span3 well well-small">
		<h5>Categories</h5>
		<ul class="nav nav-pills nav-stacked">
			<%
				Map<String, List<String>> categories = CategoryAction
						.getCategoryMap();
				List<String> categoryNames = categories.get("Name");
				List<String> categoryIDs = categories.get("ID");
				String listItems = "";
				String current_cat = "All";
				String cat = request.getParameter("cat");
				boolean activated = false;
				for (int i = 0; i < categoryNames.size(); i++) {
					String active = "";
					if (!activated && categoryIDs.get(i).equals(cat)) {
						current_cat = categoryNames.get(i);
						activated = true;
						active = " class=\"active\"";
					}
					listItems += "<li" + active
							+ "><a href=\"/product/list.jsp?cat="
							+ categoryIDs.get(i) + "\">" + categoryNames.get(i)
							+ "</a></li>";
				}
				out.write("<li" + (activated ? "" : " class=\"active\"")
						+ "><a href=\"/product/list.jsp\">All</a></li>");
				out.write(listItems);
			%>
		</ul>
	</div>
	<div class="span9">
		 <h3>
			Products for <%= current_cat%>:
			<div class="btn-group pull-right" data-toggle="buttons-radio">
				<button id="product-view-grid" class="btn active">
					<i class="icon-th"></i>
				</button>
				<button id="product-view-list" class="btn">
					<i class="icon-th-list"></i>
				</button>
			</div>
		</h3> 
		<div id="view-grid" class="row-fluid">
			<%
				Map<String, List<String>> products;
				if (activated) {
					products = ProductAction.getProductByCategoryID(Integer
							.parseInt(cat));
				} else {
					products = ProductAction.getAllProducts();
				}
				List<String> productIDs = null;
				List<String> categoryIDs_prod = null;
				List<String> productPublic = null;
				List<String> productNames = null;
				List<String> productRatings = null;
				List<String> productReviewCounts = null;
				List<String> productPrices = null;
				List<String> productDescriptions = null;
				List<String> productImages = null;
				List<List<String>> productTags = null;
				if (products != null) {
					productIDs = products.get("ID");
					categoryIDs_prod = products.get("Category_ID");
					productPublic = products.get("Public");
					productNames = products.get("Name");
					productRatings = products.get("Rating");
					productReviewCounts = products.get("Number_reviews");
					productPrices = products.get("Price");
					productDescriptions = new ArrayList<String>();
					productImages = new ArrayList<String>();
					productTags = new ArrayList<List<String>>();

					for (int i = 0; i < productNames.size(); i++) {
						if (!productPublic.get(i).equals("1")) {
							continue;
						}
						productPrices.set(i, String.format("%10.2f",
								Double.parseDouble(productPrices.get(i)) / 100).trim());
						productReviewCounts.set(i, String.format("%10.0f",
								Double.parseDouble(productReviewCounts.get(i))));
						productRatings.set(i, String.format("%10.1f",
								Double.parseDouble(productRatings.get(i))));
						Map<String, List<String>> product_images = ImageAction
								.getImages(productIDs.get(i));
						if (product_images != null) {
							productImages.add(product_images.get("Image").get(0));
						} else {
							productImages.add("http://placehold.it/220x200");
						}
						
						// Get Product XML Description
						Document prodInfo_XML = ProductAction.getXMLDocumentByID(Integer.parseInt(productIDs.get(i)));
						
						
						//System.out.println(prodInfo_XML);
						// Get Category XML Description (contains properties & types)
						Document catInfo_XML = CategoryAction.getXMLDocumentByID(Integer.parseInt(categoryIDs_prod.get(i)));
						Map<XMLType, List<String>> XMLMap = XMLParser.ParseXMLDocumentToHTML(prodInfo_XML, catInfo_XML, DisplayType.essential);
						if (XMLMap == null) {
							productDescriptions.add("No description.");
							productTags.add(null);
						} else {
							String shorten = XMLMap.get(XMLType.description).get(1);
							if (shorten.length() > 250)
								shorten = shorten.substring(0, shorten.indexOf(" ", 250)) + "...";
							productDescriptions.add(shorten);
							
							if (XMLMap.get(XMLType.tag).size() > 0) {
								ArrayList<String> tagList = new ArrayList<String>();
								productTags.add(tagList);
								for (int t = 0; t < XMLMap.get(XMLType.tag).size(); t++) {
									tagList.add(XMLMap.get(XMLType.tag).get(t));
								}
							} else {
								productTags.add(null);
							}
						}
			%>
			<%
				if (i % 3 == 0) {
			%>
			<ul class="thumbnails">
				<%
					}
				%>
				<li class="span4 product">
					<div class="thumbnail">
						<a href="/product?id=<%=productIDs.get(i)%>"><img src="<%=productImages.get(i)%>" alt="thumb-nail"
							class="img-rounded" /></a>
						<div class="caption">
							<h5>
								<a href="/product?id=<%=productIDs.get(i)%>"><%=productNames.get(i)%></a>
							</h5>
							<div class="rateit"
								data-rateit-value="<%=productRatings.get(i)%>"
								data-rateit-ispreset="true" data-rateit-readonly="true"></div>
							<div class="product-price">
								$<%=productPrices.get(i)%></div>
							<div style="margin-top: 10px">
								<%
									List<String> tagList = productTags.get(i);
											if (tagList != null) {
												for (int t = 0; t < tagList.size(); t++) {
								%>
								<a href="#"><span class="label label-info"><%=tagList.get(t)%></span></a>
								<%
									}
											}
								%>
							</div>
						</div>
					</div>
				</li>

				<%
					if ((i - 2) % 3 == 0 && i != 0) {
				%>
			</ul>
			<%
				}
			%>
			<%
				}
				}
			%>

		</div>
		
		<div id="view-list" class="row-fluid">
			<ul class="thumbnails">
				<%
					if (products != null) {
						for (int i = 0; i < productNames.size(); i++) {
							if (!productPublic.get(i).equals("1")) {
								continue;
							}
				%>
				<li class="span9 product" style="width: 100%; margin-left:0">
					<div class="thumbnail">
						<div class="row-fluid">
							<div class="span3">
								<a href="/product?id=<%=productIDs.get(i)%>"><img src="<%=productImages.get(i)%>" alt="thumb-nail"
									class="img-rounded"></a>
							</div>
							<div class="span6">
								<div class="caption">
									<h5>
										<a href="/product?id=<%=productIDs.get(i)%>"><%=productNames.get(i)%></a>
									</h5>
									<div>
										<span class="product-price">$<%=productPrices.get(i)%></span>
										<div class="rateit"
											data-rateit-value="<%=productRatings.get(i)%>"
											data-rateit-ispreset="true" data-rateit-readonly="true"></div>
										<span>( <%=productReviewCounts.get(i)%> reviews )
										</span>
									</div>
									<p style="margin-top: 10px"><%=productDescriptions.get(i)%></p>
									<div style="margin-top: 10px">
										<%
											List<String> tagList = productTags.get(i);
													if (tagList != null) {
														for (int t = 0; t < tagList.size(); t++) {
										%>
										<a href="#"><span class="label label-info"><%=tagList.get(t)%></span></a>
										<%
											}
													}
										%>
									</div>
								</div>
							</div>
						</div>
					</div>
				</li>
				<%
					}
					}
				%>
			</ul>
		</div>
	</div>
</div>


<jsp:include page="/layout/footer.jsp" flush="true" />