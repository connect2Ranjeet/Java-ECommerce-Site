<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	Map<String, String> manager = (Map<String, String>) request
			.getSession().getAttribute("manager");

	///System.out.println(manager);
	
	if (manager == null) {
		response.sendRedirect("/");
	}
	
	/*
	 Updates
	 -  logo, site name loaded from database
	 */

	//// Loading site settings: get logo brand name
	Map<String, List<String>> site = SiteAction.getSettings();
	String template_url = "/bootstrap/css/bootstrap.min1.css";

	if (site != null) {
		int template_int = Integer
				.parseInt(site.get("Template").get(0));
		switch (template_int) {
		case 2:
			template_url = "/bootstrap/css/bootstrap.min2.css";
			break;
		case 3:
			template_url = "/bootstrap/css/bootstrap.min3.css";
			break;
		case 4:
			template_url = "/bootstrap/css/bootstrap.min4.css";
			break;
		case 5:
			template_url = "/bootstrap/css/bootstrap.min5.css";
			break;
		case 6:
			template_url = "/bootstrap/css/bootstrap.min6.css";
			break;
		default:
			template_url = "/bootstrap/css/bootstrap.min1.css";
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
<script src="/js/layout.js"></script>

<script src="/libs/highcharts/js/highcharts.js" type="text/javascript"></script>
<script src="/libs/jquery_highchart_table/jquery.highchartTable.js"
	type="text/javascript"></script>

<link href="<%=template_url%>" rel="stylesheet">

<link href="/css/layout.css" rel="stylesheet">
<link rel="stylesheet" href="/font/font-awesome.css">
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

<!-- Add fancyBox -->
<link rel="stylesheet" href="/libs/fancybox/jquery.fancybox.css?v=2.1.3"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="/libs/fancybox/jquery.fancybox.pack.js?v=2.1.3"></script>

<!-- Optionally add helpers - button, thumbnail and/or media -->
<link rel="stylesheet"
	href="/libs/fancybox/helpers/jquery.fancybox-buttons.css?v=1.0.5"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="/libs/fancybox/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
<script type="text/javascript"
	src="/libs/fancybox/helpers/jquery.fancybox-media.js?v=1.0.5"></script>

<link rel="stylesheet"
	href="/libs/fancybox/helpers/jquery.fancybox-thumbs.css?v=1.0.7"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="/libs/fancybox/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

</head>
<body>
	<div class="container navbar-wrapper">
		<div class="navbar">
			<div class="navbar-inner">
				<div class="container">
					<%
						if (site != null) {
					%>
					<a class="brand" href="/"><%=site.get("Site_name").get(0)%> <img
						alt="Logo" src="<%=site.get("Logo_image").get(0)%>" style ="max-height: 25px; width: auto;height: 25px;"/> </a>
					<%
						}
					%>
					<div class="nav-collapse collapse">
						<ul class="nav pull-right">
							<li><a href="/management/logout.jsp"> Logout</a></li>
						</ul>
					</div>
					<!-- /.nav-collapse -->
				</div>
			</div>
			<!-- /navbar-inner -->
		</div>
		<!--		<div class="container">-->