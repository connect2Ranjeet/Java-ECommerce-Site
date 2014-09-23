<%@page contentType="application/json"%>
<%@ page import="Action.*"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	/// Do login
	boolean result = false;
	if (request.getMethod() == "POST") {
		String userName = request.getParameter("inputUsername");
		String password = request.getParameter("inputPassword");
		
		if (userName != null & password != null) {
			result = UserAction.login(session, userName, password);
		}
	}
	
	//// Return json
	JSONObject json = new JSONObject();

	json.put("result", new Boolean(result));
	out.print(json);
	out.flush();
%>