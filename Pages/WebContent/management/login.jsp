<%@ page import="Action.*"%>

<%
	/// Do login
	boolean result = true;
	if (request.getMethod() == "POST") {
		String userName = request.getParameter("inputUsername");
		String password = request.getParameter("inputPassword");

		if (userName != null & password != null) {
			result = ManagementAction
					.login(session, userName, password);
			if (result) {
				response.sendRedirect("/management/");
			}
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Sol - Management panel</title>
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="/bootstrap/js/bootstrap.js"></script>

</head>
<body>
	<div class="container navbar-wrapper">

		<style type="text/css">
.form-signin {
	max-width: 300px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: white;
	border: 1px solid #E5E5E5;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
}
</style>
		<br> <br>

		<form class="form-signin" method="post">
			<%
				if (!result) {
			%>
			<div class="alert alert-info">You enterred wrong username or
				password</div>
			<%
				}
			%>
			<h2 class="form-signin-heading">Management</h2>
			<br> <input type="text" class="input-block-level"
				name="inputUsername" placeholder="Username"> <input
				type="password" class="input-block-level" placeholder="Password"
				name="inputPassword"> <br>
			<br>
			<button class="btn btn-primary" type="submit">Sign in</button>
		</form>

		<hr style="clear: both;" />
		<footer class="footer">
			<p class="pull-right">
				<a href="#">Back to top</a>
			</p>
			<p>
			<div>
				<a href="/home/about.jsp">About Us</a> &middot; <a
					href="/home/contact.jsp">Contact</a> &middot; <a
					href="/home/privacy.jsp">Privacy</a> &middot; <a
					href="/home/terms.jsp">Terms</a>
			</div>
			<br> &copy; Company 2012 &middot; Developed by SOL &middot; <br>
			<br>
			</p>
		</footer>
	</div>
	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-34629511-1' ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl'
					: 'http://www')
					+ '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>
</html>