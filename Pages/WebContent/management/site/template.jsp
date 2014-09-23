<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%

	/*
		Updates:
	*/
	String site_id = "";
	String template_id = "";
	
	/// loading site details
	if(request.getMethod().equals("POST")){
		site_id = request.getParameter("site_id");
		template_id = request.getParameter("template_id");
		
		boolean result = SiteAction.updateTheme(site_id, template_id);
		System.out.println(result);
	}
	
	//// Loading site settings: get logo brand name
	Map<String, List<String>> site = SiteAction.getSettings();
	if(site!=null){
		site_id = site.get("ID").get(0);
		template_id = site.get("Template").get(0);
	}
%>


<jsp:include page="/management/layout/header.jsp" flush="true" />

<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li class="active"><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
		
			<h4>Gallery</h4>
			
			<ul class="thumbnails">
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="1">
						<div class="thumbnail">
							<a class="lightbox" href="/bootstrap/img/template_1.jpg" title="Template"> 
							<img  class="img-polaroid" src="/bootstrap/img/template_1.jpg" alt=""  style="height:165px;width: 200px;"/>
							</a>
							<div class="caption">
								<h4>Default</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>
				
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="2">
						<div class="thumbnail">
							<a class="lightbox"
								href="/bootstrap/img/template_2.jpg"
								title="Template"> <img  class="img-polaroid" 
								src="/bootstrap/img/template_2.jpg" style="height:165px;width: 200px;"
								alt="" />
							</a>
							<div class="caption">
								<h4>Amelia</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>
				
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="3">
						<div class="thumbnail">
							<a class="lightbox"
								href="/bootstrap/img/template_3.jpg"
								title="Template"> <img  class="img-polaroid" 
								src="/bootstrap/img/template_3.jpg" style="height:165px;width: 200px;"
								alt="" />
							</a>
							<div class="caption">
								<h4>Cyborg</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>
				
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="4">
						<div class="thumbnail">
							<a class="lightbox"
								href="/bootstrap/img/template_4.jpg"
								title="Template"> <img  class="img-polaroid" 
								src="/bootstrap/img/template_4.jpg" style="height:165px;width: 200px;"
								alt="" />
							</a>
							<div class="caption">
								<h4>Slate</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>
				
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="5">
						<div class="thumbnail">
							<a class="lightbox"
								href="/bootstrap/img/template_5.jpg"
								title="Template"> <img  class="img-polaroid" 
								src="/bootstrap/img/template_5.jpg" style="height:165px;width: 200px;"
								alt="" />
							</a>
							<div class="caption">
								<h4>Superhero</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>	
				
				<li class="span3">
					<form method="POST">
						<input type="hidden" name="site_id" value="<%= site_id %>">
						<input type="hidden" name="template_id" value="6">
						<div class="thumbnail">
							<a class="lightbox"
								href="/bootstrap/img/template_6.jpg"
								title="Template"> <img  class="img-polaroid" 
								src="/bootstrap/img/template_6.jpg" style="height:165px;width: 200px;"
								alt="" />
							</a>
							<div class="caption">
								<h4>United</h4>
								<button type="submit" class="btn btn-inverse">Apply this
									template</button>
							</div>
						</div>
					</form>
				</li>	
				
																			
			</ul>

		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />