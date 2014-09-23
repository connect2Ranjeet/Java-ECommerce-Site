<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	//Map<String, String> user = UserAction.getCurrentUser(request);
	Map<String, List<String>> orders = null;

	///// Get ORders from current user
	//if (user != null) {
	orders = TransactionAction.getAllTransactions();
	//}else{
	//	response.sendRedirect("/"); /// send user back if not logged in
	//}
%>

<jsp:include page="/management/layout/header.jsp" flush="true" />
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"
	type="text/javascript"></script>

<style type="text/css">
#map img {
	max-width: none;
}
</style>

<div>
	<ul class="nav nav-tabs">
		<li><a href="/management">Home</a></li>
		<li class="active"><a href="/management/order/list.jsp">Orders</a></li>
		<li><a href="/management/user/list.jsp">Users</a></li>
		<li><a href="/management/category/list.jsp">Categories</a></li>
		<li><a href="/management/product/list.jsp">Inventory</a></li>
		<li><a href="/management/site/template.jsp">Templates</a></li>
		<li><a href="/management/site/details.jsp">Site details</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active">
			<div class="btn-toolbar" style="margin-bottom: 30px">
				<a href="/management/order/list.jsp" class="btn btn-inverse">Back</a>
			</div>
			<h3>Shipping addresses</h3>
			<div id="map" style="width: 100%; height: 500px"></div>
		</div>
	</div>
</div>


<script type="text/javascript">
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom : 4,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	});

	var geocoder = new google.maps.Geocoder();
	


	$(document).ready(
			function() {

				$.ajax({
					type : "POST",
					url : '/management/order/get_order_data.jsp',
					dataType : 'json',
					success : function(order_locations) {

						var locations = order_locations;
						for ( var i = 0; i < locations.length; i++) {

							var address = locations[i].Address1 + ","
									+ locations[i].Province + ", "
									+ locations[i].State + " "
									+ locations[i].Zip

							//console.log(address);

							var content = "<address><strong>"
									+ locations[i].User + "</strong><br>"
									+ locations[i].Address1 + ", "
									+ locations[i].Address2 + "<br>"
									+ locations[i].Province + ", "
									+ locations[i].State + " "
									+ locations[i].Zip + "</address>";
							console.log(content);

							decipherLocation(address, content);							
						}
						
						
						var united_states = "United States";
						geocoder.geocode({
							'address' : united_states
						}, function(results, status) {
							if (status == google.maps.GeocoderStatus.OK) {
								map.setCenter(results[0].geometry.location);
							} else {
								console.log("Could not find location: " + location);
							}
						});						
					}
				});
			});

	function addInfoWindow(marker, content) {
		var infoWindow = new google.maps.InfoWindow({
			content : content
		});

		google.maps.event.addListener(marker, 'click', function() {
			infoWindow.open(map, marker);
		});
	}

	function decipherLocation(address, content) {
		geocoder.geocode({
			'address' : address
		}, function(results, status) {

			if (status == google.maps.GeocoderStatus.OK) {

				var marker = new google.maps.Marker({
					map : map,
					position : results[0].geometry.location
				});

				addInfoWindow(marker, content);

			} else {
				console.log(status);
			}
		});
	}

	function AutoCenter() {
		var bounds = new google.maps.LatLngBounds();

		$.each(markers, function(index, marker) {

			bounds.extend(marker.position);

		});

		//  Fit these bounds to the map

		map.fitBounds(bounds);

	}
</script>


<jsp:include page="/management/layout/footer.jsp" flush="true" />