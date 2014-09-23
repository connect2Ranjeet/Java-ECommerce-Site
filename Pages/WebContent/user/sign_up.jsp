<jsp:include page="/layout/header.jsp" flush="true" />
<%@ page import="Action.*"%>
<script type="text/javascript" src="/js/sign_up.js"></script>


<h3>Sign up</h3>
<form id="signup-form" class="form-horizontal" method="POST">
<%
if(request.getMethod().equals("POST")){
	String name = request.getParameter("inputName");
	String username = request.getParameter("inputUsername");
	String email = request.getParameter("inputEmail");
	String password = request.getParameter("inputPassword");
	String repassword = request.getParameter("inputRePassword");
	String agree = request.getParameter("inputAgree");
	if (password.compareTo(repassword) != 0) {
		%>
		<div class="alert alert-error">Your password does not match!</div>
		<%
	}
	if (agree.compareTo("on") != 0){
		%>
		<div class="alert alert-error">You have not agreed to the <a href="/home/terms.jsp">Terms of Service</a> and <a href="/home/privacy.jsp">Privacy Policy</a>!</div>
		<%	
	}
	if (password.compareTo(repassword) == 0 && agree.compareTo("on") == 0) {
		int result = UserAction.signUp(name, username, email, password); 
		if (result > 0) {
			UserAction.login(session, username, password);
			response.sendRedirect("/");
			return;
		} else {
			%>
			<div class="alert alert-error">This Username is taken!</div>
			<%	
		}
			
	}
}

%>
	<div class="control-group">
		<label class="control-label" for="inputUsername">Name</label>
		<div class="controls">
			<input type="text" id="inputName" name="inputName" placeholder="Fullname">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputUsername">Username</label>
		<div class="controls">
			<input type="text" id="inputUsername" name="inputUsername" placeholder="Username">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputEmail">Email</label>
		<div class="controls">
			<input type="text" id="inputEmail" name="inputEmail"  placeholder="Email">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputPassword">Password</label>
		<div class="controls">
			<input type="password" id="inputPassword" name="inputPassword"  placeholder="Password">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputRePassword">Re-enter Password</label>
		<div class="controls">
			<input type="password" id="inputRePassword" name="inputRePassword" placeholder="Re-enter Password">
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<label class="checkbox"> <input type="checkbox" name="inputAgree">
				I have read and agree to the <a href="/home/terms.jsp">Terms of Service</a> and <a href="/home/privacy.jsp">Privacy Policy</a>
			</label>
			<br>
			<button type="submit" class="btn btn-primary btn-large">Sign in</button>
		</div>
	</div>
</form>

<jsp:include page="/layout/footer.jsp" flush="true" />