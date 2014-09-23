<%@ page import="Action.*"%>
<%@ page import="java.util.*"%>

<%
	Map<String, List<String>> user = null;

	///// Get user_id
	String user_id = request.getParameter("id");

	if (user_id != null) {
		user = UserAction.getUserById(user_id);
	}

	if (user == null) {
		response.sendRedirect("/");
		return;
	}

	/// Upload image
	if (request.getMethod().equals("POST")) {
		//if (ImageAction.uploadImage(request, response)) {
		//	System.out.println("Finish upload");
		//}
	}
%>

<jsp:include page="/layout/header.jsp" flush="true" />

<div class="row-fluid">
	<div class="span12 well">
		<h4>Uploading avatar:</h4>
		<small>Accept formats .jpg, .png</small>
		<div style="text-align: center">
			<form method="post" enctype="multipart/form-data">
				<img alt="" src="/img/avatar.png" width="100" height="100"> <input
					type="file" name="photo" />
				<button type="submit">Upload</button>
			</form>
		</div>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" flush="true" />