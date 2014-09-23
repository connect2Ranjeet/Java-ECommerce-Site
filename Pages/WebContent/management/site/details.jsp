<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/*
		Updates:
		- 
	 */
	String site_id = "";
	String site_name = "";
	String site_email = "";
	String template_id = "";
	String site_logo = "";
	String address_1 = "";
	String address_2 = "";
	String city = "";
	String zipcode = "";
	String phone = "";
	String mission = "";

	/// update site details
	if (request.getMethod().equals("POST")
			&& request.getParameter("update_site") != null) {
		site_id = request.getParameter("site_id");
		site_name = request.getParameter("Site_name");
		site_email = request.getParameter("Contact_email");
		template_id = request.getParameter("template_id");

		address_1 = request.getParameter("address_1");
		address_2 = request.getParameter("address_2");
		city = request.getParameter("city");
		zipcode = request.getParameter("zipcode");
		mission = request.getParameter("mission");
		phone = request.getParameter("phone");

		System.out.println(phone);

		boolean result = SiteAction.updateSettings(site_id, site_name,
				site_email, template_id, address_1, address_2, city,
				zipcode, phone, mission);

	}
	
	if (request.getMethod().equals("POST")) {
		String logo_url = ImageAction.uploadImage(request, response);
		SiteAction.uploadLogo(logo_url);
	}

	//// Loading site settings
	Map<String, List<String>> site = SiteAction.getSettings();
	if (site != null) {
		site_id = site.get("ID").get(0);
		site_name = site.get("Site_name").get(0);
		site_email = site.get("Contact_email").get(0);
		template_id = site.get("Template").get(0);
		site_logo = site.get("Logo_image").get(0);
		address_1 = site.get("Address_1").get(0);
		address_2 = site.get("Address_2").get(0);
		city = site.get("City").get(0);
		zipcode = site.get("Zipcode").get(0);
		mission = site.get("Mission").get(0);
		phone = site.get("Phone").get(0);
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
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li class="active"><a href="/management/site/details.jsp">Site
				details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<form class="form-horizontal" method="POST">
				<input type="hidden" name="update_site" value="1" />
				<input type="hidden" name="site_id" value="<%=site_id%>" /> <input
					type="hidden" name="template_id" value="<%=template_id%>" />

				<div class="control-group">
					<label class="control-label" for="Site_name">Shop name</label>
					<div class="controls">
						<input type="text" id="Site_name" name="Site_name"
							placeholder="Name" value="<%=site_name%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="Contact_email">Contact
						email</label>
					<div class="controls">
						<input type="text" id="Contact_email" name="Contact_email"
							placeholder="Email" value="<%=site_email%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="address_1">Address 1</label>
					<div class="controls">
						<input type="text" id="address_1" name="address_1"
							value="<%=address_1%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="address_2">Address 2</label>
					<div class="controls">
						<input type="text" id="address_2" name="address_2"
							value="<%=address_2%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="city">City</label>
					<div class="controls">
						<input type="text" id="city" name="city" value="<%=city%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="zipcode">Zipcode</label>
					<div class="controls">
						<input type="text" id="zipcode" name="zipcode"
							value="<%=zipcode%>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="mission">Mission</label>
					<div class="controls">
						<textarea cols="30" rows="4" id="mission" name="mission"><%=mission%></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phone">Phone</label>
					<div class="controls">
						<input type="text" id="phone" name="phone" value="<%=phone%>">
					</div>
				</div>

				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Update</button>
					</div>
				</div>
			</form>
			
			<h3>Site logo</h3>
			<form method="post" enctype="multipart/form-data">
				<input type="hidden" name="site_id" value="<%=site_id%>" />
				<input type="file" name="photo" />
				<button type="submit">Upload</button>
			</form>

		</div>
	</div>

</div>

<jsp:include page="/management/layout/footer.jsp" flush="true" />