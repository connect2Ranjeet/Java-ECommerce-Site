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
	String mission = "";
	String phone = "";
	
	//// Loading site settings: get logo brand name
	Map<String, List<String>> site = SiteAction.getSettings();
	if(site!=null){
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

<jsp:include page="/layout/header.jsp" flush="true" />

<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAwmg9oNZOTwUR6K7NGyroenLtQng55W4E&sensor=true"></script>

<script type="text/javascript">
	$(function() {

		function initialize() {
			var myOptions = {
				center : new google.maps.LatLng(32.80, -117.20),
				zoom : 11,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			};
			var map = new google.maps.Map(
					document.getElementById("map_canvas"), myOptions);

			var marker = new google.maps.Marker({
				position : new google.maps.LatLng(32.78946, -117.0996),
				map : map,
				title : "Our local shop here!"
			});

		}

		initialize();

	});
</script>


<h3>About Us</h3>

<table class="table">
	<thead>
		<tr>
			<th class="span1"></th>
			<th class="span10"></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><img src="<%= site_logo %>" style="max-width:64px;"></td>
			<td>Our mission: <%= mission %></td>
		</tr>
		<tr>
			<td><i class="icon-envelope"></i></td>
			<td>Contact: <a href="mailto:<%= site_email %>"><%= site_name %></a></td>
		</tr>
		<tr>
			<td>Address</td>
			<td>
				<address>
					<strong><%=site_name %>, Inc.</strong><br> <%= address_1 %>, <%= address_2 %><br>
					<%= city %>, <%= zipcode %><br> <abbr title="Phone">P:</abbr>
					<%= phone %>
				</address>
			</td>
		</tr>
	</tbody>
</table>

<h3>Location</h3>
<div id="map_canvas" style="width: 100%; height: 400px"></div>
<jsp:include page="/layout/footer.jsp" flush="true" />