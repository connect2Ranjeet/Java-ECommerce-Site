<jsp:include page="/layout/header.jsp" flush="true"/>
<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	/**
	 * Updates:
	 * 	1. Added site name to bottom header
	 */
	Map<String, List<String>> site = SiteAction.getSettings();
%>

<h3>Terms page</h3>
<p style="padding: 1% 1% 1% 1%">
Thank you for visiting the <% if(site!=null){ %> <%= site.get("Site_name").get(0) %> <% } %>. 
This site is intended to provide you with information about our company, including 
press releases, investor information, community giving, diversity, sustainability and more.
This policy applies only with respect to information collected through this site.
</p>

<jsp:include page="/layout/footer.jsp" flush="true"/>